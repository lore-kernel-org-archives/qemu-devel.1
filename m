Received: from eggs.gnu.org ([2001:4830:134:3::10]:49822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6kN-0000jZ-5b
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6kJ-0000z6-T4
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:33:39 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6kJ-0000yi-NI
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:33:35 -0400
Received: by mail-pg1-x541.google.com with SMTP id v133-v6so9498877pgb.2
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:33:35 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ef760f1e-753f-a16c-760c-b717f94890b1@linaro.org>
Date: Mon, 15 Oct 2018 10:33:31 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 19/21] plugins: add an example
 hotblocks plugin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:49 AM, Alex Bennée wrote:
> +char *plugin_status(void)
> +{
> +    GString *report = g_string_new("We have ");
> +    char *r;
> +    g_mutex_lock(&lock);
> +    g_string_append_printf(report, "%ud entries in the hash table\n",
> +                           g_hash_table_size(hotblocks));
> +    g_mutex_unlock(&lock);
> +    r = report->str;
> +    g_string_free(report, FALSE);
> +    return r;
> +}

You're not reporting the entries themselves?
Also, are you sure you don't want to just return the GString?


r~
