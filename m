Received: from eggs.gnu.org ([209.51.188.92]:48344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD0V-0002AD-Po
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD0U-0001Lg-Qv
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD0U-0001LT-Ke
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:48:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8DAD3151C41
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 14:48:17 +0000 (UTC)
Date: Thu, 2 May 2019 16:48:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190502164812.3f8a6564@Igors-MacBook-Pro>
In-Reply-To: <20190425104326.12835-1-lersek@redhat.com>
References: <20190425104326.12835-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] tests/uefi-test-tools: report the
 SMBIOS entry point structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Philippe =?UTF-8?Q?Mathieu-Da?= =?UTF-8?Q?ud=C3=A9?= <philmd@redhat.com>

On Thu, 25 Apr 2019 12:43:24 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> Repo:      https://github.com/lersek/qemu.git
> Branch:    smbios_lp_1821884
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
[...]
> 
> Laszlo Ersek (2):
>   tests/uefi-test-tools: report the SMBIOS entry point structures
>   tests/uefi-boot-images: report the SMBIOS entry point structures

Tested-by: Igor Mammedov <imammedo@redhat.com>

> 
>  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h     |  25 +++++++++++++++-----
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf |   2 ++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c   |  23 ++++++++++++++----
>  tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2           | Bin 11776 -> 12288 bytes
>  tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2               | Bin 11776 -> 11776 bytes
>  tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2              | Bin 12800 -> 13312 bytes
>  tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2            | Bin 13312 -> 13312 bytes
>  7 files changed, 40 insertions(+), 10 deletions(-)
> 
