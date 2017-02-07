Received: from eggs.gnu.org ([2001:4830:134:3::10]:44275)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1cb6lH-0005th-Nq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1cb6lC-0001SO-Qx
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:28:51 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:35626 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1cb6lC-0001Ni-HD
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:28:46 -0500
From: Peter Lieven <pl@kamp.de>
Message-ID: <fc8d40bf-7039-fa1d-3541-9e2bd90eec94@kamp.de>
Date: Tue, 7 Feb 2017 15:28:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] USB ehci passthru issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi,


I have a DVB-S2 tuner that is passed to a vServer running Qemu via EHCI.

After some time of operation the tuner always fails with the following errors in the log:

Feb  7 15:12:17 tvheadend-neu kernel: [ 1346.926238] usb 1-1: failed=-75

Feb  7 15:12:19 tvheadend-neu kernel: [ 1348.925886] usb 1-1: dvb_usb_v2: usb_bulk_msg() failed=-75

Feb  7 15:12:17 tvheadend-neu kernel: [ 1346.926238] usb 1-1: failed=-110

Feb  7 15:12:19 tvheadend-neu kernel: [ 1348.925886] usb 1-1: dvb_usb_v2: usb_bulk_msg() failed=-110


Has anyone seen this before? The error -110 is repeated about every second.

I already tried to blacklist the tuner drviers on the host, but that didn't help.


Thanks,
Peter
