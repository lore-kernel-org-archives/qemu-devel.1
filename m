Received: from eggs.gnu.org ([2001:4830:134:3::10]:41398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCksm-0002fk-6d
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCksl-0007PL-Eg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:25:00 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181009132330.7549-2-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 9 Oct 2018 14:23:25
	+0100")
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-2-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 Oct 2018 14:24:42 +0200
Message-ID: <87tvlk92wl.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] qemu-nbd: add support for
 authorization of TLS clients
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
> the NBD server. The server admin can turn on the 'verify-peer' option
> for the x509 creds to require the client to provide a x509 certificate.
> This means the client will have to acquire a certificate from the CA
> before they are permitted to use the NBD server. This is still a fairly
> low bar to cross.
>
> This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command which
> takes the ID of a previously added 'QAuthZ' object instance. This will
> be used to validate the client's x509 distinguished name. Clients
> failing the authorization check will not be permitted to use the NBD
> server.
>
> For example to setup authorization that only allows connection from a cli=
ent
> whose x509 certificate distinguished name is
>
>    CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=3DGB
>
> use:
>
>   qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls=
,\
>                     endpoint=3Dserver,verify-peer=3Dyes \
>            --object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.exampl=
e.com,,\
>                     O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
>            --tls-creds tls0 \
>            --tls-authz authz0
> 	   ....other qemu-nbd args...
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
