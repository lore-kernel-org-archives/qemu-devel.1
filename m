Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A842086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 16:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTxswDgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A842086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2zej-0006MJ-4i
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 12:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zbs-00033F-HF
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:16:16 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:37078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2zbq-00078O-KQ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 12:16:16 -0400
Received: by mail-ot1-x32c.google.com with SMTP id e11so6782176otk.4
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=w706G/FpohUDnXgtwAPE9htdkbTZIRUDZrlQXTOzK1c=;
 b=XTxswDgxdvnSlbLWurP3ncLTErrGMlEJe9ASVrdOEShAlcja6REUhxDpteLlTzqpC4
 6f0wABtSOYFZlmmjSDrUTI8jFoK/ecrMiAkxvS105i3XPkYAeihMkMEDxQXzfjWrp7QK
 pRtZDafY/Yhsg1uTK3uNNP/FZO2UW0iJ4rlO6IWstUNLVMguHQiWm4oaN9OSSUxVgvRH
 6S9icTJdJguuIzjmoMuua8wpjK8ZOI+x2MLtWrfz3Uc7OWtYSphmZfMfIJo6sJN+rfpk
 XJ+tDsjhxcvOj4/JG/P1drU1HtLef8ZM1aElfqiu8ZWjXV/YdMCvap16+PjqYES7/OIk
 evbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=w706G/FpohUDnXgtwAPE9htdkbTZIRUDZrlQXTOzK1c=;
 b=DyyitzEkGaiOI1XtP0mG7QZxEoSuRQXTpiKoij2VK7xzVeEJQta6dn7nsEEyXeIT3h
 3p8FOFDJbyBQ1Bj/blla/E0u4tivGn4PTWufAwqU9vSqbLi/+j9mE7MiyVBnlJ26Y4qd
 PyMUktEPiyyvVsXPDq/BoRmImVFiYsRU8Xe0iXXrxVwNibMTzzfKgqgBpSTbmBhZ8trY
 Y2nM5M4+efrLg4HBuCXJs4dAx+vquIh8eVQOEFoYgWWRY/FQO+H5oeMhTSnLtXMUQ3KH
 dOhRLn6FRoYmHx4AiBZ30K8DDuL1x2VH5v8CKbGIm2Nw05Z8kje+TTX17B2rxpzJWxLA
 ylQg==
X-Gm-Message-State: AOAM533XbrKt94WU5dwZixvArlZQBe3SNzVn0rRxx9WkurEmpMIHAaxp
 DCqo2ZC3KGPd1FvPAja0j0GjHg7sLfRdUzyD5SGyJlXP4vYCtw==
X-Google-Smtp-Source: ABdhPJykLqc60g29QdmhG3WCZf6SvcFyJMW60m0o/J96NlJ02S9Xn9DJhRoDwTxGlfHzcW22wVEaU2qVSKG3HZdJVSA=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr19053691otb.135.1596557772676; 
 Tue, 04 Aug 2020 09:16:12 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 17:16:01 +0100
Message-ID: <CAFEAcA_QCv_=fz6x+O9FcM1K5fRkES2mHSXH7vdEwVH4VL4+tA@mail.gmail.com>
Subject: last call for things that need fixing for 5.1
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32c.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If there's anything else that needs fixing for 5.1, please
make sure it's listed at:
https://wiki.qemu.org/Planning/5.1#Known_issues

I'm probably going to delay rc3 til tomorrow (MST has a fix he
wants to put in but needs more time to debug a problem with it),
but in an ideal world rc3 will be the last rc before the final
release and no more changes will go in after rc3.

thanks
-- PMM

