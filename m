Received: from eggs.gnu.org ([2001:4830:134:3::10]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eGr82-0001dQ-D2
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.priebe@profihost.ag>) id 1eGr7z-0006pj-49
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:49:10 -0500
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:42526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.priebe@profihost.ag>)
	id 1eGr7y-0006nU-PG
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 13:49:07 -0500
From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Message-ID: <71615aa0-1c39-a4bc-b5f1-770f2feeb1ba@profihost.ag>
Date: Mon, 20 Nov 2017 19:48:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] kvm: Failed to flush the L2 table cache: Input/output
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hello,

while using qemu 2.9.1 and doing a backup of a disk:

I have sometimes the following output:

Formatting '/mnt/qemu-249-2017_11_19-04_00_05.qcow2', fmt=qcow2
size=236223201280 encryption=off cluster_size=65536 lazy_refcounts=off
refcount_bits=16


followed by:

kvm: Failed to flush the L2 table cache: Input/output error
kvm: Failed to flush the refcount block cache: Input/output error

If this error happens (Failed to flush) the whole backup is incomplete.
Host kernel is a 4.4 based openSuSE 42.3 kernel.

Is this a known bug?

Greets,
Stefan
