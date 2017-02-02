Received: from eggs.gnu.org ([2001:4830:134:3::10]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZEnn-0000An-9G
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cZEnk-0004vI-5V
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:39:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cZEnj-0004uk-Ux
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:39:40 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCD90804E5
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 10:39:38 +0000 (UTC)
Message-ID: <1486031975.3484.17.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 02 Feb 2017 11:39:35 +0100
In-Reply-To: <1486021764.20628.29.camel@redhat.com>
References: <1485969640-8149-1-git-send-email-abologna@redhat.com>
	<1486021764.20628.29.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] q35: Improve sample configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, drjones@redhat.com

On Thu, 2017-02-02 at 08:49 +0100, Gerd Hoffmann wrote:
> Oh yes, the wonderful confusing world of default devices ;)
>=C2=A0
> So, if you run qemu with "-nodefaults" it will not add those two
> devices.

And I wouldn't have it any other way ;)

> If you add a video card manually (via -device or config file entry) qem=
u
> will not add the default video card.
>=C2=A0
> Likewise, if you add a NIC manually, qemu will not add the default
> ethernet device (and IIRC creating the default netdev will be skipped
> too).

This has the potential to give you some unexpected results
but I'd say it's still entirely reasonable.

So what do you think, should q35-emulated.cfg recommend the
use of -nodefaults the same way q35-virtio-*.cfg do and add
the video card (cirrus-vga?) and Ethernet adapter explicitly?

The advantage in doing so would be that we would provide
maybe slightly more documentation, and we would be able to
plug the Ethernet adapter at 19.0 instead of 02.0, which as
I understand it matches real hardware better.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
