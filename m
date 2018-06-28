Received: from eggs.gnu.org ([2001:4830:134:3::10]:58621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYaU3-0002IX-K8
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYaU2-0008U8-LC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:13:27 -0400
Date: Thu, 28 Jun 2018 18:13:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180628171315.GX3513@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628132211.8795-1-rjones@redhat.com>
	<20180628132211.8795-2-rjones@redhat.com>
	<cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
	<20180628160620.GS3513@redhat.com>
	<20180628165118.GH1455@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628165118.GH1455@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Jun 28, 2018 at 05:51:18PM +0100, Richard W.M. Jones wrote:
> On Thu, Jun 28, 2018 at 05:06:20PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, Jun 28, 2018 at 09:42:18AM -0500, Eric Blake wrote:
> > > Does it make sense to forbid this operation on servers (since it on=
ly makes
> > > sense for clients)?
> >=20
> > We can't validate that here, because we can't guarantee that 'endpoin=
t'
> > is set before 'username' is set.
> >=20
> >=20
> > We could enforce it in the setter for the "loaded" property as that i=
s
> > set only after every other property is set.
>=20
> As far as I can see we could only warn here, since the set_loaded
> function returns void.

Welcome to qemu's unusual error reporting style.  You just call
error_setg(errp, ...) to report an error - return value is not
relevant - the caller simply examines whether 'Error *' is set
after the call finishes.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
