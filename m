Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE22C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:46:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F313F2068F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F313F2068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sy7-0006Jn-92
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0sxN-0005Ze-KR
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:45:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:53018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0sxK-0005nF-Sk
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:45:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0sxH-0006Sz-Sb
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 20:45:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D71632E802E
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 20:45:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2020 20:39:39 -0000
From: Simon Kaegi <1888601@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dgilbert-h jasowang skaegi
X-Launchpad-Bug-Reporter: Simon Kaegi (skaegi)
X-Launchpad-Bug-Modifier: Simon Kaegi (skaegi)
References: <159547584008.11100.1316842366379773629.malonedeb@wampee.canonical.com>
Message-Id: <159605517989.16612.5973732656627579612.malone@wampee.canonical.com>
Subject: [Bug 1888601] Re: QEMU v5.1.0-rc0/rc1 hang with nested virtualization
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bc79806a53e394359d8611620757c3bc14e9c041
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 16:45:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1888601 <1888601@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

```
(gdb) thread apply all bt

Thread 5 (LWP 211759):
#0  0x00007ff56a9988d8 in g_str_hash ()
#1  0x00007ff56a997a0c in g_hash_table_lookup ()
#2  0x00007ff56a6c528f in type_table_lookup (name=3D0x7ff56ac9a9dd "virtio-=
bus") at qom/object.c:84
#3  type_get_by_name (name=3D0x7ff56ac9a9dd "virtio-bus") at qom/object.c:1=
71
#4  object_class_dynamic_cast (class=3Dclass@entry=3D0x555556d92ac0, typena=
me=3Dtypename@entry=3D0x7ff56ac9a9dd "virtio-bus") at qom/object.c:879
#5  0x00007ff56a6c55b5 in object_class_dynamic_cast_assert (class=3D0x55555=
6d92ac0, typename=3Dtypename@entry=3D0x7ff56ac9a9dd "virtio-bus", file=3Dfi=
le@entry=3D0x7ff56aca60b8 "/root/qemu/hw/virtio/virtio.c", line=3Dline@entr=
y=3D3290, =

    func=3Dfunc@entry=3D0x7ff56aca6c30 <__func__.31954> "virtio_queue_enabl=
ed") at qom/object.c:935
#6  0x00007ff56a415842 in virtio_queue_enabled (vdev=3D0x555557ed9be0, n=3D=
0) at /root/qemu/hw/virtio/virtio.c:3290
#7  0x00007ff56a5c0837 in vhost_net_start_one (dev=3D0x555557ed9be0, net=3D=
0x555556f99ca0) at hw/net/vhost_net.c:259
#8  vhost_net_start (dev=3Ddev@entry=3D0x555557ed9be0, ncs=3D0x555557eef030=
, total_queues=3Dtotal_queues@entry=3D2) at hw/net/vhost_net.c:351
#9  0x00007ff56a3f2d98 in virtio_net_vhost_status (status=3D<optimized out>=
, n=3D0x555557ed9be0) at /root/qemu/hw/net/virtio-net.c:268
#10 virtio_net_set_status (vdev=3D0x555557ed9be0, status=3D<optimized out>)=
 at /root/qemu/hw/net/virtio-net.c:349
#11 0x00007ff56a413bdb in virtio_set_status (vdev=3Dvdev@entry=3D0x555557ed=
9be0, val=3Dval@entry=3D7 '\a') at /root/qemu/hw/virtio/virtio.c:1956
#12 0x00007ff56a65bdf0 in virtio_ioport_write (val=3D7, addr=3D18, opaque=
=3D0x555557ed1a50) at hw/virtio/virtio-pci.c:331
#13 virtio_pci_config_write (opaque=3D0x555557ed1a50, addr=3D18, val=3D<opt=
imized out>, size=3D<optimized out>) at hw/virtio/virtio-pci.c:455
#14 0x00007ff56a46eb2a in memory_region_write_accessor (attrs=3D..., mask=
=3D255, shift=3D<optimized out>, size=3D1, value=3D0x7ff463ffd5f8, addr=3D<=
optimized out>, mr=3D0x555557ed2340) at /root/qemu/softmmu/memory.c:483
#15 access_with_adjusted_size (attrs=3D..., mr=3D0x555557ed2340, access_fn=
=3D<optimized out>, access_size_max=3D<optimized out>, access_size_min=3D<o=
ptimized out>, size=3D1, value=3D0x7ff463ffd5f8, addr=3D18)
    at /root/qemu/softmmu/memory.c:544
#16 memory_region_dispatch_write (mr=3Dmr@entry=3D0x555557ed2340, addr=3D<o=
ptimized out>, data=3D<optimized out>, op=3D<optimized out>, attrs=3D..., a=
ttrs@entry=3D...) at /root/qemu/softmmu/memory.c:1465
#17 0x00007ff56a3a94b2 in flatview_write_continue (fv=3D0x7ff45426a7c0, add=
r=3Daddr@entry=3D53394, attrs=3D..., attrs@entry=3D..., ptr=3Dptr@entry=3D0=
x7ff5687eb000, len=3Dlen@entry=3D1, addr1=3D<optimized out>, l=3D<optimized=
 out>, =

    mr=3D0x555557ed2340) at /root/qemu/include/qemu/host-utils.h:164
#18 0x00007ff56a3adc4d in flatview_write (len=3D1, buf=3D0x7ff5687eb000, at=
trs=3D..., addr=3D53394, fv=3D<optimized out>) at /root/qemu/exec.c:3216
#19 address_space_write (len=3D1, buf=3D0x7ff5687eb000, attrs=3D..., addr=
=3D53394, as=3D0x7ff5687eb000) at /root/qemu/exec.c:3307
#20 address_space_rw (as=3Das@entry=3D0x7ff56b444d60 <address_space_io>, ad=
dr=3Daddr@entry=3D53394, attrs=3Dattrs@entry=3D..., buf=3D0x7ff5687eb000, l=
en=3Dlen@entry=3D1, is_write=3Dis_write@entry=3Dtrue) at /root/qemu/exec.c:=
3317
#21 0x00007ff56a3cdd5f in kvm_handle_io (count=3D1, size=3D1, direction=3D<=
optimized out>, data=3D<optimized out>, attrs=3D..., port=3D53394) at /root=
/qemu/accel/kvm/kvm-all.c:2262
#22 kvm_cpu_exec (cpu=3Dcpu@entry=3D0x555556ffaea0) at /root/qemu/accel/kvm=
/kvm-all.c:2508
#23 0x00007ff56a46503c in qemu_kvm_cpu_thread_fn (arg=3D0x555556ffaea0) at =
/root/qemu/softmmu/cpus.c:1188
#24 qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x555556ffaea0) at /root/qemu=
/softmmu/cpus.c:1160
#25 0x00007ff56a7d0f13 in qemu_thread_start (args=3D<optimized out>) at uti=
l/qemu-thread-posix.c:521
#26 0x00007ff56ab95109 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#27 0x00007ff56ac43353 in clone ()

Thread 4 (LWP 211758):
#0  0x00007ff56ac3eebb in ioctl ()
#1  0x00007ff56a3cd98b in kvm_vcpu_ioctl (cpu=3Dcpu@entry=3D0x555556fb4ac0,=
 type=3Dtype@entry=3D44672) at /root/qemu/accel/kvm/kvm-all.c:2631
#2  0x00007ff56a3cdac5 in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x555556fb4ac0) a=
t /root/qemu/accel/kvm/kvm-all.c:2468
#3  0x00007ff56a46503c in qemu_kvm_cpu_thread_fn (arg=3D0x555556fb4ac0) at =
/root/qemu/softmmu/cpus.c:1188
#4  qemu_kvm_cpu_thread_fn (arg=3Darg@entry=3D0x555556fb4ac0) at /root/qemu=
/softmmu/cpus.c:1160
#5  0x00007ff56a7d0f13 in qemu_thread_start (args=3D<optimized out>) at uti=
l/qemu-thread-posix.c:521
#6  0x00007ff56ab95109 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#7  0x00007ff56ac43353 in clone ()

Thread 3 (LWP 211757):
#0  0x00007ff56ac3dd0f in poll ()
#1  0x00007ff56a9aa5de in g_main_context_iterate.isra () at pthread_create.=
c:679
#2  0x00007ff56a9aa963 in g_main_loop_run () at pthread_create.c:679
#3  0x00007ff56a4a5b71 in iothread_run (opaque=3Dopaque@entry=3D0x555556e0c=
800) at iothread.c:82
#4  0x00007ff56a7d0f13 in qemu_thread_start (args=3D<optimized out>) at uti=
l/qemu-thread-posix.c:521
#5  0x00007ff56ab95109 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#6  0x00007ff56ac43353 in clone ()

Thread 2 (LWP 211752):
#0  0x00007ff56ac4007d in syscall ()
#1  0x00007ff56a7d1e32 in qemu_futex_wait (val=3D<optimized out>, f=3D<opti=
mized out>) at /root/qemu/include/qemu/futex.h:29
#2  qemu_event_wait () at util/qemu-thread-posix.c:460
#3  0x00007ff56a7dc0f2 in call_rcu_thread () at util/rcu.c:258
#4  0x00007ff56a7d0f13 in qemu_thread_start (args=3D<optimized out>) at uti=
l/qemu-thread-posix.c:521
#5  0x00007ff56ab95109 in start_thread (arg=3D<optimized out>) at pthread_c=
reate.c:477
#6  0x00007ff56ac43353 in clone ()

Thread 1 (LWP 211751):
#0  __lll_lock_wait (futex=3Dfutex@entry=3D0x7ff56b447980 <qemu_global_mute=
x>, private=3D0) at lowlevellock.c:52
#1  0x00007ff56ab97263 in __pthread_mutex_lock (mutex=3Dmutex@entry=3D0x7ff=
56b447980 <qemu_global_mutex>) at ../nptl/pthread_mutex_lock.c:80
#2  0x00007ff56a7d1087 in qemu_mutex_lock_impl (mutex=3D0x7ff56b447980 <qem=
u_global_mutex>, file=3D0x7ff56adcf1e3 "util/main-loop.c", line=3D238) at u=
til/qemu-thread-posix.c:79
#3  0x00007ff56a466f8e in qemu_mutex_lock_iothread_impl (file=3Dfile@entry=
=3D0x7ff56adcf1e3 "util/main-loop.c", line=3Dline@entry=3D238) at /root/qem=
u/softmmu/cpus.c:1782
#4  0x00007ff56a7e909d in os_host_main_loop_wait (timeout=3D951196740) at u=
til/main-loop.c:238
#5  main_loop_wait (nonblocking=3Dnonblocking@entry=3D0) at util/main-loop.=
c:516
#6  0x00007ff56a47876e in qemu_main_loop () at /root/qemu/softmmu/vl.c:1676
#7  0x00007ff56a3a5b52 in main (argc=3D<optimized out>, argv=3D<optimized o=
ut>, envp=3D<optimized out>) at /root/qemu/softmmu/main.c:49
```

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888601

