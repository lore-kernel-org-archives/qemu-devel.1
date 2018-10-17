Received: from eggs.gnu.org ([2001:4830:134:3::10]:43259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkyj-0007JF-Ny
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkyg-0007qp-BT
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:31:09 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181009132330.7549-4-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 9 Oct 2018 14:23:27
	+0100")
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-4-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 Oct 2018 14:30:24 +0200
Message-ID: <87in2092n3.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/6] migration: add support for a
 "tls-authz" migration parameter
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
> The QEMU instance that runs as the server for the migration data
> transport (ie the target QEMU) needs to be able to configure access
> control so it can prevent unauthorized clients initiating an incoming
> migration. This adds a new 'tls-authz' migration parameter that is used
> to provide the QOM ID of a QAuthZ subclass instance that provides the
> access control check. This is checked against the x509 certificate
> obtained during the TLS handshake.
>
> For example, when starting a QEMU for incoming migration, it is
> possible to give an example identity of the source QEMU that is
> intended to be connecting later:
>
>   $QEMU \
>      -monitor stdio \
>      -incoming defer \
>      ...other args...
>
>   (qemu) object_add tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls=
,\
>              endpoint=3Dserver,verify-peer=3Dyes \
>   (qemu) object_add authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.exampl=
e.com,,\
>              O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
>   (qemu) migrate_incoming tcp:localhost:9000
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
