Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D88CC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B532220C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wjmhxHSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B532220C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLVnQ-0004gT-C4
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLVlv-0003uk-El
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:15:12 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLVlt-0005XE-Ds
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:15:10 -0400
Received: by mail-ed1-x541.google.com with SMTP id n22so4326604edt.4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0z8Eou6QX4f2BbwIvU8sbDpxDKN42JHkQaKSy2DRb7w=;
 b=wjmhxHSIJV19STGpcuNH+mYx4auzzgCvkYTykqXmpq7VUqmEylA66z9pa7lhFtEhvT
 btD22L51Tr4nPAcStuF4DJ/S6XJifAdE1Lg/wn57rWIfKkArsChdxj5iuSQRrCnuD23N
 XQ1Dsfr7vPxyzFFhff6IPm1RaGDNXO0kjDwVAIYJmPj9v9wvDeAzGI8h+7/7HDf0dRHm
 HIPf2ZBT+G/AskxVfco6u68sQGeiygsYo3YyFjRluu6LOzLBl/a8+zjGyDWIDw9gkqO7
 g8PkLj9xPfE8UTr8qCm2K9uVGBANQTTBqewry0YwgzuZdf1zcmJdzGERf0spa1lHqQXQ
 LQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0z8Eou6QX4f2BbwIvU8sbDpxDKN42JHkQaKSy2DRb7w=;
 b=KgxfeL9+/fhKzdmeeSGmJVPWI/oG+nuXxrR6bX52t0JOVdxuCUGzBieEyUufzKJ4Iy
 zx4Y6jqFMGpunF+mxvXAX5ifWLLv12cnoj3uLnhCJG6cSdFpj/BMP55dYwcmbIec3n/L
 MBhavwqs55E+ZQ3/rqMySjbXsicffrDNEdTkbOjvwswp2RdDPrOQm1AqAxNV4RLd6xvC
 v/V7cbviWSXw8G1o8jxHLuPmsbW0pMut5IURILahhJj7BHdJwCc924pd2BpO1c0tVcdz
 nO+yPynjmR2mD6nOygedrzYW5skctoA+uRYqtfVtdAs9zXnMIwyeJQ8q8ZuFH1JbyLpQ
 bKiA==
X-Gm-Message-State: AOAM530v3x+wzgOW3jZeah7pi4XzBaClVc4UcJYd/05yWQySiUzmCnCt
 5BlCXxC2VQkPphwXnrIgHCdig5AyhH5fLly9dyRQLg==
X-Google-Smtp-Source: ABdhPJx8q+VFMpt/0m5ntZECINRzls8waIKvdkPgPmx2KL2dXYWRCFLDkYduNo5n+qP6b2u2ArK2hPzcWGTMQEf1Ax4=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr97820edb.36.1600971307231; 
 Thu, 24 Sep 2020 11:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-15-peter.maydell@linaro.org>
 <87y2lp64th.fsf@dusky.pond.sub.org>
In-Reply-To: <87y2lp64th.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 19:14:56 +0100
Message-ID: <CAFEAcA-UxY_PZU8woAzHmoHBh6BU+z9y6n4Z=UqQb=x4D1Befw@mail.gmail.com>
Subject: Re: [PATCH v5 14/20] scripts/qapi: Remove texinfo generation support
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 14:37, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > -.PHONY: check-tests/qapi-schema/doc-good.texi
> > -check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
> > -     @diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<

> We shouldn't just delete this test.
>
> It is for checking the doc generator does what it should for "good"
> input.  "Bad" input is coverd by the other doc-*.json.
>
> With the old doc generation system, the testing "good" input is
> straightforward: generate Texinfo, diff to expected Texinfo, which is
> committed to git.
>
> This test has been invaliable when maintaining and extending doc.py.
>
> With the new system, there is no ouput suitable for diffing, as the
> various outputs all depend on the version of Sphinx.
>
> Or is there?  Is there a way to have Sphinx "unparse" its internal
> representation of the input?

There is no built-in "unparse the internal representation" option.
We could add one as a Sphinx extension (basically defining a new
output format that was "print what you get"). This too is at
least potentially liable to breakage with future versions, both
if the Sphinx APIs for output-format extensions and change and
if core Sphinx gets changes that mean input rST is parsed into
a different-but-equivalent internal-tree-of-nodes representation.

The HTML output definitely depends on the Sphinx version.
The Texinfo output doesn't differ much, but it does differ in
a couple of places (firstly it has the Sphinx version number
baked into, and secondly what looks like a null-effect change
in ordoring of @anchor{} nodes).
The plain-text output is identical between Sphinx 1.6 and 3.0.
(I think this is mostly because nobody really cares about it
as an output generator, so it hasn't had any changes made to
it other than general whole-tree cleanup type stuff...)

So we could go for a simple comparison of the plaintext, and
hope future Sphinx versions don't break it. (If they did we'd
need to put together something like the iotests handling of
"these parts need to match and these might be anything" in
the golden-reference).

thanks
-- PMM

