Received: from eggs.gnu.org ([209.51.188.92]:45388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1o6-0007pp-74
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gm1cN-0006Zc-1a
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:21:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gm1cM-0005t3-RE
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:21:50 -0500
Date: Tue, 22 Jan 2019 14:34:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190122143433.GS13143@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-5-berrange@redhat.com>
	<64c2ec84-8950-3c58-0ca7-d54c1a9438d2@redhat.com>
	<20190121105314.GG30536@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121105314.GG30536@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace: add ability to do simple
 printf logging via systemtap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, Jan 21, 2019 at 10:53:14AM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 18, 2019 at 12:14:14PM -0600, Eric Blake wrote:
> > On 1/18/19 11:31 AM, Daniel P. Berrang=C3=A9 wrote:
> > > +def c_macro_to_format(macro):
> > > +    if macro.startswith("PRI"):
> > > +        return macro[3]
> > > +
> > > +    if macro =3D=3D "TARGET_FMT_plx":
> > > +        return "%016x"
> >=20
> > Do we really want to permit TARGET_FMT in our trace-events files, or
> > should that be fixed in hw/tpm/trace-events?  See commit 73ff0610.
>=20
> TARGET_FMT_plx is constant across all QEMU targets.  I think supporting
> it is nice since it makes writing trace events more natural/convenient.

Yep, I'm fine with supporting custom macros beyond PRI* in trace-events,
provided that they can be subsituted out with a simple formats code for
stap.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
