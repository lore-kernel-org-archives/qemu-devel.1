Received: from eggs.gnu.org ([209.51.188.92]:44816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1nF-0007aN-Nw
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1ls-0005ga-QT
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm1ls-0005T8-IQ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:31:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 373EF2D7ED
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:43:42 +0000 (UTC)
Date: Tue, 22 Jan 2019 14:43:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122144328.GU13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-3-berrange@redhat.com>
	<7c67886c-2d80-76e3-8826-70c059ecddff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c67886c-2d80-76e3-8826-70c059ecddff@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] trace: enforce that every
 trace-events file has a final newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Jan 18, 2019 at 11:42:14AM -0600, Eric Blake wrote:
> On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > When generating the trace-events-all file, the build system simply
> > concatenates all the individual trace-events files. If any one of tho=
se
> > files does not have a final newline, the printf format string will ha=
ve
> > the contents of the first line of the next file appended to it, which=
 is
> > usually a '#' comment.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  hw/gpio/trace-events          | 2 +-
> >  scripts/tracetool/__init__.py | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >=20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Does checkpatch and/or patchew flag what are intended to be text files
> but which lack a trailing newline?  If not, how hard would it be to get
> them to do so?

it probably should check for missing newlines at end of file, but I'm
going to let someone else tackle that due to time pressures on what
was supposed to be a quick enhancement :-)



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
