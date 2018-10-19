Received: from eggs.gnu.org ([2001:4830:134:3::10]:58122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSPb-000070-1x
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSPX-0006JP-RC
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:53:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDSPX-0006IZ-JS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:53:43 -0400
Date: Fri, 19 Oct 2018 11:53:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019105332.GI13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181018223501.21683-1-jusual@mail.ru>
	<20181018223501.21683-2-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181018223501.21683-2-jusual@mail.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] chardev/char-socket: Function
 headers refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Steffen =?utf-8?B?R8O2cnR6?= <mail@steffen-goertz.de>

On Fri, Oct 19, 2018 at 01:34:59AM +0300, Julia Suvorova wrote:
> Upcoming websocket support requires additional parameters in function
> headers that are already overloaded. This patch replaces the bunch of
> parameters with a single structure pointer.
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  chardev/char-socket.c | 55 +++++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)

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
