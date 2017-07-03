Received: from eggs.gnu.org ([2001:4830:134:3::10]:36417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dS0Rn-0008DE-Mc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dS0Rk-0001JF-Kx
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dS0Rk-0001Ib-Er
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:27:20 -0400
Date: Mon, 3 Jul 2017 14:27:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170703142711.0a1db036@nial.brq.redhat.com>
In-Reply-To: <ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<20170630020622-mutt-send-email-mst@kernel.org>
	<ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Fri, 30 Jun 2017 10:25:05 +0300
Marcel Apfelbaum <marcel@redhat.com> wrote:

[...]
> 
> So for the modern systems not supporting PCI ACPI hotplug
> we don't need pci-bridges anyway, but for the older ones
> the ACPI code of the pci-bridge will be loaded into the
> ACPI namespace only if a pci-bridge is actually hot-plugged.

just note that the set of 'older' guest OSes is limited to
one that do not support SHPC (i.e. to EOLed WinXP & co)
as for linux and more modern Windows SHPC hotplug should
just work without our ACPI hack (which taxes low memory
to keep acpi tables for bridges).

So I'm in favor of Michael's suggestion to leave ACPI PCI
only in PC machine for old WinXP guests and to keep Q35
clean, where linux or newer Windows guests could just
use standard SHPC.

[...]
