Received: from eggs.gnu.org ([2001:4830:134:3::10]:48780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPNnB-0005p4-Ij
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 03:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPNn7-0004hi-L1
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 03:23:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPNmz-0004ST-04
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 03:23:15 -0500
Date: Wed, 21 Nov 2018 09:23:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181121082307.3fa3nd7cuu3canx4@sirius.home.kraxel.org>
References: <B328F08581D714418202ABF306D3781C3B774417@dggeml509-mbx.china.huawei.com>
	<20181120152325.ekxhvjndzgflijvb@sirius.home.kraxel.org>
	<B328F08581D714418202ABF306D3781C3B776FA6@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B328F08581D714418202ABF306D3781C3B776FA6@dggeml509-mbx.china.huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiAgQ2FuJ3Qgc2VlIG1vdXNlIGN1cnNv?=
 =?utf-8?q?r_on_VNC_viewer?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guoheyi <guoheyi@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

  Hi,

> and can=E2=80=99t see cursor either with =E2=80=9Cvirtio-gpu=E2=80=9D. =
Does that mean
> virtio-gpu + VNC must rely on VNC client to draw the cursor image on
> the screen?

Yes.  virtio-gpu sends the cursor to the vnc client (via rich cursor
extension) and expects the vnc client to show it.  So, if you ask your
vnc client to not show the rich cursor the cursor is gone.  Solution:
don't do that.

stdvga has no hardware cursor support, so it is rendered to the
framebuffer (by the guest).

cirrus hardware cursor can't be mapped to rich cursor,
so it is rendered to the framebuffer too (by qemu this time).

cheers,
  Gerd
