Received: from eggs.gnu.org ([2001:4830:134:3::10]:59838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQdFm-0003hY-Ts
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQdFl-0007jp-3C
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:33:50 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:38574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQdFk-0007jO-U1
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 14:33:49 -0400
Received: by mail-ot0-x229.google.com with SMTP id n3-v6so8434985ota.5
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 11:33:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Jun 2018 19:33:27 +0100
Message-ID: <CAFEAcA8b6ziWp2ZAhyG2pY2V6EVzBNodv4ZDxFKc8hdV1=oZTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Stair step trace output since 12fb0ac05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2018 at 18:15, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Hello,
>
> Since 12fb0ac05 (char: Remove unwanted crlf conversion) trace output is
> printed in stair steps when using -trace and -serial stdio together. E.g.
> $ qemu-system-i386 -trace 'pci*' -serial stdio

I had a feeling that we were going to find that there were
situations where we really wanted to retain the crlf
processing...

thanks
-- PMM
