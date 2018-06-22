Received: from eggs.gnu.org ([2001:4830:134:3::10]:51060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWHdF-0000Wd-Ps
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fWHdC-0007l0-DU
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:41:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fWHdC-0007kh-8T
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:41:22 -0400
Date: Fri, 22 Jun 2018 09:41:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180622084117.GA23296@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615154203.11347-1-berrange@redhat.com>
	<20180615154203.11347-9-berrange@redhat.com>
	<48a79954-a9a7-cd76-40f2-c99e69ffb087@redhat.com>
	<20180621153941.GO3615@redhat.com>
	<8736xgjdvg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8736xgjdvg.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/11] authz: add QAuthZList object type
 for an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Thu, Jun 21, 2018 at 06:36:19PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Thu, Jun 21, 2018 at 10:28:23AM -0500, Eric Blake wrote:
> >> On 06/15/2018 10:42 AM, Daniel P. Berrang=C3=A9 wrote:
> >> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >> >=20
> >> > Add a QAuthZList object type that implements the QAuthZ interface.=
 This
> >> > built-in implementation maintains a trivial access control list wi=
th a
> >> > sequence of match rules and a final default policy. This replicate=
s the
> >> > functionality currently provided by the qemu_acl module.
> >> >=20
> >>=20
> >> >=20
> >> > It is not currently possible to create this via -object, since the=
re is
> >> > no syntax supported to specify non-scalar properties for objects. =
This
> >> > is likely to be addressed by later support for using JSON with -ob=
ject,
> >> > or an equivalent approach.
> >>=20
> >> Is this statement slightly stale, since we have JSON support with --=
object
> >> already?
> >
> > That's news to me if we do. Markus did a PoC but AFAIK it was never
> > proposed for merge so far.
>=20
> Correct.  Can finish the job if there's a need.
>=20
> [...]

I'm not hugely bothered by it - this QAuthZList impl serves two core
purposes - a replacement for the HMP monitor commands I deprecated,
an an engine for the QAuthZListFile which stores QAuthZList objects in
external json files. The latter is what I think we'll use in practice,
as it lets us auto-refresh on the fly via inotify which is much more
convenient than having libvirt do object_add/object_del.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
