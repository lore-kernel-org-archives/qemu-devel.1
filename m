Received: from eggs.gnu.org ([2001:4830:134:3::10]:34224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNwV3-0006cn-0e
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNwV1-00029e-W2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:25:57 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNwV1-00029W-OM
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:25:55 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 77so10903191wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 00:25:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BD44623-AD16-4D5D-BF51-15521035E974@gmail.com>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
	<alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
	<F3D7AC88-099F-432D-B46F-97F2A6F7B0E3@gmail.com>
	<f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
	<CAFEAcA-72bvtKsPHttUizYj8EvZJDfjUda7CeZe-tpRk73+NXw@mail.gmail.com>
	<CE257476-FBA4-4579-A558-495797786922@gmail.com>
	<CAFEAcA85obZ5eD7Lpydi4vH4DVat6xpaskVumodv2u1Hzz6CCg@mail.gmail.com>
	<4BD44623-AD16-4D5D-BF51-15521035E974@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 08:25:34 +0100
Message-ID: <CAFEAcA-EgM8rDvOBVRAf2Sud-7ivVpaXUhKckZiqs-YriixtHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, BALATON Zoltan <balaton@eik.bme.hu>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 22 June 2017 at 03:54, G 3 <programmingkidx@gmail.com> wrote:
> The advantage a test image would have is the user doesn't have to worry
> about compiling a test using a cross compiler. Everything the user would
> need to test QEMU is already inside the image file (hopefully).
>
> Is the setup you want something like running 'make test' ? I imagine binary
> files included with QEMU would test the emulated CPU. There would be no need
> to cross compile anything.

I want our tests to be easy to add new tests for, and easy
for anybody to recreate the binary files. Certainly providing
pre-built binaries would be helpful (faster than rebuilding
whole system images), but we must have an automated mechanism
for saying "build this image from sources" too, so that if
we want to update the test program later it's easy to do that,
or if we want to add a second test that's like the first
one but slightly modified we can easily do that too.

thanks
-- PMM
