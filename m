Received: from eggs.gnu.org ([2001:4830:134:3::10]:47979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmYLL-000277-0k
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fmYLH-0007He-Sc
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:46:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fmYLH-0007HN-LM
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 01:46:07 -0400
References: <20180805112850.26063-1-mark.cave-ayland@ilande.co.uk>
	<20180805112850.26063-2-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ded9736c-2445-2e9d-7fcd-d1fd1f849f73@redhat.com>
Date: Mon, 6 Aug 2018 07:46:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180805112850.26063-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] sysbus: always allow
 explicit_ofw_unit_address() to override address generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, ehabkost@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, qemu-devel@nongnu.org

On 08/05/2018 01:28 PM, Mark Cave-Ayland wrote:
> Some SysBusDevices either use sysbus_init_mmio() without
> sysbus_mmio_map() or the first MMIO memory region doesn't represent the
> bus address, causing a firmware device path with an invalid address to
> be generated.
> 
> SysBusDeviceClass does provide a virtual explicit_ofw_unit_address()
> method that can be used to override this process, but it was originally intended
> only as as a fallback option meaning that any existing MMIO memory regions still
> take priority whilst determining the firmware device address.
> 
> There is currently only one user of explicit_ofw_unit_address() and that
> is the PCI expander bridge (PXB) device which has no MMIO/PIO resources
> defined. This enables us to allow explicit_ofw_unit_address() to take
> priority without affecting backwards compatibility, allowing the address
> to be customised as required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/core/sysbus.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

Looks reasonable.

Reviewed-by: Thomas Huth <thuth@redhat.com>
