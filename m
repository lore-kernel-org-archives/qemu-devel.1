Received: from eggs.gnu.org ([2001:4830:134:3::10]:38566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePUq-0005sr-Ei
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePUm-0003sl-Gc
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cePUm-0003sc-A5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:05:28 -0500
References: <cover.1487224954.git.ben@skyportsystems.com>
	<06770233aa4bcf873f68632f1c60c6fa91b02779.1487224954.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f753e287-09de-3063-a51d-28f26e939a40@redhat.com>
Date: Thu, 16 Feb 2017 18:05:25 +0100
MIME-Version: 1.0
In-Reply-To: <06770233aa4bcf873f68632f1c60c6fa91b02779.1487224954.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 3/8] ACPI: Add vmgenid blob storage to
 the build tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com

On 02/16/17 07:18, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This allows them to be centrally initialized and destroyed
> 
> The "AcpiBuildTables.vmgenid" array will be used to construct the
> "etc/vmgenid_guid" fw_cfg blob.
> 
> Its contents will be linked into fw_cfg after being built on the
> pc_machine_done() -> acpi_setup() -> acpi_build() call path, and dropped
> without use on the subsequent, guest triggered, acpi_build_update() ->
> acpi_build() call path.
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/aml-build.c         | 2 ++
>  include/hw/acpi/aml-build.h | 1 +
>  2 files changed, 3 insertions(+)

Tested-by: Laszlo Ersek <lersek@redhat.com>
