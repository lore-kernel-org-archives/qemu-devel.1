Received: from eggs.gnu.org ([2001:4830:134:3::10]:45400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDIHT-0005so-Ro
	for qemu-devel@nongnu.org; Tue, 23 May 2017 18:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dDIHP-0001Ih-TB
	for qemu-devel@nongnu.org; Tue, 23 May 2017 18:27:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dDIHP-0001I9-Mi
	for qemu-devel@nongnu.org; Tue, 23 May 2017 18:27:51 -0400
Date: Wed, 24 May 2017 06:27:46 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170523222746.GA12279@lemon.lan>
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149555082900.1095.16206351753645529469@c05f1edc8ed1>
	<20170523170406.6e862ab2@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170523170406.6e862ab2@bahia.ttt.fr.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, leo@gaspard.io

On Tue, 05/23 17:04, Greg Kurz wrote:
> >   CC      hw/9pfs/9p-xattr-user.o
> > In file included from /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pf=
s/9p-local.c:18:0:
> > /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pfs/9p-local.c: In funct=
ion =E2=80=98local_set_mapped_file_attrat=E2=80=99:
> > /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pfs/9p-util.h:19:5: erro=
r: =E2=80=98map_dirfd=E2=80=99 may be used uninitialized in this function=
 [-Werror=3Dmaybe-uninitialized]
> >      close(fd);
> >      ^~~~~~~~~
> > /var/tmp/patchew-tester-tmp-5niyvzwz/src/hw/9pfs/9p-local.c:235:9: no=
te: =E2=80=98map_dirfd=E2=80=99 was declared here
> >      int map_dirfd, map_fd;
> >          ^~~~~~~~~
> > cc1: all warnings being treated as errors
>=20
> This is a false positive AFAICT... what compiler is this ?

It's gcc, as in the snipped package list above.

Fam
