Received: from eggs.gnu.org ([2001:4830:134:3::10]:48501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIgWZ-00069I-Fw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dIgWW-0008NW-AP
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:21:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:54083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dIgWW-0008My-1y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 15:21:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dIgWT-00007d-S4
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 19:21:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BF4722E81BA
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:21:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Jun 2017 19:07:50 -0000
From: Ziemowit Pierzycki <ziemowit@pierzycki.com>
Reply-To: Bug 1696180 <1696180@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <149676875833.612.2775062648799367879.malonedeb@chaenomeles.canonical.com>
Message-Id: <149686247097.10298.7308237870896392155.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1696180] Re: Issues with qemu-img, libgfapi,
 and encryption at rest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Just upgraded to 2.9.0 and actually I see a different issue:

# qemu-img convert -O raw fedora.iso gluster://dalpinfglt04/virt0/fedora6.r=
aw
[2017-06-07 16:52:43.300902] C [rpc-clnt-ping.c:160:rpc_clnt_ping_timer_exp=
ired] 0-virt0-client-2: server 172.19.38.42:49152 has not responded in the =
last 42 seconds, disconnecting.
[2017-06-07 17:02:44.342745] E [rpc-clnt.c:365:saved_frames_unwind] (--> /l=
ib64/libglusterfs.so.0(_gf_log_callingfn+0x17d)[0x7f78c3e4fe6d] (--> /lib64=
/libgfrpc.so.0(saved_frames_unwind+0x1d1)[0x7f78c3c169a1] (--> /lib64/libgf=
rpc.so.0(saved_frames_destroy+0xe)[0x7f78c3c16abe] (--> /lib64/libgfrpc.so.=
0(rpc_clnt_connection_cleanup+0x87)[0x7f78c3c18157] (--> /lib64/libgfrpc.so=
.0(rpc_clnt_notify+0x288)[0x7f78c3c18c28] ))))) 0-virt0-client-2: forced un=
winding frame type(GlusterFS 3.3) op(WRITE(13)) called at 2017-06-07 16:52:=
00.618744 (xid=3D0x1c)
[2017-06-07 17:02:44.342952] E [rpc-clnt.c:365:saved_frames_unwind] (--> /l=
ib64/libglusterfs.so.0(_gf_log_callingfn+0x17d)[0x7f78c3e4fe6d] (--> /lib64=
/libgfrpc.so.0(saved_frames_unwind+0x1d1)[0x7f78c3c169a1] (--> /lib64/libgf=
rpc.so.0(saved_frames_destroy+0xe)[0x7f78c3c16abe] (--> /lib64/libgfrpc.so.=
0(rpc_clnt_connection_cleanup+0x87)[0x7f78c3c18157] (--> /lib64/libgfrpc.so=
.0(rpc_clnt_notify+0x288)[0x7f78c3c18c28] ))))) 0-virt0-client-2: forced un=
winding frame type(GF-DUMP) op(NULL(2)) called at 2017-06-07 16:52:00.61875=
3 (xid=3D0x1d)
[2017-06-07 17:02:44.343415] E [MSGID: 114031] [client-rpc-fops.c:1593:clie=
nt3_3_finodelk_cbk] 0-virt0-client-2: remote operation failed [Transport en=
dpoint is not connected]
[2017-06-07 17:08:49.367264] C [rpc-clnt-ping.c:160:rpc_clnt_ping_timer_exp=
ired] 0-virt0-client-3: server 172.19.38.43:49152 has not responded in the =
last 42 seconds, disconnecting.
[2017-06-07 17:13:29.969206] E [rpc-clnt.c:365:saved_frames_unwind] (--> /l=
ib64/libglusterfs.so.0(_gf_log_callingfn+0x17d)[0x7f78c3e4fe6d] (--> /lib64=
/libgfrpc.so.0(saved_frames_unwind+0x1d1)[0x7f78c3c169a1] (--> /lib64/libgf=
rpc.so.0(saved_frames_destroy+0xe)[0x7f78c3c16abe] (--> /lib64/libgfrpc.so.=
0(rpc_clnt_connection_cleanup+0x87)[0x7f78c3c18157] (--> /lib64/libgfrpc.so=
.0(rpc_clnt_notify+0x288)[0x7f78c3c18c28] ))))) 0-virt0-client-3: forced un=
winding frame type(GlusterFS 3.3) op(WRITE(13)) called at 2017-06-07 17:08:=
06.371259 (xid=3D0x22)
[2017-06-07 17:13:29.969250] E [MSGID: 114031] [client-rpc-fops.c:1593:clie=
nt3_3_finodelk_cbk] 0-virt0-client-3: remote operation failed [Transport en=
dpoint is not connected]
[2017-06-07 17:13:29.969355] E [rpc-clnt.c:365:saved_frames_unwind] (--> /l=
ib64/libglusterfs.so.0(_gf_log_callingfn+0x17d)[0x7f78c3e4fe6d] (--> /lib64=
/libgfrpc.so.0(saved_frames_unwind+0x1d1)[0x7f78c3c169a1] (--> /lib64/libgf=
rpc.so.0(saved_frames_destroy+0xe)[0x7f78c3c16abe] (--> /lib64/libgfrpc.so.=
0(rpc_clnt_connection_cleanup+0x87)[0x7f78c3c18157] (--> /lib64/libgfrpc.so=
.0(rpc_clnt_notify+0x288)[0x7f78c3c18c28] ))))) 0-virt0-client-3: forced un=
winding frame type(GF-DUMP) op(NULL(2)) called at 2017-06-07 17:08:06.37126=
8 (xid=3D0x23)
[2017-06-07 17:13:29.972665] E [MSGID: 108008] [afr-transaction.c:2619:afr_=
write_txn_refresh_done] 0-virt0-replicate-1: Failing FSETXATTR on gfid 8604=
2280-9ae1-444f-8342-be4442f82111: split-brain observed. [Input/output error]
[2017-06-07 17:13:29.977821] E [MSGID: 108008] [afr-read-txn.c:90:afr_read_=
txn_refresh_done] 0-virt0-replicate-1: Failing FGETXATTR on gfid 86042280-9=
ae1-444f-8342-be4442f82111: split-brain observed. [Input/output error]
[2017-06-07 17:13:29.981667] E [MSGID: 114031] [client-rpc-fops.c:1593:clie=
nt3_3_finodelk_cbk] 0-virt0-client-2: remote operation failed [Invalid argu=
ment]
[2017-06-07 17:13:30.157560] E [MSGID: 108006] [afr-common.c:4781:afr_notif=
y] 0-virt0-replicate-0: All subvolumes are down. Going offline until atleas=
t one of them comes back up.
[2017-06-07 17:13:30.157904] E [MSGID: 108006] [afr-common.c:4781:afr_notif=
y] 0-virt0-replicate-1: All subvolumes are down. Going offline until atleas=
t one of them comes back up.
qemu-img: gluster://dalpinfglt04/virt0/fedora6.raw: error while converting =
raw: Could not create image: Transport endpoint is not connected

