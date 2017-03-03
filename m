Received: from eggs.gnu.org ([2001:4830:134:3::10]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjujC-0005XW-Df
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:27:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjuj7-0004PH-Hv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:27:06 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:38653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjuj7-0004Mn-9j
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 16:27:01 -0500
Date: Fri, 3 Mar 2017 16:26:51 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1373492692.28066935.1488576411968.JavaMail.zimbra@redhat.com>
In-Reply-To: <58B970DD0200004800140A13@prv-mh.provo.novell.com>
References: <20170202150530.1025-1-pbonzini@redhat.com>
	<20170203150050.GF642@stefanha-x1.localdomain>
	<55b46fa3-c861-9ba4-da65-25bc392d8900@redhat.com>
	<20170206115659.GC2524@work-vm>
	<58B970DD0200004800140A13@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] configure: remove
 --enable-replication/--disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, zhangchen fnst <zhangchen.fnst@cn.fujitsu.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org


> > I would actually prefer to remove many of the latter
> > (=E2=80=91=E2=80=91enable=E2=80=91vhost=E2=80=91net, =E2=80=91=E2=80=91=
enable=E2=80=91vhost=E2=80=91scsi, =E2=80=91=E2=80=91enable=E2=80=91vhost=
=E2=80=91socket) and
> > just use default=E2=80=91configs.  We are already doing it for ivshmem =
for
> > example:
>=20
> Was there ever a conclusion here? The reason I ask is that I see that
> currently
> using --disable-replication fails for me as follows:

No conclusion.  I suppose if people are interested in --disable-replication
they can submit a patch to fix the bitrot.  If 2.9 ships with the option
broken, I'll resend the patch for inclusion in 2.10.

This should give about one month to fix the option, which should be enough.

Paolo

> # ./configure --disable-replication
> ...
> # make
> ...
> make  all-recursive
> Making all in pixman
> make[3]: Nothing to be done for 'all'.
> Making all in demos
> make[3]: Nothing to be done for 'all'.
> Making all in test
> make[3]: Nothing to be done for 'all'.
> =09CHK version_gen.h
>   LINK    aarch64-softmmu/qemu-system-aarch64
> ../migration/colo.o: In function `qmp_query_xen_replication_status':
> /home/brogers/osr/git/qemu/migration/colo.c:181: undefined reference to
> `replication_get_error_all'
> ../migration/colo.o: In function `qmp_xen_set_replication':
> /home/brogers/osr/git/qemu/migration/colo.c:172: undefined reference to
> `replication_stop_all'
> /home/brogers/osr/git/qemu/migration/colo.c:172: undefined reference to
> `replication_stop_all'
> /home/brogers/osr/git/qemu/migration/colo.c:167: undefined reference to
> `replication_start_all'
> ../migration/colo.o: In function `qmp_xen_colo_do_checkpoint':
> /home/brogers/osr/git/qemu/migration/colo.c:196: undefined reference to
> `replication_do_checkpoint_all'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:208: qemu-system-aarch64] Error 1
> make: *** [Makefile:322: subdir-aarch64-softmmu] Error 2
>=20
> --
> Bruce
> =20
>=20
>=20
