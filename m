Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7517CC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FF7206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 13:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhTVGuzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FF7206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnt9-0001mk-Aa
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 09:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLnrP-0000G1-JR
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLnrO-0007I1-DT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:01:47 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLnrO-0007Fi-9M
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 09:01:46 -0400
Received: by mail-oi1-x232.google.com with SMTP id k18so1392303oib.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 06:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=93HaVial36xURZcqfHJKRWMt3ZEbi9Du7Ozf3NJtiM0=;
 b=QhTVGuzJEwQPFQ4AHz3usFfAgKMFe1IWtBn34c88iOuxyHKVToOzmnHv1Ru2rY5vql
 Pyc5dGShaBJCCbpEhNuT64IvQ+LLvf80U0BAlq33RFWNbeGHJ0q7wUK7QG+73Uy2GhAk
 6AB4+SxeTlMBl+gRtz0y8M504901TyFR12+Ddde7wZ3lrG8td5p+qzY1QGHymzsqAhCi
 QiKlEXQPnasloGb1JTGYbMUpd9RDy+Y9AhTO7fyjXjp2HZm+XZS12Ds2CXBwAAXwu/VH
 47w/6CuCNjqNhybql4mjDY38+jpvqCFin4AEbq8o3p5cotb34sxV5ScpgH0fKnowwqQF
 DHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=93HaVial36xURZcqfHJKRWMt3ZEbi9Du7Ozf3NJtiM0=;
 b=XfJRHVyseGfbQJ13pKPlixHE2SoTme6wdTNxUl51hMlZhuHFAwB7eBNSCUSjxCN38X
 YDCNB4W72/sq57OLO7a2xpED/e4G30rhgFih1wkezDqOpV13Z7zh1mgZA13urerpN44T
 PAaZ1zntKCiFxtt+PULs//fyGX7apcZDjxgQ1MRvAAfV9A1jl8/7Z+nI2EuE32umq9+g
 2NpjEln4IKUZt/ItKB8ShvElCaUvjrXRiphjgpDHD0ixs7tomwLz8SgWkz0jyBsFfIcF
 v9L67FJ7DC4nR1M7pHwvf+/X29LtSpw5qvWhHEloLuXPxR8IQRjLzFlIw8nobBzeduEN
 8f7w==
X-Gm-Message-State: AGi0PuaDjVECPNWK3dY0O27QbB4MNlyOnkoaNwLwaL8VudJLSP5lLzmu
 5ChV2X5VBFSYKDfsxNxAYX5bWmCsIfikEDTpq4daCnah4S4=
X-Google-Smtp-Source: APiQypJdLoC371shAjcJHQ2qFkHaT74qRMn6DCkhkbSYm71wpPKaYtRHw/PjDLIP6i6Mq0W0z2fJBogbODzf+0me36o=
X-Received: by 2002:aca:3049:: with SMTP id w70mr1488037oiw.146.1586264504479; 
 Tue, 07 Apr 2020 06:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200407043606.291546-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200407043606.291546-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 14:01:33 +0100
Message-ID: <CAFEAcA9pe5hG4N6Sb8CzEe=vskAxxNJctMkt8z5aV_e207HWbQ@mail.gmail.com>
Subject: Re: [PULL 00/10] ppc-for-5.0 queue 20200407
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 05:36, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c250:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200406' into staging (2020-04-06 12:36:45 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200407
>
> for you to fetch changes up to 25f3170b06544e4de620336da5b2ea3b392d66bc:
>
>   ppc/pnv: Create BMC devices only when defaults are enabled (2020-04-07 08:55:11 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-04-07
>
> An assortment of fixes for qemu-5.0, including a number for the FWNMI
> feature which is new this release.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