The file was created but nothing was written to it.  Either way, I don't
think encryption-at-rest is tested much with qemu integration.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1696180

Title:
  Issues with qemu-img, libgfapi, and encryption at rest

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  Encryption-at-rest has been supported for some time now.  The client
  is responsible for encrypting the files with a help of a master key
  file.  I have a properly setup environment and everything appears to
  be working fine but when I use qemu-img to move a file to gluster I
  get the following:

  =

  # qemu-img convert -f raw -O raw linux.iso gluster://gluster01/virt0/linu=
x.raw
  [2017-06-06 16:52:25.489720] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_lookup+0x4e5) [0x7f30f7a36d35] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL
  [2017-06-06 16:52:25.490778] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_lookup+0x4e5) [0x7f30f7a36d35] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL
  [2017-06-06 16:52:25.492263] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_lookup+0x4e5) [0x7f30f7a36d35] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL
  [2017-06-06 16:52:25.497226] E [mem-pool.c:579:mem_put] (-->/lib64/libglu=
sterfs.so.0(syncop_create+0x44d) [0x7f30f7a3cf5d] -->/lib64/libglusterfs.so=
.0(+0x59f02) [0x7f30f7a32f02] -->/lib64/libglusterfs.so.0(mem_put+0x190) [0=
x7f30f7a24a60] ) 0-mem-pool: mem-pool ptr is NULL

  On and on until I get this message:

  [2017-06-06 17:00:03.467361] E [MSGID: 108006] [afr-common.c:4409:afr_not=
ify] 0-virt0-replicate-0: All subvolumes are down. Going offline until atle=
ast one of them comes back up.
  [2017-06-06 17:00:03.467442] E [MSGID: 108006] [afr-common.c:4409:afr_not=
ify] 0-virt0-replicate-1: All subvolumes are down. Going offline until atle=
ast one of them comes back up.

  I asked for help assuming it's a problem with glusterfs and was told
  it appears qemu-img's implementation of libgfapi doesn't call the
  xlator function correctly.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1696180/+subscriptions
