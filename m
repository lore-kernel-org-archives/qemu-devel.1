Received: from eggs.gnu.org ([2001:4830:134:3::10]:46996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cP39m-0005rU-Rg
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cP39i-0005jD-So
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:12:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cP39i-0005iy-Na
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 03:12:14 -0500
Message-ID: <1483603931.3966.12.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 05 Jan 2017 09:12:11 +0100
In-Reply-To: <87y3yqil7s.fsf@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
	<f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
	<8737h9xidn.fsf@mail.parknet.co.jp>
	<87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
	<1483519820.5670.45.camel@redhat.com>
	<46bcf40d-7c47-733b-44e3-b5a38527524e@reactos.org>
	<87y3yqil7s.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] ps2: Fix lost scancodes by recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Do, 2017-01-05 at 06:11 +0900, OGAWA Hirofumi wrote:
> Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:
>=20
> > Le 04/01/2017 =C3=A0 09:50, Gerd Hoffmann a =C3=A9crit :
> >> On Mi, 2016-12-28 at 04:55 +0900, OGAWA Hirofumi wrote:
> >>> With "ps2: use QEMU qcodes instead of scancodes", key handling was
> >>> changed to qcode base. But all scancodes are not converted to new one=
.
> >>>
> >>> This adds some missing qcodes/scancodes what I found in using.
> >>
> >> Added to ui queue.
> >
> > Hi Gerd,
> >
> > Your pull request (patch 01/11) contains v2 of this patch (which is inc=
omplete).
> > I've only reviewed v3, which is complete.
>=20
> Yes, please use v3. Here is copy&paste, FWIW.

Please don't send new versions of patches as reply.  That confuses
various patch management tools, they are considered being part of the
discussion then.  This is how the reviewed-by tag ended up being
attributed to the wrong patch version.

Have a look at http://patchew.org/QEMU/ for example, the patches sent as
reply don't show up there, so they are not tested automatically.

thanks,
  Gerd
