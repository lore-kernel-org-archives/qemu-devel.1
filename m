Received: from eggs.gnu.org ([209.51.188.92]:48749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gomfo-0004SK-N1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gomfn-0005Dj-N1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:00:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gomfn-0005CI-H7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:00:47 -0500
Date: Wed, 30 Jan 2019 10:00:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190130100034.GC15904@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190130031427.13129-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130031427.13129-1-jasowang@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2] test-filter-mirror: pass UNIX domain
 socket through fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Jan 30, 2019 at 11:14:27AM +0800, Jason Wang wrote:
> The tests tries to let qemu server mode to process the connection
> which turns out to be racy after commit 8258292e18c3 ("monitor: Remove
> "x-oob", offer capability "oob" unconditionally"). This is because the
> filter may try to mirror the packets before UNIX socket object is
> ready (connected was set to true) from the view of qemu. In this case
> the packet will be dropped silently.
>=20
> Fixing this by passing pre-connected socket created by socketpair() to
> qemu through fd.
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from v1:
> - close the socket pairs in the end of test
> ---
>  tests/test-filter-mirror.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)

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
