Received: from eggs.gnu.org ([209.51.188.92]:48708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdix-0005Ba-6r
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJdiu-00076Z-Va
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:43:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJdiu-000757-Iy
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:43:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so3599308wmb.5
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 05:43:32 -0700 (PDT)
References: <20190425104326.12835-1-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0fdbbd5b-0ed3-0f45-8b9d-d5f5f2c76a89@redhat.com>
Date: Thu, 25 Apr 2019 14:43:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190425104326.12835-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Igor Mammedov <imammedo@redhat.com>

On 4/25/19 12:43 PM, Laszlo Ersek wrote:
> Repo:      https://github.com/lersek/qemu.git
> Branch:    smbios_lp_1821884
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
> 
> In
> 
>   [Qemu-devel] [PATCH for 4.1 v2 09/13]
>   tests: acpi: ignore SMBIOS tests when UEFI firmware is used
> 
> at
> 
>   http://mid.mail-archive.com/1553605799-168605-10-git-send-email-imammedo@redhat.com
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07037.html
> 
> Igor had to temporarily exclude SMBIOS unit testing with UEFI guests.
> 
> Let the BiosTablesTest guest UEFI app report the SMBIOS entry point(s),
> so that SMBIOS unit tests can cover UEFI guests.
> 
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> 
> Thanks
> Laszlo
> 
> Laszlo Ersek (2):
>   tests/uefi-test-tools: report the SMBIOS entry point structures
>   tests/uefi-boot-images: report the SMBIOS entry point structures
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

Series:
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
