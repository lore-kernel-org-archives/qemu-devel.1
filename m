Received: from eggs.gnu.org ([2001:4830:134:3::10]:42835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fnMZb-0005Z9-Mk
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fnMZY-0008QG-JH
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:24:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49834 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fnMZY-0008N0-EG
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 025B24023444
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:24:11 +0000 (UTC)
Date: Wed, 8 Aug 2018 13:24:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180808112409.wazgnksmsvhl4sa6@sirius.home.kraxel.org>
References: <20180808104930.23133-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180808104930.23133-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] ui: remove deprecated UI frontends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com

On Wed, Aug 08, 2018 at 11:49:27AM +0100, Daniel P. Berrang=E9 wrote:
> We deprecated GTK2 and SDL1.2 in the 2.12.0 release, so they are able t=
o
> be removed entirely in the 3.1.0 release. The min GTK3 version can also
> be bumped up based the distros we aim to support.

Yes for gtk2, finally the #ifdef mess is gone, yay!

Not so sure for sdl1, that one was more controversial and sdl2
regression fixes are still tickling in (although it seems we killed most
of them meanwhile).  Also due to sdl1 being a separate source file
anyway the maintanance costs are not that high.

Comments?

When actually removing sdl1 the -no-frame cmd line switch can go too as
sdl1 is the only user.

cheers,
  Gerd
