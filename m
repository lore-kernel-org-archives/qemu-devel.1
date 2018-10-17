Received: from eggs.gnu.org ([2001:4830:134:3::10]:43633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCl0F-0008O2-PJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCl0E-0002N5-LZ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:32:43 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181009132330.7549-5-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 9 Oct 2018 14:23:28
	+0100")
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-5-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 Oct 2018 14:32:17 +0200
Message-ID: <87efco92jy.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/6] chardev: add support for
 authorization for TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?utf-8?Q?Marc-?= =?utf-8?Q?Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David
	Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>
> Currently any client which can complete the TLS handshake is able to use
> a chardev server. The server admin can turn on the 'verify-peer' option
> for the x509 creds to require the client to provide a x509
> certificate. This means the client will have to acquire a certificate
> from the CA before they are permitted to use the chardev server. This is
> still a fairly low bar.
>
> This adds a 'tls-authz=3DOBJECT-ID' option to the socket chardev backend
> which takes the ID of a previously added 'QAuthZ' object instance. This
> will be used to validate the client's x509 distinguished name. Clients
> failing the check will not be permitted to use the chardev server.
>
> For example to setup authorization that only allows connection from a
> client whose x509 certificate distinguished name contains 'CN=3Dfred', you
> would use:
>
>   $QEMU -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls,\
>                 endpoint=3Dserver,verify-peer=3Dyes \
>         -object authz-simple,id=3Dauthz0,identity=3DCN=3Dlaptop.example.c=
om,,\
>                 O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
>         -chardev socket,host=3D127.0.0.1,port=3D9000,server,\
> 	         tls-creds=3Dtls0,tls-authz=3Dauthz0 \
>         ...other qemu args...
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
