Received: from eggs.gnu.org ([2001:4830:134:3::10]:51211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1e4Pmn-0003RB-AX
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1e4Pmi-00082a-7X
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1e4Pmh-00080F-V1
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 07:11:44 -0400
Date: Tue, 17 Oct 2017 13:11:26 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20171017111126.GF6127@andariel.pipo.sk>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016163515.GH11975@redhat.com>
	<20171017101707.5ff95d1c@nial.brq.redhat.com>
	<71e77669-5498-78a0-88b6-f634dc3727f6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Lcqw/5GzJkKu54yC"
Content-Disposition: inline
In-Reply-To: <71e77669-5498-78a0-88b6-f634dc3727f6@redhat.com>
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au


--Lcqw/5GzJkKu54yC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 17, 2017 at 12:56:28 +0200, Laszlo Ersek wrote:
> On 10/17/17 10:17, Igor Mammedov wrote:
> > On Mon, 16 Oct 2017 17:35:15 +0100
> > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >=20
> >> On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
> >>
> >> This really needs to have a commit message that provides justification
> >> for why this option is needed when we already have -S that is used
> >> to allow configuration before the guest starts.
> > Sorry, I've should have added here what I've tried to describe in cover=
 letter.
> >=20
> > -S pauses machine too late as machine is already created by the time
> > it's paused so trying to reconfigure it might require machine to be rec=
reated.
> > In case of NUMA options it might be possible to hack x86 target to
> > rebuild/override acpi/fw_cfg so it would reflect the new settings set
> > this late but I wouldn't expect that it would work in general.
> >=20
> > The cleanest way to configure it is pausing and configuring numa mapping
> > before machine is build.
>=20
> Asking from the sideline: if the NUMA mapping has to be configured so
> early, why can't it be done on the QEMU command line?
>=20
> (I asked myself the same question when I first saw your patches -- I
> couldn't find an explanation in the blurb --, so I assumed it was
> obvious and/or others would ask the same question.)

Because libvirt needs to be able to query qemu before setting stuff up.
As we already established, it's not okay to run a throwaway qemu process
to do so, so we are getting into the chicken/egg problem zone.

--Lcqw/5GzJkKu54yC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlnl5VoACgkQHGwCByjY
1Goxew//WaNGpdSrl1BJxKedUI3aa+YbATZUOO2NhesHgS1ZqnNQaluU9357qB+m
uOM0h9r4L4ytNt5emlhFsAR3W7IzE6z8psuYGQxqAGPDqqw8kUMuIAGw8TRny3wM
1Chh7vsgHdbVt1A2DjA3JFZAp7vGaIlqkz5/x55/S3SXdD95OX0D0PpVyjhcG1xm
AFK28JHQD+8OmuGH91cq6vSD9CLSRsiCXTuEkh5a7bXb9ImFxYC0GIfbeFrQ6k+K
RGJE8ErazoQh9XWdFNKSRvnFYx2x6WSXQM7N663DNq2yMVmv0WEw+SKzPxJ23nNJ
dLmFiVhJseKzaD3WfS81eDzKNP62cZfiGwBOYA33UVfo+oZSZQXqKDneNv6FgaIj
J4GRHA3PC49fCfhcbpUv0Ns9ixngauQ1ncm/rtq5yPDJwX8TMUhAgah/+KXlawuy
XK3O9J3KABRZk4SkqSnIgkkft7F1YLlnE+ekJTeKeCqDxtpY/xu5Pnikehi6iiCo
oOJ6YXjcjHDG2SXa1QYH9SW2g7Kuk1zQ0+Iu+R5JuWUuWlAH656Xq4Bl0/daiFBa
4F4T2uF5AS6PRVnNyfzcHtVMQHYMP8FVvZFgQ5H12aC7AfK12lFCUqtLWRAc1HxZ
eFKvggQQLM0Bwow0L7cF+W/MtTN2GRkpdwL6jooqLTPhE1HvCO4=
=FUDr
-----END PGP SIGNATURE-----

--Lcqw/5GzJkKu54yC--
