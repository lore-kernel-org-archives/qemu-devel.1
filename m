Received: from eggs.gnu.org ([2001:4830:134:3::10]:39998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOr2p-0005jK-0c
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:20:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOr2l-0006lo-RD
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:20:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOr2l-0006lP-Kq
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 15:20:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C418E285D0
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 20:20:46 +0000 (UTC)
Date: Tue, 12 Dec 2017 20:20:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171212202040.GA2458@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] No uhd (3840x2160) guest res?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

My guests don't seem to offer the standard uhd resolution of 3840x2160
- what should be providing that?

I'm running an f27 gnome (X or wayland) guest with:

./x86_64-softmmu/qemu-system-x86_64 -device virtio-vga --enable-kvm -m 2G /home/vmimages/fedora27.qcow2

and the guest lists:
4096x2160
2480x1680
2560x1600
1920x1440
1856x1392
1792x1344
2048x1152
1920x1200
1920x1080
(and smaller)

given that it can offer 4096x2160, I assume it's not running out of RAM.

I couldn't find anywhere with those higher resolutions listed
in seabios to consider changing.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
