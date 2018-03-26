Received: from eggs.gnu.org ([2001:4830:134:3::10]:42400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f0Wpw-0006l9-Uz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f0Wpt-0003qU-0O
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f0Wps-0003nX-RR
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 14:27:12 -0400
Date: Mon, 26 Mar 2018 15:26:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180326182658.GP3417@localhost.localdomain>
References: <20180326150916.9602-1-marcandre.lureau@redhat.com>
	<20180326150916.9602-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180326150916.9602-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 02/38] qmp-shell: learn to send commands
 with quoted arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Mar 26, 2018 at 05:08:40PM +0200, Marc-Andr=E9 Lureau wrote:
> Use shlex to split the CLI command, respecting quoted arguments, and
> also comments. This allows to call for ex:
>=20
> (QEMU) human-monitor-command command-line=3D"screendump /dev/null"
> {"execute": "human-monitor-command", "arguments": {"command-line": "scr=
eendump /dev/null"}}
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Wonderful.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
