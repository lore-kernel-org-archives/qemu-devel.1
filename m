Received: from eggs.gnu.org ([2001:4830:134:3::10]:46733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkLiR-0001Cl-3y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkLiO-0004t0-1x
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dkLiN-0004sd-RS
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 22:48:19 -0400
Date: Wed, 23 Aug 2017 05:48:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170823053601-mutt-send-email-mst@kernel.org>
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] hw/acpi-build: Fix ACPI SRAT Memory
 Affinity building
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On Tue, Aug 22, 2017 at 11:24:08AM +0800, Dou Liyang wrote:
> V3 --> v4:
>   -add a new testcase.
> 
> This patchset fixs an ACPI building bug which caused by no RAM
> in the first NUAM node. and also add a new testcase for the bug.

thanks!
Pls remember to ping or repost after release is out.

> Dou Liyang (2):
>   hw/acpi-build: Fix SRAT memory building when there is no memory in
>     node0
>   ACPI/unit-test: Add a new testcase for RAM allocation in numa node
> 
>  hw/i386/acpi-build.c                  |  78 ++++++++++++++++++++++------------
>  tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
>  tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
>  tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
>  tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
>  tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
>  tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
>  tests/bios-tables-test.c              |  30 +++++++++++++
>  8 files changed, 80 insertions(+), 28 deletions(-)
>  create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
>  create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
>  create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
>  create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
>  create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
>  create mode 100644 tests/acpi-test-data/q35/SRAT.numamem
> 
> -- 
> 2.5.5
> 
> 
