Received: from eggs.gnu.org ([2001:4830:134:3::10]:47037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA4DX-0005Zq-N4
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA4DU-00047a-JU
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:22:47 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eA4DU-00047L-Ec
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 21:22:44 -0400
Received: by mail-qk0-x243.google.com with SMTP id w134so5012055qkb.0
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 18:22:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
	<CAFEAcA9TD+imsuD+0zmZ5FGH7cVCw5+ZiKdPS1uBjqj=ujKiQw@mail.gmail.com>
	<fb931086-a889-7e76-5c1e-ec393d681044@linux.vnet.ibm.com>
	<CAFEAcA_kwTC0B=CmanSPnjFXpgB2HgO_k5+iLQ+HcrsN9TRX8g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c757656b-5c7e-3948-9148-54024d28fd88@amsat.org>
Date: Wed, 1 Nov 2017 22:22:35 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_kwTC0B=CmanSPnjFXpgB2HgO_k5+iLQ+HcrsN9TRX8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] configure: do CC check before verifying
 host CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

>>> I think that currently we try to make "--help" work
>>> even if you don't have a working C compiler. Does this
>>> break that?
>>
>> Just checked, configure --help isn't broken with this change:
> 
> Did you test with gcc uninstalled again? It's hard to see
> how it could work -- if the compile test fails we'll call
> error_exit, which (as the name suggests) exits. Your patch
> moves the compiler check from after we handle --help to
> before it...

$ CC=asdf ./configure --help

ERROR: "asdf" either does not exist or does not work

Oops.
