Received: from eggs.gnu.org ([2001:4830:134:3::10]:32943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frans@fransdb.nl>) id 1esRcg-0006u7-Kf
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 06:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frans@fransdb.nl>) id 1esRcd-0007Rh-IK
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 06:16:10 -0500
Received: from fransdb.nl ([80.101.31.146]:60366 helo=pubserv1.fransdb.nl)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <frans@fransdb.nl>) id 1esRcd-0007NQ-Av
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 06:16:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by pubserv1.fransdb.nl (Postfix) with ESMTP id 2FEBF42275
	for <qemu-devel@nongnu.org>; Sun,  4 Mar 2018 12:15:40 +0100 (CET)
Received: from pubserv1.fransdb.nl ([127.0.0.1])
	by localhost (pubserv1.fransdb.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FSPf8cB6H-Wi for <qemu-devel@nongnu.org>;
	Sun,  4 Mar 2018 12:15:37 +0100 (CET)
Received: from [192.168.101.128] (unknown [192.168.0.13])
	by pubserv1.fransdb.nl (Postfix) with ESMTP id C5AAA41844
	for <qemu-devel@nongnu.org>; Sun,  4 Mar 2018 12:15:36 +0100 (CET)
From: Frans de Boer <frans@fransdb.nl>
Message-ID: <96ce9600-c1e3-c3d6-5c3d-7d30cf799e04@fransdb.nl>
Date: Sun, 4 Mar 2018 12:15:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: nl
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Problem compiling qemu-2.1.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

LS,

I try to compile qemu and get the next error message:

mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/util/memfd=
.c:40:12:=20
error: static declaration of =E2=80=98memfd_create=E2=80=99 follows non-s=
tatic declaration
  static int memfd_create(const char *name, unsigned int flags)
             ^~~~~~~~~~~~
In file included from /usr/include/bits/mman-linux.h:115:0,
                  from /usr/include/bits/mman.h:45,
                  from /usr/include/sys/mman.h:41,
                  from=20
/mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/include/s=
ysemu/os-posix.h:29,
                  from=20
/mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/include/q=
emu/osdep.h:104,
                  from=20
/mnt/rhome/frans-tw/data/projects/linux/kernel/qemu/qemu-2.11.1/util/memf=
d.c:28:
/usr/include/bits/mman-shared.h:46:5: note: previous declaration of=20
=E2=80=98memfd_create=E2=80=99 was here
  int memfd_create (const char *__name, unsigned int __flags) __THROW;

I use the newest Tumbleweed of openSuse with the gcc 7.3.0 compiler suite=
.

Suggestions?

Regards,
Frans.
