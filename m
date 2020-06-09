Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063CCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DCB206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 21:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DCB206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilT5-0004J5-5p
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 17:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jilHZ-0006YN-4f
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:55:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:57108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jilHX-0006BG-S5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:55:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jilHW-0000Ty-7f
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 20:55:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2E1682E8105
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 20:55:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2020 20:49:55 -0000
From: Eric Blake <1874073@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eblake laurent-vivier mliska philmd pmaydell
X-Launchpad-Bug-Reporter: Martin Liska (mliska)
X-Launchpad-Bug-Modifier: Eric Blake (eblake)
References: <158747496330.1952.6391008472811579405.malonedeb@chaenomeles.canonical.com>
Message-ID: <ddb9102f-19c1-fc48-8c94-608bcca86be9@redhat.com>
Subject: [Bug 1874073] Re: [PATCH] hw/openrisc/openrisc_sim: Add assertion to
 silent GCC warning
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 773e053ff51fc4a35a06b863eb700d68a78189c8
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 10:15:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1874073 <1874073@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200609204955.g7Fo0HBlHFM9juZwzdIz8G3dfFh_3lhw7h2dAdLZVE0@z>

On 6/9/20 3:42 PM, Stafford Horne wrote:

>>> While humans can tell smp_cpus will always be in the [1, 2] range,
>>> (openrisc_sim_machine_init sets mc->max_cpus =3D 2), the compiler
>>> can't.
>>>
>>> Add an assertion to give the compiler a hint there's no use of
>>> uninitialized data.
>>>

> Acked-by: Stafford Horne <shorne@gmail.com>
> =

> I see there are now two patches for this, I kind of like this assert fix.
> =

> Shall I queue it for OpenRISC pulling?  Or can someone else pick this up?

Looks like Laurent already volunteered to queue it through the trivial =

patches tree.

-- =

Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874073

Title:
  openrisc_sim.c:87:42: error: 'cpu_irqs[0]' may be used uninitialized
  in this function [-Werror=3Dmaybe-uninitialized]

Status in QEMU:
  Confirmed

Bug description:
  I see the warning since gcc10:

  static void openrisc_sim_init(MachineState *machine):
  ...
      qemu_irq *cpu_irqs[2];
  ...

  =

      serial_mm_init(get_system_memory(), 0x90000000, 0, serial_irq,
                     115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);

  I would initialize cpu_irqs[2] with {}.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874073/+subscriptions

