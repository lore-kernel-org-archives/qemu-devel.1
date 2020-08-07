Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F4FC433E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2572075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2572075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zaM-0006rq-HW
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3zYb-00053z-RJ
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:25:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:38758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3zYZ-0000bF-3o
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:25:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3zYV-0002jF-KM
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 10:24:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8AD612E810A
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 10:24:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 10:07:29 -0000
From: Thomas Huth <1306818@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sunha0520 th-huth
X-Launchpad-Bug-Reporter: Sunha Ahn (sunha0520)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20140411212931.9215.60239.malonedeb@gac.canonical.com>
Message-Id: <159679484983.11064.17443388587635866046.malone@chaenomeles.canonical.com>
Subject: [Bug 1306818] Re: resetting moder register in opencores_eth.c code
 (ethernet IP core specification code)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d4e1acf4c8fe01fc6f9892a99ce4bef11ad077f0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
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
Reply-To: Bug 1306818 <1306818@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking through old bug tickets... is this still an issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1306818

Title:
  resetting moder register in opencores_eth.c code (ethernet IP core
  specification  code)

Status in QEMU:
  Incomplete

Bug description:
  Hi, I would like to report a possible error in the code
  qemu/hw/net/opencores_eth.c

  The corresponding data sheet :
  http://www.cprover.org/firmware/doc/ethoc/eth_speci.pdf

  =

  In the code, there is a function open_eth_moder_host_write. =


  static void open_eth_moder_host_write(OpenEthState *s, uint32_t val)
  {
      uint32_t set =3D val & ~s->regs[MODER];

      if (set & MODER_RST) {
          open_eth_reset(s);
      }

      s->regs[MODER] =3D val;

      if (set & MODER_RXEN) {
          s->rx_desc =3D s->regs[TX_BD_NUM];
          open_eth_notify_can_receive(s);
      }
      if (set & MODER_TXEN) {
          s->tx_desc =3D 0;
          open_eth_check_start_xmit(s);
      }
  }

  This piece of code is executed when MODER (Mode Register) resister is
  command to updated to =E2=80=98val=E2=80=99.

  In case of reset, as you can see, if the MODER_RST bit (0x800) bit is set=
 && the old MODER_RST bit (0x800) of MODER register is clear, the code fall=
s into the if(set & MODER_RST) branch. Then, it calls open_eth_reset(s), wh=
ich does =E2=80=9Cs->regs[MODER] =3D 0xa000;=E2=80=9D. Now, the MODER regis=
ter is reset to 0xa000. Page 9 of the data sheet (http://www.cprover.org/fi=
rmware/doc/ethoc/eth_speci.pdf) specifies the reset value of the moder is 0=
000A000h. So far, the code works fine. =

  Then, the open_eth_moder_host_write function does not end but executes bu=
t executes =E2=80=9Cs->regs[MODER] =3D val;=E2=80=9D line. Now, the MODER r=
egister is not 0xa000 any more. =

  In fact, since the MODER_RST bit of =E2=80=98val=E2=80=99 is 1, now the M=
ODER_RST bit of the MODER register becomes 1 as well. Suppose one somehow c=
alls this  open_eth_moder_host_write again with val =3D MODER_RST with purp=
ose of resetting again. Since the MODER_RST bit is 1, (set =3D val & ~s->re=
gs[MODER]) & MODER_RST is zero. So after this, resetting again is not possi=
ble. =


  Hence, I doubt the function=E2=80=99s correctness here. I think it could =
be
  better if the function changes to :

      if (set & MODER_RST) {
          open_eth_reset(s);
  		return;
      }

  Please let me know if I am correct.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1306818/+subscriptions

