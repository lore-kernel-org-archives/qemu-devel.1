Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7FAC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 07:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EDA206D8
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 07:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EDA206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzEoL-00054e-0y
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 03:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzEnh-0004el-AD
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 03:40:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:42364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jzEne-0006y4-Oc
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 03:40:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jzEnb-0005jF-UY
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 07:40:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DD3432E80D2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 07:40:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2020 07:26:38 -0000
From: Vishnu Dixit <1888923@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: bandwidth hmat hmat-lb latency
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rvdixit23
X-Launchpad-Bug-Reporter: Vishnu Dixit (rvdixit23)
X-Launchpad-Bug-Modifier: Vishnu Dixit (rvdixit23)
Message-Id: <159566199879.4877.1642879405857907906.malonedeb@wampee.canonical.com>
Subject: [Bug 1888923] [NEW] Configured Memory access latency and bandwidth
 not taking effect
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e85d0ab92e2924d39b8285aeae075a01d25eff06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9b3b03559973c964d75e61ab69f427c3e8914700
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 03:40:52
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
Reply-To: Bug 1888923 <1888923@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I was trying to configure latencies and bandwidths between nodes in a
NUMA emulation using QEMU 5.0.0.

Host : Ubuntu 20.04 64 bit
Guest : Ubuntu 18.04 64 bit

