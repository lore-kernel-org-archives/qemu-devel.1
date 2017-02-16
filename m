Received: from eggs.gnu.org ([2001:4830:134:3::10]:39939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePas-0003rP-IZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePao-0005dy-KA
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:11:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cePao-0005di-F0
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:11:42 -0500
References: <cover.1487224954.git.ben@skyportsystems.com>
	<625570854359178b416000644f68695bc50630ae.1487224954.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <68730a47-a8fc-bfde-75e6-5a4f237cf89f@redhat.com>
Date: Thu, 16 Feb 2017 18:11:39 +0100
MIME-Version: 1.0
In-Reply-To: <625570854359178b416000644f68695bc50630ae.1487224954.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/8] ACPI: Add Virtual Machine
 Generation ID support
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
> This implements the VM Generation ID feature by passing a 128-bit
> GUID to the guest via a fw_cfg blob.
> Any time the GUID changes, an ACPI notify event is sent to the guest
> 
> The user interface is a simple device with one parameter:
>  - guid (string, must be "auto" or in UUID format
>    xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  default-configs/i386-softmmu.mak     |   1 +
>  default-configs/x86_64-softmmu.mak   |   1 +
>  hw/acpi/Makefile.objs                |   1 +
>  hw/acpi/vmgenid.c                    | 239 +++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c                 |  16 +++
>  include/hw/acpi/acpi_dev_interface.h |   1 +
>  include/hw/acpi/vmgenid.h            |  35 +++++
>  7 files changed, 294 insertions(+)
>  create mode 100644 hw/acpi/vmgenid.c
>  create mode 100644 include/hw/acpi/vmgenid.h

I compared this version against v6. It looks good. I also tested it
(with the fixup I mentioned under v7 1/8, and without live migration).

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
