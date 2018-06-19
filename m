Received: from eggs.gnu.org ([2001:4830:134:3::10]:50168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fVBWt-0007ES-54
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1fVBWo-00082O-8p
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:58:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1fVBWo-00082I-3R
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 03:58:14 -0400
Date: Tue, 19 Jun 2018 15:58:08 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20180619075808.GB23983@wei-ubt>
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-6-git-send-email-wexu@redhat.com>
	<f94057e1-5d6f-c90d-5b21-d1cd561d6d53@redhat.com>
	<20180606033815.GA3749@wei-ubt>
	<04a61e4a-f0ae-0e7d-03aa-c488e89fd1ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04a61e4a-f0ae-0e7d-03aa-c488e89fd1ca@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 5/8] virtio: queue pop for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: jfreimann@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com

On Wed, Jun 06, 2018 at 11:41:18AM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 11:38, Wei Xu wrote:
> >>>+
> >>>+    head =3D vq->last_avail_idx;
> >>>+    i =3D head;
> >>>+
> >>>+    caches =3D vring_get_region_caches(vq);
> >>>+    cache =3D &caches->desc;
> >>>+    vring_packed_desc_read(vdev, &desc, cache, i);
> >>I think we'd better find a way to avoid reading descriptor twice.
> >Do you mean here and the read for empty check?
> >
> >Wei
> >
>=20
> Yes.

OK, will figure it out.

>=20
> Thanks
>=20
>=20
