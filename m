Received: from eggs.gnu.org ([2001:4830:134:3::10]:43290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQc2R-00063K-1r
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQc2N-00007C-U1
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:15:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:59686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fQc2N-00006V-Mb
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:15:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
	by localhost (Postfix) with SMTP id 21F267456B7
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 19:15:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 0BF1E7456B4
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 19:15:54 +0200 (CEST)
Date: Wed, 6 Jun 2018 19:15:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] Stair step trace output since 12fb0ac05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

Since 12fb0ac05 (char: Remove unwanted crlf conversion) trace output is 
printed in stair steps when using -trace and -serial stdio together. E.g.
$ qemu-system-i386 -trace 'pci*' -serial stdio

Regards,
BALATON Zoltan
