Received: from eggs.gnu.org ([2001:4830:134:3::10]:32942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8SVU-0001Kd-7U
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8SVQ-0007SR-8w
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:59:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8SVQ-0007SB-26
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:59:08 -0400
Date: Fri, 5 Oct 2018 17:58:50 +0200
From: "Hoffmann, Gerd" <kraxel@redhat.com>
Message-ID: <20181005155850.vci6pt27rumdlq6t@sirius.home.kraxel.org>
References: <20180914135230.15178-1-marcandre.lureau@redhat.com>
	<20181005135052.GA4113@lpt>
	<CAMxuvawF+5=GyP70FNzS3zWfoe7Ca667hMKqmjWkhCe_bNCCMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMxuvawF+5=GyP70FNzS3zWfoe7Ca667hMKqmjWkhCe_bNCCMg@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Kaplansky, Victor" <victork@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, libvir-list <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Felipe Franciosi <felipe@nutanix.com>, "Liu, Changpeng" <changpeng.liu@intel.com>

  Hi,

> For example, "virgl" support may not be implemented. This
> --print-capabilities is a simple way to check what the backend
> implements.

What is the expected behavior in case virgl is implemented by the
backend, but not available (due to lack of 3d hardware in the host for
example) ?

cheers,
  Gerd
