Received: from eggs.gnu.org ([2001:4830:134:3::10]:55792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyO0-00075I-KR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyNx-0003SO-6g
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41232
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyNx-0003SD-0O
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:03:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB1k9S068677
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:48 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmhws8m5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:03:48 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:46 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:52 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-26-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 25/40] roms/SLOF: Update submodule to latest
 status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Thomas Huth <thuth@redhat.com>

We need the latest fixes for building the libc and libnet
of SLOF for the s390-ccw network bootloader firmware.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1499863793-18627-9-git-send-email-thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 roms/SLOF | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/SLOF b/roms/SLOF
index 66d250e..834113a 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 66d250ef0fd06bb88b7399b9563b5008201f2d63
+Subproject commit 834113a1c67d6fb53dea153c3313d182238f2d36
-- 
2.7.4
