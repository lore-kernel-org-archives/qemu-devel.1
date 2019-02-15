Received: from eggs.gnu.org ([209.51.188.92]:52087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guaE0-00038m-Cy
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1guaDy-0001Y1-Hj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:56:04 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:49501)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1guaDy-0001RT-A1
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 04:56:02 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
	by localhost (Postfix) with SMTP id 516F67465DE
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 10:55:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 39D057465DA
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 10:55:59 +0100 (CET)
Date: Fri, 15 Feb 2019 10:55:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1902151046540.80982@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: [Qemu-devel] MemoryRegionOps access sizes
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

Could someone please explain how the MemoryRegionOps 
valid.{min,max}_access_size and unaligned and corresponding impl 
constraints work and where are these implemented? And in particular if 
this would work:

static const MemoryRegionOps ops = {
     .read = readfn,
     .write = writefn,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
     .endianness = DEVICE_LITTLE_ENDIAN,
};

This is related to this question:
http://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg03157.html
but that's probably ignored in the middle of a thread so I ask separately.

Thank you,
BALATON Zoltan
