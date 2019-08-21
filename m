Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7CFC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8DC22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTUaTCDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8DC22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48943 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RTt-0001jX-Uw
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i0RRj-00006h-R3
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i0RRi-0004pZ-Aw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:18:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45115)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i0RRi-0004cb-3h
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:18:42 -0400
Received: by mail-oi1-x243.google.com with SMTP id v12so1660133oic.12
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OJbNdUxCuT5NMN4TyslQ2/VvJJ1wrfde63ShPS2uIVM=;
 b=OTUaTCDMMz3nhosT279ruREWAimVzGhjislV4pWuM6ZFsFx7oy1ZblsMJiApnLYFJO
 Dbc2B8uPUDabi4sABXiWVi1V8P299ZCAby5tvOaLcCCwECOjaeF6oKOJ/ExoHrIJJBXK
 Lrt+yVUqgi8vYFIFpoTpDFVpF2CGDEagHMRrR5bf5M4zyyK1hyIBIFZCs6qFuqWpL1eS
 yh37DOiTgWh+nY2h/Ibh+GN5rdqDqpHtsGlNnWx2486fZOfnwz6jwwGg2yq7rkyBJSfp
 5j5uPxoCUyUaTFh3A8OOZ8AIxn33KpQVi1skm2Kym9gxpb3BcSrtl0xQSGTMRpa5Tk54
 9K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OJbNdUxCuT5NMN4TyslQ2/VvJJ1wrfde63ShPS2uIVM=;
 b=Cg4TNtVhs/WuOpL8XM+TWrddlxZsfL4PIKSThCkXGhrsgtzu3gGF4gPgJ73WkuZogP
 gcUNrjeXnQcXv+J61t1yGUB+8wIbqsTNL6nWIrn3yDV9Qz1zG8EZbzKfOhOBbbgg5K2p
 3r+hgmch1NBdLmy3VcpFViVQ/bdYA9wzhRXcrgCdqxhSaomeVSir7dGFL1mV+ti6S4n6
 6AXO7vOmt+MtA9BH2aUs9HS8o+kIU57CuuCqh7fy0USqistmi3OCb/6kQIlETVZAPyoT
 CVXQzu5MRoShtxDTQ7mel4RPqaZK/hFmxsuUylOwQ8bOsZZAilgeRvuExq24QAVyyaIH
 Vaug==
X-Gm-Message-State: APjAAAWP9Vio1Fs4PKO8c8Z/JQZAtV+SyB/BH48g21+Q8dnsNlmL2Ew0
 EmVxdyXOj8phMaihNCRwLdIgaE2ldH658PefF8Yhug==
X-Google-Smtp-Source: APXvYqwg3xV7hh6nE8uIkXIcPFZofrPECMQ3ZHrz8j6ZRJSwPiNWyhHbYbxs3DcsJHl5WbBS84D0RcoVMTtakIRKpjw=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr182282oib.48.1566397108071; 
 Wed, 21 Aug 2019 07:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190821072542.23090-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190821072542.23090-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Aug 2019 15:18:16 +0100
Message-ID: <CAFEAcA8ACHfwLX18T=8YZXfgRNx4W8emei3_3-Pa1ZbyBig3eg@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 00/42] ppc-for-4.2 queue 20190821
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Aug 2019 at 08:25, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20190821
>
> for you to fetch changes up to c0e6616b6685ffdb4c5e091bc152e46e14703dd1:
>
>   ppc: Fix emulated single to double denormalized conversions (2019-08-21 17:17:39 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue for 2019-08-21
>
> First ppc and spapr pull request for qemu-4.2.  Includes:
>    * Some TCG emulation fixes and performance improvements
>    * Support for the mffsl instruction in TCG
>    * Added missing DPDES SPR
>    * Some enhancements to the emulation of the XIVE interrupt
>      controller
>    * Cleanups to spapr MSI management
>    * Some new suspend/resume infrastructure and a draft suspend
>      implementation for spapr
>    * New spapr hypercall for TPM communication (will be needed for
>      secure guests under an Ultravisor)
>    * Fix several memory leaks
>
> And a few other assorted fixes.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

