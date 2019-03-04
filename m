Received: from eggs.gnu.org ([209.51.188.92]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0o7n-0001tP-Dt
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0o7m-0000Au-Gp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:59:23 -0500
Date: Mon, 4 Mar 2019 13:59:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190304135909.GL4239@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1551454936-205218-1-git-send-email-imammedo@redhat.com>
	<1551454936-205218-2-git-send-email-imammedo@redhat.com>
	<20190301154947.GJ21251@redhat.com>
	<20190301183328.20b63e23@redhat.com>
	<20190301174806.GN21251@redhat.com>
	<15464582-e8a6-6654-7679-15d87c10af38@redhat.com>
	<20190304145510.57c73177@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190304145510.57c73177@redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org, ehabkost@redhat.com, libvir-list@redhat.com, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au

On Mon, Mar 04, 2019 at 02:55:10PM +0100, Igor Mammedov wrote:
> On Mon, 4 Mar 2019 09:11:19 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > On 01/03/2019 18.48, Daniel P. Berrang=C3=A9 wrote:
> > [...]
> > > So I think this patch has to be dropped & replaced with one that
> > > simply documents that memdev syntax is preferred. =20
> >=20
> > That's definitely not enough. I've had a couple of cases already wher=
e
> > we documented that certain options should not be used anymore, and
> > people simply ignored it (aka. if it ain't broken, don't do any chang=
e).
> > Then they just started to complain when I really tried to remove the
> > option after the deprecation period.
>=20
> > So Igor, if you can not officially deprecate these things here yet, y=
ou
> > should at least make sure that they can not be used with new machine
> > types anymore. Then, after a couple of years, when we feel sure that
> > there are only some few or no people left who still use it with the o=
ld
> > machine types, we can start to discuss the deprecation process again,=
 I
> > think.
> Is it acceptable to silently disable CLI options (even if they are brok=
en
> like in this case) for new machine types?
> I was under impression that it should go through deprecation first.

Yes, it must go through deprecation. I was saying we can't disable
the CLI options at all, until there is a way for libvirt to correctly
use the new options.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
