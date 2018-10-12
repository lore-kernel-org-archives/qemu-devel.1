Received: from eggs.gnu.org ([2001:4830:134:3::10]:49394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAubP-0002vB-1f
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:23:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAubL-0005o1-QP
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:23:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAubL-0005mh-JI
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:23:23 -0400
Date: Fri, 12 Oct 2018 12:23:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181012102311.uojhijhdrbaxrjw3@sirius.home.kraxel.org>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181011154834.GA10122@redhat.com>
	<20181012093757.GT16720@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012093757.GT16720@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Victor Kaplansky <victork@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Felipe Franciosi <felipe@nutanix.com>, Changpeng Liu <changpeng.liu@intel.com>

  Hi,

> Note, I can't remember what Markus had proposed for CLI arguments in
> QAPI, so I invented something arbitary but plausible.

Using qapi visitors to parse the command line.  Used by -blockdev and
-display (and maybe others meanwhile).  See parse_display_qapi().

I think Daniels suggestion was to do that in the backends ...

cheers,
  Gerd
