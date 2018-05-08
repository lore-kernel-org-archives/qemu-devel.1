Received: from eggs.gnu.org ([2001:4830:134:3::10]:48853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG5Fx-0003Mg-8P
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG5Ft-0005au-AN
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:14:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fG5Ft-0005ao-5P
	for qemu-devel@nongnu.org; Tue, 08 May 2018 12:14:21 -0400
Date: Tue, 8 May 2018 17:14:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180508161401.GI5967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504160026.14017-4-berrange@redhat.com>
	<752b52d8-2990-13d7-753c-36aafc5f0041@redhat.com>
	<20180508151940.GC5967@redhat.com>
	<ea7bffe9-5219-43a9-a250-b60b67b69b55@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea7bffe9-5219-43a9-a250-b60b67b69b55@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] glib: enforce the minimum required
 version and warn about old APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Tue, May 08, 2018 at 06:02:55PM +0200, Paolo Bonzini wrote:
> On 08/05/2018 17:19, Daniel P. Berrang=C3=A9 wrote:
> > Ok, that change looks fine with me assuming it passes your build test=
s.
> > In fact that is what I had done in an earlier version.
> >=20
> > Regards,
> > Daniel
>=20
> Actually there is a use of g_strv_contains in tests/test-qga.c.  It is
> guarded by GLIB_CHECK_VERSION(2, 44, 0) but the right fix should be to
> include the compatibility function instead.
>=20
> For now I am dropping this patch.

Ok, I'll have a look at that, and re-post an updated patch later. There
are a few other uses of GLIB_CHECK_VERSION to be investigated too I see.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