The machine configured has 2 nodes. Each node has 2 CPUs and has been
allocated 3GB of memory. The memory access latencies and bandwidths for
a local access (i.e from initiator 0 to target 0, and from initiator 1
to target 1) are set as 40ns and 10GB/s respectively. The memory access
latencies and bandwidths for a remote access (i.e from initiator 1 to
target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
respectively.

The command line launch is as follows.

sudo x86_64-softmmu/qemu-system-x86_64  \
-machine hmat=3Don \
-boot c \
-enable-kvm \
-m 6G,slots=3D2,maxmem=3D7G \
-object memory-backend-ram,size=3D3G,id=3Dm0 \
-object memory-backend-ram,size=3D3G,id=3Dm1 \
-numa node,nodeid=3D0,memdev=3Dm0 \
-numa node,nodeid=3D1,memdev=3Dm1 \
-smp 4,sockets=3D4,maxcpus=3D4  \
-numa cpu,node-id=3D0,socket-id=3D0 \
-numa cpu,node-id=3D0,socket-id=3D1 \
-numa cpu,node-id=3D1,socket-id=3D2 \
-numa cpu,node-id=3D1,socket-id=3D3 \
-numa dist,src=3D0,dst=3D1,val=3D20 \
-net nic \
-net user \
-hda testing.img \
-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacces=
s-latency,latency=3D40 \
-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacces=
s-bandwidth,bandwidth=3D10G \
-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacces=
s-latency,latency=3D80 \
-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacces=
s-bandwidth,bandwidth=3D5G \
-numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacces=
s-latency,latency=3D80 \
-numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacces=
s-bandwidth,bandwidth=3D5G \
-numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacces=
s-latency,latency=3D40 \
-numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacces=
s-bandwidth,bandwidth=3D10G \

Then the latencies and bandwidths between the nodes were tested using
the Intel Memory Latency Checker v3.9
(https://software.intel.com/content/www/us/en/develop/articles/intelr-
memory-latency-checker.html). But the obtained results did not match the
configuration. The following are the results obtained.

Latency_matrix with idle latencies (in ns)

Numa Node
. .0. . .1.
0 36.2 36.4
1 34.9 35.4

Bandwidth_matrix with memory bandwidths (in MB/s)

Numa Node
. . .0. . . .1. =

0 15167.1 15308.9
1 15226.0 15234.0

A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D from l=
mbench to
measure the memory read latencies. This also gave results which did not
match the config.

Any information on why the config latency and bandwidth values are not
applied, would be appreciated.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: bandwidth hmat hmat-lb latency

** Description changed:

  I was trying to configure latencies and bandwidths between nodes in a
  NUMA emulation using QEMU 5.0.0.
  =

  Host : Ubuntu 20.04 64 bit
  Guest : Ubuntu 18.04 64 bit
-  =

- The machine configured has 2 nodes. Each node has 2 CPUs and has been all=
ocated 3GB of memory. The memory access latencies and bandwidths for a loca=
l access (i.e from initiator 0 to target 0, and from initiator 1 to target =
1) are set as 40ns and 10GB/s respectively. The memory access latencies and=
 bandwidths for a remote access (i.e from initiator 1 to target 0, and from=
 initiator 0 to target 1) are set as 80ns and 5GB/s respectively. =

+ =

+ The machine configured has 2 nodes. Each node has 2 CPUs and has been
+ allocated 3GB of memory. The memory access latencies and bandwidths for
+ a local access (i.e from initiator 0 to target 0, and from initiator 1
+ to target 1) are set as 40ns and 10GB/s respectively. The memory access
+ latencies and bandwidths for a remote access (i.e from initiator 1 to
+ target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
+ respectively.
  =

  The command line launch is as follows.
  =

  sudo x86_64-softmmu/qemu-system-x86_64  \
  -machine hmat=3Don \
  -boot c \
  -enable-kvm \
  -m 6G,slots=3D2,maxmem=3D7G \
  -object memory-backend-ram,size=3D3G,id=3Dm0 \
  -object memory-backend-ram,size=3D3G,id=3Dm1 \
  -numa node,nodeid=3D0,memdev=3Dm0 \
  -numa node,nodeid=3D1,memdev=3Dm1 \
  -smp 4,sockets=3D4,maxcpus=3D4  \
  -numa cpu,node-id=3D0,socket-id=3D0 \
  -numa cpu,node-id=3D0,socket-id=3D1 \
  -numa cpu,node-id=3D1,socket-id=3D2 \
  -numa cpu,node-id=3D1,socket-id=3D3 \
  -numa dist,src=3D0,dst=3D1,val=3D20 \
  -net nic \
  -net user \
  -hda testing.img \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
  =

  Then the latencies and bandwidths between the nodes were tested using
  the Intel Memory Latency Checker v3.9
  (https://software.intel.com/content/www/us/en/develop/articles/intelr-
  memory-latency-checker.html). But the obtained results did not match the
  configuration. The following are the results obtained.
  =

  Latency_matrix with idle latencies (in ns)
  =

  Numa
- Node  0     1
+ lat node0 node1
  0    36.2 36.4
  1    34.9 35.4
  =

  Bandwidth_matrix with memory bandwidths (in MB/s)
  =

- Numa
- Node 0       1
+ Numa Node =

+ bw node0 .bw node1
  0 15167.1 15308.9
  1 15226.0 15234.0
  =

  A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D from=
 lmbench to
  measure the memory read latencies. This also gave results which did not
  match the config.
  =

  Any information on why the config latency and bandwidth values are not
  applied, would be appreciated.

** Description changed:

  I was trying to configure latencies and bandwidths between nodes in a
  NUMA emulation using QEMU 5.0.0.
  =

  Host : Ubuntu 20.04 64 bit
  Guest : Ubuntu 18.04 64 bit
  =

  The machine configured has 2 nodes. Each node has 2 CPUs and has been
  allocated 3GB of memory. The memory access latencies and bandwidths for
  a local access (i.e from initiator 0 to target 0, and from initiator 1
  to target 1) are set as 40ns and 10GB/s respectively. The memory access
  latencies and bandwidths for a remote access (i.e from initiator 1 to
  target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
  respectively.
  =

  The command line launch is as follows.
  =

  sudo x86_64-softmmu/qemu-system-x86_64  \
  -machine hmat=3Don \
  -boot c \
  -enable-kvm \
  -m 6G,slots=3D2,maxmem=3D7G \
  -object memory-backend-ram,size=3D3G,id=3Dm0 \
  -object memory-backend-ram,size=3D3G,id=3Dm1 \
  -numa node,nodeid=3D0,memdev=3Dm0 \
  -numa node,nodeid=3D1,memdev=3Dm1 \
  -smp 4,sockets=3D4,maxcpus=3D4  \
  -numa cpu,node-id=3D0,socket-id=3D0 \
  -numa cpu,node-id=3D0,socket-id=3D1 \
  -numa cpu,node-id=3D1,socket-id=3D2 \
  -numa cpu,node-id=3D1,socket-id=3D3 \
  -numa dist,src=3D0,dst=3D1,val=3D20 \
  -net nic \
  -net user \
  -hda testing.img \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
  =

  Then the latencies and bandwidths between the nodes were tested using
  the Intel Memory Latency Checker v3.9
  (https://software.intel.com/content/www/us/en/develop/articles/intelr-
  memory-latency-checker.html). But the obtained results did not match the
  configuration. The following are the results obtained.
  =

  Latency_matrix with idle latencies (in ns)
  =

- Numa
+ Numa Node
  lat node0 node1
  0    36.2 36.4
  1    34.9 35.4
  =

  Bandwidth_matrix with memory bandwidths (in MB/s)
  =

- Numa Node =

- bw node0 .bw node1
+ Numa Node
+ bw node0  bw node1
  0 15167.1 15308.9
  1 15226.0 15234.0
  =

  A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D from=
 lmbench to
  measure the memory read latencies. This also gave results which did not
  match the config.
  =

  Any information on why the config latency and bandwidth values are not
  applied, would be appreciated.

** Description changed:

  I was trying to configure latencies and bandwidths between nodes in a
  NUMA emulation using QEMU 5.0.0.
  =

  Host : Ubuntu 20.04 64 bit
  Guest : Ubuntu 18.04 64 bit
  =

  The machine configured has 2 nodes. Each node has 2 CPUs and has been
  allocated 3GB of memory. The memory access latencies and bandwidths for
  a local access (i.e from initiator 0 to target 0, and from initiator 1
  to target 1) are set as 40ns and 10GB/s respectively. The memory access
  latencies and bandwidths for a remote access (i.e from initiator 1 to
  target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
  respectively.
  =

  The command line launch is as follows.
  =

  sudo x86_64-softmmu/qemu-system-x86_64  \
  -machine hmat=3Don \
  -boot c \
  -enable-kvm \
  -m 6G,slots=3D2,maxmem=3D7G \
  -object memory-backend-ram,size=3D3G,id=3Dm0 \
  -object memory-backend-ram,size=3D3G,id=3Dm1 \
  -numa node,nodeid=3D0,memdev=3Dm0 \
  -numa node,nodeid=3D1,memdev=3Dm1 \
  -smp 4,sockets=3D4,maxcpus=3D4  \
  -numa cpu,node-id=3D0,socket-id=3D0 \
  -numa cpu,node-id=3D0,socket-id=3D1 \
  -numa cpu,node-id=3D1,socket-id=3D2 \
  -numa cpu,node-id=3D1,socket-id=3D3 \
  -numa dist,src=3D0,dst=3D1,val=3D20 \
  -net nic \
  -net user \
  -hda testing.img \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
  =

  Then the latencies and bandwidths between the nodes were tested using
  the Intel Memory Latency Checker v3.9
  (https://software.intel.com/content/www/us/en/develop/articles/intelr-
  memory-latency-checker.html). But the obtained results did not match the
  configuration. The following are the results obtained.
  =

  Latency_matrix with idle latencies (in ns)
  =

  Numa Node
- lat node0 node1
- 0    36.2 36.4
- 1    34.9 35.4
+ . .0. . .1.
+ 0 36.2 36.4
+ 1 34.9 35.4
  =

  Bandwidth_matrix with memory bandwidths (in MB/s)
  =

  Numa Node
- bw node0  bw node1
+ . . .0. . . .1. =

  0 15167.1 15308.9
  1 15226.0 15234.0
  =

  A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D from=
 lmbench to
  measure the memory read latencies. This also gave results which did not
  match the config.
  =

  Any information on why the config latency and bandwidth values are not
  applied, would be appreciated.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1888923

Title:
  Configured Memory access latency and bandwidth not taking effect

Status in QEMU:
  New

Bug description:
  I was trying to configure latencies and bandwidths between nodes in a
  NUMA emulation using QEMU 5.0.0.

  Host : Ubuntu 20.04 64 bit
  Guest : Ubuntu 18.04 64 bit

  The machine configured has 2 nodes. Each node has 2 CPUs and has been
  allocated 3GB of memory. The memory access latencies and bandwidths
  for a local access (i.e from initiator 0 to target 0, and from
  initiator 1 to target 1) are set as 40ns and 10GB/s respectively. The
  memory access latencies and bandwidths for a remote access (i.e from
  initiator 1 to target 0, and from initiator 0 to target 1) are set as
  80ns and 5GB/s respectively.

  The command line launch is as follows.

  sudo x86_64-softmmu/qemu-system-x86_64  \
  -machine hmat=3Don \
  -boot c \
  -enable-kvm \
  -m 6G,slots=3D2,maxmem=3D7G \
  -object memory-backend-ram,size=3D3G,id=3Dm0 \
  -object memory-backend-ram,size=3D3G,id=3Dm1 \
  -numa node,nodeid=3D0,memdev=3Dm0 \
  -numa node,nodeid=3D1,memdev=3Dm1 \
  -smp 4,sockets=3D4,maxcpus=3D4  \
  -numa cpu,node-id=3D0,socket-id=3D0 \
  -numa cpu,node-id=3D0,socket-id=3D1 \
  -numa cpu,node-id=3D1,socket-id=3D2 \
  -numa cpu,node-id=3D1,socket-id=3D3 \
  -numa dist,src=3D0,dst=3D1,val=3D20 \
  -net nic \
  -net user \
  -hda testing.img \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D80 \
  -numa hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D5G \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-latency,latency=3D40 \
  -numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Dacc=
ess-bandwidth,bandwidth=3D10G \

  Then the latencies and bandwidths between the nodes were tested using
  the Intel Memory Latency Checker v3.9
  (https://software.intel.com/content/www/us/en/develop/articles/intelr-
  memory-latency-checker.html). But the obtained results did not match
  the configuration. The following are the results obtained.

  Latency_matrix with idle latencies (in ns)

  Numa Node
  . .0. . .1.
  0 36.2 36.4
  1 34.9 35.4

  Bandwidth_matrix with memory bandwidths (in MB/s)

  Numa Node
  . . .0. . . .1. =

  0 15167.1 15308.9
  1 15226.0 15234.0

  A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D from=
 lmbench to
  measure the memory read latencies. This also gave results which did
  not match the config.

  Any information on why the config latency and bandwidth values are not
  applied, would be appreciated.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1888923/+subscriptions

