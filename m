Received: from eggs.gnu.org ([2001:4830:134:3::10]:36363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1eFDqW-0001YJ-Re
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.weil@weilnetz.de>) id 1eFDqT-0004SF-PK
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:40:20 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:53324
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.weil@weilnetz.de>)
	id 1eFDqT-0004R8-IH
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:40:17 -0500
From: Stefan Weil <sw@weilnetz.de>
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
	<ce62c001-2273-c850-88f8-592fc58766c9@weilnetz.de>
	<7bb60d60-28d4-3c37-2740-fd16d7c6856a@gtri.gatech.edu>
Message-ID: <2e6d4835-e277-fd46-12bc-612c7e57a6f4@weilnetz.de>
Date: Thu, 16 Nov 2017 07:40:14 +0100
MIME-Version: 1.0
In-Reply-To: <7bb60d60-28d4-3c37-2740-fd16d7c6856a@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add new PCI ID for i82559a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, jasowang@redhat.com, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>

Am 15.11.2017 um 14:09 schrieb Michael Nawrocki:
> Hi Stefan,
>
> I've got a VxWorks driver binary that explicitly looks for device ID
> 0x1030 (which is admittedly not ideal). It seems like the "82559
> InBusiness 10/100" hardware uses this, though I've had trouble finding
> an official source. The following documents reference that ID:
>
> https://pci-ids.ucw.cz/read/PC/8086/1030
> http://ks.pams.ncsu.edu/pub/ncsuscyld/i386/misc/src/trees/hdstg2/modules/pcitable
>
> https://cateee.net/lkddb/web-lkddb/E100.html
>
> And I found a similar post on a different mailing list that might shed
> some light:
> http://www.beowulf.org/pipermail/eepro100/2000-January/000760.html
>
> It looks like the 8255x series of devices have a number of potential
> IDs; maybe a property to set a specific PCI device ID would work?
>
> Thanks,
> Mike

Yes, that might be a very general solution which could be applied to all
PCI devices.
It could even be extended to include the vendor ID or any PCI
configuration value
as well.

Nevertheless the technically correct solution would be a full emulation
of the
EEPROM. Then we could provide an EEPROM for the 82559 InBusiness 10/100",
and the data from that EEPROM would set the right PCI device ID.

Jason, until we get a better solution, the last commit should be
reverted before
the new QEMU version is made. That commit also added a wrong help text.

Regards
Stefan
