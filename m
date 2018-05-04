Received: from eggs.gnu.org ([2001:4830:134:3::10]:53851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEhlr-0005Tf-V8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fEhlo-00083Q-QV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:57:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50912 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fEhlo-000830-M2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:57:36 -0400
Date: Fri, 4 May 2018 21:57:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180504205721.GA30250@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504214006.17217d00.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180504214006.17217d00.olaf@aepfle.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Document intent for supported build
 platforms and bump min glib to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Fri, May 04, 2018 at 09:40:06PM +0200, Olaf Hering wrote:
> Am Fri,  4 May 2018 17:00:23 +0100
> schrieb Daniel P. Berrang=C3=A9 <berrange@redhat.com>:
>=20
> >   - I suggested following libvirt's lead in writing a policy for how
> >     we pick supported OS targets to inform maintainers when min versi=
ons
> >     can be increased.
>=20
> Since Xen depends on qemu, it also means that SLE11 will disappear
> silently for them.

There's still option of using existing QEMU versions on old distros, or
building a new parallel installed glib to support new QEMU, if old distro
support is needed.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
