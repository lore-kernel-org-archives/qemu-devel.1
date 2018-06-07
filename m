Received: from eggs.gnu.org ([2001:4830:134:3::10]:44638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQqEn-0004sc-Ea
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQqEk-0001Tq-AB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:25:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60240 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQqEk-0001TA-5H
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:25:38 -0400
Date: Thu, 7 Jun 2018 09:25:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180607082524.GB28827@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-2-berrange@redhat.com>
	<fa882626-6066-bda1-2919-95c1bfbf689d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa882626-6066-bda1-2919-95c1bfbf689d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] glib: bump min required glib
 library version to 2.40
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jun 06, 2018 at 02:12:33PM -0400, John Snow wrote:
>=20
>=20
> On 06/06/2018 01:32 PM, Daniel P. Berrang=C3=A9 wrote:
> > Per supported platforms doc, the various min glib on relevant distros=
 is:
>=20
> Which doc?

The main QEMU doc=20

https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

>=20
> >=20
> >   RHEL-7: 2.50.3
> >   Debian (Stretch): 2.50.3
> >   Debian (Jessie): 2.42.1
> >   OpenBSD (Ports): 2.54.3
> >   FreeBSD (Ports): 2.50.3
> >   OpenSUSE Leap 15: 2.54.3
> >   Ubuntu (Xenial): 2.48.0
> >   macOS (Homebrew): 2.56.0
> >=20
> > This suggests that a minimum glib of 2.42 is a reasonable target.
>=20
> Looks like useful info to check in somewhere -- though I suppose the
> commit message counts.

Yeah I think commit message is sufficient

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
