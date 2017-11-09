Received: from eggs.gnu.org ([2001:4830:134:3::10]:42559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCgKG-0000M3-9r
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCgKB-00032v-8w
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eCgKB-00032T-3j
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:28:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 28255C04AC56
	for <qemu-devel@nongnu.org>; Thu,  9 Nov 2017 06:28:26 +0000 (UTC)
Date: Thu, 9 Nov 2017 07:28:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171109062821.nquhgziygo6mwoqi@sirius.home.kraxel.org>
References: <20171108144809.56305-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108144809.56305-1-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, lersek@redhat.com, imammedo@redhat.com

On Wed, Nov 08, 2017 at 04:48:09PM +0200, Marcel Apfelbaum wrote:
> Currently there is no MMIO range over 4G
> reserved for PCI hotplug. Since the 32bit PCI hole
> depends on the number of cold-plugged PCI devices
> and other factors, it is very possible is too small
> to hotplug PCI devices with large BARs.
> 
> Fix it by reserving 2G for I4400FX chipset
> in order to comply with older Win32 Guest OSes
> and 32G for Q35 chipset.
> 
> Note this is a regression since prev QEMU versions had
> some range reserved for 64bit PCI hotplug.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
