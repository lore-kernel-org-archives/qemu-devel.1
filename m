Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5A4C388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8155206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8155206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbgyy-0000BV-TW
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgsX-0000GQ-KT
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:20:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:54586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgsP-0001Kd-NG
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:20:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbgsN-00070z-NT
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:20:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A4BAD2E8023
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:20:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:11:13 -0000
From: Thomas Huth <1662600@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kozkey th-huth
X-Launchpad-Bug-Reporter: Corey Olson (kozkey)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170207172049.29850.43816.malonedeb@gac.canonical.com>
Message-Id: <160482667402.12454.17458922077197766280.malone@gac.canonical.com>
Subject: [Bug 1662600] Re: error while building from source on Ubuntu 16.04
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 13b065b855e0ae405694a3f931b71add25cd9462
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1662600 <1662600@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting all older bugs to
"Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1662600

Title:
  error while building from source on Ubuntu 16.04

Status in QEMU:
  Incomplete

Bug description:
  I'm trying to build Qemu from source (from git) as specified here:
  http://www.qemu-project.org/download/#source

  Here is the git commit hash for the source:
  7d2c6c95511e42dffe2b263275e09957723d0ff4

  During the 'make' step, I get the following error:

  migration/rdma.c: In function =E2=80=98qemu_rdma_dump_id=E2=80=99:
  migration/rdma.c:749:21: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:750:22: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:750:37: error: =E2=80=98IBV_LINK_LAYER_INFINIBAND=E2=80=
=99 undeclared (first use in this function)
  migration/rdma.c:750:37: note: each undeclared identifier is reported onl=
y once for each function it appears in
  migration/rdma.c:751:24: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:751:39: error: =E2=80=98IBV_LINK_LAYER_ETHERNET=E2=80=99=
 undeclared (first use in this function)
  migration/rdma.c: In function =E2=80=98qemu_rdma_broken_ipv6_kernel=E2=80=
=99:
  migration/rdma.c:850:26: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:850:41: error: =E2=80=98IBV_LINK_LAYER_INFINIBAND=E2=80=
=99 undeclared (first use in this function)
  migration/rdma.c:852:33: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  migration/rdma.c:852:48: error: =E2=80=98IBV_LINK_LAYER_ETHERNET=E2=80=99=
 undeclared (first use in this function)
  migration/rdma.c:891:18: error: =E2=80=98struct ibv_port_attr=E2=80=99 ha=
s no member named =E2=80=98link_layer=E2=80=99
  make: *** [migration/rdma.o] Error 1

  I searched around a bit, my problem seems related to this:
  https://patchwork.kernel.org/patch/992952/

  That issue makes me think my libibverbs may be out of date, but I
  checked and I have libibverbs-dev installed.  Is that the correct
  version?

  FYI, I installed libibverbs-dev as suggested here: http://wiki.qemu-
  project.org/index.php/Hosts/Linux#Recommended_additional_packages

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1662600/+subscriptions

