Received: from eggs.gnu.org ([2001:4830:134:3::10]:56956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgXBo-0001ro-5W
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgXBl-0001D4-3H
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:42:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgXBk-0001Ct-U3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:42:37 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1375280478
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:42:37 +0000 (UTC)
Message-ID: <1487770954.4687.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 22 Feb 2017 14:42:34 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: [Qemu-devel] ipxe for qemu maintainance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Ladi Prosek <lprosek@redhat.com>, Jeff Cody <jcody@redhat.com>

  Hi folks,

I'd like to start maintaining qemu-specific branches in our ipxe.git
repo.  The reason for this are some problems with the upstream ipxe
maintainance:

 * The ipxe maintainer apparently is pretty busy.  Often (but not
   always) it takes weeks or even months to get patches merged upstream,
   which is bad in case we need a fix included quickly due to freeze
   deadline approaching ...
 * There is no release management whatsoever.  No stable branches,
   no release tags.  Picking up a fix upstream means rebasing to
   a snapshot which includes the fix.

So I'd like to improve that downstream with qemu branches, where we can
commit not-yet merged patches, revert broken patches and cherry-pick
bugfixes.

This is *NOT* meant to be a replacement for working with upstream to get
patches merged and bugs fixed.  But it will allow us to handle things in
a timely manner without having to depend on the upstream maintainer.
And we can be more selective about the ipxe patches we accept during
freeze.

I plan to also add qemu release tags to the repo, so you can easily
figure what is included in each qemu release.

Laszlo created a wiki page for this, naming conventions for branches and
tags are listed there too:
        http://wiki.qemu-project.org/IpxeDownstreamForQemu

Comments?

cheers,
  Gerd

PS: v2, this time with the correct qemu-devel address ...
