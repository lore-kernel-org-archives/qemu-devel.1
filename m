Received: from eggs.gnu.org ([2001:4830:134:3::10]:36017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNOo-00087J-D0
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNOk-0003oB-JI
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:14:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTNOk-0003o0-DG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:14:26 -0400
Date: Thu, 14 Jun 2018 09:14:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614081420.GG6355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180612062430.GA15344@xz-mi>
	<CAFEAcA_Bh4U1X_FDbakcc7YDBHFrkCjCKGrtuTWegn7rAGZUeQ@mail.gmail.com>
	<20180613040259.GI15344@xz-mi> <20180613092809.GF27901@redhat.com>
	<20180614025521.GR15344@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180614025521.GR15344@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Thu, Jun 14, 2018 at 10:55:21AM +0800, Peter Xu wrote:
> On Wed, Jun 13, 2018 at 10:28:09AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Jun 13, 2018 at 12:02:59PM +0800, Peter Xu wrote:
> > > On Tue, Jun 12, 2018 at 09:52:45AM +0100, Peter Maydell wrote:
> > > > On 12 June 2018 at 07:24, Peter Xu <peterx@redhat.com> wrote:
> > > > > For example, I wanted to compile QEMU once and install it on mu=
ltiple
> > > > > systems.  What would be the suggested way to do so?
> > > >=20
> > > > For this, I would recommend using whatever the packaging
> > > > format for those systems is. Eg for Debian use the existing
> > > > Debian QEMU packages, for Redhat systems use RPMs, etc.
> > > > If you want a newer version of QEMU than is in the distro's
> > > > packages, you can probably forward port the packaging parts
> > > > to a newer QEMU without too much pain.
> > > >=20
> > > > Or you can use a distro-agnostic packaging tool of some sort;
> > > > there are a few out there but I have no particular recommendation=
s.
> > >=20
> > > I'll start my investigation with RPM first.  Thanks Peter.
> >=20
> > If you're interested in Fedora, I maintain a Copr repository which
> > provides RPMs for every QEMU version since 1.4.0 and every libvirt
> > version since 1.2.0...
> >=20
> >   https://copr.fedorainfracloud.org/coprs/berrange/virt-ark/
> >=20
> > Yeah, Fedora 28 is missing, but I'll be adding it real soon.
>=20
> Good to know this.
>=20
> Then is there an easy way to port the specfile and tools to QEMU
> repository so that we can pack that even with a git tree?

The QEMU spec I'm using for virt-ark is very much cut-down and simplified
and doesn't try to follow best practices for packaging [1]

Well if we want to have a RPM spec file for QEMU distributed with upstrea=
m
QEMU, then I think it would be better todo what libvirt does[2], and simp=
ly
have the real Fedora  specfile kept in QEMU git [3].

Regards,
Daniel

[1] https://pagure.io/virt-ark/blob/master/f/qemu-ark.spec.in
[2] https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dblob;f=3Dlibvirt.spec.in=
;hb=3DHEAD
[3] https://src.fedoraproject.org/rpms/qemu/blob/master/f/qemu.spec
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
