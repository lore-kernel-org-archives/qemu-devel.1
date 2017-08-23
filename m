Received: from eggs.gnu.org ([2001:4830:134:3::10]:45678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkRDg-0003IX-4j
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dkRDd-0007w6-2W
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:41:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dkRDc-0007vb-S3
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:40:56 -0400
Date: Wed, 23 Aug 2017 10:40:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170823104051.36488fcb@nial.brq.redhat.com>
In-Reply-To: <1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1503372250-5092-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1503372250-5092-3-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/2] ACPI/unit-test: Add a new testcase
 for RAM allocation in numa node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com

On Tue, 22 Aug 2017 11:24:10 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> As QEMU supports the memory-less node, it is possible that there is
> no RAM in the first numa node(also be called as node0). eg:
>   ... \
>   -m 128,slots=3,maxmem=1G \
>   -numa node -numa node,mem=128M \
> 
> But, this makes it hard for QEMU to build a known-to-work ACPI SRAT
> table. Only fixing it is not enough.
> 
> Add a testcase for this situation to make sure the ACPI table is
> correct for guest.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  tests/acpi-test-data/pc/DSDT.numamem  | Bin 0 -> 6463 bytes
>  tests/acpi-test-data/pc/SLIT.numamem  | Bin 0 -> 48 bytes
>  tests/acpi-test-data/pc/SRAT.numamem  | Bin 0 -> 264 bytes
>  tests/acpi-test-data/q35/DSDT.numamem | Bin 0 -> 9147 bytes
>  tests/acpi-test-data/q35/SLIT.numamem | Bin 0 -> 48 bytes
>  tests/acpi-test-data/q35/SRAT.numamem | Bin 0 -> 264 bytes
>  tests/bios-tables-test.c              |  30 ++++++++++++++++++++++++++++++
>  7 files changed, 30 insertions(+)
>  create mode 100644 tests/acpi-test-data/pc/DSDT.numamem
>  create mode 100644 tests/acpi-test-data/pc/SLIT.numamem
>  create mode 100644 tests/acpi-test-data/pc/SRAT.numamem
>  create mode 100644 tests/acpi-test-data/q35/DSDT.numamem
>  create mode 100644 tests/acpi-test-data/q35/SLIT.numamem
>  create mode 100644 tests/acpi-test-data/q35/SRAT.numamem


considering only SRAT table has been changed and the other
tables match with default blobs, I'd suggest to keep only
  tests/acpi-test-data/[pc|q35]/SRAT.numamem
in this patch and drop the rest of *.numamem tables
as test case should fallback to default tables
when .numamem variant doesn't exists
