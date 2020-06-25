Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2691C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A80C2080C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bdfpsIPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A80C2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXAx-00071O-TX
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joX7A-0002IB-2z; Thu, 25 Jun 2020 15:00:48 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com
 ([40.107.8.108]:43330 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1joX75-0004TP-R2; Thu, 25 Jun 2020 15:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqzdUkSRYXZpCcMJOwyCQ3+ipikm5VGLlIH6TRg8d4pJYLp2jAVXTYKbOH/pqpXfhzVkiQmdMGQ0maBYJ8zkaBa3QlUW7NPezz32AQgSfiFJjp/QB19ncuhSIHycePCsGHWDvoY1jkW3YntC9aFwYa/B14Ygyx1IeSNpAoUnnIFlO9OTs1a6+hTuo/sHw6LgE5+PeL8rMKG9apPmkWvJMnBwzp8S/L2yISz03t3Ua3Y3PWNXToQt3bm4u3m9o0QGD+GX0jhLKAnvBmK0vnfLUH8SSu5P2paTaWIWFKoCqmpAPzPTPJ1kj2VCqfyEFZtnPcpgg3jMbrdZ+odER4HBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lyt1MnTW3b2iMe/Fs7NvufdPyZmecUcFeq15B7Jpw0=;
 b=mM2rByyP65XnGUwY3Rtx1h6QOBm34nUSfhKEbjpOYdGhfMZ6nOdUdefuphmL564nRnzcC62IitGDWctf4TfQlb8g4wderLT29BE06b5NGbk/LyylrqZwYvT066YryaZi6qEjgSVJ/TweZGuv/v8Stj6Y41wNbDG8eKHfI2AksfQkO9SDROvvApUY+vrJsmjqSOzZVoSFKadubv2/QQrDPaZUJrDw36BuVLdywpFHSzu8s3ge3pstisT5N+lsNZgixFYP0yMbIimVY8LFhLrDYuMzTs5r0JrEWfD0QIQmvMSb+pagvSOB1OZ/WebKr+sC8kpb/18G5Y0cTTBTvxVLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lyt1MnTW3b2iMe/Fs7NvufdPyZmecUcFeq15B7Jpw0=;
 b=bdfpsIPWz/jzHwbQBxvqW/EJen/fNpnzOmrc5Nj1x5IAooUtQStGKR/prJPxH4dV+01PzL4E+nVKeJmj8ljQwRgYmJO4nmFzwoSEAfvPR/7V4wwF1A4qmT4BRs9QLW+XUbYzIRdjs9DRQreH21QzcAoGSM+o9v0CFdKASKyGJDs=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5496.eurprd08.prod.outlook.com (2603:10a6:20b:de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 25 Jun
 2020 19:00:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 19:00:39 +0000
Subject: Re: [PATCH 03/46] qdev: Smooth error checking of qdev_realize() &
 friends
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-4-armbru@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <f75c7f3b-477f-f662-5239-87a14c996aa8@virtuozzo.com>
Date: Thu, 25 Jun 2020 22:00:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624164344.3778251-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0029.eurprd03.prod.outlook.com
 (2603:10a6:205:2::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.69) by
 AM4PR0302CA0029.eurprd03.prod.outlook.com (2603:10a6:205:2::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 19:00:38 +0000
X-Originating-IP: [185.215.60.69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d8334af-a6ab-4e38-c6a3-08d8193a0d40
X-MS-TrafficTypeDiagnostic: AM7PR08MB5496:
X-Microsoft-Antispam-PRVS: <AM7PR08MB54967D6EAA4DB7F37F96DD9BC1920@AM7PR08MB5496.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j8hFD9EM8itGlLBbk5qjDMOLYw2KYSdswy9+e2l+qEAMNJV6FxIgl6oTOk6bx1UjYNQUik7l4aCSyAavdhdAs3kjCImLfO/rwBPk5ZJlFVGH/NxaYN6S1wkZvKOxSJJLSbSkILpGszCA+yzi2eTzOUAfqjBjzvULu6CpTXg/pN5apdTFkt3VBFozPlCNY383uJNtGoTCBB7JyjVMTJy/3zX7Sd5ExdLAZcVUyOfJnK5Rk787zZ/w1aMx6EELxDoLNWX3SsIRv98jIkpNJy0vo3hIZ3rnZ4ImIPjc0mgKGuNOMCfN41PlOZoildEFlI5iBCNiaJNC7w2QZZAYzAn825gn+j1E8p57XZrcYIrGDVp5sYGbljOBbyyeB6QoYsWK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(396003)(346002)(376002)(366004)(16526019)(6486002)(8936002)(478600001)(316002)(83380400001)(8676002)(16576012)(36756003)(4326008)(2906002)(26005)(186003)(5660300002)(956004)(66946007)(66556008)(86362001)(31696002)(2616005)(31686004)(66476007)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 46bVyb81ufGp+nB0mh/01ZPcmSdthljt2bKm+eEwhUFpVQLj14HnBdE5/BrewNth9hEfwIX4crtfpY2FQ3QNafLpQadRM61Owwd04n0Q85gIyGXUIjkHjeRh1UdKC8eWhYFEpDoWayTsjHN491CwcGYcCuoDqmTVF2XJr/Rqs6es9eNh7yPtdeMEqfX3v0tFZuL3tfZj5Z0fhsXWg4RrJoGy7ZZlgqBOUOmnSZTEhrOgW6cXe2kLGWo6cj877RWtMswVbeAUQvGACpdHOaMVGEWkvvoByjANZjAC5JgER4vE4YwLTjqrkmHa5B5/1npyeFeG5vd+1Ie7jeUigEAgKzIcU6rl5tS+Sfn0Qgg5HwhkN7Gnht7EE2PE3I45L7BjIMiC7RUEtr7JLyZa7fllq/6zI6THR/0UnIfiREI26Il/IKUs8Q1QqShmaBu3+fx4QZkk6MS+Fl/2vpwSoML2w9gfDyP0TXXSyLh5939ge0M=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8334af-a6ab-4e38-c6a3-08d8193a0d40
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 19:00:39.5714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CILD6CsOK+OBE24cx8PtiEJ1C+IJ4/dOkI60Dy9FCqYECOnsA5dYHVAQX1ZW9MiinxduXQQxnyUC2QcEHMdFEpFnFfYYK1djW1z6haRAo9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5496
Received-SPF: pass client-ip=40.107.8.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:00:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

24.06.2020 19:43, Markus Armbruster wrote:
> Convert
> 
>      foo(..., &err);
>      if (err) {
>          ...
>      }
> 
> to
> 
>      if (!foo(..., &err)) {
>          ...
>      }
> 
> for qdev_realize(), qdev_realize_and_unref(), qbus_realize() and their
> wrappers isa_realize_and_unref(), pci_realize_and_unref(),
> sysbus_realize(), sysbus_realize_and_unref(), usb_realize_and_unref().
> Coccinelle script:

Please, also mention a command to run the script

> 
>      @@
>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      identifier errp;
>      @@
>      -      fun(args, &err, args2);
>      -      if (err) {
>      +      if (!fun(args, errp, args2)) {
> 	       ... when != err
>      -	   error_propagate(errp, err);
> 	       ...
> 	   }
> 
>      @@
>      identifier fun = {isa_realize_and_unref, pci_realize_and_unref, qbus_realize, qdev_realize, qdev_realize_and_unref, sysbus_realize, sysbus_realize_and_unref, usb_realize_and_unref};
>      expression list args, args2;
>      typedef Error;
>      Error *err;
>      @@
>      -      fun(args, &err, args2);
>      -      if (err) {
>      +      if (!fun(args, &err, args2)) {
> 	       ...
> 	   }
> 
> Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
> ARMSSE being used both as typedef and function-like macro there.
> Convert manually.
> 
> Eliminate error_propagate() that are now unnecessary.  Delete @err
> that are now unused.  Clean up whitespace.
> 
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> ---
>   hw/arm/allwinner-a10.c          |  21 ++-----
>   hw/arm/armsse.c                 | 104 ++++++++------------------------
>   hw/arm/armv7m.c                 |  12 +---
>   hw/arm/aspeed_ast2600.c         |  68 ++++++---------------
>   hw/arm/aspeed_soc.c             |  60 +++++-------------
>   hw/arm/bcm2835_peripherals.c    |  60 +++++-------------
>   hw/arm/bcm2836.c                |  12 +---
>   hw/arm/cubieboard.c             |   3 +-
>   hw/arm/digic.c                  |  12 +---
>   hw/arm/digic_boards.c           |   3 +-
>   hw/arm/fsl-imx25.c              |  44 ++++----------
>   hw/arm/fsl-imx31.c              |  32 +++-------
>   hw/arm/fsl-imx6.c               |  48 ++++-----------
>   hw/arm/msf2-soc.c               |  21 ++-----
>   hw/arm/nrf51_soc.c              |  24 ++------
>   hw/arm/stm32f205_soc.c          |  29 +++------
>   hw/arm/stm32f405_soc.c          |  32 +++-------
>   hw/arm/xlnx-zynqmp.c            |  61 +++++--------------
>   hw/block/fdc.c                  |   4 +-
>   hw/block/xen-block.c            |   3 +-
>   hw/char/serial-pci-multi.c      |   5 +-
>   hw/char/serial-pci.c            |   5 +-
>   hw/char/serial.c                |  10 +--
>   hw/core/cpu.c                   |   3 +-
>   hw/cpu/a15mpcore.c              |   5 +-
>   hw/cpu/a9mpcore.c               |  21 ++-----
>   hw/cpu/arm11mpcore.c            |  17 ++----
>   hw/cpu/realview_mpcore.c        |   9 +--
>   hw/display/virtio-gpu-pci.c     |   6 +-
>   hw/display/virtio-vga.c         |   5 +-
>   hw/intc/armv7m_nvic.c           |   9 +--
>   hw/intc/pnv_xive.c              |   8 +--
>   hw/intc/realview_gic.c          |   5 +-
>   hw/intc/spapr_xive.c            |   8 +--
>   hw/intc/xics.c                  |   5 +-
>   hw/intc/xive.c                  |   3 +-
>   hw/isa/piix4.c                  |   5 +-
>   hw/microblaze/xlnx-zynqmp-pmu.c |   9 +--
>   hw/mips/cps.c                   |  17 ++----
>   hw/misc/macio/cuda.c            |   5 +-
>   hw/misc/macio/macio.c           |  25 ++------
>   hw/misc/macio/pmu.c             |   5 +-
>   hw/pci-host/pnv_phb3.c          |  13 +---
>   hw/pci-host/pnv_phb4.c          |   5 +-
>   hw/pci-host/pnv_phb4_pec.c      |   5 +-
>   hw/ppc/e500.c                   |   5 +-
>   hw/ppc/pnv.c                    |  53 ++++------------
>   hw/ppc/pnv_core.c               |   4 +-
>   hw/ppc/pnv_psi.c                |   9 +--
>   hw/ppc/spapr_cpu_core.c         |   3 +-
>   hw/ppc/spapr_irq.c              |   5 +-
>   hw/riscv/opentitan.c            |   9 +--
>   hw/riscv/sifive_e.c             |   6 +-
>   hw/riscv/sifive_u.c             |   5 +-
>   hw/s390x/event-facility.c       |  13 ++--
>   hw/s390x/s390-pci-bus.c         |   3 +-
>   hw/s390x/sclp.c                 |   3 +-
>   hw/s390x/virtio-ccw-crypto.c    |   5 +-
>   hw/s390x/virtio-ccw-rng.c       |   5 +-
>   hw/scsi/scsi-bus.c              |   4 +-
>   hw/sd/aspeed_sdhci.c            |   4 +-
>   hw/sd/ssi-sd.c                  |   3 +-
>   hw/usb/bus.c                    |   3 +-
>   hw/virtio/virtio-rng-pci.c      |   5 +-
>   qdev-monitor.c                  |   3 +-
>  65 files changed, 248 insertions(+), 768 deletions(-)

Almost all of this diff-stat may be generated by more obvious script:

@rule1@
identifier fun = {qdev_realize, qdev_realize_and_unref, sysbus_realize};
expression list args;
typedef Error;
Error *err;
identifier errp;
@@

-      fun(args, &err);
-      if (err)
+      if (!fun(args, errp))
        {
-              error_propagate(errp, err);
            return;
        }

@depends on rule1@
identifier err;
@@

-    Error *err = NULL;
      ... when != err


===
Script started by command
spatch --sp-file x.cocci --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff --max-width 80 --use-gitgrep hw

You see, I consider only obvious case, where we have only error_propagate + return in the if. I suggest to make a separate generated patch, based on my cocci script (it's mostly yours, actually), and as a second patch - the remaining of your patch. I do think that this will simplify the review.

diffstat generated by my cocci script:
  50 files changed, 230 insertions(+), 725 deletions(-)

Difference with your patch, considering only files, touched by new script is very small:

[root@kvm error-smooth-my-try]# git diff --name-only | xargs git diff bbdd4596d3e3290 --
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 416adfcce0..cacfcbac54 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -185,6 +185,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
  {
      MachineState *ms = MACHINE(qdev_get_machine());
      const struct MemmapEntry *memmap = sifive_e_memmap;
+
      SiFiveESoCState *s = RISCV_E_SOC(dev);
      MemoryRegion *sys_mem = get_system_memory();
  
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 645b4080c5..32ff015c2c 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -442,13 +442,15 @@ static void init_event_facility(Object *obj)
  static void realize_event_facility(DeviceState *dev, Error **errp)
  {
      SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
+    Error *local_err = NULL;
  
-    if (!qdev_realize(DEVICE(&event_facility->quiesce),
-                      BUS(&event_facility->sbus), errp)) {
+    if (!qdev_realize(DEVICE(&event_facility->quiesce), BUS(&event_facility->sbus), errp)) {
          return;
      }
-    if (!qdev_realize(DEVICE(&event_facility->cpu_hotplug),
-                      BUS(&event_facility->sbus), errp)) {
+    qdev_realize(DEVICE(&event_facility->cpu_hotplug),
+                 BUS(&event_facility->sbus), &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
          qdev_unrealize(DEVICE(&event_facility->quiesce));
          return;
      }



- Hmm, strange, "--max-width 80" doesn't help. So, we may keep the patch fully-generated with only one over-80 line, or write in commit message that the only manual fix is one over-80 line wrapping in hw/s390x/event-facility.c


-- 
Best regards,
Vladimir

