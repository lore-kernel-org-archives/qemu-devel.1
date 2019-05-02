Received: from eggs.gnu.org ([209.51.188.92]:49665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5Qm-0007fx-DQ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hM5Qf-0003zG-PT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hM5Qc-0003mu-K1
	for qemu-devel@nongnu.org; Thu, 02 May 2019 02:42:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C1018553D
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 06:42:41 +0000 (UTC)
Date: Thu, 2 May 2019 08:42:38 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190502064238.42mqoy2bv53yrirl@sirius.home.kraxel.org>
References: <20190419075625.24251-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419075625.24251-1-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-4.1 0/2] Fix ohci_die() and move PCI
 code to separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Fri, Apr 19, 2019 at 09:56:23AM +0200, Thomas Huth wrote:
> First patch fixes a problem with ohci_die(), second patch moves PCI code into
> a separate file, so that the sysbus OHCI device can also be used without
> the dependency on the PCI code.
> 
> v2: Split the patch into two patches, one for the ohci_die() fix and one
>     for the PCI code movement.
> 
> Thomas Huth (2):
>   hw/usb/hcd-ohci: Do not use PCI functions with sysbus devices in
>     ohci_die()
>   hw/usb/hcd-ohci: Move PCI-related code into a separate file

Added to usb queue.

thanks,
  Gerd
