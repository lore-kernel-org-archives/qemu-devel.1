Received: from eggs.gnu.org ([2001:4830:134:3::10]:33069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSY6-0004LF-7U
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDSXu-0007yL-NS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:02:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDSXp-0007oi-1n
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 07:02:18 -0400
Date: Fri, 19 Oct 2018 12:02:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019110203.GL13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181018223501.21683-1-jusual@mail.ru>
	<20181018223501.21683-4-jusual@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181018223501.21683-4-jusual@mail.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tests/test-char: Check websocket
 chardev functionality
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

On Fri, Oct 19, 2018 at 01:35:01AM +0300, Julia Suvorova wrote:
> Test order:
>     Creating server websocket chardev
>     Creating usual tcp chardev client
>     Sending handshake message from client
>     Receiving handshake reply
>     Sending ping frame with "hello" payload
>     Receiving pong reply
>     Sending binary data "world"
>     Checking the received data on server side
>     Checking of closing handshake
>=20
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/test-char.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)

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
