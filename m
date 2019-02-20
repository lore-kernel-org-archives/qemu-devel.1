Received: from eggs.gnu.org ([209.51.188.92]:39228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gwG7P-0000Iw-Ic
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gwG7B-0005Df-8R
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:52:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gwG6t-0003ni-9m
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 19:51:43 -0500
Date: Wed, 20 Feb 2019 08:46:17 +0800
From: Wei Xu <wexu@redhat.com>
Message-ID: <20190220004617.GA23868@wei-ubt>
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-12-git-send-email-wexu@redhat.com>
	<ba86ca50-73e8-1c06-8ab0-0e8b74aeac58@redhat.com>
	<20190219112312.GA1582@wei-ubt>
	<4e786e43-4ef0-f463-5be4-7d264d6d35be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e786e43-4ef0-f463-5be4-7d264d6d35be@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/11] virtio: CLI and provide packed
 ring feature bit by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: tiwei.bie@intel.com, maxime.coquelin@redhat.com, qemu-devel@nongnu.org, jfreiman@redhat.com, mst@redhat.com

On Tue, Feb 19, 2019 at 09:33:40PM +0800, Jason Wang wrote:
>=20
> On 2019/2/19 =E4=B8=8B=E5=8D=887:23, Wei Xu wrote:
> >On Tue, Feb 19, 2019 at 03:32:19PM +0800, Jason Wang wrote:
> >>On 2019/2/14 =E4=B8=8B=E5=8D=8812:26,wexu@redhat.com  wrote:
> >>>From: Wei Xu<wexu@redhat.com>
> >>>
> >>>Add userspace and vhost kernel/user support.
> >>>
> >>>Add CLI "ring_packed=3Dtrue/false" to enable/disable packed ring pro=
vision.
> >>>Usage:
> >>>     -device virtio-net-pci,netdev=3Dxx,mac=3Dxx:xx:xx:xx:xx:xx,ring=
_packed=3Dfalse
> >>>
> >>>By default it is provided.
> >>Please compat this for old machine types.
> >It is provided by default, how to make it compatible for old machine t=
ypes?
> >Hide or provide it?
> >
> >Wei
> >
>=20
> Take a look at e.g how pc_compat_3_1 and hw_compat_3_1 was used.

OK, thanks.

Wei
>=20
> Thanks
>=20
>=20
