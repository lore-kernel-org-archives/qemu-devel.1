Received: from eggs.gnu.org ([2001:4830:134:3::10]:58703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fbQWq-0000SS-1t
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fbQWm-0008Kq-T6
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:12:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fbQWm-0008KE-Ls
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:12:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id r5-v6so204693pgv.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 06:11:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1530732637-28606-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1530732637-28606-6-git-send-email-aleksandar.markovic@rt-rk.com>
	<57a2af86-a882-7974-645b-048b630e9ef7@amsat.org>
	<BYAPR08MB4870FDA59891224B4A0AC3CAD4400@BYAPR08MB4870.namprd08.prod.outlook.com>
	<6bed7e02-a3d3-ea93-7291-96799d4d2a83@amsat.org>
	<DM6PR08MB48736A43E3F1DD85841D46F9D4470@DM6PR08MB4873.namprd08.prod.outlook.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3ce28b5c-a074-e600-04b5-eab4d4ad1621@twiddle.net>
Date: Fri, 6 Jul 2018 06:11:56 -0700
MIME-Version: 1.0
In-Reply-To: <DM6PR08MB48736A43E3F1DD85841D46F9D4470@DM6PR08MB4873.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/8] target/mips: Add CP0 BadInstrX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <smarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Petar Jovanovic <pjovanovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Paul Burton <pburton@wavecomp.com>

On 07/06/2018 04:40 AM, Stefan Markovic wrote:
> +#if defined(TARGET_MIPS64)
> +            tcg_gen_andi_i64(arg, arg, ~0xffff);
> +#else
> +            tcg_gen_andi_i32(arg, arg, ~0xffff);
> +#endif

That's what tcg_gen_andi_tl is for -- avoiding such ifdefs.


r~
