Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD2C4725C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 04:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C313E206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 04:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C313E206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWBsF-0002kj-Sn
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 00:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWBrU-0002J3-6h
 for qemu-devel@nongnu.org; Wed, 06 May 2020 00:40:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:52164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jWBrT-0000Gk-0l
 for qemu-devel@nongnu.org; Wed, 06 May 2020 00:40:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jWBrQ-00005h-FN
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 04:40:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6B8B42E8107
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 04:40:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2020 04:31:51 -0000
From: Yonggang Luo <1877015@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: luoyonggang xavier-ding
X-Launchpad-Bug-Reporter: xuan (xavier-ding)
X-Launchpad-Bug-Modifier: Yonggang Luo (luoyonggang)
References: <158873300816.14142.15664636500998863138.malonedeb@gac.canonical.com>
Message-Id:
 <CAE2XoE8tLwbUPWXbGFxf_kZ2S5X-hrmQuqEM_difn8=gcJQbwg@mail.gmail.com>
Subject: Re: [Bug 1877015] [NEW] virtio only support packed ring size power of
 2 between 256 and 1024
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 08ec63f134cba6d451861e90fa3ad205048671e8
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 22:50:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1877015 <1877015@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200506043151.sJrJwOP7x0cfFOvCVvMjnxcLgJs6Vfw9PbtDvG78sow@z>

Maybe the virtio need to be revised?

On Wed, May 6, 2020 at 10:51 AM xuan <1877015@bugs.launchpad.net> wrote:

> Public bug reported:
>
> Issue discription=EF=BC=9A
> When QEMU starts with "-device
> virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,disable-modern=3D=
false,mrg_rxbuf=3Don,rx_queue_size=3D1025,tx_queue_size=3D1025,mq=3Don,vect=
ors=3D15,packed=3Don"
>
> It raises error: Invalid rx_queue_size (=3D 1025), must be a power of 2
> between 256 and 1024
>
> Analysis:
> According to virtio1.1 spec, the packed queue size value does not have to
> be a power of 2.
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1877015
>
> Title:
>   virtio only support packed ring size power of 2 between 256 and 1024
>
> Status in QEMU:
>   New
>
> Bug description:
>   Issue discription=EF=BC=9A
>   When QEMU starts with "-device
> virtio-net-pci,netdev=3Dnetdev0,mac=3D52:54:00:00:00:01,disable-modern=3D=
false,mrg_rxbuf=3Don,rx_queue_size=3D1025,tx_queue_size=3D1025,mq=3Don,vect=
ors=3D15,packed=3Don"
>
>   It raises error: Invalid rx_queue_size (=3D 1025), must be a power of 2
>   between 256 and 1024
>
>   Analysis:
>   According to virtio1.1 spec, the packed queue size value does not have
> to be a power of 2.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1877015/+subscriptions
>
>

-- =

         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877015

Title:
  virtio only support packed ring size power of 2

Status in QEMU:
  New

Bug description:
  Issue discription=EF=BC=9A
  When QEMU starts with "-device virtio-net-pci,netdev=3Dnetdev0,mac=3D52:5=
4:00:00:00:01,disable-modern=3Dfalse,mrg_rxbuf=3Don,rx_queue_size=3D1025,tx=
_queue_size=3D1025,mq=3Don,vectors=3D15,packed=3Don"

  It raises error: Invalid rx_queue_size (=3D 1025), must be a power of 2
  between 256 and 1024

  Analysis:
  According to virtio1.1 spec, the packed queue size value does not have to=
 be a power of 2.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877015/+subscriptions

