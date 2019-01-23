Received: from eggs.gnu.org ([209.51.188.92]:40657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmHWO-0000JE-F8
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmHWN-0004Qu-Ni
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:20:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmHWN-0004HK-Hk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:20:43 -0500
Date: Wed, 23 Jan 2019 13:20:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

  Hi,

> Pulseaudio uses OSS backend on NetBSD anyway and we keep an in-kernel
> mixer. So it adds nothing except additional intermediate layer.
> 
> For non-professional audio purposes OSS is good enough for such
> applications.

What happens if pulseaudio is running and using the sound device?  Can
qemu open and use the device in parallel?  "in-kernel mixer" sounds like
this is works and the kernel mixes the streams from all applications
before sending it to the sound device.  Or will qemu get a -EBUSY?

If parallel usage works we can default to oss I think.  Otherwise we
should try pulse first, and in case it is not available (daemon not
running) try oss next.

What about sdl?  Prefer oss over sdl I guess?  Or the other way around?

What is the native sound interface for openbsd btw?  oss doesn't
compile (missing sys/soundcard.h header).

cheers,
  Gerd
