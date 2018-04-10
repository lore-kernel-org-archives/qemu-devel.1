Received: from eggs.gnu.org ([2001:4830:134:3::10]:56641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5mJY-0004GD-GH
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5mJU-0006Lq-LI
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:59:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5mJU-0006LU-HE
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:59:28 -0400
Date: Tue, 10 Apr 2018 07:59:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180410055914.3ak6niwxjkpph26u@sirius.home.kraxel.org>
References: <20180407000117.25640-1-lersek@redhat.com>
	<bf5fc85b-0695-3bd0-117d-759d5dbd4546@redhat.com>
	<6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bfdae78-909f-e7ad-b0f0-25f76dfd81f7@redhat.com>
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

> I threw in "-kernel" because, although it also (usually?) means
> "memory", I expected people would want it separate.
> 
> Regarding memory vs. pflash, I thought that these two, combined with the
> access permissions, could cover all of RAM, ROM, and read-only and
> read-write pflash too.
> 
> So, "-bios" (-> ROM) boils down to "memory", with write access denied --
> please see the SeaBIOS example near the end.

Hmm, I'm wondering whenever it is useful to model things this way.  It's
not like you can actually configure things for -bios seabios.rom or
-kernel uboot.elf.  Only pflash allows to actually configure things, and
there are not that many useful combinations.  The code needs
Read+Execute.  Allowing Write could be useful in theory, to allow the
guest doing firmware updates.  But I think nobody actually does that, so
in practice it is fixed.  The varstore can have different permissions,
but it's only two useful combinations.  Either allow access
unconditionally, or allow access in secure contect (aka smm) only.

cheers,
  Gerd
