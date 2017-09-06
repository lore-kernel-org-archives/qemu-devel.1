Received: from eggs.gnu.org ([2001:4830:134:3::10]:38545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpSWn-0007Tg-2N
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpSWi-0007IU-4l
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:05:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dpSWh-0007IE-Uu
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 01:05:24 -0400
References: <20170904090310.22530-1-marcandre.lureau@redhat.com>
	<1931f0be-40ce-49b8-02e4-0d98801091ae@redhat.com>
	<CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aa1b0e7c-1968-fbee-6219-a26a08313d4f@redhat.com>
Date: Wed, 6 Sep 2017 07:05:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLaz9KsPWG+_h1H=dwmY0EgAfcq6r2dAJvfvJz8JB5cBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: generate tests/.gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

On 05.09.2017 12:42, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Sep 4, 2017 at 12:21 PM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
>=20
>     On 04.09.2017 11 <tel:04%2009%2020%2017%2011>:03, Marc-Andr=C3=A9 L=
ureau
>     wrote:
[...]
>     >=C2=A0 # Build the help program automatically
>     >
>     >=C2=A0 all: $(QEMU_IOTESTS_HELPERS-y)
>     >
>     > +$(SRC_PATH)/tests/.gitignore: $(MAKEFILE_LIST)
>     > +=C2=A0 =C2=A0 =C2=A0$(call quiet-command, echo "$(tests-cleanfil=
es)"
>     "$(tests-cleandirs)" | \
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xargs -n1 | sort=
 | uniq | sed -e s:^:/: >
>     $@,"GEN","$(@F)")
>=20
>     Please do not use SRC_PATH here. I'm doing out of tree builds, and =
I
>     don't want that these are touching my source folder!
>=20
> I understand the feeling, I do also mostly out of tree build. However, =
I
> don't think it makes much sense to generate .gitignore in the build dir=
.

Why not? If you're doing out-of-tree builds, you don't need the
.gitignore in the source directory anyway, so it certainly does not make
sense to generate there such a file in the source directory.

> It's git related, and in the git source dir, you have .git that is
> writable already

It's unlikely, but I think it is perfectly legal to have your git source
directory e.g. mounted temporarily as a read-only file system. I'd then
still expect to be able to use my read-only sources to build QEMU out of
tree.

 Thomas


PS: Looks like you're sending HTML mails ... please check the setup of
your mail program.
