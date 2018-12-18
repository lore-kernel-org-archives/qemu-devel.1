Received: from eggs.gnu.org ([2001:4830:134:3::10]:59970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZCZ8-0008O0-F4
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZCZ4-0005wY-FQ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:25:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZCZ4-0005ue-8o
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:25:26 -0500
Date: Tue, 18 Dec 2018 10:25:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181218102518.GA22638@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181217202602.31113-1-r.bolshakov@yadro.com>
	<20181217202602.31113-2-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217202602.31113-2-r.bolshakov@yadro.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/2] util: Implement debug-threads for macOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: qemu-devel@nongnu.org

On Mon, Dec 17, 2018 at 11:26:01PM +0300, Roman Bolshakov wrote:
> macOS provides pthread_setname_np that doesn't have thread id argument.
>=20
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  configure                | 32 ++++++++++++++++++++++++++------
>  qemu-options.hx          |  4 ++--
>  util/qemu-thread-posix.c |  6 +++++-
>  3 files changed, 33 insertions(+), 9 deletions(-)

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
