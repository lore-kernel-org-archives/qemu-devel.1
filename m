Received: from eggs.gnu.org ([2001:4830:134:3::10]:44370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rdelobel@gmail.com>) id 1eoA2J-0004w3-E7
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rdelobel@gmail.com>) id 1eoA2F-0005Ls-7V
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:40:55 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rdelobel@gmail.com>) id 1eoA2F-0005LR-0M
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:40:51 -0500
Received: by mail-ot0-x244.google.com with SMTP id 41so6648488otd.13
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 07:40:50 -0800 (PST)
MIME-Version: 1.0
From: Ronald Delobel <rdelobel@gmail.com>
Date: Tue, 20 Feb 2018 16:40:49 +0100
Message-ID: <CAMyPS3QVbV2FPNfE-Y_-kgpcpOTWr9zFWED50oCkJaBjJ3XtRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] make error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

This is the error I get when building qemu-2.11.[0-1] with
gcc-7.3.0/glibc-2.27, removing the static attribute suffice to finnish the
build using the glibc provided memfd_create and qemu don't crash, but I
miss some knowledge here about what a static function really is, a kind of
private one? Shouldn't it be renamed instead and stay as static?

Just to report it.


  CC      util/qemu-thread-posix.o
  CC      util/memfd.o
util/memfd.c:40:12: error: la d=C3=A9claration statique de =C2=AB memfd_cre=
ate =C2=BB suit
une d=C3=A9claration non statique
 static int memfd_create(const char *name, unsigned int flags)
            ^~~~~~~~~~~~
In file included from /usr/include/bits/mman-linux.h:115:0,
                 from /usr/include/bits/mman.h:45,
                 from /usr/include/sys/mman.h:41,
                 from
/usr/local/src/qemu-2.11.1/include/sysemu/os-posix.h:29,
                 from /usr/local/src/qemu-2.11.1/include/qemu/osdep.h:104,
                 from util/memfd.c:28:
/usr/include/bits/mman-shared.h:46:5: note: la d=C3=A9claration pr=C3=A9c=
=C3=A9dente de
=C2=AB memfd_create =C2=BB =C3=A9tait ici
 int memfd_create (const char *__name, unsigned int __flags) __THROW;
     ^~~~~~~~~~~~
make: *** [/usr/local/src/qemu-2.11.1/rules.mak:66: util/memfd.o] Error 1
