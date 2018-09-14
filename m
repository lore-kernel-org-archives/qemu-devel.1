Received: from eggs.gnu.org ([2001:4830:134:3::10]:40599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0llN-0004Ty-Eh
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0llK-0000r2-9K
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:55:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g0llK-0000pL-3a
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 06:55:46 -0400
Date: Fri, 14 Sep 2018 12:55:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180914105530.nxpfaqgegyktdpcp@sirius.home.kraxel.org>
References: <20180913112205.3252-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913112205.3252-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-user: define conventions for
 vhost-user backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Gonglei <arei.gonglei@huawei.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

  Hi,

> +* --pidfile=PATH
> +
> +Write the process id (PID) to the given file PATH. This is mostly
> +useful if the backend daemonize/fork itself.

Is there any reason to daemonize itself?

If not: shoud we disallow it and drop the --pidfile switch?

If yes: should we add a --daemonize switch then to control whenever the
process daemonizes itself?

Otherwise the conventions look good to me.

cheers,
  Gerd
