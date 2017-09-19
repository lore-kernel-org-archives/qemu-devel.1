Received: from eggs.gnu.org ([2001:4830:134:3::10]:40853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duEFL-0000bD-2T
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duEFH-0005zl-4x
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:51:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:41194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duEFG-0005zS-Rt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:51:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duEFC-0003VE-Ki
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:51:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9A4822E84A6
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:50:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 08:43:34 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1718118 <1718118@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150580625533.32282.1265641231641467649.malonedeb@soybean.canonical.com>
Message-Id: <150581061449.13760.4455034761691572296.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1718118] Re: qemu crashes with
 hw/ppc/spapr_drc.c:417:spapr_drc_detach: assertion failed: (drc->dev)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

(gdb) bt
#0  0x00003fffb24beff0 in raise () at /lib64/libc.so.6
#1  0x00003fffb24c136c in abort () at /lib64/libc.so.6
#2  0x00003fffb2bcaa04 in g_assertion_message () at /lib64/libglib-2.0.so.0
#3  0x00003fffb2bcab0c in g_assertion_message_expr () at /lib64/libglib-2.0=
.so.0
#4  0x00000000101b85a0 in spapr_drc_detach (drc=3D0x2fc31220) at /home/nasa=
stry/qemu/hw/ppc/spapr_drc.c:417
#5  0x00000000101972e0 in spapr_memory_unplug_request (hotplug_dev=3D0x2faa=
60b0, dev=3D0x2fb8fb10, errp=3D0x3fffe92bfa90) at /home/nasastry/qemu/hw/pp=
c/spapr.c:3084
#6  0x000000001019856c in spapr_machine_device_unplug_request (hotplug_dev=
=3D0x2faa60b0, dev=3D0x2fb8fb10, errp=3D0x3fffe92bfa90)
    at /home/nasastry/qemu/hw/ppc/spapr.c:3354
#7  0x00000000104461a8 in hotplug_handler_unplug_request (plug_handler=3D0x=
2faa60b0, plugged_dev=3D0x2fb8fb10, errp=3D0x3fffe92bfa90) at hw/core/hotpl=
ug.c:45
#8  0x000000001036e15c in qdev_unplug (dev=3D0x2fb8fb10, errp=3D0x3fffe92bf=
a90) at qdev-monitor.c:878
#9  0x000000001036e1e4 in qmp_device_del (id=3D0x2fab2880 "dimm0", errp=3D0=
x3fffe92bfa90) at qdev-monitor.c:888
#10 0x000000001038975c in qmp_marshal_device_del (args=3D0x30658db0, ret=3D=
0x3fffe92bfb50, errp=3D0x3fffe92bfb48) at qmp-marshal.c:1462
#11 0x000000001081fd98 in do_qmp_dispatch (cmds=3D0x10c0e078 <qmp_commands>=
, request=3D0x3093ebf0, errp=3D0x3fffe92bfbc0) at qapi/qmp-dispatch.c:104
#12 0x000000001081ff84 in qmp_dispatch (cmds=3D0x10c0e078 <qmp_commands>, r=
equest=3D0x3093ebf0) at qapi/qmp-dispatch.c:131
#13 0x00000000100983dc in handle_qmp_command (parser=3D0x2fae1e80, tokens=
=3D0x2faa44e0) at /home/nasastry/qemu/monitor.c:3852
#14 0x000000001082aef0 in json_message_process_token (lexer=3D0x2fae1e88, i=
nput=3D0x2faa2420, type=3DJSON_RCURLY, x=3D70, y=3D374) at qobject/json-str=
eamer.c:105
#15 0x000000001086d5d0 in json_lexer_feed_char (lexer=3D0x2fae1e88, ch=3D12=
5 '}', flush=3Dfalse) at qobject/json-lexer.c:323
#16 0x000000001086d7c4 in json_lexer_feed (lexer=3D0x2fae1e88, buffer=3D0x3=
fffe92bff88 "}", size=3D1) at qobject/json-lexer.c:373
#17 0x000000001082b004 in json_message_parser_feed (parser=3D0x2fae1e80, bu=
ffer=3D0x3fffe92bff88 "}", size=3D1) at qobject/json-streamer.c:124
#18 0x000000001009863c in monitor_qmp_read (opaque=3D0x2fae1df0, buf=3D0x3f=
ffe92bff88 "}", size=3D1) at /home/nasastry/qemu/monitor.c:3894
#19 0x000000001078e3c8 in qemu_chr_be_write_impl (s=3D0x2fab36b0, buf=3D0x3=
fffe92bff88 "}", len=3D1) at chardev/char.c:167
#20 0x000000001078e484 in qemu_chr_be_write (s=3D0x2fab36b0, buf=3D0x3fffe9=
2bff88 "}", len=3D1) at chardev/char.c:179
#21 0x000000001079a910 in tcp_chr_read (chan=3D0x2fbfbbc0, cond=3DG_IO_IN, =
opaque=3D0x2fab36b0) at chardev/char-socket.c:441
#22 0x00000000107be3d4 in qio_channel_fd_source_dispatch (source=3D0x2fab47=
70, callback=3D0x1079a760 <tcp_chr_read>, user_data=3D0x2fab36b0) at io/cha=
nnel-watch.c:84
#23 0x00003fffb2b93ab0 in g_main_context_dispatch () at /lib64/libglib-2.0.=
so.0
#24 0x0000000010837e9c in glib_pollfds_poll () at util/main-loop.c:213
#25 0x0000000010838064 in os_host_main_loop_wait (timeout=3D-1) at util/mai=
n-loop.c:261
#26 0x000000001083818c in main_loop_wait (nonblocking=3D0) at util/main-loo=
p.c:515
#27 0x00000000103771c4 in main_loop () at vl.c:1999
#28 0x0000000010381828 in main (argc=3D54, argv=3D0x3fffe92c1988, envp=3D0x=
3fffe92c1b40) at vl.c:4877

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1718118

