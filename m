Received: from eggs.gnu.org ([2001:4830:134:3::10]:42666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkwt-0005kK-Ke
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkwr-0004oR-MI
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:29:14 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20181009132330.7549-3-berrange@redhat.com> ("Daniel
	P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 9 Oct 2018 14:23:26
	+0100")
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-3-berrange@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 17 Oct 2018 14:28:53 +0200
Message-ID: <87murc92pm.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/6] nbd: allow authorization with
 nbd-server-start QMP command
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
> As with the previous patch to qemu-nbd, the nbd-server-start QMP command
> also needs to be able to specify authorization when enabling TLS encrypti=
on.
>
> First the client must create a QAuthZ object instance using the
> 'object-add' command:
>
>    {
>      'execute': 'object-add',
>      'arguments': {
>        'qom-type': 'authz-list',
>        'id': 'authz0',
>        'parameters': {
>          'policy': 'deny',
>          'rules': [
>            {
>              'match': '*CN=3Dfred',
>              'policy': 'allow'
>            }
>          ]
>        }
>      }
>    }
>
> They can then reference this in the new 'tls-authz' parameter when
> executing the 'nbd-server-start' command:
>
>    {
>      'execute': 'nbd-server-start',
>      'arguments': {
>        'addr': {
>            'type': 'inet',
>            'host': '127.0.0.1',
>            'port': '9000'
>        },
>        'tls-creds': 'tls0',
>        'tls-authz': 'authz0'
>      }
>    }
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

similar to previous patch in series.
