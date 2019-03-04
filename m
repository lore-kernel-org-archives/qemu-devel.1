Received: from eggs.gnu.org ([209.51.188.92]:53368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0p01-0004rN-Bw
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1h0ozv-00016s-Hu
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:55:24 -0500
Date: Mon, 4 Mar 2019 15:54:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190304155457.206a7ff7@redhat.com>
In-Reply-To: <20190304135909.GL4239@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<15464582-e8a6-6654-7679-15d87c10af38@redhat.com>
	<20190304145510.57c73177@redhat.com>
	<20190304135909.GL4239@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [libvirt] [PATCH 1/2] numa: deprecate
 'mem' parameter of '-numa node' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, 4 Mar 2019 13:59:09 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Mar 04, 2019 at 02:55:10PM +0100, Igor Mammedov wrote:
> > On Mon, 4 Mar 2019 09:11:19 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >  =20
> > > On 01/03/2019 18.48, Daniel P. Berrang=C3=A9 wrote:
> > > [...] =20
> > > > So I think this patch has to be dropped & replaced with one that
> > > > simply documents that memdev syntax is preferred.   =20
> > >=20
> > > That's definitely not enough. I've had a couple of cases already where
> > > we documented that certain options should not be used anymore, and
> > > people simply ignored it (aka. if it ain't broken, don't do any chang=
e).
> > > Then they just started to complain when I really tried to remove the
> > > option after the deprecation period. =20
> >  =20
> > > So Igor, if you can not officially deprecate these things here yet, y=
ou
> > > should at least make sure that they can not be used with new machine
> > > types anymore. Then, after a couple of years, when we feel sure that
> > > there are only some few or no people left who still use it with the o=
ld
> > > machine types, we can start to discuss the deprecation process again,=
 I
> > > think. =20
> > Is it acceptable to silently disable CLI options (even if they are brok=
en
> > like in this case) for new machine types?
> > I was under impression that it should go through deprecation first. =20
>=20
> Yes, it must go through deprecation. I was saying we can't disable
> the CLI options at all, until there is a way for libvirt to correctly
> use the new options.

I'm not adding new options (nor plan to for numa case (yet)),
-numa node,memdev is around several years by now and should be used
as default for creating new configs.

In light of keeping 'mem' option around for old machines,
Deprecation should have served for notifying users that legacy
options will be disabled later on (for new machines at least
if no way found for migration compatible transition for older ones).

What I'm mainly aiming here is to prevent using broken legacy options
for new VMs (like in RHBZ1624223 case) and deprecation is the only way
we have now to notify users about CLI breaking changes.

In the -mem-path/prealloc case, there will be a new machine option 'memdev'
to replace them but that's migration compatible, so libvirt could use new
CLI syntax to replace even old configs.
(If there is a mechanism for introducing/introspecting a new options
per-machine or whole QEMU, I'd happy to add a new option there on top of
just deprecation notice that we have now).

> Regards,
> Daniel
