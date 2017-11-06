Received: from eggs.gnu.org ([2001:4830:134:3::10]:51606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eBUsi-0008Fz-Oz
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eBUsi-0002xa-5l
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:03:12 -0500
Received: from mail-yw0-x232.google.com ([2607:f8b0:4002:c05::232]:46574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eBUsi-0002xQ-1K
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 19:03:12 -0500
Received: by mail-yw0-x232.google.com with SMTP id t71so6537791ywc.3
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 16:03:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMo8BfKYk0zMhnbP6VoyG8Di87hndaLD6rtHT=3yXFVfuhCk2A@mail.gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
	<1509767121-26925-16-git-send-email-jcmvbkbc@gmail.com>
	<CAAdtpL5cr_Pi7_HKsxDRwfkPhYPc6rGU=53AdbW0HoHbm-LrFw@mail.gmail.com>
	<CAMo8BfKYk0zMhnbP6VoyG8Di87hndaLD6rtHT=3yXFVfuhCk2A@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 5 Nov 2017 16:03:10 -0800
Message-ID: <CAMo8BfJ7SXPZmTTuGbjjZJknnnvcDDTvQaGhBdyNmXsKfc=qPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 15/16] target/xtensa: implement const16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Sun, Nov 5, 2017 at 3:43 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> however I think this can be simplified in 1 instr on target supporting
>> deposit32:
>>
>>     tcg_gen_deposit_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[0]], 16, 16)
>
> arg[1] is an immediate argument, not a register index, so probably not.

Oh, I've got it, replace cpu_R[arg[1]] with a temporary:

TCGv_i32 c = tcg_const_i32(arg[1]);
tcg_gen_deposit_i32(cpu_R[arg[0]], c, cpu_R[arg[0]], 16, 16);
tcg_temp_free(c);

-- 
Thanks.
-- Max
