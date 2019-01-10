Received: from eggs.gnu.org ([209.51.188.92]:49517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghXKU-0003wn-A1
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghXKS-00030l-LC
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:12:50 -0500
Date: Thu, 10 Jan 2019 10:12:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190110101243.GE2178@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
	<3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
	<20190109172801.GB3998@redhat.com>
	<d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
	<60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60b7e2bf-6822-6e0b-7184-b38594eb38ed@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jan 09, 2019 at 03:25:53PM -0600, Eric Blake wrote:
> On 1/9/19 3:20 PM, Paolo Bonzini wrote:
> > On 09/01/19 18:28, Daniel P. Berrang=C3=A9 wrote:
> >>> so both files include each other, how nice ...
> >> If the header files are mutually dependent it makes me wonder what t=
he
> >> point of having them split up is ?
> >>
> >> Feels like either they need to be merged, or they need to be split u=
p
> >> and refactored even more to remove the mutual dependancy.
> >=20
> > If they include each other only for the typedefs, then prehaps the
> > solution is to change the coding style and allow using struct in
> > function prototypes.  I'm pretty sure there are several examples of t=
his
> > already.
>=20
> Or stick the typedef in <typedefs.h>, instead of trying to find (or
> create) some other common header.

Probably better to just have a local  spapr_types.h instead of
polluting the global namespace.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