Title:
  QEMU v5.1.0-rc0/rc1 hang with nested virtualization

Status in QEMU:
  New

Bug description:
  We're running Kata Containers using QEMU and with v5.1.0rc0 and rc1
  have noticed a problem at startup where QEMu appears to hang. We are
  not seeing this problem on our bare metal nodes and only on a VSI that
  supports nested virtualization.

  We unfortunately see nothing at all in the QEMU logs to help
  understand the problem and a hung process is just a guess at this
  point.

  Using git bisect we first see the problem with...

  ---

  f19bcdfedd53ee93412d535a842a89fa27cae7f2 is the first bad commit
  commit f19bcdfedd53ee93412d535a842a89fa27cae7f2
  Author: Jason Wang <jasowang@redhat.com>
  Date:   Wed Jul 1 22:55:28 2020 +0800

  =C2=A0=C2=A0=C2=A0=C2=A0virtio-pci: implement queue_enabled method

  =C2=A0=C2=A0=C2=A0=C2=A0With version 1, we can detect whether a queue is =
enabled via
  =C2=A0=C2=A0=C2=A0=C2=A0queue_enabled.

  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Jason Wang <jasowang@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Cindy Lu <lulu@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Message-Id: <20200701145538.22333-5-lulu@redhat.c=
om>
  =C2=A0=C2=A0=C2=A0=C2=A0Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Acked-by: Jason Wang <jasowang@redhat.com>

  =C2=A0hw/virtio/virtio-pci.c | 13 +++++++++++++
  =C2=A01 file changed, 13 insertions(+)

  ---

  Reverting this commit (on top of 5.1.0-rc1) seems to work and prevent
  the hanging.

  ---

  Here's how kata ends up launching qemu in our environment --
  /opt/kata/bin/qemu-system-x86_64 -name sandbox-849df14c6065931adedb9d18bc=
