Received: from eggs.gnu.org ([2001:4830:134:3::10]:48341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evNFz-0007Qs-FE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evNFu-0005aq-JQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evNFu-0005a0-EU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:12:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 202528182D16
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 13:12:46 +0000 (UTC)
References: <20180312124939.20562-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9bbe182-4a13-0063-4ce8-98151f1bd228@redhat.com>
Date: Mon, 12 Mar 2018 08:12:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180312124939.20562-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Enable passing pre-opened chardev
 socket FD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 03/12/2018 07:49 AM, Daniel P. Berrang=C3=A9 wrote:
> An update of:
>=20
>    v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04618.h=
tml
>    v2: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04706.h=
tml
>    v3: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04892.h=
tml
>    v4: https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg00950.h=
tml
>=20
> This enables fixing a long standing problem that libvirt has with
> starting up QEMU. It has to busy-wait retrying connect() on the QMP
> monitor socket until QEMU finally creates & listens on it, but at same
> time must be careful to not wait forever if QEMU exits.
>=20
> With this patch series, libvirt can simply pass in a pre-opened UNIX do=
main
> socket file descriptor, which it can immediately connect to with no bus=
y-wait.
>=20
> NB, this will generate one expected failure with patchew / checkpatch.p=
l

>=20
> Changed in v5:
>=20
>    - Docs typo (Eric)
>    - Fix errno setting in int parsing code (Eric)
>=20

> Daniel P. Berrang=C3=A9 (9):
>    char: don't silently skip tn3270 protocol init when TLS is enabled
>    cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int
>      types
>    sockets: pull code for testing IP availability out of specific test
>    sockets: strengthen test suite IP protocol availability checks
>    sockets: move fd_is_socket() into common sockets code
>    sockets: check that the named file descriptor is a socket
>    sockets: allow SocketAddress 'fd' to reference numeric file
>      descriptors
>    char: refactor parsing of socket address information
>    char: allow passing pre-opened socket file descriptor at startup

Whose tree should this go through?  It's got some QAPI impact, so I'm=20
okay including it in my QAPI pull request later today, if there is no=20
better tree...

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
