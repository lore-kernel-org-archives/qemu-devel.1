Received: from eggs.gnu.org ([2001:4830:134:3::10]:52570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp1q-0008Ip-7i
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp1m-0001j5-Lj
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp1m-0001iz-Fu
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:02:18 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:02:08 +0200
Message-Id: <20170602160210.1868-1-lersek@redhat.com>
In-Reply-To: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
Subject: [Qemu-devel] [seabios PATCH 0/2] romfile_loader: cope with the
 UEFI-oriented allocation extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS@seabios.org, qemu-devel@nongnu.org, edk2-devel@lists.01.org
Cc: Kevin O'Connor <kevin@koconnor.net>, "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

Please see the parent blurb
<http://mid.mail-archive.com/c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
for a high level description.

Cc: "Kevin O'Connor" <kevin@koconnor.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>

Thanks
Laszlo

Laszlo Ersek (2):
  romfile_loader: alloc: cope with the UEFI-oriented NOACPI content hint
  romfile_loader: alloc: cope with the UEFI-oriented 64BIT zone hint

 src/fw/romfile_loader.h | 14 +++++++++++---
 src/fw/romfile_loader.c |  6 +++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.9.3
