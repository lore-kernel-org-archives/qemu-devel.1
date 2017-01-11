Received: from eggs.gnu.org ([2001:4830:134:3::10]:42201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cR7cb-00012l-AQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 20:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cardoe@cardoe.com>) id 1cR7cY-0002nj-5h
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 20:22:37 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cardoe@cardoe.com>) id 1cR7cX-0002nH-U6
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 20:22:34 -0500
Received: by mail-it0-x243.google.com with SMTP id o138so1228834ito.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 17:22:33 -0800 (PST)
References: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
	<20170109130852.GE2541@work-vm>
	<20170110160154.GD17540@stefanha-x1.localdomain>
From: Doug Goldstein <cardoe@cardoe.com>
Message-ID: <eb09b932-772f-edcc-abca-a90c2e2d98af@cardoe.com>
Date: Tue, 10 Jan 2017 19:22:24 -0600
MIME-Version: 1.0
In-Reply-To: <20170110160154.GD17540@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="rEm0qabDGvBbvCcJcjq8iQlxPc0pitB3O"
Subject: Re: [Qemu-devel] assert hit on master with q35 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rEm0qabDGvBbvCcJcjq8iQlxPc0pitB3O
From: Doug Goldstein <cardoe@cardoe.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <eb09b932-772f-edcc-abca-a90c2e2d98af@cardoe.com>
Subject: Re: [Qemu-devel] assert hit on master with q35 machine type
References: <38337537-d2f4-6933-f4fe-2092247a199d@cardoe.com>
 <20170109130852.GE2541@work-vm>
 <20170110160154.GD17540@stefanha-x1.localdomain>
In-Reply-To: <20170110160154.GD17540@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/10/17 10:01 AM, Stefan Hajnoczi wrote:
> On Mon, Jan 09, 2017 at 01:08:53PM +0000, Dr. David Alan Gilbert wrote:=

>> copying in Stefan since it's his commit.
>=20
> I can't reproduce the assertion failure.
>=20
> Are you able to provide a backtrace (e.g. launch QEMU under gdb and the=
n
> use the 'bt' command after the assertion failure is raised)?
>=20
> Thanks,
> Stefan
>=20

#0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.=
c:58
#1  0x00007ffff44db3ea in __GI_abort () at abort.c:89
#2  0x00007ffff44d1bb7 in __assert_fail_base (fmt=3D<optimized out>,
    assertion=3Dassertion@entry=3D0x555555ae8e8a "vq->notification_disabl=
ed
> 0",
    file=3Dfile@entry=3D0x555555ae89c0
"/home/doug/work/qemu/hw/virtio/virtio.c",
    line=3Dline@entry=3D215,
    function=3Dfunction@entry=3D0x555555ae9630 <__PRETTY_FUNCTION__.43707=
>
"virtio_queue_set_notification") at assert.c:92
#3  0x00007ffff44d1c62 in __GI___assert_fail (
    assertion=3Dassertion@entry=3D0x555555ae8e8a "vq->notification_disabl=
ed
> 0",
    file=3Dfile@entry=3D0x555555ae89c0
"/home/doug/work/qemu/hw/virtio/virtio.c",
    line=3Dline@entry=3D215,
    function=3Dfunction@entry=3D0x555555ae9630 <__PRETTY_FUNCTION__.43707=
>
"virtio_queue_set_notification") at assert.c:101
#4  0x00005555557f25d6 in virtio_queue_set_notification (vq=3D0x55555666a=
a90,
    enable=3Denable@entry=3D1) at /home/doug/work/qemu/hw/virtio/virtio.c=
:215
#5  0x00005555557dc311 in virtio_net_has_buffers (q=3D<optimized out>,
    q=3D<optimized out>, bufsize=3D102)
    at /home/doug/work/qemu/hw/net/virtio-net.c:1008
#6  virtio_net_receive (nc=3D<optimized out>, buf=3D0x555557386b88 "", si=
ze=3D102)
    at /home/doug/work/qemu/hw/net/virtio-net.c:1148
#7  0x00005555559cad33 in nc_sendv_compat (flags=3D<optimized out>, iovcn=
t=3D1,
    iov=3D0x7fffead746d0, nc=3D0x55555788b340) at net/net.c:705
#8  qemu_deliver_packet_iov (sender=3D<optimized out>, flags=3D<optimized=
 out>,
    iov=3D0x7fffead746d0, iovcnt=3D1, opaque=3D0x55555788b340) at net/net=
=2Ec:732
#9  0x00005555559cd929 in qemu_net_queue_deliver (size=3D<optimized out>,=

    data=3D<optimized out>, flags=3D<optimized out>, sender=3D<optimized =
out>,
    queue=3D0x55555788b550) at net/queue.c:164
#10 qemu_net_queue_flush (queue=3D0x55555788b550) at net/queue.c:261
#11 0x00005555559cab0c in qemu_flush_or_purge_queued_packets (
    nc=3D0x55555788b340, purge=3D<optimized out>) at net/net.c:611
