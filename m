Received: from eggs.gnu.org ([2001:4830:134:3::10]:50230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaxO-0007A7-8c
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ctaxK-00029Z-Qr
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:21:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:54989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ctaxK-00028l-JR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:21:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ctaxJ-0000P0-1j
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 14:21:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6850C2E81A7
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 14:21:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Mar 2017 14:14:26 -0000
From: Thomas Huth <1629618@bugs.launchpad.net>
Reply-To: Bug 1629618 <1629618@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161002040116.27549.43175.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170330141427.10482.75130.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1629618] Re: QEMU causes host hang / reset on
 PPC64EL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Closing, since this is a kernel problem, not a QEMU problem.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1629618

Title:
  QEMU causes host hang / reset on PPC64EL

Status in QEMU:
  Invalid

Bug description:
  QEMU causes a host hang / reset on PPC64EL when used in KVM + HV mode
  (kvm_hv module).

  After a random amount of uptime, starting new QEMU virtual machines
  will cause the host to experience a soft CPU lockup.  Depending on
  configuration and other random factors the host will either checkstop
  and reboot, or hang indefinitely.  The following stacktrace was pulled
  from an instance where the host simply hung after starting a fourth
  virtual machine.

  Command line:

  qemu-system-ppc64 --enable-kvm -M pseries -cpu host -smp
  14,cores=3D14,threads=3D1,sockets=3D1 -m 64G -realtime mlock=3Don -kernel
  vmlinux-4.7.0-1-powerpc64le -initrd initrd.img-4.7.0-1-powerpc64le

  Lockup trace:

  [  527.393933] KVM guest htab at c000003ae4000000 (order 29), LPID 4
  [  574.637695] INFO: rcu_sched self-detected stall on CPU
  [  574.637799] 	112-...: (5249 ticks this GP) idle=3D699/140000000000001/=
0 softirq=3D5358/5382 fqs=3D5072
  [  574.637877] 	 (t=3D5250 jiffies g=3D19853 c=3D19852 q=3D64401)
  [  574.637947] Task dump for CPU 112:
  [  574.637982] qemu-system-ppc R  running task        0 12037  11828 0x00=
040004
  [  574.638051] Call Trace:
  [  574.638081] [c000001c1cddb430] [c0000000000f2710] sched_show_task+0xe0=
/0x180 (unreliable)
  [  574.638164] [c000001c1cddb4a0] [c0000000001326f4] rcu_dump_cpu_stacks+=
0xe4/0x150
  [  574.638246] [c000001c1cddb4f0] [c000000000137a04] rcu_check_callbacks+=
0x6b4/0x9c0
  [  574.638328] [c000001c1cddb610] [c00000000013f7c4] update_process_times=
+0x54/0xa0
  [  574.638409] [c000001c1cddb640] [c000000000156c28] tick_sched_handle.is=
ra.5+0x48/0xe0
  [  574.638489] [c000001c1cddb680] [c000000000156d24] tick_sched_timer+0x6=
4/0xd0
  [  574.638602] [c000001c1cddb6c0] [c000000000140274] __hrtimer_run_queues=
+0x124/0x420
  [  574.638683] [c000001c1cddb750] [c00000000014123c] hrtimer_interrupt+0x=
ec/0x2c0
  [  574.638765] [c000001c1cddb810] [c00000000001fe5c] __timer_interrupt+0x=
8c/0x270
  [  574.638847] [c000001c1cddb860] [c00000000002053c] timer_interrupt+0x9c=
/0xe0
  [  574.638915] [c000001c1cddb890] [c000000000002750] decrementer_common+0=
x150/0x180
  [  574.639001] --- interrupt: 901 at kvmppc_hv_get_dirty_log+0x1c4/0x570 =
[kvm_hv]
  [  574.639001]     LR =3D kvmppc_hv_get_dirty_log+0x1f8/0x570 [kvm_hv]
  [  574.639114] [c000001c1cddbc30] [d00000001a524980] kvm_vm_ioctl_get_dir=
ty_log_hv+0xd0/0x170 [kvm_hv]
  [  574.639209] [c000001c1cddbc80] [d00000001a4d4140] kvm_vm_ioctl_get_dir=
ty_log+0x40/0x60 [kvm]
  [  574.639291] [c000001c1cddbcb0] [d00000001a4ca3cc] kvm_vm_ioctl+0x3fc/0=
