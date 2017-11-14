Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eEixd-0000M5-J2
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1eEixZ-0005m8-LG
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:41:37 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:41360
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1eEixZ-0005iO-E6
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 16:41:33 -0500
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ce62c001-2273-c850-88f8-592fc58766c9@weilnetz.de>
Date: Tue, 14 Nov 2017 22:41:28 +0100
MIME-Version: 1.0
In-Reply-To: <20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add new PCI ID for i82559a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, jasowang@redhat.com, mst@redhat.com

Am 06.11.2017 um 21:35 schrieb Mike Nawrocki:
> Adds a new PCI ID for the i82559a (0x8086 0x1030) interface. Enables
> this ID with a new property "use-alt-device-id" to preserve
> compatibility.
> 
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  hw/net/eepro100.c    | 12 ++++++++++++
>  include/hw/pci/pci.h |  1 +
>  qemu-options.hx      |  2 +-
>  3 files changed, 14 insertions(+), 1 deletion(-)


Sorry that I missed this patch.
I think I should have an entry for eepro100 in MAINTAINERS.

Mike, which hardware uses i82559a with PCI device id 0x1030?

https://www.intel.com/content/www/us/en/support/articles/000005612/network-and-i-o/ethernet-products.html
only lists devices with
0x1229.

Thanks,
Stefan
