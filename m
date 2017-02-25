Received: from eggs.gnu.org ([2001:4830:134:3::10]:34708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chf0C-0006e2-0j
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:15:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chf0B-0002xF-8b
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:15:20 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chf0B-0002wZ-2W
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 11:15:19 -0500
Received: by mail-wm0-x232.google.com with SMTP id r141so34502754wmg.1
	for <qemu-devel@nongnu.org>; Sat, 25 Feb 2017 08:15:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.20.1702242123280.76443@zero.eik.bme.hu>
References: <cover.1487522123.git.balaton@eik.bme.hu>
	<4bed0ec61e74992657933af970366a9e2636589a.1487522123.git.balaton@eik.bme.hu>
	<CAFEAcA-KW64ar8dER9V7x87BzH0G_uQstqXFoA2kuf2j3Hc4WQ@mail.gmail.com>
	<alpine.BSF.2.20.1702242123280.76443@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Feb 2017 16:14:57 +0000
Message-ID: <CAFEAcA9pjHt_vx10V-+H7j2_hc8gkMmJLfbYvSR2Z8dj4cguCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 04/10] sm501: Add emulation of chip
 connected via PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 24 February 2017 at 20:25, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Fri, 24 Feb 2017, Peter Maydell wrote:
>> Dropping the requirement for a base addr is not really the same
>> change as adding the PCI device.
>
>
> This is needed for PCI device because the base is not accessible before
> something maps the BARs of the device so I had to use something else that is
> known. So this change is part of making it a PCI device but I could make
> this a separate patch if you think that's better. Should I split it off or
> can leave it here?

I would split it off.

thanks
-- PMM
