Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4791C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0542065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdYAAzjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0542065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqv3-0008E1-MD
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsqtu-0006Os-KM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:56:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsqtt-0007Zj-3R
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:56:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id l63so20255966pge.12
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6B7I0qbm7CcrSVUR3SOXzS/15f+zxikt+RIgGrrt4fI=;
 b=ZdYAAzjsfXunv1zLsHhOdF2L1lbvfeCQtZ/5MPznD51kPdhnPXYXf7Cn17+kzvmogX
 KCjV55rE9MHAzZht0FhionIq6VkO2JzUFml+nb/mT6RPvyI6VnhIIlOzCFY4HeShpMPl
 LxQw3vT1WTgnrO551Vkt5g49D8PXIZ52QmmzUh3HqSWACZwPHrFuKN1N/eCniRgJazUL
 UphFMKjOMVdgqIoPp/faJLOVKKNKUHLBLNMdrAUS/mAT3MGoj+G885joo3RLpLYWpAUl
 HYx3xp9QKBmxu8HANsJrNL2mneqz8Qf1kwRrbNhTq+QO0LNoIh8BcCxuMOMJDmW6vJiZ
 K6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6B7I0qbm7CcrSVUR3SOXzS/15f+zxikt+RIgGrrt4fI=;
 b=Q7RjyEbUivQ1DLOyliCfj30xkg0Fx9SsZFwmuN3FnrO1JNCX4A89e3YN84mNNXi6OW
 Z0Wl00syn9ijG8thup1IP79tcp3P4dpQWpC4ph7lh1fPMM5jyM0Ip0zUFrKxtMxeULSR
 3E7ikQUXEmnxGm2TSpC5RVaxldgu+4DBCGXzHX6Ek+9QapUr/1bCRiLiJtlKExJOUqgJ
 G+sIiJOSpFvzDM4Q3PPiRJz3GfxV6F4V7zNs6tqlb7JMOYTR6q3MLsqRP0e5qTAGDYV6
 flPUkrX5IQWHAfXScXByQDDnHrbOegxwO3rjebHZr+oYHCTcFIPakvYlByjEesUpgLgV
 AKJQ==
X-Gm-Message-State: AOAM530X+PZ/dalMn25xFtMZRc4+Y8loaJLVE2AhIZEwLLvfUr4BYPOL
 iCJCfwta7jwQM8DGRxQnpmeIOOd8dAvoDkcHosA=
X-Google-Smtp-Source: ABdhPJxH+jEmcoj0oDrdVxzSvUinRQnAIEDuwjZLi4v2hw1BL71jU0hgZ8lZxwG0nQwMDRLmURGwcYWR9U5/Ubbk2aY=
X-Received: by 2002:a62:3645:: with SMTP id d66mr51588645pfa.275.1594141015688; 
 Tue, 07 Jul 2020 09:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <87pn97o93a.fsf@linaro.org>
In-Reply-To: <87pn97o93a.fsf@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 7 Jul 2020 09:56:44 -0700
Message-ID: <CAMo8BfLH2jVLjbdMMWCCuhmh+i40NyHQFK-=bAUw3sSoAxwPww@mail.gmail.com>
Subject: Re: [PATCH 00/21] target/xtensa: implement double precision FPU
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 7, 2020 at 4:31 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> I've only looked at the softfloat bits as I'm not familiar with xtensa

Thanks for taking a look!

> at all. However you can have a vague:
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> for the series - congratulations you pass your own tests ;-)

Unless you've built toolchains for the newly added cores and
run the tests on these cores it only means that new tests are
properly disabled for the cores without FPU/DFPU. I'll
take it as an independent build test (:

--
Thanks.
-- Max

