Received: from eggs.gnu.org ([2001:4830:134:3::10]:38770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d17Vd-00011a-1O
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d17Vc-0004T7-Au
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 04:32:13 -0400
Date: Thu, 20 Apr 2017 16:32:02 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170420083202.GF24486@lemon.lan>
References: <20170420075237.18219-1-famz@redhat.com>
	<149267590581.42.16656996221803790280@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149267590581.42.16656996221803790280@c05f1edc8ed1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v13 00/20] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

> /var/tmp/patchew-tester-tmp-7vbaovju/src/block/file-posix.c: In functio=
n =E2=80=98raw_handle_lock_update=E2=80=99:
> /var/tmp/patchew-tester-tmp-7vbaovju/src/block/file-posix.c:1117:17: er=
ror: =E2=80=98lock_fd=E2=80=99 may be used uninitialized in this function=
 [-Werror=3Dmaybe-uninitialized]
>                  qemu_close(lock_fd);
>                  ^~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-7vbaovju/src/rules.mak:69: recipe for targe=
t 'block/file-posix.o' failed

False positive. lock_fd is initialized in a "if (op =3D=3D RAW_LT_PREPARE=
)" branch
above, and we are in a "case RAW_LT_PREPARE" switch branch too.

Fam
