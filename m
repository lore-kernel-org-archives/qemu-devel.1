Received: from eggs.gnu.org ([2001:4830:134:3::10]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5mcA-00056S-LF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:18:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5mc7-0007gI-Hd
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:18:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5mc7-0007g2-CS
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 02:18:43 -0400
Date: Tue, 10 Apr 2018 08:18:40 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180410061840.k263ac2b2lgnwi5c@sirius.home.kraxel.org>
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<20180409081923.n2ktwrp2jp7xpoon@sirius.home.kraxel.org>
	<43fbc488-20d6-f5de-0a56-6c28355cc4d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43fbc488-20d6-f5de-0a56-6c28355cc4d4@redhat.com>
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

  Hi,

> > uboot for example implements uefi unterfaces too (dunno how complete,
> > but reportly recent versions can run uefi shell and grub just fine).
> 
> Indeed: when I was struggling with this enum type and tried to look for
> more firmware types to add, my googling turned up the "UEFI on Top of
> U-Boot" whitepaper, from Alex and Andreas :)

In case you wanna play: uboot supports x86 qemu meanwhile, so you can
try install u-boot.git-x86 from my firmware repo, then run
"qemu-system-x86_64 -bios /usr/share/u-boot.git/x86/qemu-pc/u-boot.rom".

It certainly isn't a useful edk2 replacement atm.  It has no virtio
drivers.  And even when using ide storage its not like it would happily
boot a fedora live iso.  So I certainly wouldn't tag that as uefi today.
That might change at some point in the future though.

> Again, this reaches to the root of the problem: when a user creates a
> new domain, using high-level tools, they just want to tick "UEFI". (Dan
> has emphasized this to me several times, so I think I get the idea by
> now, if not the full environment.) We cannot ask the user, "please be
> more specific, do you want UEFI from edk2, or UEFI on top of U-Boot?"

Well, in case the uefi support in u-boot is good enough some day then it
doesn't matter to the user whenever uboot or edk2 boots the efi guest
from disk/iso, right?

cheers,
  Gerd
