Received: from eggs.gnu.org ([2001:4830:134:3::10]:50679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMFcF-0001WM-Og
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMFcC-0008Vj-H5
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:58:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eMFcC-0008VL-7I
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:58:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 459576A7CB
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 15:58:35 +0000 (UTC)
Date: Tue, 5 Dec 2017 15:58:23 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171205155822.GA2969@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] netfilter crash with device-add e1000e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Hi,
  I've got a 25% repeatable crash doing a 'device-add e1000e'
in the netfilter code:

Program terminated with signal SIGSEGV, Segmentation fault.
#0  qemu_netfilter_receive (nf=3D0x76656474656e, direction=3DNET_FILTER_DIR=
ECTION_TX, sender=3D0x563b5c78e130, flags=3D0, iov=3D0x563b5c78e7a0, iovcnt=
=3D4, sent_cb=3D0x0) at /home/dgilbert/git/hmp/net/filter.c:34
34	    if (qemu_can_skip_netfilter(nf)) {
[Current thread is 1 (Thread 0x7f9657cfc700 (LWP 21410))]
Missing separate debuginfos, use: dnf debuginfo-install SDL-1.2.15-29.fc27.=
x86_64 at-spi2-atk-2.26.1-1.fc27.x86_64 at-spi2-core-2.26.2-1.fc27.x86_64 a=
tk-2.26.1-1.fc27.x86_64 bluez-libs-5.47-2.fc27.x86_64 brlapi-0.6.6-8.fc27.x=
86_64 bzip2-libs-1.0.6-24.fc27.x86_64 cairo-1.15.8-1.fc27.x86_64 cairo-gobj=
ect-1.15.8-1.fc27.x86_64 celt051-0.5.1.3-14.fc27.x86_64 cyrus-sasl-lib-2.1.=
26-34.fc27.x86_64 dbus-libs-1.12.0-1.fc27.x86_64 expat-2.2.5-1.fc27.x86_64 =
fontconfig-2.12.6-4.fc27.x86_64 freetype-2.8-6.fc27.x86_64 gdk-pixbuf2-2.36=
=2E11-1.fc27.x86_64 glib2-2.54.2-1.fc27.x86_64 glibc-2.26-16.fc27.x86_64 gl=
usterfs-api-3.12.3-1.fc27.x86_64 glusterfs-libs-3.12.3-1.fc27.x86_64 gmp-6.=
1.2-6.fc27.x86_64 gnutls-3.5.16-3.fc27.x86_64 graphite2-1.3.10-3.fc27.x86_6=
4 gstreamer1-1.12.3-1.fc27.x86_64 gstreamer1-plugins-base-1.12.3-1.fc27.x86=
_64 gtk3-3.22.26-1.fc27.x86_64 gvfs-client-1.34.1-1.fc27.x86_64 harfbuzz-1.=
4.8-1.fc27.x86_64 keyutils-libs-1.5.10-3.fc27.x86_64 krb5-libs-1.15.2-4.fc2=
7.x86_64 libX11-1.6.5-4.fc27.x86_64 libXau-1.0.8-9.fc27.x86_64 libXcomposit=
e-0.4.4-11.fc27.x86_64 libXcursor-1.1.14-10.fc27.x86_64 libXdamage-1.1.4-11=
=2Efc27.x86_64 libXext-1.3.3-7.fc27.x86_64 libXfixes-5.0.3-4.fc27.x86_64 li=
bXi-1.7.9-4.fc27.x86_64 libXinerama-1.1.3-9.fc27.x86_64 libXrandr-1.5.1-4.f=
c27.x86_64 libXrender-0.9.10-4.fc27.x86_64 libXtst-1.2.3-4.fc27.x86_64 liba=
cl-2.2.52-18.fc27.x86_64 libaio-0.3.110-9.fc27.x86_64 libattr-2.4.47-21.fc2=
7.x86_64 libblkid-2.30.2-1.fc27.x86_64 libcacard-2.5.3-3.fc27.x86_64 libcom=
_err-1.43.5-2.fc27.x86_64 libcrypt-nss-2.26-16.fc27.x86_64 libcurl-7.55.1-7=
=2Efc27.x86_64 libdatrie-0.2.9-6.fc27.x86_64 libdrm-2.4.88-1.fc27.x86_64 li=
bepoxy-1.4.3-3.fc27.x86_64 libfdt-1.4.5-1.fc27.x86_64 libffi-3.1-14.fc27.x8=
6_64 libgcc-7.2.1-2.fc27.x86_64 libgcrypt-1.8.1-1.fc27.x86_64 libgpg-error-=
1.27-3.fc27.x86_64 libibverbs-14-4.fc27.x86_64 libidn2-2.0.4-1.fc27.x86_64 =
libiscsi-1.15.0-5.fc27.x86_64 libjpeg-turbo-1.5.1-4.fc27.x86_64 libmount-2.=
30.2-1.fc27.x86_64 libnfs-1.9.8-5.fc27.x86_64 libnghttp2-1.25.0-1.fc27.x86_=
64 libnl3-3.4.0-1.fc27.x86_64 libpng-1.6.31-1.fc27.x86_64 libpsl-0.18.0-1.f=
c27.x86_64 librados2-12.2.1-1.fc27.x86_64 librbd1-12.2.1-1.fc27.x86_64 libr=
dmacm-14-4.fc27.x86_64 libseccomp-2.3.2-5.fc27.x86_64 libselinux-2.7-2.fc27=
=2Ex86_64 libssh2-1.8.0-5.fc27.x86_64 libstdc++-7.2.1-2.fc27.x86_64 libtasn=
1-4.12-3.fc27.x86_64 libthai-0.1.25-4.fc27.x86_64 libunistring-0.9.7-3.fc27=
=2Ex86_64 libusbx-1.0.21-4.fc27.x86_64 libuuid-2.30.2-1.fc27.x86_64 libwayl=
and-client-1.14.0-1.fc27.x86_64 libwayland-cursor-1.14.0-1.fc27.x86_64 libw=
ayland-server-1.14.0-1.fc27.x86_64 libxcb-1.12-5.fc27.x86_64 libxkbcommon-0=
=2E7.1-5.fc27.x86_64 lttng-ust-2.10.0-2.fc27.x86_64 lz4-libs-1.8.0-1.fc27.x=
86_64 lzo-2.08-11.fc27.x86_64 mesa-libgbm-17.2.4-2.fc27.x86_64 mesa-libwayl=
and-egl-17.2.4-2.fc27.x86_64 ncurses-libs-6.0-13.20170722.fc27.x86_64 nettl=
e-3.4-1.fc27.x86_64 nspr-4.17.0-1.fc27.x86_64 nss-3.34.0-1.0.fc27.x86_64 ns=
s-softokn-freebl-3.34.0-1.0.fc27.x86_64 nss-util-3.34.0-1.0.fc27.x86_64 num=
actl-libs-2.0.11-5.fc27.x86_64 openldap-2.4.45-3.fc27.x86_64 openssl-libs-1=
=2E1.0g-1.fc27.x86_64 opus-1.2.1-3.fc27.x86_64 orc-0.4.27-3.fc27.x86_64 p11=
-kit-0.23.9-2.fc27.x86_64 pango-1.40.14-1.fc27.x86_64 pcre-8.41-3.fc27.x86_=
64 pcre2-10.30-2.fc27.x86_64 pixman-0.34.0-4.fc27.x86_64 spice-server-0.14.=
0-1.fc27.x86_64 systemd-libs-234-9.fc27.x86_64 usbredir-0.7.1-5.fc27.x86_64=
 userspace-rcu-0.10.0-3.fc27.x86_64 vte3-0.36.5-5.fc27.x86_64 xen-libs-4.9.=
1-1.fc27.x86_64 xz-libs-5.2.3-4.fc27.x86_64 zlib-1.2.11-4.fc27.x86_64
(gdb) where
#0  0x0000563b5aa3bac0 in qemu_netfilter_receive (nf=3D0x76656474656e, dire=
ction=3DNET_FILTER_DIRECTION_TX, sender=3D0x563b5c78e130, flags=3D0, iov=3D=
0x563b5c78e7a0, iovcnt=3D4, sent_cb=3D0x0) at /home/dgilbert/git/hmp/net/fi=
lter.c:34
#1  0x0000563b5aa31cef in filter_receive_iov (nc=3D0x563b5c78e130, nc=3D0x5=
63b5c78e130, sent_cb=3D0x0, iovcnt=3D4, iov=3D0x563b5c78e7a0, flags=3D0, se=
nder=3D0x563b5c78e130, direction=3DNET_FILTER_DIRECTION_TX) at /home/dgilbe=
rt/git/hmp/net/net.c:571
#2  0x0000563b5aa31cef in qemu_sendv_packet_async (sender=3D0x563b5c78e130,=
 iov=3D0x563b5c78e7a0, iovcnt=3D4, sent_cb=3D0x0) at /home/dgilbert/git/hmp=
