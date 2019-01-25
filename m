Received: from eggs.gnu.org ([209.51.188.92]:53689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmvU6-0007Lk-2r
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 02:01:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmvQv-0008DZ-7e
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:57:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmvQv-0008Cg-1M
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 01:57:45 -0500
Date: Fri, 25 Jan 2019 07:57:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190125065743.ti6asoydf5hprzz6@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<da5485bb1a115b2cfd3a4484cb5f351c026ae4db.1547681517.git.DirtY.iCE.hu@gmail.com>
	<20190117092212.ccv7zv4snnuanxtw@sirius.home.kraxel.org>
	<75f937a5-4ab7-fdf5-f14c-e1ec87226c4a@gmail.com>
	<20190124074224.vuwxr6gith4txvmj@sirius.home.kraxel.org>
	<20190124111922.j2dduwjpm76con7w@sirius.home.kraxel.org>
	<e48f9c9d-0953-feeb-4818-ad7f208c519c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e48f9c9d-0953-feeb-4818-ad7f208c519c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/50] audio: reduce glob_audio_state
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 24, 2019 at 09:12:58PM +0100, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2019-01-24 12:19, Gerd Hoffmann wrote:
> >   Hi,
> >=20
> >> So, I think with the first part the only open issue is whenever we g=
o
> >> with the nested types (i.e. patch #1 as-is) or not.  Given that the
> >> one-element-structs added in that patch will get additional fields I
> >> think the nesting makes sense.
> >=20
> > Spoke too soon: scripts/checkpatch.pl flags a bunch of codestyle issu=
es.
>=20
> Most of them are about the code style of the old audio subsystem, I
> fixed some of them but not everything.  IIRC last time it wasn't a
> problem, but it was in 2015.  Should I go over them again and fix all o=
f
> them?

The first ones I saw where not a old audio codestyle (which is
whitespace-after-function-name mostly) issues but newly introduced ones.
A few rules have been added since 2015.

Fixing the existing issues due to old audio code style (when
changing/moving code) is fine, but not required.  Newly added code
should follow usual qemu code style.

cheers,
  Gerd
