Received: from eggs.gnu.org ([2001:4830:134:3::10]:50837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fDXhQ-0002RC-1Y
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fDXhP-0002vm-AH
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:00:16 -0400
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f41972e8-0ae2-7c1d-a66a-499a841080e3@redhat.com>
Date: Tue, 1 May 2018 17:59:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Expand ECAM region in machvirt 2_13?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu list <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Hi,

I would like to resume the discussion on extending the number of PCI
buses to 256 (as in Q35) as a follow-up of past discussions:
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03631.html.

With the current 16MB ECAM region we are limited to 16 PCIe busses.

Could we envision to have a 256MB ECAM region and move it to another
location beyond 256GB, in virt2_13 machine type?

Current ECAM range within [0x3f000000, 0x40000000]
would be kept unchanged for legacy and when vms->highmem is set to false.
Migration from <2_13 to >=2_13 would be allowed whereas migration from
> =2.13 to <2.13 wouldn't.

Thanks

Eric
