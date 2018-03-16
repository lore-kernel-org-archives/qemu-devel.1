Received: from eggs.gnu.org ([2001:4830:134:3::10]:41134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewogW-0003vf-68
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewogT-0007Dy-4m
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:42:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewogS-0007DQ-Vn
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 08:42:09 -0400
Date: Fri, 16 Mar 2018 12:41:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316124149.GG3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316122540.28409-1-pbonzini@redhat.com>
	<20180316122540.28409-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316122540.28409-2-pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] docker: test-mingw: use SDL2 and GTK+3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, f4bug@amsat.org

On Fri, Mar 16, 2018 at 01:25:39PM +0100, Paolo Bonzini wrote:
> Do not test the deprecated API versions.  debian-win32-cross and debian=
-win64-cross
> are already using SDL2 (they do not cover GTK+ at all).
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 8 ++++----
>  tests/docker/test-mingw                | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