9260a6d896f1814a8c5cfa239865772f1b7a5f -uuid 6bec458e-1da7-4847-a5d7-5ab31d=
4d2465 -machine pc,accel=3Dkvm,kernel_irqchip -cpu host,pmu=3Doff -qmp unix=
:/run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa239865772f1b7a5=
f/qmp.sock,server,nowait -m 4096M,slots=3D10,maxmem=3D30978M -device pci-br=
idge,bus=3Dpci.0,id=3Dpci-bridge-0,chassis_nr=3D1,shpc=3Don,addr=3D2,romfil=
e=3D -device virtio-serial-pci,disable-modern=3Dtrue,id=3Dserial0,romfile=
=3D -device virtconsole,chardev=3Dcharconsole0,id=3Dconsole0 -chardev socke=
t,id=3Dcharconsole0,path=3D/run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f=
1814a8c5cfa239865772f1b7a5f/console.sock,server,nowait -device virtio-scsi-=
pci,id=3Dscsi0,disable-modern=3Dtrue,romfile=3D -object rng-random,id=3Drng=
0,filename=3D/dev/urandom -device virtio-rng-pci,rng=3Drng0,romfile=3D -dev=
ice virtserialport,chardev=3Dcharch0,id=3Dchannel0,name=3Dagent.channel.0 -=
chardev socket,id=3Dcharch0,path=3D/run/vc/vm/849df14c6065931adedb9d18bc926=
0a6d896f1814a8c5cfa239865772f1b7a5f/kata.sock,server,nowait -chardev socket=
,id=3Dchar-396c5c3e19e29353,path=3D/run/vc/vm/849df14c6065931adedb9d18bc926=
0a6d896f1814a8c5cfa239865772f1b7a5f/vhost-fs.sock -device vhost-user-fs-pci=
,chardev=3Dchar-396c5c3e19e29353,tag=3DkataShared,romfile=3D -netdev tap,id=
=3Dnetwork-0,vhost=3Don,vhostfds=3D3:4,fds=3D5:6 -device driver=3Dvirtio-ne=
t-pci,netdev=3Dnetwork-0,mac=3D52:ac:2d:02:1f:6f,disable-modern=3Dtrue,mq=
=3Don,vectors=3D6,romfile=3D -global kvm-pit.lost_tick_policy=3Ddiscard -vg=
a none -no-user-config -nodefaults -nographic -daemonize -object memory-bac=
kend-file,id=3Ddimm1,size=3D4096M,mem-path=3D/dev/shm,share=3Don -numa node=
,memdev=3Ddimm1 -kernel /opt/kata/share/kata-containers/vmlinuz-5.7.9-74 -i=
nitrd /opt/kata/share/kata-containers/kata-containers-initrd_alpine_1.11.2-=
6_agent.initrd -append tsc=3Dreliable no_timer_check rcupdate.rcu_expedited=
=3D1 i8042.direct=3D1 i8042.dumbkbd=3D1 i8042.nopnp=3D1 i8042.noaux=3D1 nor=
eplace-smp reboot=3Dk console=3Dhvc0 console=3Dhvc1 iommu=3Doff cryptomgr.n=
otests net.ifnames=3D0 pci=3Dlastbus=3D0 debug panic=3D1 nr_cpus=3D4 agent.=
use_vsock=3Dfalse scsi_mod.scan=3Dnone init=3D/usr/bin/kata-agent -pidfile =
/run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa239865772f1b7a5f=
/pid -D /run/vc/vm/849df14c6065931adedb9d18bc9260a6d896f1814a8c5cfa23986577=
2f1b7a5f/qemu.log -smp 2,cores=3D1,threads=3D1,sockets=3D4,maxcpus=3D4

  ---

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888601/+subscriptions

