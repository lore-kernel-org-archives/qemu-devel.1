Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D04C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61B72074A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfmg5vFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61B72074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTlqN-0005r5-LD
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 09:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTloY-0005DG-AG
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:00:02 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:43981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTloW-0005C2-5q
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:00:01 -0400
Received: by mail-ej1-x62d.google.com with SMTP id md26so7360111ejb.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4lBbng1IHwfF2BPa07IUp2iROTa0iyh8aBwYMixlHF4=;
 b=qfmg5vFAO6k2q3GXM4qDLespb0vJ1okOlq/vWsCwR2Ca8pULRJ48SAuzVrASp5Ny62
 7zdUS6VtjzxP7gHhPOdolUidaFt5BllEgZ/B1CmELyser7H0PJVLfekntBUEQpa03Ca+
 c9dvkOUguwfHsBtz6bBTyhL6QLD0rnsy/7A1VKN2S9DuwR5d4a3v8v7swLGCgTDCJfUM
 2ang29/siR2KLbXgbfpOnPkP4SjqR1q+bCVAWubUfoYE5aZplOpnXYl1lQ2ehahDAl2u
 kllaL0w0g9OG1/4GgUEunhaIgRDHrRVGgoybsoSiV4Q4aDY8J2efnC7FqyvEUv7iT6id
 lpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4lBbng1IHwfF2BPa07IUp2iROTa0iyh8aBwYMixlHF4=;
 b=C0ooFyjMW4789toNsCeNWL6OwgooNVIYpu/jeKcqy67iTFOkhw2aUv4mT8Y9i9sXP0
 zSBYP9eVH4hc6dGf0FgNVuynl29Jn0p76qGk/xiEHOA8luSsCJH9ZTNLScsTD5nkjIkA
 FgkZ93XOluQsioIxIOV6jiMXQfv3llWMgMf2jb1X7gaGJEvxjePh1or96mn36M1/1ekR
 B+ZAO4Pj7EQ9aUG/9qMxglKAxgU5pKVXdSn4gYT6YL3g9LBtbsd8s4twgdONqpr4f0lc
 NQIRXCQZz8Hq1ch/05IRydAVgtPKpJrvWNfQBsxM1xDPYT8oxfkZFcOrOJ+xrb+qCqFm
 6zYw==
X-Gm-Message-State: AOAM530N4CHPM4QEWfasfEW5Sb0Rce84uWuuw2acobs0ivLE2ChHWEkG
 sdEJqzV8LRAeA4nPfTrWN2o+sv4NqLfe8mnMT6CIcg==
X-Google-Smtp-Source: ABdhPJyMdqgSkQf8b/H8XSP9RIIGkNHYlYJOln8UWcYmPYfj8mHTQNFjUiYkp67kgFfrOSRP97z2Yms+LdwyICAtucQ=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr8447704ejb.482.1602939597675; 
 Sat, 17 Oct 2020 05:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602771296.git.qemu_oss@crudebyte.com>
 <CAFEAcA_ygiXU=Lh1iOPUDOsXu-cuVze-wDhc90wZ+r7C-BBesA@mail.gmail.com>
 <5809478.Xo1ZfStJPt@silver>
In-Reply-To: <5809478.Xo1ZfStJPt@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 13:59:46 +0100
Message-ID: <CAFEAcA-zFFtwPQfHg14URpwzjYoJEZ=CrD73QAfzaUYhzogNgw@mail.gmail.com>
Subject: Re: [PULL 0/5] 9p queue 2020-10-15
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Oct 2020 at 12:55, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
> Oops, get_current_dir_name() is a GNU extension. I just enabled Cirrus-CI to
> prevent this from happening again. Sorry Peter.
>
> Am I supposed to rebase for v2 PRs?

Yeah, just rebase and resend, please.

thanks
-- PMM

