Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFCFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A641220724
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joLg1qC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A641220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8lHL-0005YH-WB
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8lGm-00054K-Ir
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:10:20 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:44564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8lGk-0007Hi-N6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:10:20 -0400
Received: by mail-ej1-x629.google.com with SMTP id bo3so2641725ejb.11
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tAzXOUi1P29gbo4U58nf63CBOG/fcZ5R6/9x0MagTms=;
 b=joLg1qC6OUK/xbsvv7r3OQ0sSBihgnsvNoFkPSoijyEbaQ/Bn5C/xY5NwtiyH26tk9
 nylwoEXKsx+Qk6OHx7IBufte28kwsYRN4hw+PTE3v4rcOhAnGSUG2ya+jf+HHL6eVCN6
 MJVcLkxDCmM6H9fBlydDk2JjUW6+rgd+y6V+9tSfPtlaB7XoSiJzCCJD1DUzjPKcatFm
 CpugE71y1U98+Xd2vpmsoWJfnbJfAoZxVlgCiW4crHgXWSU1HiLwy0IoUJpykv3cbARF
 m6FkiYvi1j3RRmYBBvSXMLxQfyjixfi/kbAfmDDChAgWb92YutuJW/6gb/cTm40aqudx
 o+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tAzXOUi1P29gbo4U58nf63CBOG/fcZ5R6/9x0MagTms=;
 b=JVbEIKu+hEd9gHlAUQx4L3BQz3Dd/lHZFOnE1RVcczVQUYC49yA2c4eWg88IfOTAdm
 OgSo9CFUFmdvlBw4kiMW6iZSPc+Rub18RFyxeBtK3KZYivO9aq5Qb/V2hwnSHxcG4r36
 th78ZuaJODKe0ag67oS0tAMkjGnAdKwi1TtpLQ9zcW8bSJn2OBaNGWk5MQHcsiapgOzV
 QT5vMWxHH6n8VtnfLALjS+6BqkMGeKWc8CuC6Bun+/xhA6ccm8WFGW4Au6xAz3hSbKEx
 84ClTPRF0kXbeqg7AxrqRyXRDGL+NYqFDBlhXSvPscInB7GGpHtkPThBhtJisTc9u2PD
 JRyA==
X-Gm-Message-State: AOAM533scQGFEsOCTgfal9wQjpyYlqmJF+umF2NvbmCow+ZcceKj4p/+
 jWbfXblTB4AHzyNvapseeX6qU/O+Q/k161FKxZRFHw==
X-Google-Smtp-Source: ABdhPJzK/KhovFFDNmLRrFft+sFKpK/23FxSVS6RlQ6TIirFX9ajriAkhA2w7Zjq/5G0ls7SW4UEubTXLcPGO18Jv/E=
X-Received: by 2002:a17:906:7fc9:: with SMTP id
 r9mr3336029ejs.407.1597932616793; 
 Thu, 20 Aug 2020 07:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
 <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
 <20200820133023.GD99531@linux.fritz.box>
In-Reply-To: <20200820133023.GD99531@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 15:10:04 +0100
Message-ID: <CAFEAcA_fCDAk4J=4BEzsNm8ZF9pbWwzbt5F3wxUE_g+_0as24g@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 14:30, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 20.08.2020 um 13:56 hat Paolo Bonzini geschrieben:
> > The Meson conversion was announced in October 2019 as breaking in-tree
> > builds, and the deprecation request is from March 2020.  So I don't
> > think this is a breakage but rather a widely-announced change.
>
> Wasn't the decision after that discussion that we do _not_ want to
> deprecate './configure; make' from the source directory?
>
> I seem to remember that we wanted to merge a message to make a
> recommendation for out-of-tree builds, but looking at configure, I can't
> find even that.

We opted not to do that or to mark out-of-tree builds as deprecated
in the release notes, because the outcome of the discussion was
that we wanted to retain the support for 'run configure and make
from the source tree'.

thanks
-- PMM

