Received: from eggs.gnu.org ([2001:4830:134:3::10]:49519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWNEV-0001X7-Ej
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cWNES-0000JE-8M
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cWNES-0000J1-2V
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:03:24 -0500
References: <cover.1485308342.git.ben@skyportsystems.com>
	<01f010147f8faaf7bd7c4ea94a364a584f323b0a.1485308342.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ce9b8f71-2bf2-01a1-a19f-9bcc82b716a3@redhat.com>
Date: Wed, 25 Jan 2017 14:03:21 +0100
MIME-Version: 1.0
In-Reply-To: <01f010147f8faaf7bd7c4ea94a364a584f323b0a.1485308342.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/9] linker-loader: Add new 'allocate
 and return address' cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org

On 01/25/17 02:43, ben@skyportsystems.com wrote:
> From: Ben Warren <ben@skyportsystems.com>
> 
> This adds a new linker-loader command to instruct the guest to allocate
> memory for a fw_cfg file and write the address back into another
> writeable fw_cfg file.  Knowing this address, QEMU can then write into
> guest memory at runtime.
> 
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hw/acpi/bios-linker-loader.c         | 71 ++++++++++++++++++++++++++++++++++--
>  include/hw/acpi/bios-linker-loader.h |  7 ++++
>  2 files changed, 75 insertions(+), 3 deletions(-)

The OVMF side for this is now tracked by:

https://bugzilla.tianocore.org/show_bug.cgi?id=359

Thanks
Laszlo
