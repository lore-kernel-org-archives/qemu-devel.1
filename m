Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97715C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60577207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 17:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzNpA1yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60577207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlyby-0002JZ-IT
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 13:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlybC-0001aD-E2
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:45:14 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:34692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlybA-0000Oe-Im
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 13:45:14 -0400
Received: by mail-oo1-xc43.google.com with SMTP id v3so1349320oot.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2qmwHswApVSYrMfm287st1BzO5wGu9YBA4IZqnJpVZI=;
 b=GzNpA1ywjj5iIWvKUlHtqaglO7uu+YcsmVlipzpwO56t9su+AB1uFtH85mapw5rrth
 V33qp875P7Sssz95xCivpFuOJG7l/Llaqu9HDkoOjwEmhvQalNhkieoi/iW+ZYro1joX
 vj1NtOaHD7EYLeWOBfS2xhfMoI2JviiwnCZDnZ30s6ArwPKI7Ye+VjKiQhzepqCO1vbO
 9Sh+NJLRYZyqmi28YsDQk75raPK9n+CUIjciweCE6wJq6ZPnwbIsui3aV6vLYvKzYLbr
 nJyKV3SovYeqxJqNrQ5DYJ3xzg/beo3FUp3jfSe7Q3UPtnXO9pmuJL7gHFRrM0HC0/Gv
 30Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2qmwHswApVSYrMfm287st1BzO5wGu9YBA4IZqnJpVZI=;
 b=AEjyJbb+9z+XSFOVcMxhwAGw+pErz7m4VMzQeEcG5t6NcI08DOrLC98/JJIkAoFwXQ
 VAXDdDDT70pNNcha47tbPKOdcwtkzC7ao6rpBxKHMudns9lcMLzg11bxUQFmFUpaIihg
 xUJHtISMbMOW0rFPCLCCyE2IxvO8KcxbwIAjK5YtOjKhMhIEh+OX+xOJ+NfAbVaNyXSm
 lYDkDpW4z1hSfAb5nevZMMjoDhVEzZZoMX6BOV4x2SU1obdJh/zuQM12/XHcI7SKacjg
 gDTWrGNCVd5E5sdn4YtmHNAFNjjVkczDia2TMEBzntWjwUh/evUN2WxYpaVVyZ+RVpGf
 4sIA==
X-Gm-Message-State: AOAM5306tZc8uN+VY5X2c60kiQ3E/hFk7hgS+neG2Fdh9KpA53fGj/NT
 L8ihckc0UfdzIu0rA8dz5dBYB67crY4ryriMeUtnkA==
X-Google-Smtp-Source: ABdhPJwFtNhjRxK8/11Q23ml0ex8eHRaFXjrhLg0NQbDgJMQzMxM1VNF93Y3db+M2PI8Qgu1Pxr3dQOqXF/96tvmkHM=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr5149530ooi.85.1592502311500; 
 Thu, 18 Jun 2020 10:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-14-richard.henderson@linaro.org>
 <CAFEAcA86dH_utZzXdbvwhB_67OgVGc249tO6TOBtfw+nWi2-7g@mail.gmail.com>
 <bc120bc8-a08a-3b8e-cc31-e7c09e06a3a0@linaro.org>
In-Reply-To: <bc120bc8-a08a-3b8e-cc31-e7c09e06a3a0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 18:45:00 +0100
Message-ID: <CAFEAcA-v7uTL=j_78gkESbTiV8Q2JgRBoVz4spNekSyvSC0fUw@mail.gmail.com>
Subject: Re: [PATCH v7 13/42] target/arm: Define arm_cpu_do_unaligned_access
 for user-only
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 18:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
> First, this could definitely be delayed to the follow-on linux-user patch set.
>
> Second, in the linux-user patch set, I decode the syndrome data to determine
> what kind of segv to deliver for MTE synchronous faults.  It would be easy to
> extend that just a little to notice the usual syndrome for unaligned accesses.
>  Which may be less confusing than abusing the v7m exception code?

Yeah, if we're going to look at syndrome data anyway that might
be clearer.

The other thing that really it would be nice if we were able
to feed through (via syndrome info or otherwise) is the difference
between SIGSEGV with si_code == SEGV_ACCERR vs SEGV_MAPERR.
At the moment handle_cpu_signal() knows the difference, but it
doesn't have a way to pass this through to tlb_fill, and then
cpu_loop() has to make up a si_code when it gets the EXCP_DATA_ABORT.
I mention this mostly in case it affects how you want to design
how you treat alignment and MTE faults -- it might be that the
si_code stuff is better dealt with entirely differently.

thanks
-- PMM

