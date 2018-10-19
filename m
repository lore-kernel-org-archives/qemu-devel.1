Received: from eggs.gnu.org ([2001:4830:134:3::10]:57151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDSMq-0006GF-KS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gDSMn-0001Se-B4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:50:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gDSMm-0001Lo-Vv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:50:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id y18-v6so15632007pge.0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 03:50:42 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 19 Oct 2018 03:50:34 -0700
Message-Id: <1539946236-18028-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] hw: ccid-card-emulated: fix some resources
 leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@163.com, Li Qiang <liq3ea@gmail.com>


Li Qiang (2):
  hw: ccid-card-emulated: introduce clean_event_notifier
  hw: ccid-card-emulated: cleanup resource when realize in error path

 hw/usb/ccid-card-emulated.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

-- 
1.8.3.1
