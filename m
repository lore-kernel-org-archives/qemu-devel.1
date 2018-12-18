Received: from eggs.gnu.org ([2001:4830:134:3::10]:38682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZGVb-00086J-MQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZGVZ-0005ud-SS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:38:07 -0500
Date: Tue, 18 Dec 2018 14:36:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181218143648.GA4807@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181218110333.22558-1-philmd@redhat.com>
	<20181218092648-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218092648-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Fix strncpy() warnings for GCC8 new
 -Wstringop-truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Ben Pye <ben@curlybracket.co.uk>, Stefan Weil <sw@weilnetz.de>, Howard Spoelstra <hsp.cat7@gmail.com>, Jeff Cody <jcody@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Thomas Huth <thuth@redhat.com>, Liu Yuan <namei.unix@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, 1803872@bugs.launchpad.net, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 18, 2018 at 09:31:00AM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 18, 2018 at 12:03:30PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
> > GCC 8 new warning prevents builds to success since quite some time.
> > First report on the mailing list is in July 2018:
> > https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03723.html
> >=20
> > Various intents has been sent to fix this:
> > - Incorrectly using g_strlcpy()
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03705.html
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg03706.html
> > - Using assert() and strpadcpy()
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03938.html
> > - Use #pragma GCC diagnostic ignored "-Wstringop-truncation"
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> > - adding an inline wrapper with said pragma in there
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> > - -Wno-stringop-truncation is the makefile
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04261.html
> >=20
> > This series replace the strncpy() calls by strpadcpy() which seemed
> > to me the saniest option.
> >=20
> > Regards,
> >=20
> > Phil.
>=20
> Do you happen to know why does it build fine with
> Gcc 8.2.1?
>=20
> Reading the GCC manual it seems that
> there is a "nostring" attribute that means

typo - its "nonstring"

> "might not be 0 terminated".
> I think we should switch to that which fixes the warning
> but also warns if someone tries to misuse these
> as C-strings.
>=20
> Seems to be a better option, does it not?

Yes, it does look best as gcc manual explicitly suggests "nonstring"
as the way to stop this strncpy warning.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
