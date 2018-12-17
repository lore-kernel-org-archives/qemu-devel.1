Received: from eggs.gnu.org ([2001:4830:134:3::10]:35806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYib6-0003MR-Rx
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 21:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYib0-0006nP-K0
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 21:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gYib0-0006m6-C7
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 21:25:26 -0500
Date: Sun, 16 Dec 2018 21:25:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181216212513-mutt-send-email-mst@kernel.org>
References: <1543467132-2873-1-git-send-email-liq3ea@gmail.com>
	<CAKXe6SL+aYFgbHDHq2jBogfBDKrO3a1=xaKyqeNV_-f_Gm5DAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXe6SL+aYFgbHDHq2jBogfBDKrO3a1=xaKyqeNV_-f_Gm5DAw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] hw: vmmouse: use link property
 instead of DEFINE_PROP_PTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com, Darren Kenny <darren.kenny@oracle.com>, Markus Armbruster <armbru@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On Mon, Dec 17, 2018 at 09:10:06AM +0800, Li Qiang wrote:
> Ping....Paolo, could these patches go to your misc tree?
>=20
> Thanks,
> Li Qiang


Fine by me

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Li Qiang <liq3ea@gmail.com> =E4=BA=8E2018=E5=B9=B411=E6=9C=8829=E6=97=A5=
=E5=91=A8=E5=9B=9B=E4=B8=8B=E5=8D=8812:53=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     According https://wiki.qemu.org/Contribute/BiteSizedTasks
>     the 'DEFINE_PROP_PTR' should be replaced by QOM link property.
>     The first patch replace constant strings with TYPE_XXXX and move so=
me
>     definition to pc.h header file so that the second patch can work.
>=20
>     Change since v2: detail commit message
>     Change since v1: fix some issues per Markus' review
>=20
>     Li Qiang (2):
>     =C2=A0 hw: pc: use TYPE_XXX instead of constant strings
>     =C2=A0 hw: vmmouse: Use link instead of pointer property
>=20
>     =C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++=
----
>     =C2=A0hw/i386/vmmouse.c=C2=A0 =C2=A0 | 18 +++++++++++-------
>     =C2=A0include/hw/i386/pc.h |=C2=A0 3 +++
>     =C2=A03 files changed, 19 insertions(+), 11 deletions(-)
>=20
>     --
>     2.11.0
>=20
>=20
