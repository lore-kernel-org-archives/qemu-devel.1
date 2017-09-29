Received: from eggs.gnu.org ([2001:4830:134:3::10]:41743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmhI-0005AH-NC
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 00:14:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxmhF-0000TH-Ho
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 00:14:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxmhF-0000Rd-8d
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 00:14:41 -0400
Date: Fri, 29 Sep 2017 12:14:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170929041433.GA29131@pxdev.xzpeter.org>
References: <20170929033844.26935-1-peterx@redhat.com>
	<150665750396.84.2688523110192906870@b58463cdfd5f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150665750396.84.2688523110192906870@b58463cdfd5f>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 00/22] QMP: out-of-band (OOB) execution
 support
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, lvivier@redhat.com, quintela@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, shajnocz@redhat.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, dgilbert@redhat.com
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 28, 2017 at 08:58:25PM -0700, no-reply@patchew.org wrote:
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c: In function =E2=80=98=
monitor_io_thread_init=E2=80=99:
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4286:32: error: impl=
icit declaration of function =E2=80=98iothread_create=E2=80=99 [-Werror=3D=
implicit-function-declaration]
>      mon_global.mon_io_thread =3D iothread_create("monitor_io_thr",
>                                 ^~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4286:5: error: neste=
d extern declaration of =E2=80=98iothread_create=E2=80=99 [-Werror=3Dnest=
ed-externs]
>      mon_global.mon_io_thread =3D iothread_create("monitor_io_thr",
>      ^~~~~~~~~~
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4286:30: error: assi=
gnment makes pointer from integer without a cast [-Werror=3Dint-conversio=
n]
>      mon_global.mon_io_thread =3D iothread_create("monitor_io_thr",
>                               ^
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c: In function =E2=80=98=
monitor_io_thread_destroy=E2=80=99:
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4420:5: error: impli=
cit declaration of function =E2=80=98iothread_destroy=E2=80=99 [-Werror=3D=
implicit-function-declaration]
>      iothread_destroy(mon_global.mon_io_thread);
>      ^~~~~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4420:5: error: neste=
d extern declaration of =E2=80=98iothread_destroy=E2=80=99 [-Werror=3Dnes=
ted-externs]
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c: In function =E2=80=98=
monitor_cleanup=E2=80=99:
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4433:5: error: impli=
cit declaration of function =E2=80=98iothread_stop=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
>      iothread_stop(mon_global.mon_io_thread);
>      ^~~~~~~~~~~~~
> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4433:5: error: neste=
d extern declaration of =E2=80=98iothread_stop=E2=80=99 [-Werror=3Dnested=
-externs]
> cc1: all warnings being treated as errors
> /var/tmp/patchew-tester-tmp-hw4oylij/src/rules.mak:66: recipe for targe=
t 'monitor.o' failed
> make[1]: *** [monitor.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:327: recipe for target 'subdir-arm-softmmu' failed
> make: *** [subdir-arm-softmmu] Error 2
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 2

This is because the iothread series that this series used has not yet
been pushed to master.

--=20
Peter Xu
