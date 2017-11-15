Received: from eggs.gnu.org ([2001:4830:134:3::10]:58155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEwfL-0001Ah-90
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEwfG-0002FN-NV
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:19:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEwfG-0002Ep-Gp
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:19:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A108B6869B
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 12:19:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-103.ams2.redhat.com
	[10.36.116.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 67BE511E7CC
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 12:19:33 +0000 (UTC)
Date: Wed, 15 Nov 2017 13:19:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171115121932.x4oh4aok5j5x6kxr@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] building user interfaces as modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

  Hi,

I'm trying to revamp the display initialization code:

  * First use a qapi type for the display options, so we can use
    -blockdev style command line parsing for -display (not there yet,
    but closer).
  * Second initialize all user interfaces the same way and build a
    registry for UIs.  Drops lots of #ifdefs from vl.c
  * Finally this should make it *alot* easier to build user interfaces
    as modules.

For SDL we already have sdl.mo defined in ui/Makefile.objs. so I tried
that first.  Just flipping CONFIG_SDL from 'y' to 'm' doesn't work
though.  sdl support isn't build, neither with nor without
--enable-modules.

Any clues?

thanks,
  Gerd

git branch:
  https://www.kraxel.org/cgit/qemu/log/?h=sirius/display-cmdline
