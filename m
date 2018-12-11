Received: from eggs.gnu.org ([2001:4830:134:3::10]:60656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWcgt-0004hL-31
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWcgp-0001Di-VL
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:42:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWcgp-0001DJ-Oo
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 02:42:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1702C049580
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 07:42:46 +0000 (UTC)
Date: Tue, 11 Dec 2018 08:42:41 +0100
From: "Hoffmann, Gerd" <kraxel@redhat.com>
Message-ID: <20181211074241.ovuharwewaw22ygq@sirius.home.kraxel.org>
References: <20181126124250.29985-1-marcandre.lureau@redhat.com>
	<20181126124250.29985-2-marcandre.lureau@redhat.com>
	<20181210142956.wucn33osm7fxa27d@sirius.home.kraxel.org>
	<CAMxuvawUrZ=y-txTS86Tz3b-BYY05k4n-jBiY8+vO5e7AOkPKA@mail.gmail.com>
	<20181210183313-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210183313-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH for-3.2 01/11] vhost-user: define
 conventions for vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "P. Berrange, Daniel" <berrange@redhat.com>

  Hi,

> Right. The main issue is that we need to make sure only
> in-tree devices are supported.

Well, that is under debate right now, see:
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04912.html

> vhost-user by design
> is for out of tree users. It needn't be hard,
> maybe it's enough to just make qemu launch these processes
> as opposed to connecting to them on command line.

Not sure this is a good idea, with security being one of the motivating
factors to move device emulation to other processes.  When libvirt
launches the processes it can place them in separate sandboxes ...

cheers,
  Gerd
