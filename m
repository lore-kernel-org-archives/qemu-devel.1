Received: from eggs.gnu.org ([2001:4830:134:3::10]:34511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fD6rx-0000Q0-2e
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fD6rt-0008Pm-T7
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:21:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fD6rt-0008PC-NH
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 07:21:17 -0400
Date: Mon, 30 Apr 2018 13:21:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180430132107.0a37704d.cohuck@redhat.com>
In-Reply-To: <20180430103312.GH3249@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430103312.GH3249@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 30 Apr 2018 11:33:12 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, Apr 27, 2018 at 04:51:03PM +0100, Peter Maydell wrote:
> > Hi; I usually let people forget about releases for a month or
> > so before bringing this topic up, but:
> >=20
> > (1) do we want to call the next release 2.13, or something else?
> > There's no particular reason to bump to 3.0 except some combination of
> >  * if we keep going like this we'll get up to 2.42, which starts to
> >    get silly
> >  * Linus-style "avoid being too predictable"
> >  * triskaidekaphobia
> > but maybe we should anyway? =20
>=20
> I'm in favour of changnig the major version to 3.0, but when we do
> so we should also define a clear rule we can follow for major version
> bumps, so we don't have the same silly debate for how we pick 4.0,
> 5.0 etc.
>=20
> Given, that we have a clear deprecation process now, my view is that
> we should formally declare that major version numbers changes are
> meaningless. As soon as you try to assign special meaning to major
> version changes, you open the door to endless debate about whether
> a particular set of changes is meaningful enough to justify the
> major version change, leading to eventually 2.42.=20

I agree.

>=20
> Two possible options
>=20
>  a) Bump major version once a year, so we'll have 3.0, 3.1, 3.3,
>     4.0, 4.1, 4.2, 5.0, ...etc  We missed the first release this
>     year, so we would only have 3.0 and 3.1 this year.
>=20
>  b) Bump major release when minor version gets double-digits.
>     eg 3.0, 3.1, ...., 3.9, 3.9, 4.0, ...., 4.9, 5.0...
>=20
> Personally I'd go for (a). If we do this, it doesn't preclude
> us from just happening to do some releases that are backwards
> incompatible. Our deprecation policy has provided us a way to
> have a backwards incompatible change in ANY release we make.
> We just have to ensure people are forewarned of what's coming.

If we bump the major version each year anyway, why not go the whole way
and use 2018.1, 2018.2, ... (or even <year>.<month>)? The nice thing
about that is that you can see at a glance when the release took place.
The drawback is that stable updates might look a bit awkward, but I
don't think that's too bad, as we don't do multiple stable branches.

>=20
> If it was an incredibly large & disruptive incompatible change,
> we might none the less choose to align its arrival with a major
> version bump. That's ok. We simply do not require that a major
> version change has to have a major incompatibility.

I'm not really in favour of that. "The major version means nothing
special, except when it does"? Also, cue the "is this change disruptive
enough?" discussions :)
