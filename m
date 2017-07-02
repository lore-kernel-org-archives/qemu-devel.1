Received: from eggs.gnu.org ([2001:4830:134:3::10]:54547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRT54-0000y9-QC
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRT51-0006M1-Oe
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:49:42 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:33725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dRT51-0006Ll-Ks
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 20:49:39 -0400
Received: by mail-qk0-x22c.google.com with SMTP id v143so40790328qkb.0
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 17:49:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865510456.17063.14029858939919926288.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b588bf10-0269-c9da-adc3-2fe1539902a6@twiddle.net>
Date: Sat, 1 Jul 2017 17:49:36 -0700
MIME-Version: 1.0
In-Reply-To: <149865510456.17063.14029858939919926288.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 12/29] target/i386: [tcg] Refactor
 disas_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 06:05 AM, Lluís Vilanova wrote:
> +#ifdef TARGET_X86_64
> +    if (dc->code64)
> +        disas_flags = 2;
> +    else
> +#endif
> +        disas_flags = !dc->code32;

Even though this is code movement, missing braces.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
