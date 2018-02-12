Received: from eggs.gnu.org ([2001:4830:134:3::10]:38135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKdT-0003ek-W6
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elKdT-0006Ot-93
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 15:23:35 -0500
References: <20180212184849.11858-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0af2741-d4b1-f655-f209-38a6958a354d@redhat.com>
Date: Mon, 12 Feb 2018 14:23:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180212184849.11858-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-io: fix EOF Ctrl-D handling in
 qemu-io readline code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On 02/12/2018 12:48 PM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> qemu-io puts the TTY into non-canonical mode, which means no EOF proces=
sing is
> done and thus getchar() will never return the EOF constant. Instead we =
have to
> query the TTY attributes to determine the configured EOF character (usu=
ally
> Ctrl-D / 0x4), and then explicitly check for that value. This fixes the
> regression that prevented Ctrl-D from triggering an exit of qemu-io tha=
t has
> existed since readline was first added in
>=20
>    commit 0cf17e181798063c3824c8200ba46f25f54faa1a
>    Author: Stefan Hajnoczi <stefanha@redhat.com>
>    Date:   Thu Nov 14 11:54:17 2013 +0100
>=20
>      qemu-io: use readline.c
>=20
> It also ensures that a newline is printed when exiting, to complete the
> line output by the "qemu-io> " prompt.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
