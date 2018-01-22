Received: from eggs.gnu.org ([2001:4830:134:3::10]:38580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1edYrS-0006Cz-SD
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1edYrP-0003Lb-R5
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:57:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1edYrP-0003HS-Ip
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:57:51 -0500
Date: Mon, 22 Jan 2018 09:57:42 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180122095742.GA20014@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180115155413.GJ32271@localhost.localdomain>
	<2f56a075-ba01-4329-b46c-33b3d40000cb@oracle.com>
	<CAOMFOmXs17F4WnLZ_ThvYoNDO7R557vf3QNHSYq6RR_WvkL3uA@mail.gmail.com>
	<ce8aad47-a63f-f5ba-2a56-7f3a18a44ab8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce8aad47-a63f-f5ba-2a56-7f3a18a44ab8@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH QEMU v1 0/4] multiboot: bss_end_addr can be
 zero / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, daniel.kiper@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 19, 2018 at 04:18:07PM -0800, Jack Schwartz wrote:
> Hi Anatol, Daniel and Kevin.
>=20
> On 01/19/18 10:36, Anatol Pomozov wrote:
> > Hello Jack
> >=20
> > On Wed, Jan 17, 2018 at 12:06 PM, Jack Schwartz
> > <jack.schwartz@oracle.com> wrote:
> > > Hi Kevin and Anatol.
> > >=20
> > > Kevin, thanks for your review.
> > >=20
> > > More inline below...
> > >=20
> > > On 01/15/18 07:54, Kevin Wolf wrote:
> > > > Am 21.12.2017 um 18:25 hat Jack Schwartz geschrieben:
> > > > > Properly account for the possibility of multiboot kernels with =
a zero
> > > > > bss_end_addr.  The Multiboot Specification, section 3.1.3 allow=
s for
> > > > > kernels without a bss section, by allowing a zeroed bss_end_add=
r
> > > > > multiboot
> > > > > header field.
> > > > >=20
> > > > > Do some cleanup to multiboot.c as well:
> > > > > - Remove some unused variables.
> > > > > - Use more intuitive header names when displaying fields in mes=
sages.
> > > > > - Change fprintf(stderr...) to error_report
> > > > There are some conflicts with Anatol's (CCed) multiboot series:
> > > > https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg03003=
.html
> > > >=20
> > > > None if these should be hard to resolve, but it would be good if =
you
> > > > could agree with each other whose patch series should come first,=
 and
> > > > then the other one should be rebased on top of that.
> > > Anatol,
> > >=20
> > > from my side, there are pros and cons to either patch set going in =
first,
> > > but advantages to either are pretty negligible.  Pro for you going =
first: I
> > > can use the constants you will define in header files.  Pro for me =
going
> > > first: your merge should be about the same as if you went first (si=
nce my
> > > changes are small, more localized and affect only multiboot.c) and =
my merge
> > > will be easier.
> > >=20
> > > What are your thoughts?
> > Please move ahead with your patches. I'll rebase my changes on top of=
 yours.
> OK.=C2=A0 I'm consulting with my company's legal department and waiting=
 for their
> approvals for delivery of a test "kernel".=C2=A0 I'll get in touch will=
 everyone
> once I have an answer about that.=C2=A0 I anticipate about a week befor=
e taking
> next steps to deliver.
>=20
> Kevin and Daniel, thanks for your inputs on this issue (different
> subthread), which I have forwarded to our legal department for review.

FWIW, I don't think it needs to be your responsibility to decide this. I
think the QEMU community / maintainer taking the patches needs to decide
whether it is acceptable / desirable.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
