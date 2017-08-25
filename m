Received: from eggs.gnu.org ([2001:4830:134:3::10]:56217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qyron.private@gmail.com>) id 1dlA9i-00071u-Fe
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qyron.private@gmail.com>) id 1dlA9h-0000Bx-Rr
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:39:54 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:32913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <qyron.private@gmail.com>)
	id 1dlA9h-0000BM-MA
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 04:39:53 -0400
Received: by mail-oi0-x231.google.com with SMTP id t88so15645017oij.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 01:39:52 -0700 (PDT)
MIME-Version: 1.0
From: Sergei Dyshel <qyron.private@gmail.com>
Date: Fri, 25 Aug 2017 11:39:30 +0300
Message-ID: <CAAeL1MGV5zSPq0OCVCsw4+xzRXm95z-yd_oN2__yskd6aUmESQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Make NVME device "migratable" (savevm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,
>From what I understand, I can't "savevm" a VM that uses NVME device because
it has ".unmigratable = 1" in the code. What support must be implemented in
order to make it "migratable"?
-- 
Regards,
Sergei Dyshel
