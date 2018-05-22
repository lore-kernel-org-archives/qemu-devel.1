Received: from eggs.gnu.org ([2001:4830:134:3::10]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1fL8Rs-0008TM-QQ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1fL8Ro-0006hM-Ql
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:39:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:1203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1fL8Ro-0006gf-Ii
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:39:32 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Tue, 22 May 2018 14:39:28 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B65CBBD@SHSMSX103.ccr.corp.intel.com>
References: <1526682016-17336-1-git-send-email-changpeng.liu@intel.com>
	<20180522131120.GM21655@stefanha-x1.localdomain>
In-Reply-To: <20180522131120.GM21655@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vhost-blk: turn on pre-defined RO feature
 bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Tuesday, May 22, 2018 6:11 AM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: qemu-devel@nongnu.org; mst@redhat.com
> Subject: Re: [PATCH] vhost-blk: turn on pre-defined RO feature bit
>=20
> On Sat, May 19, 2018 at 06:20:16AM +0800, Changpeng Liu wrote:
> > Read only feature shouldn't be negotiable, because if the
> > backend device reported Read only feature supported, QEMU
> > host driver shouldn't change backend's RO attribute.
>=20
> I don't understand this patch.
>=20
> Does it make *all* virtio-blk devices read-only?
If the slave target reported RO feature, the disk in OS should be RO, curre=
ntly
users should specify in QEMU command to enable RO.
>=20
> Or is the idea that the vhost-user slave has to clear the read-only bit
> if it is a writable device?
Exactly.
>=20
> Stefan
