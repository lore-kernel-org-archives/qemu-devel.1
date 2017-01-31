Received: from eggs.gnu.org ([2001:4830:134:3::10]:32784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYaPo-0005lW-9v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:32:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYaPj-0004nv-Bi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:32:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYaPj-0004np-5h
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:32:11 -0500
References: <20170130133954.31353-1-marcandre.lureau@redhat.com>
	<20170130133954.31353-20-marcandre.lureau@redhat.com>
	<68c0ebae-7559-80eb-23fc-f8acc218a6d3@redhat.com>
	<CAJ+F1CL1reqXTC+qvhcjKbNt2YSFd=R37A7ZidiVJdFXv7nhdQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <78545c77-05a8-9de7-d196-5fdfa31702b3@redhat.com>
Date: Tue, 31 Jan 2017 10:32:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL1reqXTC+qvhcjKbNt2YSFd=R37A7ZidiVJdFXv7nhdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 19/41] char: remove class kind field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org



On 31/01/2017 04:08, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jan 31, 2017 at 12:08 AM Paolo Bonzini <pbonzini@redhat.com
> <mailto:pbonzini@redhat.com>> wrote:
>=20
>=20
>=20
>     On 30/01/2017 08:39, Marc-Andr=C3=A9 Lureau wrote:
>     > The class kind is necessary to lookup the chardev name in
>     > qmp_chardev_add() after calling qemu_chr_new_from_opts() and to s=
et
>     > the appropriate ChardevBackend (mainly to free the right
>     > fields).
>     >
>     > qemu_chr_new_from_opts() can be changed to use a non-qmp function
>     > using the chardev class typename. Introduce qemu_chardev_add() to=
 be
>     > called from qemu_chr_new_from_opts() and remove the class chardev=
 kind
>     > field. Set the backend->type in the parse callback (when non-comm=
on
>     > fields are added).
>     >
>     > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.co=
m
>     <mailto:marcandre.lureau@redhat.com>>
>     > ---
>     >  include/sysemu/char.h |  1 -
>     >  backends/baum.c       |  1 -
>     >  backends/msmouse.c    |  1 -
>     >  backends/testdev.c    |  1 -
>     >  qemu-char.c           | 99
>     +++++++++++++++++++++++++--------------------------
>     >  spice-qemu-char.c     |  4 +--
>     >  ui/console.c          |  2 +-
>     >  ui/gtk.c              |  1 -
>     >  8 files changed, 51 insertions(+), 59 deletions(-)
>=20
>     I am not sure about this patch.  Why not remove backend->type
>     altogether, and instead look at ChardevClass with object_dynamic_ca=
st?
>=20
>=20
> For the reason I gave in the patch summary: qapi_free_ChardevBackend()
> dispatch based on ChardevBackendKind enum, not on Chardev object type.

Oops, I was confusing ChardevBackend and CharBackend!

Paolo
