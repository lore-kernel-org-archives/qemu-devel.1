Received: from eggs.gnu.org ([2001:4830:134:3::10]:34288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drUfw-0002JW-Qy
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drUfr-0003cd-U0
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:47:20 -0400
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:33624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drUfr-0003cW-Py
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:47:15 -0400
Received: by mail-qk0-x22e.google.com with SMTP id o129so20928042qkd.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 12:47:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
	<6a9c81f3-bbe3-e177-1ede-ad0cf40fe553@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <005f4db4-ff06-30ee-f693-f233fd37c247@amsat.org>
Date: Mon, 11 Sep 2017 16:47:07 -0300
MIME-Version: 1.0
In-Reply-To: <6a9c81f3-bbe3-e177-1ede-ad0cf40fe553@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter, Stefan,

> Am 11.09.2017 um 20:24 schrieb Peter Maydell:
>> I've also turned on a tci compile check on my pre-merge tests.
>> (It doesn't pass "make check" for me, though...)

Peter you might want to restrict it to X86...

--target-list=subdir-i386-softmmu,x86_64-softmmu,x86_64-linux-user

> 
> I just tested it myself. "make check" passed, but printed some
> KVM related messages which could be suppressed by fixing the
> test code:
> 
> [...]
>    GTESTER tests/test-qht-par
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> [...]
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> make: Verzeichnis „/qemu/bin/“ wird verlassen

Stefan are you testing no-X86 targets?

Regards,

Phil.
