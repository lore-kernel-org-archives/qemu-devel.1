Received: from eggs.gnu.org ([2001:4830:134:3::10]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drUn2-0005Bs-34
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1drUmy-00010U-7H
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:54:40 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:54092
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1drUmy-0000zT-0j
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 15:54:36 -0400
References: <20170911022839.23231-1-f4bug@amsat.org>
	<1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
	<CAFEAcA9+iDKf7UmQ2tevR9KQb_F2fJoBY03zrMMwM7ypFUdeAw@mail.gmail.com>
	<6a9c81f3-bbe3-e177-1ede-ad0cf40fe553@weilnetz.de>
	<005f4db4-ff06-30ee-f693-f233fd37c247@amsat.org>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <4296c8b2-e3ed-7a73-05bb-985603d08423@weilnetz.de>
Date: Mon, 11 Sep 2017 21:54:33 +0200
MIME-Version: 1.0
In-Reply-To: <005f4db4-ff06-30ee-f693-f233fd37c247@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Am 11.09.2017 um 21:47 schrieb Philippe Mathieu-Daud=C3=A9:
[...]> Stefan are you testing no-X86 targets?

I only tested x86_64:

./configure --enable-debug --enable-tcg-interpreter \
  --target-list=3Dx86_64-linux-user,x86_64-softmmu

If other targets fail, I'll have a look to find the cause.

Stefan
