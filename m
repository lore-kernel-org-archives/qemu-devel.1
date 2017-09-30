Received: from eggs.gnu.org ([2001:4830:134:3::10]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dy5eP-00040w-KN
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dy5eL-0002r7-2Y
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:29:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dy5eK-0002qK-Rz
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 20:28:56 -0400
Date: Sat, 30 Sep 2017 08:28:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170930002847.GC29131@pxdev.xzpeter.org>
References: <20170929033844.26935-1-peterx@redhat.com>
	<150665750396.84.2688523110192906870@b58463cdfd5f>
	<20170929041433.GA29131@pxdev.xzpeter.org>
	<1ef3d76b-ddd8-7c6a-e934-1fb84de2b35f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ef3d76b-ddd8-7c6a-e934-1fb84de2b35f@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, famz@redhat.com, quintela@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, shajnocz@redhat.com, pbonzini@redhat.com, marcandre.lureau@gmail.com, dgilbert@redhat.com
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 02:03:14PM -0500, Eric Blake wrote:
> On 09/28/2017 11:14 PM, Peter Xu wrote:
> > On Thu, Sep 28, 2017 at 08:58:25PM -0700, no-reply@patchew.org wrote:
> >> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c: In function =E2=80=
=98monitor_io_thread_init=E2=80=99:
> >> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4286:32: error: i=
mplicit declaration of function =E2=80=98iothread_create=E2=80=99 [-Werro=
r=3Dimplicit-function-declaration]
> >>      mon_global.mon_io_thread =3D iothread_create("monitor_io_thr",
> >>                                 ^~~~~~~~~~~~~~~
> >> /var/tmp/patchew-tester-tmp-hw4oylij/src/monitor.c:4286:5: error: ne=
sted extern declaration of =E2=80=98iothread_create=E2=80=99 [-Werror=3Dn=
ested-externs]
>=20
> >=20
> > This is because the iothread series that this series used has not yet
> > been pushed to master.
>=20
> In which case, you can add a 'Based-on: <message-id>' tag in your cover
> letter of this series to tell patchew to not try this series unless it
> applies all Based-on series first.

I've heard of this new patchew feature but I definitely missed it this
time.  Thanks for mentioning that!

--=20
Peter Xu
