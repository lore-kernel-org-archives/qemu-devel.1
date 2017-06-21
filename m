Received: from eggs.gnu.org ([2001:4830:134:3::10]:36218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNiVH-0002JK-Mj
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNiVG-00065U-PD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:29:15 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNiVG-00064R-Iz
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:29:14 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y25so102674210wrd.2
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 09:29:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CE257476-FBA4-4579-A558-495797786922@gmail.com>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508221304.y36owezwla7sc6ss@aurel32.net>
	<BB3E29F1-8BBB-407B-AAC8-795E9718CF5E@gmail.com>
	<20170508225007.2duqxlo5ab2aenpl@aurel32.net>
	<alpine.BSF.2.20.1705091148560.78100@zero.eik.bme.hu>
	<F3D7AC88-099F-432D-B46F-97F2A6F7B0E3@gmail.com>
	<f2644920-8eda-e768-adee-71db36ea2fa3@amsat.org>
	<CAFEAcA-72bvtKsPHttUizYj8EvZJDfjUda7CeZe-tpRk73+NXw@mail.gmail.com>
	<CE257476-FBA4-4579-A558-495797786922@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jun 2017 17:28:52 +0100
Message-ID: <CAFEAcA85obZ5eD7Lpydi4vH4DVat6xpaskVumodv2u1Hzz6CCg@mail.gmail.com>
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

On 21 June 2017 at 17:27, G 3 <programmingkidx@gmail.com> wrote:
> On Jun 21, 2017, at 12:20 PM, Peter Maydell wrote:
>> We don't yet have any mechanism for having tests that need to
>> be compiled for the target architecture, do we?
>
>
> I don't know about that but I do know we have image files that can be booted
> in various guest. These image files could include tests like the floating
> point test.
>
> Here is the link to the test images page:
> http://wiki.qemu.org/Testing/System_Images

Yes -- those are almost all very out of date, not reproducible
at all and don't cover very many of our systems, because we
don't have a good mechanism for writing tests that need
to be built for the target architecture. I'd like us to
have a setup so that it's easy to say "just add a new test",
rather than accumulating more random images on the wiki...

thanks
-- PMM
