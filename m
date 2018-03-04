Received: from eggs.gnu.org ([2001:4830:134:3::10]:35986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esYGA-0001JD-CA
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 13:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1esYG6-0007JO-D4
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 13:21:22 -0500
References: <96ce9600-c1e3-c3d6-5c3d-7d30cf799e04@fransdb.nl>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bf227ff2-d45a-a279-568f-c60968a0aa09@redhat.com>
Date: Sun, 4 Mar 2018 19:21:09 +0100
MIME-Version: 1.0
In-Reply-To: <96ce9600-c1e3-c3d6-5c3d-7d30cf799e04@fransdb.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Problem compiling qemu-2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frans de Boer <frans@fransdb.nl>, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 04.03.2018 12:15, Frans de Boer wrote:
> LS,
>=20
> I try to compile qemu and get the next error message:
>=20
> mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/util/mem=
fd.c:40:12:
> error: static declaration of =E2=80=98memfd_create=E2=80=99 follows non=
-static declaration
> =C2=A0static int memfd_create(const char *name, unsigned int flags)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~=
~~~~~~~~
> In file included from /usr/include/bits/mman-linux.h:115:0,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from /usr/include/bits/mman.h:45,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from /usr/include/sys/mman.h:41,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from
> /mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/include=
/sysemu/os-posix.h:29,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from
> /mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/include=
/qemu/osdep.h:104,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from
> /mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/util/me=
mfd.c:28:
>=20
> /usr/include/bits/mman-shared.h:46:5: note: previous declaration of
> =E2=80=98memfd_create=E2=80=99 was here
> =C2=A0int memfd_create (const char *__name, unsigned int __flags) __THR=
OW;
>=20
> I use the newest Tumbleweed of openSuse with the gcc 7.3.0 compiler sui=
te.
>=20
> Suggestions?

Not sure, but it sounds like you need this patch on top:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D75e5b70e6b5dcc4f221=
9992

 HTH,
  Thomas
