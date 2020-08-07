Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572F2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CC412177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC412177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yja-0005sI-CY
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3yh6-0003We-4a
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:29:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:42932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3yh3-0002fi-Oc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:29:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3yh1-0005oP-WD
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 09:29:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EC8752E808C
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 09:29:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 09:19:56 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1030807@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: k-henning-z philmd th-huth
X-Launchpad-Bug-Reporter: Henning Schild (k-henning-z)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <20120730102531.13148.51710.malonedeb@wampee.canonical.com>
 <159678769319.10780.14963118191647047477.malone@chaenomeles.canonical.com>
Message-ID: <4e854df9-b3e2-ecf0-0c24-0c4d8031bd93@redhat.com>
Subject: Re: [Bug 1030807] Re: PCI host bridge should ignore 1- and 2-byte I/O
 accesses
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 2c76416c1bddbcb0868f34930925a71fc6d5a57b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
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
Reply-To: Bug 1030807 <1030807@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200807091956.93x7wbhr6VL-XDtejoeNt932cRG1wqbhqeEOWKkOP6Q@z>

Cc'ing Julia (can't find her on Launchpad) because this looks
similar to a bug she has been tracking.

On 8/7/20 10:08 AM, Thomas Huth wrote:
> Looking through old bug tickets... is this still an issue with the
> latest version of QEMU? Or could we close this ticket nowadays?
> =

> =

> ** Changed in: qemu
>        Status: New =3D> Incomplete
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1030807

Title:
  PCI host bridge should ignore 1- and 2-byte I/O accesses

Status in QEMU:
  Incomplete

Bug description:
  In PCI there are two IO modes. Deprecated Mode2 that uses single byte IO =
and Mode1 that uses 4byte IO.
  According to the spec a host bridge that supports Mode1 should ignore all=
 IO that is not 4bytes.

  > Anytime a host bridge sees a full DWORD I/O write from the host to
  > CONFIG_ADDRESS, the bridge must latch the data into its CONFIG_ADDRESS
  > register. On full DWORD I/O reads to CONFIG_ADDRESS, the bridge must re=
turn the
  > data in CONFIG_ADDRESS. Any other types of accesses to this address (no=
n-DWORD)
  > have no effect on CONFIG_ADDRESS and are executed as normal I/O transac=
tions on
  > the PCI bus. Therefore, the only I/O Space consumed by this register is=
 a DWORD at the
  > given address. I/O devices that share the same address but use BYTE or =
WORD registers
  > are not affected because their transactions will pass through the host =
bridge unchanged.

  In qemu the host bridge will accept 1-, 2-, and 4-byte reads/writes.
  That breakes plan9 guests that do not use the bios to access the PCI
  config space.

  have a look at:
  http://code.google.com/p/plan9front/source/browse/sys/src/9/pc/pci.c

  In Lines 960-967 the check for PCI Mode1 is done. This check assumes that=
 the 4-byte write at line 961 succeeds and the single byte write at 962 is =
ignored.
  On qemu line 962 will not be ignored and the test in line 963 will fail.
  The plan9 kernel will fall back to Mode2 which does not work.
  The result is that the guest will not see any PCI devices.

  I do not really have an image that you guys could quickly check this with=
, but i could prepare one if need be.
  An easy way to reproduce this in linux would be to stick an outb between =
those two lines from pci_check_type1(void).

  > outl(0x80000000, 0xCF8);
  + outb0x01, 0xcfb);
  > if (inl(0xCF8) =3D=3D 0x80000000 && pci_sanity_check(&pci_direct_conf1)=
) {

  I did not try this but i guess on real hardware the linux kernel would
  still work while it would not work anymore on qemu.

  I tried to come up with a patch but did not find a quick solution. I
  found that in hw/piic_pci.c sysbus_add_io is used which will register
  read/write functions for 1, 2, and 4 bytes. This is done in ioport.c
  ioport_register. I guess if i provided a patch you guys might not like
  it :). So i figured i should report the bug, let me know if you need
  any additional information.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1030807/+subscriptions

