Received: from eggs.gnu.org ([2001:4830:134:3::10]:55744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KYc-0002N8-KW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9KYb-00042K-UA
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:05:14 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9KYb-00041F-Qy
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:05:13 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so9894684qkh.0
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 17:05:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170512233843.27713-1-f4bug@amsat.org>
	<20170512233843.27713-5-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <740c525c-5d6a-9748-66dc-fdf98064e5a8@twiddle.net>
Date: Fri, 12 May 2017 17:05:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170512233843.27713-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 4/6] target/m68k: optimize bcd_flags()
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>

On 05/12/2017 04:38 PM, Philippe Mathieu-Daudé wrote:
> Patch created mechanically using Coccinelle script via:
> 
>      $ spatch --macro-file scripts/cocci-macro-file.h --in-place \
>          --sp-file scripts/coccinelle/tcg_gen_extract.cocci --dir target
> 
> Signed-off-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Acked-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)


Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
