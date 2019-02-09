Received: from eggs.gnu.org ([209.51.188.92]:39959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gsSRF-0005Nm-Bj
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gsSRD-0002yn-DJ
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:12:57 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:59058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gsSRB-0002tV-DP
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:12:53 -0500
Date: Sat, 9 Feb 2019 14:12:43 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190209131243.uiob7rzcwi3paw77@function>
References: <20190208181122.23393-1-marcandre.lureau@redhat.com>
	<20190208181122.23393-5-marcandre.lureau@redhat.com>
	<20190209114041.ibd3adln5vw4iky5@function>
	<CAMxuvaxT-ULfE8-EmVbX1muCrTXyUPQ7V574R9J6gSy0uabg6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaxT-ULfE8-EmVbX1muCrTXyUPQ7V574R9J6gSy0uabg6w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH slirp 4/5] slirp: add state saving/loading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau, le sam. 09 f=C3=A9vr. 2019 14:09:02 +0100, a ecri=
t:
> On Sat, Feb 9, 2019 at 12:40 PM Samuel Thibault <samuel.thibault@gnu.or=
g> wrote:
> >
> > marcandre.lureau@redhat.com, le ven. 08 f=C3=A9vr. 2019 19:11:21 +010=
0, a ecrit:
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > Based on qemu vmstate serialization code. At this point it should
> > > produce the same result. However, with future state versions, slirp
> > > should be free to change its format, by bumping the reported state
> > > version.
> >
> > Mmm, then qemu needs to be taught to call slirp_state_save/load/versi=
on?
>=20
> Yes, see "[Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp"

Ah, I did have a look there but somehow missed it because burried within
file removals :)

Samuel