x760 [kvm]
  [  574.639372] [c000001c1cddbd40] [c0000000002d9e18] do_vfs_ioctl+0xd8/0x=
8e0
  [  574.639442] [c000001c1cddbde0] [c0000000002da6f4] SyS_ioctl+0xd4/0xf0
  [  574.639512] [c000001c1cddbe30] [c000000000009260] system_call+0x38/0x1=
08
  [  580.601573] NMI watchdog: BUG: soft lockup - CPU#112 stuck for 22s! [q=
emu-system-ppc:12037]
  [  580.601655] Modules linked in: xt_tcpudp(E) rpcsec_gss_krb5(E) nfsv4(E=
) dns_resolver(E) ext4(E) ecb(E) crc16(E) jbd2(E) mbcache(E) tun(E) btrfs(E=
) crc32c_generic(E) raid6_pq(E) xor(E) dm_crypt(E) xts(E) gf128mul(E) algif=
_skcipher(E) af_alg(E) dm_mod(E) bonding(E) cpufreq_stats(E) iptable_filter=
(E) ip_tables(E) x_tables(E) bridge(E) stp(E) llc(E) ipmi_devintf(E) ipmi_m=
sghandler(E) i2c_dev(E) fuse(E) raid1(E) md_mod(E) ses(E) sd_mod(E) enclosu=
re(E) sg(E) binfmt_misc(E) radeon(E) ttm(E) drm_kms_helper(E) snd_hda_codec=
_hdmi(E) snd_hda_intel(E) drm(E) snd_hda_codec(E) snd_hda_core(E) snd_hwdep=
(E) snd_pcm(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) sn=
d_timer(E) evdev(E) i2c_algo_bit(E) snd(E) soundcore(E) at24(E) ahci(E) mpt=
3sas(E) nvmem_core(E) libahci(E) raid_class(E) scsi_transport_sas(E) powern=
v_rng(E) rng_core(E) uinput(E) kvm_hv(E) kvm(E) ib_srp(E) scsi_transport_sr=
p(E) ofpart(E) powernv_flash(E) mtd(E) nfsd(E) opal_prd(E) auth_rpcgss(E) p=
arport_pc(E) lp(E) parport(E) autofs4(E) nfsv3(E) nfs_acl(E) nfs(E) lockd(E=
) grace(E) sunrpc(E) fscache(E) ib_ipoib(E) ib_umad(E) rdma_ucm(E) ib_uverb=
s(E) rdma_cm(E) iw_cm(E) ib_cm(E) ib_sa(E) configfs(E) hid_generic(E) usbhi=
d(E) hid(E) xhci_pci(E) xhci_hcd(E) usbcore(E) tg3(E) usb_common(E) ptp(E) =
pps_core(E) libphy(E) ib_mthca(E) ib_mad(E) ib_core(E) ib_addr(E)
  [  580.603295] CPU: 112 PID: 12037 Comm: qemu-system-ppc Tainted: G      =
      E   4.6.0-2-powerpc64le #1 Debian 4.6.3-1
  [  580.603386] task: c000001f706f0180 ti: c000001c1cdd8000 task.ti: c0000=
01c1cdd8000
  [  580.603456] NIP: d00000001a52cb54 LR: d00000001a52cb88 CTR: 0000000000=
000000
  [  580.603524] REGS: c000001c1cddb900 TRAP: 0901   Tainted: G            =
E    (4.6.0-2-powerpc64le Debian 4.6.3-1)
  [  580.603613] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24048=
444  XER: 00000000
  [  580.603784] CFAR: d00000001a52cb18 SOFTE: 1
  GPR00: d00000001a52cb88 c000001c1cddbb80 d00000001a53c580 40016e77790fe611
  GPR04: 0000000beceac194 00000000019a4544 0000000000000001 0000000000000000
  GPR08: 4000000000000000 0000000000000000 0000000000000001 8000000101a9b824
  GPR12: c00000000009aea0 c00000000fbbf000
  [  580.604205] NIP [d00000001a52cb54] kvmppc_hv_get_dirty_log+0x1c4/0x570=
 [kvm_hv]
  [  580.604274] LR [d00000001a52cb88] kvmppc_hv_get_dirty_log+0x1f8/0x570 =
[kvm_hv]
  [  580.604341] Call Trace:
  [  580.604366] [c000001c1cddbb80] [d00000001a52cb88] kvmppc_hv_get_dirty_=