/net/net.c:768
#3  0x0000563b5a97ea18 in net_tx_pkt_sendv (pkt=3D0x563b5c867620, iov_cnt=
=3D<optimized out>, iov=3D<optimized out>, nc=3D0x563b5c78e130) at /home/dg=
ilbert/git/hmp/hw/net/net_tx_pkt.c:546
#4  0x0000563b5a97ea18 in net_tx_pkt_send (pkt=3D0x563b5c867620, nc=3Dnc@en=
try=3D0x563b5c78e130) at /home/dgilbert/git/hmp/hw/net/net_tx_pkt.c:620
#5  0x0000563b5a9882c8 in e1000e_tx_pkt_send (queue_index=3D<optimized out>=
, tx=3D0x563b5cbe3108, core=3D0x563b5cbc2ea0) at /home/dgilbert/git/hmp/hw/=
net/e1000e_core.c:665
#6  0x0000563b5a9882c8 in e1000e_process_tx_desc (queue_index=3D<optimized =
out>, dp=3D0x7f9657cf9010, tx=3D0x563b5cbe3108, core=3D0x563b5cbc2ea0) at /=
home/dgilbert/git/hmp/hw/net/e1000e_core.c:742
#7  0x0000563b5a9882c8 in e1000e_start_xmit (core=3D0x563b5cbc2ea0, txr=3Dt=
xr@entry=3D0x7f9657cf9080) at /home/dgilbert/git/hmp/hw/net/e1000e_core.c:9=
33
#8  0x0000563b5a9884ce in e1000e_set_tdt (core=3D<optimized out>, index=3D<=
optimized out>, val=3D<optimized out>) at /home/dgilbert/git/hmp/hw/net/e10=
00e_core.c:2443
#9  0x0000563b5a98b236 in e1000e_core_write (core=3D0x563b5cbc2ea0, addr=3D=
<optimized out>, val=3D1, size=3D4) at /home/dgilbert/git/hmp/hw/net/e1000e=
_core.c:3248
#10 0x0000563b5a7b63d8 in memory_region_write_accessor (mr=3D0x563b5cbc2ad0=
, addr=3D14360, value=3D<optimized out>, size=3D4, shift=3D<optimized out>,=
 mask=3D<optimized out>, attrs=3D...) at /home/dgilbert/git/hmp/memory.c:560
