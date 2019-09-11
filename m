Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E07C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA53206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="OyLJimhM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EoGjEkMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA53206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83HG-0006rm-FU
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1i83GU-0006QD-Aj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1i83GP-0002KH-Ee
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:06:34 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1i83GP-0002Jh-2t
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:06:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 503FF22465
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 10:06:27 -0400 (EDT)
Received: from imap26 ([10.202.2.76])
 by compute7.internal (MEProxy); Wed, 11 Sep 2019 10:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :subject:content-type; s=fm2; bh=4QKbP+09nKZR2u7hCBAACXsSE8Iby1v
 O9DtA0ITK+k0=; b=OyLJimhMoJ1dDLwoGroqivzByU9/GHI+f3p1Jyq0oFiUP+U
 vtGVDA7Kdc8egngaIunopUS0+deaMpOmE8r9qEo+LIel8VqJHFycXc29f6Pp2UV0
 GTIBanrBWc5WeriqLVHBakGMlXlxvKXzPb0ZzJi/xKLrjozEQCnZFcsDe6RrO0pP
 +VWlVoPZnnThH9E+3DSPij3L8riW8YZgV9kO7Qiy2QYz4rn2U38h2jK8sylU+JV9
 UJ0ujAITSwTbRKmbCBxiwF+grUJQd6QPU0gOp7ASNn/hwSZtDDMcicD1IZtxM2ad
 /UVS3bC+fvNtPl0TArs+w4QLFO4lNWq/TMYA3VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4QKbP+
 09nKZR2u7hCBAACXsSE8Iby1vO9DtA0ITK+k0=; b=EoGjEkMizHlQidkXOePPws
 983bJryrqGl4wjPt6gnEENFlBao3yXvmlkqTLvp1wrZuvBb5Yv25PpOKb7TDSP1G
 8rJhe1sr/qL1x3yHxtv3DyxzoBKHl6ub3gzVUtvpi35f1+dZbyHzFn7+EjjgZFTU
 oDzrV3jlRHJr1QXMNuSFh2WS+/5GbtpKJR/WbBSfZL0n9cJuSePsfz3/CW0klELN
 hxDfcfsnAJJtBPc7YNosWf5jfMWx0frIFi2c4VBZ1luDe50pUHeuSP8tAILpHBIg
 /pG7FyPJxDECRijS4YseFlp/R/WjFCvQUf8xP1Djf2XWFkDC7RnswxAX+9SFvntg
 ==
X-ME-Sender: <xms:Yv94XU8wMWlpf6c3yzvDynGfUbXlPNDbkjJ5ikLJsq17Uio7dba54w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdeghecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvffutgesthdtre
 dtreerjeenucfhrhhomheptehlihhsthgrihhruceorghlihhsthgrihhrsegrlhhishht
 rghirhdvfedrmhgvqeenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrse
 grlhhishhtrghirhdvfedrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Yv94XZlgSo12hujj3FWN_UR7LxsBNUhzF9Q8Tn2Gzf9S8ntSc6qwzw>
 <xmx:Yv94XZxMDcRvvSYtodLuxSZw4e64wN7gugrAiop0i50gUgRVXK5uQQ>
 <xmx:Yv94XT72zdWTagLFozPRE4zsvqM02EdhqdzECqZ6a_bfFXWu6eNPtA>
 <xmx:Y_94XbvV92kjuf8oA6qHoeJW14rIioEbnDannOU9AgT5i_7MHEp8kg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D21A314200A1; Wed, 11 Sep 2019 10:06:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-227-g18586b54-fmstable-20190911v1
Mime-Version: 1.0
Message-Id: <acd9fbba-71af-47b1-911c-f8b88e806cac@www.fastmail.com>
In-Reply-To: <CAFEAcA8gLzitZ8OKU+Ht79fsU1BOguxEu9FvafD0vjR9cJKx7A@mail.gmail.com>
References: <cover.1567750222.git.alistair@alistair23.me>
 <CAFEAcA8gLzitZ8OKU+Ht79fsU1BOguxEu9FvafD0vjR9cJKx7A@mail.gmail.com>
Date: Wed, 11 Sep 2019 15:05:29 +0100
From: Alistair <alistair@alistair23.me>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.26
Subject: Re: [Qemu-devel] 
 =?utf-8?q?=5BPATCH_v4_0/6=5D_Add_the_STM32F405_and_?=
 =?utf-8?q?Netduino_Plus_2_machine?=
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 11, 2019, at 11:49 AM, Peter Maydell wrote:
> On Fri, 6 Sep 2019 at 07:10, Alistair Francis <alistair@alistair23.me> wrote:
> >
> >
> > Now that the Arm-M4 CPU has been added to QEMU we can add the Netduino
> > Plus 2 machine. This is very similar to the STM32F205 and Netduino 2 SoC
> > and machine.
> >
> > v4:
> > - Rebase on master
> > v3:
> > - Remove custom reset handler
> > - Add init-entry and init-sp properties
> > - Rebase on master (including Kconfig changes)
> > v2:
> > - Reorder patchset
> > - Return the kernel entry point instead of using a pointer
> > - Address Peter's comments
> >
> >
> > Alistair Francis (6):
> > armv7m: Allow entry information to be returned
> > target/arm: Allow setting M mode entry and sp
> > hw/misc: Add the STM32F4xx Sysconfig device
> > hw/misc: Add the STM32F4xx EXTI device
> > hw/arm: Add the STM32F4xx SoC
> > hw/arm: Add the Netduino Plus 2
> 
> What are the changes for setting initial SP and PC for?

If it's not set the the guest code jumps into some broken address and crashes at boot.

> Why is this SoC special? Is it different from the
> stm32f205 SoC we model already?

From memory the STM32F205 might have the same issue. It just wasn't a big problem as my STM32F2xx tests were targeting QEMU while the STM32F4xx isn't.

> 
> I'm not in general a fan of individual board models having
> their own custom behaviour for -kernel. The inconsistencies
> between architectures and between A- and M- profile are
> awkward enough as it is...

I do see it as a pain as well, but I'm not sure what else to do to fix it.

Alistair

> 
> thanks
> -- PMM
> 
> 

