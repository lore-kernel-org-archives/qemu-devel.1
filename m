Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F8C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3035520720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mv5IZ0Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3035520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5F9-00011A-CD
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5E6-0008Tr-ES
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:59:58 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5E4-0005yt-E3
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:59:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id m33so7057980otc.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lvlRkImLD1pM0alB1uagHUGC/3kVagGNl9hh9GL2TwI=;
 b=Mv5IZ0CzkPmaxlQKc4AXRymp5dGGg1Fm9Zt7O0qy337nID//LWpz7QqjZwoVIpfx/s
 zyMJSMEqLXOhbjOvQhWfghKErNkZgZiiaARlMsBcPujAakAOuxNDb4LdgwxnF6Ha+cjp
 75S2UEc0khvIBYwj7lfeLpzY3YyKV/s6MvQTVRZCrzyke3sZxSkI0hJfCb9C4Wy2lTxL
 4J6vg2BSH+VxHeYjhAYuX09Ykjkhl4pjQoSLvVojrf2tM1esOfoRBhnnRoQhZ57Cng1Y
 8fWPPbqviYSjHfN3s0mv2KtDgQ4SNO35VqgcD7gn8swO5nzs6PCbbvXH6bOmllOwTJ8C
 xu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lvlRkImLD1pM0alB1uagHUGC/3kVagGNl9hh9GL2TwI=;
 b=qx5nL4LaXJtPeJxH5RnyUf7GYAXiL5EmvQ5tmDUulP/3aTptMv/VuwCUux95XFYEda
 tAEO9NCAKSNwDxLNzTCn6vnSpnI9D2iA2g0ukx2EaCAawqVYaP3pb9IgyovF5Y3nKPYT
 q6GThCfFOOAwEDKMo3AbpAwG0H9WV6+0TaZOYxRIhh8rGAzbFXM97Uru5NdGIK2Jd4sP
 LeVuE7B+RsDJJ7dP8Yn10GS/Dsx+HcokQo7rfpZBHc7LMEPsIP5sUbYXUO3icESE+J1n
 D0C44XWhr7ZAT6HgQcw9esjtQu0st8X0qCd5XYNPJdIeZrn/x/A3bzLI7NJcMoCFjORl
 daCg==
X-Gm-Message-State: AGi0Pua4UKH6oiTcaT2ePwLZ2br7lkueWtKrZWO/JbnVocSw1QKCUgNz
 wmgJcfxCoUGtNyHDV4ozKbZvRhBi9ZEEBllRo0nPSg==
X-Google-Smtp-Source: APiQypL/3AQL9SOsLGgtd3FQvVghBdSWqFHnq3CnC2o0u+UdieB/14O1/WSjitLGKVpmjRg/+Hwy2OyFeYMmTHm07lU=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr11792173otj.91.1589191195077; 
 Mon, 11 May 2020 02:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141729.31930-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200505141729.31930-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 10:59:44 +0100
Message-ID: <CAFEAcA8N-H0yWjNv6gosYw=tpWeMRSwPhxGmAA8sgn7f48dT9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] target/arm: Remove access_el3_aa32ns_aa64any()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 at 15:17, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Hi,
>
> Laurent reported hitting the assert in access_el3_aa32ns()
> when accessing 32-bit versions of some of the virtualization
> regs when EL3 is 64-bit.
>
> I think we got this wrong back then and it seems to me like
> we should merge access_el3_aa32ns and access_el3_aa32ns_aa64_any()
> and always call the merged function to handle both aa32-only cases
> and mixed aa32/aa64.



Applied to target-arm.next, thanks.

-- PMM

