Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsM2P-00055i-UF
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsM2O-0006gx-QX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:46:05 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsM2O-0006gJ-Kk
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 00:46:04 -0400
Received: by mail-io0-x241.google.com with SMTP id g32so2466342ioj.1
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 21:46:04 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <2acadeb5-41e1-ce09-6e3b-37001dd57042@weilnetz.de>
References: <20170913221149.30382-1-f4bug@amsat.org>
	<2acadeb5-41e1-ce09-6e3b-37001dd57042@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Sep 2017 01:46:03 -0300
Message-ID: <CAAdtpL4SzR55xFEtJ3Re_-Gh6GLdVqbK6pqJoDuQQMhTFCTe_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel/hax: move hax-stub.c to accel/stubs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

>> --- a/accel/stubs/Makefile.objs
>> +++ b/accel/stubs/Makefile.objs
>> @@ -1,2 +1,3 @@
>>  obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
>>  obj-$(call lnot,$(CONFIG_TCG)) += tcg-stub.o
>> +obj-$(call lnot,$(CONFIG_HAX)) += hax-stub.o
>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thanks!

>
> Personally, I like alphabetic order for such lines.
> Maybe that can be done when it is applied.

Fine by me ;)

Richard if you plan to take this, tell me if you prefer another patch
alphabetically sorted.

Regards,

Phil.
