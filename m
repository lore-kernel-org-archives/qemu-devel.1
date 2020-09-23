Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259FCC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:49:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52E320708
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 17:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52E320708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL8t2-0000fi-NF
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 13:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kL8pk-0008Pe-80
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:45:36 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:28874)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kL8ph-0003lH-7y
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 13:45:35 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 08NHiFQo091877;
 Wed, 23 Sep 2020 19:44:15 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 08NHiFki025286; Wed, 23 Sep 2020 19:44:15 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 08NHiFFL025284;
 Wed, 23 Sep 2020 19:44:15 +0200
X-Authentication-Warning: haar.felk.cvut.cz: pisa set sender to
 pisa@cmp.felk.cvut.cz using -f
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/7] hw/net/can: Correct Kconfig dependencies after
 switch to meson build.
Date: Wed, 23 Sep 2020 19:44:14 +0200
User-Agent: KMail/1.9.10
References: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
 <dd539770e9c182125a9c3d87b9ca329121b11abc.1599168753.git.pisa@cmp.felk.cvut.cz>
 <9bd9046d-9a16-3c23-3044-4446a9a05b55@redhat.com>
In-Reply-To: <9bd9046d-9a16-3c23-3044-4446a9a05b55@redhat.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202009231944.14734.pisa@cmp.felk.cvut.cz>
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 08NHiFQo091877
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.099, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
 NICE_REPLY_A -0.00, SPF_HELO_NONE 0.00, SPF_NONE 0.00,
 URIBL_BLOCKED 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1601487860.57122@rMSxjLa4huBukhM8qo81fA
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 13:45:26
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marek Vasut <marex@denx.de>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Charvat <charvj10@fel.cvut.cz>, Jan Kiszka <jan.kiszka@siemens.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Paolo,

On Wednesday 23 of September 2020 17:48:09 Paolo Bonzini wrote:
> On 03/09/20 23:48, Pavel Pisa wrote:
> > The original CAN_PCI config option enables multiple SJA1000 PCI boards
> > emulation build. These boards bridge SJA1000 into I/O or memory
> > address space of the host CPU and depend on SJA1000 emulation.
>
> Can you explain how the mistake is related to the meson switch?
>
> The conversion seems good:
>
> diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs
> deleted file mode 100644
> index 9f0c4ee332..0000000000
> --- a/hw/net/can/Makefile.objs
> +++ /dev/null
> @@ -1,4 +0,0 @@
> -common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
> -common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
> -common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
> -common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
> diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
> new file mode 100644
> index 0000000000..c9cfeb7954
> --- /dev/null
> +++ b/hw/net/can/meson.build
> @@ -0,0 +1,4 @@
> +softmmu_ss.add(when: 'CONFIG_CAN_SJA1000', if_true:
> files('can_sja1000.c')) +softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true:
> files('can_kvaser_pci.c')) +softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true:
> files('can_pcm3680_pci.c')) +softmmu_ss.add(when: 'CONFIG_CAN_PCI',
> if_true: files('can_mioe3680_pci.c'))

I have analyzed history and potential problem source is older
then the switch to meson build but I did not realized it before
update to the meson build between v1 and v2 patches submission.

There has not been described dependencies between options
in the original QEMU code.

There has been only single list what is compiled in for targets
supporting PCI

default-configs/pci.mak:

 CONFIG_CAN_BUS=y
 CONFIG_CAN_SJA1000=y
 CONFIG_CAN_PCI=y

So good, all enabled together, so no problem with mutual dependencies.
But when the QEMU switched to Kconfig

  build: convert pci.mak to Kconfig 1/23/19 7:56 AM

then config looks like this

hw/net/Kconfig:
  config CAN_PCI
     bool
      default y if PCI_DEVICES
      depends on PCI
      select CAN_BUS
 
  config CAN_SJA1000
      bool
      default y if PCI_DEVICES
      depends on PCI
      select CAN_BUS

There is a problem when some tool (kconfig-fronteds) is used
to manually tune configuration because if the CAN_PCI
is enabled but CAN_SJA1000 stays disabled then the build fails.
That is no problem for default options combinations
controlled by PCI option.

So the problem existed there even before messon build
switch but I have noticed it when I experienced clash
of v1 patches with newer QEMU mainline. So my mistake is
that I have not identified that switch to Kconfig
started the problem.

But in the CTU CAN FD v1 submission we (with Jan Charvat)
have not distinguished between SJA1000 and CTU CAN FD
emulation enable so I have not checked where option
i enabled and how

hw/net/can/Makefile.objs:

 common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
 common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
 common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
+
+common-obj-$(CONFIG_CAN_PCI) += ctucan_core.o
+common-obj-$(CONFIG_CAN_PCI) += ctucan_pci.o

I have decided to separated SJA1000 PCI and CTU CAN FD
support in the v2 when I have to reflect mainline change
to meson anyway and I have found that there is potential
problem with the dependencies. I have updated them.

config CAN_SJA1000
    bool
    default y if PCI_DEVICES
    select CAN_BUS

config CAN_PCI
    bool
    default y if PCI_DEVICES
    depends on PCI && CAN_SJA1000
    select CAN_BUS

config CAN_CTUCANFD
    bool
    default y if PCI_DEVICES
    select CAN_BUS

config CAN_CTUCANFD_PCI
    bool
    default y if PCI_DEVICES
    depends on PCI && CAN_CTUCANFD
    select CAN_BUS

The SJA1000 and CAN_CTUCANFD controller sources should
build even without PCI support because there can be and
exists hardware options where cores are connected to
platform-bus. These systems can be emulated even without
PCI enabled in future if code for connection of these
controllers to platform-bus/device-tree in implemented
in future.

By the way, you are replying to CTU CAN FD v2 series from
2020-09-03. But mainline moved forward and I have
sent updated v3 at 2020-09-14 to reflect some bulk
change to DECLARE_INSTANCE_CHECKER etc...

If you have already pushed v2 and it does not cause
build problems then I will provide update patch
when code reaches mainline.

If you have not pushed code to the mainline yet,
consider v3 which should follow better actual
mainline state. The list of updates to v3 follows.

Thanks much for your time,

Pavel

+Patches v3 updates:
+
+ - resend triggered by switch to DECLARE_INSTANCE_CHECKER
+   in mainline. I try to follow mainline as time allows.
+
+ - SJA1000, CTU CAN FD and SocketCAN support retested
+   with QEMU mainline from 9/12/20 10:17 PM
+
+ - Added Reviewed-by: Vikram Garhwal
+   to reviewed and tested patches which are used as common
+   CAN FD base at Xilinx
+
+ - Added Vikram Garhwal to MAINTAINERS file as the second person
+   who has interrest in QEMU CAN (FD) support and would
+   like to be notified about changes and help with reviews.

