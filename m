Received: from eggs.gnu.org ([209.51.188.92]:47876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw4dV-0007J9-G8
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gw4dT-0001sD-R1
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:36:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gw4dR-0001qR-Rz
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:36:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 167AE8667D
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 12:36:19 +0000 (UTC)
Date: Tue, 19 Feb 2019 13:36:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190219123613.amgwx7sgzbcgazic@sirius.home.kraxel.org>
References: <20190219101510.9356-1-kraxel@redhat.com>
	<a7050f62-b56f-cc1a-7600-5197b83a27ac@redhat.com>
	<20190219121258.rua536oattwkwgkc@sirius.home.kraxel.org>
	<20190219121946.GG7154@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219121946.GG7154@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] audio: don't use alsa by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

> > So SDL has the same problem (possibly only when using alsa).
> > 
> > Hmm.  Dropping can_be_default here will too break sound on BSD ...
> 
> We could temporarily put the Linux default ordering back to have "oss"
> before sdl/alsa until the initialization code in sdl/alsa can be fixed to
> correctly detect working audio.

Reordering doesn't help, they would still probe successfully and fail
later, only after oss probe failed ...

pa is ok, when the daemon isn't running init() fails properly.

cheers,
  Gerd
