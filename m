Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57528C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 04:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2272B2072A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 04:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2272B2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k25jO-0006eZ-BG
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 00:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k25ig-0006Es-T6
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 00:35:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:42082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k25ie-0008R8-E3
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 00:35:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k25ib-00061z-Ed
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2020 04:35:29 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5DF482E80E7
 for <qemu-devel@nongnu.org>; Sun,  2 Aug 2020 04:35:29 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2020 04:29:37 -0000
From: Patrick Magauran <1889943@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: patmagauran
X-Launchpad-Bug-Reporter: Patrick Magauran (patmagauran)
X-Launchpad-Bug-Modifier: Patrick Magauran (patmagauran)
References: <159622949743.5060.8912306868276612545.malonedeb@soybean.canonical.com>
Message-Id: <159634257744.3361.8442021489420408279.malone@gac.canonical.com>
Subject: [Bug 1889943] Re: Improper TCP/IP packet splitting on e1000e/vmxnet3
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2ba648486f158aa1183f0e00eb3d05ad123d1852
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 00:35:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1889943 <1889943@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After stepping through the code, it has become clear that the
e1000e/vmxnet3 emulated models do not implement TCP segmentation,
however they still "advertise" it as a feature to the guest OS.

Regarding my prior interpretation, the implementation is written to
forward the entire packet to the host OS if the has_vnet_hdr variable is
set, which is passed all the way up from the IFF_VNET_HDR on the tap/tun
interface. I am not sure what the kernel considers when setting that
flag, but it appears that it is true when in a host-only configuration,
and false otherwise. I may look into the virtio implementation to see
how it affects that because they are linked.

In order to fix this, it would likely be possible to modify the
net_tx_pkt_do_sw_fragmentation function in net_tx_pkt.c to incorporate
the full set of offloads, not just ipv4.

Because both the e1000e and the vmxnet3 implmentations share net_tx_pkt
functions, this could fix both.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1889943

Title:
  Improper TCP/IP packet splitting on e1000e/vmxnet3

Status in QEMU:
  New

Bug description:
  Problem Description:
  When using a tap interface and the guest sends a TCP packet that would ne=
ed to be segmented, it is fragmented using IP fragmentation. The host does =
not reassemble the IP fragments and forwards them to the next hop. This cau=
ses issues on certain ISPs, which seemingly reject IP fragments(Verizon Fio=
s). =

  This issue occurs on the e1000e and vmxnet3 NIC models, and possibly othe=
rs. It does not occur on the virtio(which passes the entire packet through =
to the host w/o fragmentation or segmentation) or the e1000 model(). =


  Test scenario:
  Setup a tap and network bridge using the directions here: https://gist.gi=
thub.com/extremecoders-re/e8fd8a67a515fee0c873dcafc81d811c
  Boot the machine into any modern guest(a Fedora 31 live iso was used for =
testing)
  Begin a wireshark capture on the host machine
  On the host(or another machine on the network) run: npx http-echo-server(=
See https://github.com/watson/http-echo-server)
  On the guest run
  Curl -d =E2=80=9CLorem ipsum dolor sit amet, consectetur adipiscing elit.=
 Maecenas venenatis viverra ipsum, ac tincidunt est rhoncus eu. Suspendisse=
 vehicula congue ante, non rhoncus elit tempus vitae. Duis ac leo massa. Do=
nec rutrum condimentum turpis nec ultricies. Duis laoreet elit eu arcu pulv=
inar, vitae congue neque mattis. Mauris sed ante nunc. Vestibulum vitae urn=
a a tellus maximus sagittis. Vivamus luctus pellentesque neque, vel tempor =
purus porta ut. Phasellus at quam bibendum, fermentum libero sit amet, ulla=
mcorper mauris. In rutrum sit amet dui id maximus. Ut lectus ligula, hendre=
rit nec aliquam non, finibus a turpis. Proin scelerisque convallis ante, et=
 pharetra elit. Donec nunc nisl, viverra vitae dui at, posuere rhoncus nibh=
. Mauris in massa quis neque posuere placerat quis quis massa. Donec quis l=
acus ligula. Donec mollis vel nisi eget elementum. Nam id magna porta nunc =
consectetur efficitur ac quis lorem. Cras faucibus vel ex porttitor mattis.=
 Praesent in mattis tortor. In venenatis convallis quam, in posuere nibh. P=
roin non dignissim massa. Cras at mi ut lorem tristique fringilla. Nulla ac=
 quam condimentum metus tincidunt vulputate ut at leo. Nunc pellentesque, n=
unc vel rhoncus condimentum, arcu sem molestie augue, in suscipit mauris od=
io mollis odio. Integer hendrerit lectus a leo facilisis, in accumsan urna =
maximus. Nam nec odio volutpat, varius est id, tempus libero. Vestibulum lo=
bortis tortor quam, ac scelerisque urna rhoncus in. Etiam tempor, est sit a=
met vulputate molestie, urna neque sodales leo, sit amet blandit risus feli=
s sed est. Nulla eu eros nec tortor dapibus maximus faucibus ut erat. Ut ph=
aretra tempor massa in bibendum. Interdum et malesuada fames ac ante ipsum =
primis in faucibus. Etiam mattis molestie felis eu efficitur. Morbi tincidu=
nt consectetur diam tincidunt feugiat. Morbi euismod ut lorem finibus pelle=
ntesque. Aliquam eu porta ex. Aliquam cursus, orci sit amet volutpat egesta=
s, est est pulvinar erat, sed luctus nisl ligula eget justo vestibulum.=E2=
=80=9D <ECHOSERVERIP:PORT>

  2000 bytes of Lorem Ipsum taken from https://www.lipsum.com/

  Compare results from an e1000, a virtio, and a e1000e card:
  +--------+-----------+---------+------------+
  | Model  | Fragment  | Segment | Wire Size  |
  +--------+-----------+---------+------------+
  | e1000e | Yes       | NO      | 1484 + 621 |
  +--------+-----------+---------+------------+
  | e1000  | No        | Yes     | 1516 + 620 |
  +--------+-----------+---------+------------+
  | Virtio | NO        | NO      | 2068       |
  +--------+-----------+---------+------------+

  Expected Results:
  TCP Segment to proper size OR pass full size to host and let the host spl=
it if necessary.

  Configuration changes that did not work:
  Disable host, guest, router firewalls
  Different Hosts
  Different Physical NICs
  Libvirt based NAT/Routed modes
  Fedora 32 vs 31
  Qemu 4.2.0 vs github commit d74824cf7c8b352f9045e949dc636c7207a41eee

  System Information:
  lsb_release -rd
  Description:	Fedora release 32 (Thirty Two)
  Release:	32

  uname -a
  Linux pats-laptop-linux 5.7.10-201.fc32.x86_64 #1 SMP Thu Jul 23 00:58:39=
 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

  I can provide additional logs, debug info, etc. if needed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1889943/+subscriptions

