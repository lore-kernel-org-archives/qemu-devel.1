Received: from eggs.gnu.org ([2001:4830:134:3::10]:36781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkUul-0003Nw-E2
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkUuk-0001Bd-KC
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:37:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-14-marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 14:37:27 +0200
In-Reply-To: <20170822132255.23945-14-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 22 Aug 2017
	15:22:14 +0200")
Message-ID: <87378izchk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/54] qapi: drop the sentinel in enum
 array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:parallels" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Now that all usages have been converted to user lookup helpers.

I don't think you got them all:

    $ git-grep -F _lookup.
    tests/test-qobject-input-visitor.c:    for (i =3D 0; i < EnumOne_lookup=
.size; i++) {
    tests/test-qobject-input-visitor.c:        v =3D visitor_input_test_ini=
t(data, "%s", EnumOne_lookup.array[i]);
    tests/test-qobject-input-visitor.c:                           UserDefNa=
tiveListUnionKind_lookup.array[kind],
    tests/test-string-input-visitor.c:    for (i =3D 0; i < EnumOne_lookup.=
size; i++) {
    tests/test-string-input-visitor.c:        v =3D visitor_input_test_init=
(data, EnumOne_lookup.array[i]);
    ui/input-legacy.c:    for (i =3D 0; i < QKeyCode_lookup.size; i++) {
    ui/input-legacy.c:        if (!strncmp(key, QKeyCode_lookup.array[i], k=
ey_length) &&
    ui/input-legacy.c:            !QKeyCode_lookup.array[i][key_length]) {

I think I commented on all of these guys in my review of PATCH 06-12.
