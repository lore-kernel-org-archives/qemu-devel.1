Received: from eggs.gnu.org ([2001:4830:134:3::10]:54139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eHRjY-0000B7-Ja
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 04:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eHRjT-0000af-Rg
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 04:54:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eHRjT-0000ZS-IE
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 04:54:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4AB08553E
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:54:12 +0000 (UTC)
Date: Wed, 22 Nov 2017 10:54:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171122095411.ul6tlqus3gm2ur5j@sirius.home.kraxel.org>
References: <20171120120636.GJ3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120120636.GJ3037@localhost.localdomain>
Subject: Re: [Qemu-devel] "make -C roms lgplvgabios" broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> Do we still care enough about lgplvgabios to try to fix that, or
> should we just remove the lgplvgabios rules and the roms/vgabios
> submodule?  The last commit in our vgabios.git submodule was 7
> years ago.

I plan to zap it anyway when switching to the separate firmware repo[1].
Which will probably take a while though as I'm handicapped atm with my
right arm in plaster.

Feel free to remove it earlier.

It is there as backup just in case there are regressions due to the
switch to seavgabios, but at this point in time we surely wouldn't
switch back ...

> Related to that, pc-bios/README seems to be outdated, as it says
> the VGA BIOS come from lgplvgabios, which doesn't seem to be the
> case anymore.

Indeed.

cheers,
  Gerd

[1] sneak preview with seabios and edk2 at
    https://www.kraxel.org/cgit/qemu-firmware/
