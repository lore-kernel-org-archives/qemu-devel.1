Received: from eggs.gnu.org ([2001:4830:134:3::10]:54472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dMhhS-0000E9-Hf
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 17:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dMhhN-0002Kd-L8
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 17:25:38 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:47985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1dMhhN-0002J9-Ef
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 17:25:33 -0400
Date: Sun, 18 Jun 2017 23:25:15 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1706182319020.18505@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] Commit 77af8a2b9 breaks (mac)OS X 10.11.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, "Gabriel L. Somlo" <gsomlo@gmail.com>

Hello,

After 77af8a2b9 (hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to 
improve guest OS support.) OS X 10.11.6 hangs during boot near detecting 
IOAPIC. (Gabriel's latest v3 applesmc patch series does not fix this.) 
Maybe another register needs to be implemented somewhere?

Regards,
BALATON Zoltan
