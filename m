Received: from eggs.gnu.org ([2001:4830:134:3::10]:48152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45Sv-0005k0-EI
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgnyang@gmail.com>) id 1d45Sq-0001Rc-JB
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:57:41 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgnyang@gmail.com>) id 1d45Sq-0001QX-E3
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 08:57:36 -0400
Received: by mail-pg0-x243.google.com with SMTP id v20so2814648pgn.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 05:57:35 -0700 (PDT)
From: Zihan Yang <tgnyang@gmail.com>
Date: Fri, 28 Apr 2017 20:55:07 +0800
Message-Id: <1493384110-32060-1-git-send-email-tgnyang@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] hw: make *_exit return void/convert to
 unrealize in sclp/virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <tgnyang@gmail.com>

These first patch remove the console_exit function in sclp since it 
actually does nothing, the callback return type in SCLPEventClass is
changed to void. The second patch convert return type of *_exit function
 of virtio-ccw to void. The third patch replace the exit callback with
unrealize in the class init function of virtio-ccw, because the exit 
callback of DeviceClass will be removed in the future.

Zihan Yang (3):
  hw/char/sclp*: remove console_exit function in sclp
  hw/s390x: make virtio_ccw_exit function in virtio-ccw return void
  hw/s390: replace exit with unrealize during class init of virtio-ccw

 hw/char/sclpconsole-lm.c          | 6 ------
 hw/char/sclpconsole.c             | 6 ------
 hw/s390x/event-facility.c         | 6 +-----
 hw/s390x/virtio-ccw.c             | 9 ++++-----
 hw/s390x/virtio-ccw.h             | 2 +-
 include/hw/s390x/event-facility.h | 2 +-
 6 files changed, 7 insertions(+), 24 deletions(-)

-- 
2.7.4
