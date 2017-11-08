Received: from eggs.gnu.org ([2001:4830:134:3::10]:34365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCSMA-0000o1-2U
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCSM9-0002OI-6C
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:33:34 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:49748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eCSM8-0002Ny-W9
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 10:33:33 -0500
Received: by mail-wr0-x22b.google.com with SMTP id o88so2781276wrb.6
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 07:33:32 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Nov 2017 15:33:31 +0000
Message-ID: <CAJSP0QUOCzWfM614zRKme+GecU+NVNOFcoGz1wdBcdgKzrq-LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Moving release tarballs to a CDN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Hi Mike and Jeff,
qemu.org's bandwidth usage is dominated by release tarball downloads.
This puts qemu.org bandwidth usage in the 2+ TB/month range.

Many hosting providers do not offer this much bandwidth as part of a
basic package that would otherwise fit qemu.org's requirements.

Several people have suggested putting release tarballs on a mirror or
CDN to offload the bandwidth usage.  Jeff Cody and I looked at using
GitHub's "releases" feature to host release tarballs.

The following changes would be necessary:

1. Add qemu.org URL redirection to GitHub:
https://download.qemu.org/qemu-(\d+.\d+.\d+).tar.xz ->
https://github.com/qemu/qemu/releases/download/v\1/qemu-\1.tar.xz

2. Modify release script to immediately push to GitHub and then upload
tar.xz via API:
https://developer.github.com/v3/repos/releases/#upload-a-release-asset

3. Continue using https://download.qemu.org/qemu-\d+.\d+.\d+.tar.xz
URL for download links.

This way future QEMU releases would be hosted on GitHub with nice
qemu.org download links.  The signature file stays hosted on qemu.org
so it's possible to validate that the tarball has not been tampered
with.

How does this sound?

Stefan