#12 0x00005555557f1eff in virtio_queue_notify_vq (vq=3D0x55555666aa90)
    at /home/doug/work/qemu/hw/virtio/virtio.c:1318
#13 0x00005555557adec8 in memory_region_write_accessor (mr=3D0x555557756d=
30,
    addr=3D0, value=3D<optimized out>, size=3D2, shift=3D<optimized out>,=

    mask=3D<optimized out>, attrs=3D...) at /home/doug/work/qemu/memory.c=
:526
#14 0x00005555557ab25d in access_with_adjusted_size (addr=3Daddr@entry=3D=
0,
    value=3Dvalue@entry=3D0x7fffead74888, size=3Dsize@entry=3D2,
    access_size_min=3D<optimized out>, access_size_max=3D<optimized out>,=

    access=3D0x5555557ade50 <memory_region_write_accessor>, mr=3D0x555557=
756d30,
    attrs=3D...) at /home/doug/work/qemu/memory.c:592
#15 0x00005555557af28c in memory_region_dispatch_write (
    mr=3Dmr@entry=3D0x555557756d30, addr=3D0, data=3D<optimized out>,
    size=3Dsize@entry=3D2, attrs=3Dattrs@entry=3D...)
    at /home/doug/work/qemu/memory.c:1336
#16 0x0000555555764d8a in address_space_write_continue (mr=3D0x555557756d=
30,
    l=3D<optimized out>, addr1=3D<optimized out>, len=3D2, buf=3D0x7ffff7=
fed028 "",
    attrs=3D..., addr=3D34359750656, as=3D0x5555560aa6a0 <address_space_m=
emory>)
    at /home/doug/work/qemu/exec.c:2635
#17 address_space_write (as=3D0x5555560aa6a0 <address_space_memory>,
    addr=3D<optimized out>, attrs=3D..., buf=3D<optimized out>, len=3D<op=
timized
out>)
    at /home/doug/work/qemu/exec.c:2686
#18 0x000055555576532d in address_space_rw (as=3D<optimized out>,
    addr=3D<optimized out>, attrs=3D..., attrs@entry=3D...,
    buf=3Dbuf@entry=3D0x7ffff7fed028 "", len=3D<optimized out>,
    is_write=3D<optimized out>) at /home/doug/work/qemu/exec.c:2788
#19 0x00005555557aa2a8 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x5555565bc7f0)=

    at /home/doug/work/qemu/kvm-all.c:1968
#20 0x0000555555797d48 in qemu_kvm_cpu_thread_fn (arg=3D0x5555565bc7f0)
    at /home/doug/work/qemu/cpus.c:998
#21 0x00007ffff48726ca in start_thread (arg=3D0x7fffead75700)
    at pthread_create.c:333
#22 0x00007ffff45ac0af in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:105

--=20
Doug Goldstein


--rEm0qabDGvBbvCcJcjq8iQlxPc0pitB3O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0

iQJ7BAEBCgBmBQJYdYjWXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRBNTM5MEQ2RTNFMTkyNzlCNzVDMzIwOTVB
MkJDMDNEQzg3RUQxQkQ0AAoJEKK8A9yH7RvUO+sP+MSzRIoSLkVNWDZLO0noNtZh
40284MiEhplom0/rv1XEZ4i4los+L+e5tml6tEklqZZCUu1brvk19mHQz++iFMlR
twNNEg8sPIWKFOCynroFVDOmwVpY/VlwEbRdF2sFsZrzYjEu3WCXftceLINkoqaJ
90atSMg6ywdkovbJ6YYiw5FipwvK3LBhmcv4xCuRmTE76ns6GZGqH3RfP6MF+rWP
s2e73W4b67LKkc3Ec7KaXSYCa2SlI1xqDSi+cJr6OQ9vSECcKL2Y0zFfjMNH5SAz
+pPY83k4e4F3rBvHnw7EZay3S2h/MVozlaTG2uua0NoCYVoSluKiJHPLjCia1Ycw
SNzytPSYu8AYsCF6DrawmaR4A8ArQMRzJYWO+58p7mho8l2A5W4JNJk7zkJWwmTS
r4Zd7acBxt3bQuMLpBn8/j69pIq4uyGbsDMZj/Opdq4eKVaHaBmUDWJerbu+yqU7
a9r3BiiwGrqkPcDRHnYJwqqRWcCnJqiEnVOrwR4sWeqaYg1QTCZD+IBX1SCJEchG
R0aps4s8bhtESO8PC/k8nrroS5jCLBdJjT4bIr6BUjFyobIanWOJ8rVe7MXL42C2
st6E9qFI0cmth6XZPvrS5izD9Kr1mXnDHd3SACbkebbzhiMV1ztGWpWUWZ0TqK38
LwGH7eYzzvnuKonUlq4=
=S5i/
-----END PGP SIGNATURE-----

--rEm0qabDGvBbvCcJcjq8iQlxPc0pitB3O--
