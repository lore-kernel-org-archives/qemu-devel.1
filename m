Received: from eggs.gnu.org ([2001:4830:134:3::10]:34313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXLxu-0007AZ-7q
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXLxp-0006J6-Dx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:26:38 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:35297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXLxp-0006IU-7S
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:26:33 -0400
Received: by mail-pg0-x22e.google.com with SMTP id v190so7104228pgv.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 23:26:33 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170718045540.16322-1-f4bug@amsat.org>
	<20170718045540.16322-8-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f6699104-8167-1a3f-b4cc-c547fab05ccf@twiddle.net>
Date: Mon, 17 Jul 2017 20:26:25 -1000
MIME-Version: 1.0
In-Reply-To: <20170718045540.16322-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 07/10] target/sparc: optimize
 gen_op_mulscc() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

On 07/17/2017 06:55 PM, Philippe Mathieu-Daudé wrote:
> Done with the Coccinelle semantic patch from commit 58daf05d07dd
> (see scripts/coccinelle/tcg_gen_extract.cocci)
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> 
> Richard: are you ok squashing it with previous commit?
>           maybe you need to update 58daf05d07dd to your commit...

Yes, I've squashed this into the previous while applying.


r~
