Received: from eggs.gnu.org ([2001:4830:134:3::10]:34949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5S1c-0000M7-9A
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5S1Z-0005PM-3k
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:19:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5S1Y-0005O8-Uv
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:19:37 -0400
Date: Mon, 9 Apr 2018 10:19:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180409081923.n2ktwrp2jp7xpoon@sirius.home.kraxel.org>
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

> > +{ 'enum' : 'SystemFirmwareType',
> > +  'data' : [ 'bios', 'slof', 'uboot', 'uefi' ] }
> 
> The naming here is quite a bad mixture between firmware interface
> ('bios', 'uefi') and firmware implementations ('slof', 'uboot'). There
> could be other implementations of BIOS or UEFI than SeaBIOS and EDK2 ...
> so I'd suggest to rather name them 'seabios' and 'edk2' here instead.

uboot for example implements uefi unterfaces too (dunno how complete,
but reportly recent versions can run uefi shell and grub just fine).

cheers,
  Gerd