#11 0x0000563b5a7b386e in access_with_adjusted_size (addr=3Daddr@entry=3D14=
360, value=3Dvalue@entry=3D0x7f9657cf9238, size=3Dsize@entry=3D4, access_si=
ze_min=3D<optimized out>, access_size_max=3D<optimized out>, access_fn=3D
    0x563b5a7b6360 <memory_region_write_accessor>, mr=3D0x563b5cbc2ad0, att=
rs=3D...) at /home/dgilbert/git/hmp/memory.c:627
#12 0x0000563b5a7b8357 in memory_region_dispatch_write (mr=3Dmr@entry=3D0x5=
63b5cbc2ad0, addr=3D14360, data=3D<optimized out>, size=3Dsize@entry=3D4, a=
ttrs=3Dattrs@entry=3D...) at /home/dgilbert/git/hmp/memory.c:1516
#13 0x0000563b5a773e7e in flatview_write_continue (mr=3D0x563b5cbc2ad0, l=
=3D<optimized out>, addr1=3D<optimized out>, len=3D4, buf=3D0x7f96bdf27028 =
<error: Cannot access memory at address 0x7f96bdf27028>, attrs=3D..., addr=
=3D1074018328, fv=3D0x7f96480122e0) at /home/dgilbert/git/hmp/exec.c:2963
#14 0x0000563b5a773e7e in flatview_write (fv=3D<optimized out>, addr=3D<opt=
imized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized out>) at =
/home/dgilbert/git/hmp/exec.c:3020
#15 0x0000563b5a778695 in flatview_rw (fv=3D<optimized out>, addr=3D<optimi=
zed out>, attrs=3D..., buf=3Dbuf@entry=3D0x7f96bdf27028 <error: Cannot acce=
ss memory at address 0x7f96bdf27028>, len=3Dlen@entry=3D0, is_write=3D<opti=
mized out>)
    at /home/dgilbert/git/hmp/exec.c:3129
#16 0x0000563b5a7786df in address_space_rw (as=3D<optimized out>, addr=3D<o=
ptimized out>, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=3D0x7f96bdf2=
7028 <error: Cannot access memory at address 0x7f96bdf27028>, len=3D0, is_w=
rite=3D<optimized out>)
    at /home/dgilbert/git/hmp/exec.c:3139
#17 0x0000563b5a7c71c8 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x563b5be6a680) a=
t /home/dgilbert/git/hmp/accel/kvm/kvm-all.c:1937
#18 0x0000563b5a7a3c74 in qemu_kvm_cpu_thread_fn (arg=3D0x563b5be6a680) at =
/home/dgilbert/git/hmp/cpus.c:1128
#19 0x00007f96bd3be609 in start_thread () at /lib64/libpthread.so.0
#20 0x00007f96b3134e6f in clone () at /lib64/libc.so.6
(gdb) p nf
$1 =3D (NetFilterState *) 0x76656474656e

that nf value is ASCII 'netdev'.

My test is currently:
QEMU -enable-kvm -m 1G -smp 2 -object memory-backend-file,id=3Dmem,size=3D1=
G,mem-path=3D/dev/shm,share=3Don -numa node,memdev=3Dmem -mem-prealloc -tra=
ce events=3Dvhost-trace-file -chardev socket,id=3Dchar0,path=3D/tmp/vubrsrc=
=2Esock -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar0,vhostforce -d=
evice virtio-net-pci,netdev=3Dmynet1 $IMAGE -net none -monitor stdio

then I've got a vhost-user-bridge running on that socket and doing
routing.
In the guest it's doing a looping curl just fetching a page.
And then at the HMP I do:

device-add e1000e

I'm sometimes seeing the crash on this VM, but also sometimes
seeing it if I then migrate and the destination fails in the same
way.

I don't think it's happening without the device-add.

This is on an unmodified 2994cb2ee244b7d6a from today.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
