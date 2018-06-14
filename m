Received: from eggs.gnu.org ([2001:4830:134:3::10]:38404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTIQ7-0008Bn-Az
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTIQ3-0003pt-FM
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:55:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fTIQ3-0003pe-2G
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:55:27 -0400
Date: Thu, 14 Jun 2018 10:55:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180614025521.GR15344@xz-mi>
References: <20180612062430.GA15344@xz-mi>
	<CAFEAcA_Bh4U1X_FDbakcc7YDBHFrkCjCKGrtuTWegn7rAGZUeQ@mail.gmail.com>
	<20180613040259.GI15344@xz-mi> <20180613092809.GF27901@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180613092809.GF27901@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Jun 13, 2018 at 10:28:09AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jun 13, 2018 at 12:02:59PM +0800, Peter Xu wrote:
> > On Tue, Jun 12, 2018 at 09:52:45AM +0100, Peter Maydell wrote:
> > > On 12 June 2018 at 07:24, Peter Xu <peterx@redhat.com> wrote:
> > > > For example, I wanted to compile QEMU once and install it on mult=
iple
> > > > systems.  What would be the suggested way to do so?
> > >=20
> > > For this, I would recommend using whatever the packaging
> > > format for those systems is. Eg for Debian use the existing
> > > Debian QEMU packages, for Redhat systems use RPMs, etc.
> > > If you want a newer version of QEMU than is in the distro's
> > > packages, you can probably forward port the packaging parts
> > > to a newer QEMU without too much pain.
> > >=20
> > > Or you can use a distro-agnostic packaging tool of some sort;
> > > there are a few out there but I have no particular recommendations.
> >=20
> > I'll start my investigation with RPM first.  Thanks Peter.
>=20
> If you're interested in Fedora, I maintain a Copr repository which
> provides RPMs for every QEMU version since 1.4.0 and every libvirt
> version since 1.2.0...
>=20
>   https://copr.fedorainfracloud.org/coprs/berrange/virt-ark/
>=20
> Yeah, Fedora 28 is missing, but I'll be adding it real soon.

Good to know this.

Then is there an easy way to port the specfile and tools to QEMU
repository so that we can pack that even with a git tree?

Regards,

--=20
Peter Xu
