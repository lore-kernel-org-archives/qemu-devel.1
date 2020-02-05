Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C1FC35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 08:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69B12082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfgnmqcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69B12082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izFjL-0007hD-1M
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 03:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1izFiR-000773-Ld
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 03:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1izFiQ-0005LE-Kd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 03:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1izFiO-0004k4-3P; Wed, 05 Feb 2020 03:07:16 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 34BB32082E;
 Wed,  5 Feb 2020 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580890031;
 bh=/PmRNbSIFey1F65Cjr0+6NLe5UDtJZ3iR0/Zifk5+IE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=HfgnmqcIicTGt0hrULA7Hl21ViHA6c5PYsOR7Bpb+GeqEfCyN3/BSz8xDhGGhxgLF
 uTb7owhlPTolrsB/J5SRxlkeOOIRpgG7rBd6pK012Z3VrPKvcILLiM6irM94WJXY8g
 VA0TlD4pr64aDgh4pcWLDakGrLa2YgPDO6D5drzw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78]
 helo=why) by disco-boy.misterjones.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1izFiH-0035yj-He; Wed, 05 Feb 2020 08:07:09 +0000
Date: Wed, 5 Feb 2020 08:07:08 +0000
From: Marc Zyngier <maz@kernel.org>
To: Gavin Shan <gshan@redhat.com>
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
Message-ID: <20200205080708.7ecf194f@why>
In-Reply-To: <8a286e1c-c3f3-3052-e497-d44a90667451@redhat.com>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <7f6e29e6-1df9-4513-79ba-b53873b0735e@ozlabs.ru>
 <544f261e4b9c97f1d3a5fb64cef42ba5@kernel.org>
 <ff584722-1b51-e538-7c45-c71cdc40105f@redhat.com>
 <c61c95c434dbcf97a0c946f0993d4843@kernel.org>
 <8a286e1c-c3f3-3052-e497-d44a90667451@redhat.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: gshan@redhat.com, aik@ozlabs.ru, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, drjones@redhat.com,
 eric.auger@redhat.com, jthierry@redhat.com, shan.gavin@gmail.com,
 qemu-devel@nongnu.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 14:51:39 +1100
Gavin Shan <gshan@redhat.com> wrote:

[...]

> The mechanism I figured out is to inject SError to guest, as below snippet shows. It
> helps to get a panic and guest rebooting, which looks similar to what x86/p
> pc have.

I think being able to inject a SError is a reasonable thing to have for
QEMU. After all, the RAS spec[1] says that "An SError interrupt can also
be generated for IMPLEMENTATION DEFINED causes."

What I'm more concerned about is how this is going to coexist with the
RAS extension itself (which is mandated with ARMv8.2), and whether we
should classify this with a particular syndrome (by populating the ESR
field in the event injection structure), if only to be able to
distinguish the SW-injected SError from a RAS error propagated by KVM.

It looks to me that this SError could be described as a "Recoverable
Error", but I'd like someone who knows more about the RAS extension to
comment on this.

Thanks,

	M.

[1] https://static.docs.arm.com/ddi0587/cb/2019_07_05_DD_0587_C_b.pdf
-- 
Jazz is not dead. It just smells funny...

