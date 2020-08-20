Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50299C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:34:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F0420658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sx8kurAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F0420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8htp-0000Jx-Bz
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8hss-0007o3-04
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:33:26 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:38297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8hsq-00044I-Be
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 06:33:25 -0400
Received: by mail-ej1-x635.google.com with SMTP id d6so1897037ejr.5
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pPC8X1NXg3RscXngfc7zMky2e+rfbjyk67d2V95UmQo=;
 b=Sx8kurAPVUL9VACAdkKqMTPEKQFty23FM+5jqvclSfu5CVbCw1Sjpf5bEySMUDAAzF
 9lxDk2cMgdfyuBnvnjP+b+bYQ7+lBGntoWEMOcZaGTmfXkVcTwlU2BfCb6QEaF9vz/bK
 n/D4+dTQgcKGPsdJnOZMpLvjoAziXnO+QH27Se1M2zmco681Y7omiCY2ovVxqJsNj7Jz
 sYFEUunTpagobY92JvsTzRnlOJTq6di91g4upCnid2QLsgRikumRI0fNyo5FhhDH9p/J
 eNYS3+S/mVwCfPuct/7Gdk5kKhvwOPhSvTTU38+jAJEAciX+bfJlA4iblazEV1ziPVU9
 Z9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pPC8X1NXg3RscXngfc7zMky2e+rfbjyk67d2V95UmQo=;
 b=UZF0RlBOa0zLHIVS+JLpFSYufUbOQ6mvbmoLPlHrrKQDUYAaM5fVAWSrzRNosBU3UN
 DH7LKAGlj1mGaMBlqRHFsVt9yJgtxQOnHuhB4ubb4VkKqBZ06YCXtp37lT9JiKCi3LdW
 9HFCGd8I3vW0OK0HyLYnc6u0da4MTPXxz1COFI1ntwbFECRffYzzEV9MbSkgq1vxENC7
 HXduSquyg6xIu6m3WA4kZsLdRCBnzV3YR/Hsyjtx4s5rHN2oBxJgmNC1MeL7yqmXgN8o
 elXrNRVD/J3IsQsXhXvkV/tJQ+YSAcg9uaMbvL24ZLEMQz3xyM8scnaGI3Cb3nRXH5W+
 9vpg==
X-Gm-Message-State: AOAM533j4kzsNTqqdde6bPeruK10L/I+tX6NL73pKOQEiI5sYrj1PVkW
 xer1eB2xyinE/GNRDPKdnhg5qk/k5mZulg2m1JfhUg==
X-Google-Smtp-Source: ABdhPJwGMqFYclC9ZmTN21oXTeAg/9gOiinsMTeBgpEEXxxROOjX/7aN/1AZWZ9kjZIvjDgOKcMDnVlFkLTNLjYJwmI=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr2504397ejr.250.1597919602863; 
 Thu, 20 Aug 2020 03:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200819213203.17876-1-pbonzini@redhat.com>
In-Reply-To: <20200819213203.17876-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 11:33:11 +0100
Message-ID: <CAFEAcA86m9N5ceYB+Nu965Se=qyZ_3W-Cn76Qc+Dd75hEApz=w@mail.gmail.com>
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Wed, 19 Aug 2020 at 22:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2eddb3c65821dce76433d5da6f3e6419349d1b77:
>
>   docs: convert build system documentation to rST (2020-08-19 16:13:30 -0400)
>
> v6->v7:
> * new patch to preserve compatibility symlinks from previous binary locations
> * fixed cut-and-paste error in linux-user/mips/meson.build
> * preserve compatibility check-block target even if no block tests are defined

'make check' still fails for the all-linux-static config, this
time for a different reason:

make: *** No rule to make target 'check-qtest', needed by 'check'. Stop.

thanks
-- PMM

