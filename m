Received: from eggs.gnu.org ([2001:4830:134:3::10]:51899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFydg-0005H5-Pm
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gFydc-00080Q-U7
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gFydY-0007IM-Sw
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:42:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E835308A967
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 09:42:19 +0000 (UTC)
Date: Fri, 26 Oct 2018 10:42:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181026094208.GD31390@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<nycvar.YSQ.7.76.1810261213001.8270@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1810261213001.8270@xnncv>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Fri, Oct 26, 2018 at 12:33:55PM +0530, P J P wrote:
>   Hello Dan, all
>=20
> +-- On Thu, 25 Oct 2018, Daniel P. Berrang=C3=A9 wrote --+
> | On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
> | > While being at it deprecate cirrus too.
> | >=20
> | > Reason (short version): use stdvga instead.
> | > Verbose version:
> | >     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considere=
d-harmful
> |=20
> |=20
> | I don't debate the points in the blog post above that stdvga is a
> | better choice, but I don't think that's enough to justify deprecating
> | cirrus at this point in time, because when it then gets deleted it
> | will break way too many existing deployments.
> |=20
> | We need to socialize info in that blog post above more widely and
> | especially ensure that apps are not using that by default. I don't
> | see it being viable to formally deprecate it in QEMU any time soon
> | though given existing usage.
>=20
> To note, IMO there are other devices/sources in QEMU which are potentia=
l=20
> candidates for deprecation, similar to adlib etc. It'll help if we coul=
d=20
> device a process to deprecate/remove such code base. Other than mainten=
ance it=20
> invariably also becomes source of security issues.
>=20
> Ex.(similar to Fedora) we could announce such candidate on qemu-devel l=
ist and=20
> after review over a period of say a month, candidate will be
> deprecated/expunged. (thinking aloud)

QEMU has a deprecation process:

  https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features

Most of the stuff deprecated is CLI args / monitor commands, etc where
mgmt apps just adjust the way they are calling QEMU, so end user's VMs
are largely not impacted.

Deprecating a device type that is widely used is not desirable because
that will cause breakage of existing guests.  Distros are free to disable
devices in their builds if they want to reduce the scope for CVEs in
packages they maintain, but again they should think carefully about how
many users they are going to break by doing so.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
