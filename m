Received: from eggs.gnu.org ([2001:4830:134:3::10]:58521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gWJsS-0003ZE-OJ
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gWJsO-0006E9-MY
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:37:32 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59768)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gWJsO-0006DG-Bm
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 06:37:28 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-7-cota@braap.org>
In-Reply-To: <20181209193749.12277-7-cota@braap.org>
Date: Mon, 10 Dec 2018 14:37:25 +0300
Message-ID: <002301d4907c$b9854390$2c8fcab0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC v2 06/38] plugin: add core code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'Emilio G. Cota'" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Richard Henderson' <richard.henderson@linaro.org>


> From: Emilio G. Cota [mailto:cota@braap.org]
> +/*
> + * A dynamic callback has an insertion point that is determined at run-time.
> + * Usually the insertion point is somewhere in the code cache; think for
> + * instance of a callback to be called upon the execution of a particular TB.
> + */
> +struct qemu_plugin_dyn_cb {
> +    union qemu_plugin_cb_sig f;
> +    void *userp;
> +    unsigned tcg_flags;
> +    enum plugin_dyn_cb_type type;
> +    /* @rw applies to mem callbacks only (both regular and inline) */
> +    enum qemu_plugin_mem_rw rw;
> +    /* fields specific to each dyn_cb type go here */
> +    union {
> +        struct {
> +            bool haddr;
> +        } mem;
> +        struct {
> +            enum qemu_plugin_op op;
> +            uint64_t imm;
> +        } inline_insn;
> +    };
> +};
> +
> +struct qemu_plugin_dyn_cb_arr {
> +    struct qemu_plugin_dyn_cb *data;
> +    size_t n;
> +    size_t capacity;
> +};
> +

Why not list or something dynamic? Is the indexing required?

Can you add the comments for the data structures and functions?
It is very hard to seek through the whole patch to get the details about them.

Pavel Dovgalyuk
