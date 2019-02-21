Received: from eggs.gnu.org ([209.51.188.92]:45202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwl2U-0007Tz-7L
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwkpl-0007UB-W5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:40:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwkpi-0007GP-2S
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B62E5E6A9E
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 09:39:38 +0000 (UTC)
Date: Thu, 21 Feb 2019 10:39:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221093933.zyrln3sevyiztubg@sirius.home.kraxel.org>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
	<20190208112357.31615-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208112357.31615-14-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 13/13] RFC: add explicit can_migrate to
 vhost_user_backend_dev_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

> Since this is not well specified, add a common blocker for the
> VhostUserBackend users (vhost-user-input and upcoming gpu will use
> it).
> 
> RFC since I am not sure that's what Michael had in mind when
> requesting such blocker.

vmstate_vhost_input blocks migration too (via .unmigratable = 1).
One way to block live migration is enough.

I think it makes sense to do it per device.  virtio-input doesn't carry
much state, so live-migrating it shouldn't be that difficuilt.
virtio-gpu will be harder ...

cheers,
  Gerd