Title:
  qemu crashes with hw/ppc/spapr_drc.c:417:spapr_drc_detach: assertion
  failed: (drc->dev)

Status in QEMU:
  New

Bug description:
  Qemu crashes with error "hw/ppc/spapr_drc.c:417:spapr_drc_detach:
  assertion failed: (drc->dev)" when memory hotplug and hotunplug was
  done continuously.

  Steps to re-produce:
  1. git clone (today's i.e 19th Sept)
  2. Bring up ppc64le guest with memory hotplug capabilities ( I used libvi=
rt xml to do this).
  3. And do continuous memory hotplug and unplug using the following memory=
 xml (mem_hp_8g.xml)
  <memory model=3D'dimm'>
  <target>
  <size unit=3D'KiB'>8388608</size>
  <node>1</node>
  </target>
  </memory>
  4. Run the following =

  for i in `seq 1 100`; do virsh attach-device nrs mem_hp_8g.xml --live; vi=
rsh detach-device nrs mem_hp_8g.xml --live; done
  5. Guest will crash
  6. Following is from qemu log

  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin QEMU_=
AUDIO_DRV=3Dnone /usr/local/bin/qemu-system-ppc64 -name guest=3Dnrs,debug-t=
hreads=3Don -S -object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/=
libvirt/qemu/domain-19-nrs/master-key.aes -machine pseries-2.10,accel=3Dkvm=
,usb=3Doff,dump-guest-core=3Doff -m size=3D8388608k,slots=3D256,maxmem=3D41=
9430400k -realtime mlock=3Doff -smp 4,sockets=3D4,cores=3D1,threads=3D1 -nu=
ma node,nodeid=3D0,cpus=3D0-1,mem=3D4096 -numa node,nodeid=3D1,cpus=3D2-3,m=
em=3D4096 -uuid d7987973-2467-43ff-b8d2-acefc6ac59e5 -display none -no-user=
-config -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/lib/libvir=
t/qemu/domain-19-nrs/monitor.sock,server,nowait -mon chardev=3Dcharmonitor,=
id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shutdown -boot strict=3Don =
-device qemu-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x3 -device virtio-scsi-pci,i=
d=3Dscsi0,bus=3Dpci.0,addr=3D0x2 -drive file=3D/home/nasastry/pegas-1.0-ppc=
64le.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi0-0-0-0 -device scsi-hd,=
bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=
=3Dscsi0-0-0-0,bootindex=3D1 -netdev tap,fd=3D28,id=3Dhostnet0,vhost=3Don,v=
hostfd=3D30 -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:=
00:89:8a:8b,bus=3Dpci.0,addr=3D0x1 -chardev pty,id=3Dcharserial0 -device sp=
apr-vty,chardev=3Dcharserial0,reg=3D0x30000000 -device virtio-balloon-pci,i=
d=3Dballoon0,bus=3Dpci.0,addr=3D0x4 -s -msg timestamp=3Don
  2017-09-19 06:59:07.878+0000: Domain id=3D19 is tainted: custom-argv
  2017-09-19T06:59:07.918273Z qemu-system-ppc64: -chardev pty,id=3Dcharseri=
al0: char device redirected to /dev/pts/5 (label charserial0)
  **
  ERROR:/home/nasastry/qemu/hw/ppc/spapr_drc.c:417:spapr_drc_detach: assert=
ion failed: (drc->dev)
  2017-09-19 06:59:51.428+0000: shutting down, reason=3Dcrashed

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1718118/+subscriptions
