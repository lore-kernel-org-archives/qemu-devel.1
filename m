Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fk2wQ-0008V8-0Y
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fk2wO-00044Z-Vp
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 03:50:06 -0400
Date: Mon, 30 Jul 2018 15:49:52 +0800
From: yuchenlin <yuchenlin@synology.com>
Message-ID: <6616ccd2-847b-4f5b-bdcd-e0c4d6a2263a@Mail>
In-Reply-To: <96bc216a-d335-dd36-06f0-5985bb52df53@weilnetz.de>
References: <20180730024701.7613-1-yuchenlin@synology.com>
	<96bc216a-d335-dd36-06f0-5985bb52df53@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH 0/2] Refine some vdi code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Hi, Stefan

I agree that redundancy of If else may helps people to understand the cod=
e.

However, CON=46IG=5FVDI=5FWRITE only contributes:

=23if defined(CON=46IG=5FVDI=5FWRITE)
.bdrv=5Fco=5Fpwritev =3D vdi=5Fco=5Fpwritev,
=23endif

I think we don't need CON=46IG=5FVDI=5FWRITE to document the code.
As its name implies, vdi=5Fco=5Fpwritev shows the code parts for vdi writ=
e support.


I appreciated your time and effort for reviews.

Regards,
yuchenlin


Stefan Weil <sw=40weilnetz.de> =E6=96=BC 2018-07-30 15:13 =E5=AF=AB=E9=81=
=93=EF=BC=9A
> Am 30.07.2018 um 04:46 schrieb yuchenlin=40synology.com: > =46rom: yuch=
enlin <yuchenlin=40synology.com> > > This series refine some code in vdi.=
c, includes: > > * Remvoe CON=46IG=5FVDI=5FWRITE because there is no reas=
on to leave an always on > and cannot configure option in the code-side. =
> * decouple if else if chain to get more readability. > > Thanks, > yuch=
enlin > > yuchenlin (2): > vdi: remove CON=46IG=5FVDI=5FWRITE > vdi: refi=
ne code for vdi=5Fopen > > block/vdi.c =7C 32 ++++++++++++++++++---------=
----- > 1 file changed, 18 insertions(+), 14 deletions(-) Technically the=
se changes are fine, but personally I prefer my old code. If else is rend=
undant here, but redundancy helps humans to understand the code. CON=46IG=
=5FVDI=5FWRITE still has a similar function as it documents which code pa=
rts are relevant for write support. Stefan  =20
