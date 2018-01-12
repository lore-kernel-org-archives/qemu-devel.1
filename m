Received: from eggs.gnu.org ([2001:4830:134:3::10]:57902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ea1Wp-0005XA-4A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ea1Wk-0001Hc-8x
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:45:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ea1Wk-0001HQ-20
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:45:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EF1D2FDC
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 15:45:53 +0000 (UTC)
Date: Fri, 12 Jan 2018 17:45:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180112174431-mutt-send-email-mst@kernel.org>
References: <1515665816-10313-1-git-send-email-ghammer@redhat.com>
	<20180111215210-mutt-send-email-mst@kernel.org>
	<CAA2ifQycadzATfW4w0icnskOgLTB1MUT2cMxVOt4=ZMWwgL=TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA2ifQycadzATfW4w0icnskOgLTB1MUT2cMxVOt4=ZMWwgL=TQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: improve virtio devices
 initialization time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gal Hammer <ghammer@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Jan 12, 2018 at 10:48:21AM +0200, Gal Hammer wrote:
>=20
> On Thu, Jan 11, 2018 at 9:52 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>=20
>     On Thu, Jan 11, 2018 at 12:16:56PM +0200, Gal Hammer wrote:
>     > The loading time of a VM is quite significant when its virtio
>     > devices uses a large amount of virt-queues (e.g. a virtio-serial
>     > device with
>     =E2=80=8B=E2=80=8B
>     max_ports=3D511). Most of the time is spend in the
>     > creation of all the required event notifiers (ioeventfd and memor=
y
>     > regions).
>     >
>     > This patch pack all the changes to the memory regions in a
>     > single memory transaction.
>     >
>     > Reported-by: Sitong Liu <siliu@redhat.com>
>     > Reported-by: Xiaoling Gao <xiagao@redhat.com>
>     > Signed-off-by: Gal Hammer <ghammer@redhat.com>
>=20
>     Nice patch! Any timing numbers to share before/after?
>=20
>=20
> Thanks. Unfortunately I made a mistake in the shutdown code (the transa=
ction
> is wrapping the code which doesn't modify the memory regions), so a V2 =
is on
> its way.
>=20
> As for the timing. Running a VM with 25 virtio-serial devices,=E2=80=8B=
 each one with
> max_ports=3D511, results in a boot time of around 30 minutes. With this=
 patch
> (and a another patch to kvm) reduce it to approximately 3 minutes.

Good to know, sounds like an important fix to have.
Since you plan to do v2 anyway, please add this info
in the commit log.


> This was reported and tracked here: https://bugzilla.redhat.com/show_bu=
g.cgi?id
> =3D1528588
>=20
> =C2=A0=C2=A0=C2=A0 Gal.
