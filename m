Received: from eggs.gnu.org ([2001:4830:134:3::10]:60826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTxG-0002GC-R8
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRTxF-0005Uu-RL
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:45:42 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865825357.17063.13113603039704787150.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ae9e2ddd-8a58-cc7b-fcbf-bcab107a98fd@twiddle.net>
Date: Sat, 1 Jul 2017 18:45:33 -0700
MIME-Version: 1.0
In-Reply-To: <149865825357.17063.13113603039704787150.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 25/29] target/arm: [tcg] Port to tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 06:57 AM, Lluís Vilanova wrote:
> -    if (max_insns > TCG_MAX_INSNS) {
> -        max_insns = TCG_MAX_INSNS;
> +    if ((dc->base.tb->cflags & CF_LAST_IO) && dc->condjmp) {
> +        /* FIXME: This can theoretically happen with self-modifying code. */
> +        cpu_abort(cpu, "IO on conditional branch instruction");
>       }
...
> -        gen_io_end();
> +    if (dc->base.tb->cflags & CF_LAST_IO && dc->condjmp) {
> +        /* FIXME: This can theoretically happen with self-modifying code. */
> +        cpu_abort(cpu, "IO on conditional branch instruction");

Two copies of this code... sequentially, apparently?


r~
