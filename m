Received: from eggs.gnu.org ([2001:4830:134:3::10]:58251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFyuU-0001EP-Qz
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFyuK-0000eR-4F
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 06:00:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gFyuJ-0000ds-QP
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEABA311C3D0
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:59:54 +0000 (UTC)
Date: Fri, 26 Oct 2018 10:59:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181026095943.GG31390@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<nycvar.YSQ.7.76.1810261213001.8270@xnncv>
	<20181026094208.GD31390@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181026094208.GD31390@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Fri, Oct 26, 2018 at 10:42:08AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Oct 26, 2018 at 12:33:55PM +0530, P J P wrote:
> >   Hello Dan, all
> >=20
> > +-- On Thu, 25 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
> > | On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
> > | > While being at it deprecate cirrus too.
> > | >=20
> > | > Reason (short version): use stdvga instead.
> > | > Verbose version:
> > | >     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-conside=
red-harmful
> > |=20
> > |=20
> > | I don't debate the points in the blog post above that stdvga is a
> > | better choice, but I don't think that's enough to justify deprecati=
ng
> > | cirrus at this point in time, because when it then gets deleted it
> > | will break way too many existing deployments.
> > |=20
> > | We need to socialize info in that blog post above more widely and
> > | especially ensure that apps are not using that by default. I don't
> > | see it being viable to formally deprecate it in QEMU any time soon
> > | though given existing usage.
> >=20
> > To note, IMO there are other devices/sources in QEMU which are potent=
ial=20
> > candidates for deprecation, similar to adlib etc. It'll help if we co=
uld=20
> > device a process to deprecate/remove such code base. Other than maint=
enance it=20
> > invariably also becomes source of security issues.
> >=20
> > Ex.(similar to Fedora) we could announce such candidate on qemu-devel=
 list and=20
> > after review over a period of say a month, candidate will be
> > deprecated/expunged. (thinking aloud)
>=20
> QEMU has a deprecation process:
>=20
>   https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
>=20
> Most of the stuff deprecated is CLI args / monitor commands, etc where
> mgmt apps just adjust the way they are calling QEMU, so end user's VMs
> are largely not impacted.
>=20
> Deprecating a device type that is widely used is not desirable because
> that will cause breakage of existing guests.  Distros are free to disab=
le
> devices in their builds if they want to reduce the scope for CVEs in
> packages they maintain, but again they should think carefully about how
> many users they are going to break by doing so.

I should also say that QEMU as an upstream project has multiple goals.
Running KVM guests with modern PV hardware is only one of them, albeit
a widely used one. Being able to run old legacy OS with old hardware,
and running arbitrary embedded boards/devices with emulation are both
use cases that QEMU project aims to address. To eliminate all the old
"crufty" device emulation in name of improving security for KVM, would
be to eliminate core use cases of the project. THis is why we're trying
to persue the direction of making it easier for vendors to disable
features and devices they don't wish to support & thus limit their
downstream CVE exposure.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