log+0x1f8/0x570 [kvm_hv] (unreliable)
  [  580.604469] [c000001c1cddbc30] [d00000001a524980] kvm_vm_ioctl_get_dir=
ty_log_hv+0xd0/0x170 [kvm_hv]
  [  580.604562] [c000001c1cddbc80] [d00000001a4d4140] kvm_vm_ioctl_get_dir=
ty_log+0x40/0x60 [kvm]
  [  580.604685] [c000001c1cddbcb0] [d00000001a4ca3cc] kvm_vm_ioctl+0x3fc/0=
x760 [kvm]
  [  580.604765] [c000001c1cddbd40] [c0000000002d9e18] do_vfs_ioctl+0xd8/0x=
8e0
  [  580.604837] [c000001c1cddbde0] [c0000000002da6f4] SyS_ioctl+0xd4/0xf0
  [  580.604906] [c000001c1cddbe30] [c000000000009260] system_call+0x38/0x1=
08
  [  580.604977] Instruction dump:
  [  580.605012] 2ba90003 419effc4 7fa97000 419effbc 81314310 2f890000 409e=
ffb0 7d00b0a8
  [  580.605127] 7d09a039 40820014 7d08a378 7d00b1ad <41e20008> 7e89a378 4c=
00012c 2fa90000
  [  637.648374] INFO: rcu_sched self-detected stall on CPU
  [  637.648473] 	112-...: (21002 ticks this GP) idle=3D699/140000000000001=
/0 softirq=3D5358/5382 fqs=3D20825
  [  637.648554] 	 (t=3D21003 jiffies g=3D19853 c=3D19852 q=3D260741)
  [  637.648612] Task dump for CPU 112:
  [  637.648646] qemu-system-ppc R  running task        0 12037  11828 0x00=
040004
  [  637.648719] Call Trace:
  [  637.648745] [c000001c1cddb430] [c0000000000f2710] sched_show_task+0xe0=
/0x180 (unreliable)
  [  637.648825] [c000001c1cddb4a0] [c0000000001326f4] rcu_dump_cpu_stacks+=
0xe4/0x150
  [  637.648903] [c000001c1cddb4f0] [c000000000137a04] rcu_check_callbacks+=
0x6b4/0x9c0
  [  637.648985] [c000001c1cddb610] [c00000000013f7c4] update_process_times=
+0x54/0xa0
  [  637.649067] [c000001c1cddb640] [c000000000156c28] tick_sched_handle.is=
ra.5+0x48/0xe0
  [  637.649147] [c000001c1cddb680] [c000000000156d24] tick_sched_timer+0x6=
4/0xd0
  [  637.649216] [c000001c1cddb6c0] [c000000000140274] __hrtimer_run_queues=
+0x124/0x420
  [  637.649296] [c000001c1cddb750] [c00000000014123c] hrtimer_interrupt+0x=
ec/0x2c0
  [  637.649374] [c000001c1cddb810] [c00000000001fe5c] __timer_interrupt+0x=
8c/0x270
  [  637.649456] [c000001c1cddb860] [c00000000002053c] timer_interrupt+0x9c=
/0xe0
  [  637.649525] [c000001c1cddb890] [c000000000002750] decrementer_common+0=
x150/0x180
  [  637.649645] --- interrupt: 901 at kvmppc_hv_get_dirty_log+0x1c4/0x570 =
[kvm_hv]
  [  637.649645]     LR =3D kvmppc_hv_get_dirty_log+0x1f8/0x570 [kvm_hv]
  [  637.649760] [c000001c1cddbc30] [d00000001a524980] kvm_vm_ioctl_get_dir=
ty_log_hv+0xd0/0x170 [kvm_hv]
  [  637.649854] [c000001c1cddbc80] [d00000001a4d4140] kvm_vm_ioctl_get_dir=
ty_log+0x40/0x60 [kvm]
  [  637.649936] [c000001c1cddbcb0] [d00000001a4ca3cc] kvm_vm_ioctl+0x3fc/0=
x760 [kvm]
  [  637.650014] [c000001c1cddbd40] [c0000000002d9e18] do_vfs_ioctl+0xd8/0x=
8e0
  [  637.650083] [c000001c1cddbde0] [c0000000002da6f4] SyS_ioctl+0xd4/0xf0
  [  637.650153] [c000001c1cddbe30] [c000000000009260] system_call+0x38/0x1=
08

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1629618/+subscriptions
