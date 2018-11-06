Received: from eggs.gnu.org ([2001:4830:134:3::10]:37790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJv00-0002XN-DO
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJuzv-0005WN-Ez
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:38:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gJuzv-0005Rp-9g
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:37:59 -0500
Date: Tue, 6 Nov 2018 07:37:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181106063756.wh5ufbohlb7bdf42@sirius.home.kraxel.org>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
	<1540208764.16655.240.camel@redhat.com>
	<1541087251.16655.419.camel@redhat.com>
	<20181105065258.4mpdv5w4rp3eui5p@sirius.home.kraxel.org>
	<1541420337.16655.496.camel@redhat.com>
	<20181105130808.qwrb6gm2l3jqiu2z@sirius.home.kraxel.org>
	<1541433791.16655.503.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541433791.16655.503.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add
 functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org, Frediano Ziglio <fziglio@redhat.com>

  Hi,

> > I can see that it simplifies the logic in spice-server if we have a
> > single function call instead of two.  So we could deprecate
> > spice_qxl_set_max_monitors() in favour of your
> > spice_qxl_set_device_info() variant.
> > 
> > spice_qxl_set_max_monitors() would then basically do this:
> > 
> >     spice_qxl_set_max_monitors(qxl, max)
> >     {
> >         spice_qxl_set_device_info(qxl, NULL, 0, max);
> >     }
> 
> I can't actually do this, it does the wrong thing for the one-channel-
> per-head (virtio-gpu) case. For that case it would send all
> device_display_ids to 0 on all interfaces, but they need to be
> different numbers.

Well, qemu calls spice_qxl_set_max_monitors() only in case there are
multiple monitors in one channel, i.e. qxl.

cheers,
  Gerd
