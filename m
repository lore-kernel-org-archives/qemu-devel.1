Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F6AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45DA21744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgxHX0Sg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45DA21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2yjt-0004YM-01
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2yiz-0003eY-0V
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:19:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2yiw-0005Y2-RF
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:19:32 -0400
Received: by mail-ot1-x344.google.com with SMTP id z18so10362082otk.6
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 08:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HjWGT6xwCEg7T9/pJEP1aflDEKtb9JWAZmrkeggYvEo=;
 b=YgxHX0SgWa/CHjL+F6ZEZB7OtJI7OLJbN7Tsivynx86/Rt2HN5gYBj+wMYw4dIOXLm
 IP+ZSITIHzFxIXwuRgZ9BC58c1nE2dmI21k/XWuIaOYoRLdZnt0J8PuubFk+ntvFihxR
 JGMYrfhtzMt/OrhhBNijRyFyDT0PCJpU2j8hMoCigWQhTCCmD+FGrOxrXLdnaOxbTMCz
 x+6GsptrPH+jGgBSReTjMGJMA5kxV8w5D2LO3hA3/NitHTfoqx0Fq9f4wlUNXqKQsO0U
 C9Yq7gs43L5vPkuHLcu4Bfrd8UutbL6R1biyzy94jiir7xZarRQVi6idXdFxQJ1N2Iqd
 AKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HjWGT6xwCEg7T9/pJEP1aflDEKtb9JWAZmrkeggYvEo=;
 b=KrjJJRH4iERJ9HQd/T9GUkHmCo2mzbafkO3b3/AA3/69d4V/XITK87hdXvRLKDrGRF
 eMfLX8kbMhg5JgvtXm9Kzr+K/eR81MrSVxEJHbjiJqH1CG1iMizgAMNx7XvkfnUFhmZE
 oLZ4cAvemGXjOciNjp/O+6PAKn9cwo2ib8WJrjpCsKITZAakGuCrt615a1flIz+yv0qE
 K6coUkj2hr4KtkeL3UPFWTOTus5TBBQJ2hawDyxr5i+KLqeWGg49hV8QtMjESC+6z2f6
 orvrf/wtbQeI0AOPhZrlRSxn+RCq9uv4q209nNJxiDTiUPAy6T/wfJys2V3oE9wSy9d3
 TGBQ==
X-Gm-Message-State: AOAM532IiIsofOapm3xRRZqrOj/30XVPsT/dudFPVXe9AwBiVbpJ9y1y
 bvchMKcEE2ueGj02cb1357sNO9X8nrcywNJNfuaOJg==
X-Google-Smtp-Source: ABdhPJwX0QfMO+C47HL+QgYHOjASJCqpLYoZIJFXQYsreWGEDF7dcKafqWHx25iKuE4FprmDe2dnvLdN9CU5Ar8KQS0=
X-Received: by 2002:a9d:3b61:: with SMTP id z88mr18815702otb.135.1596554369046; 
 Tue, 04 Aug 2020 08:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200804141640.591031-1-mst@redhat.com>
In-Reply-To: <20200804141640.591031-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 16:19:15 +0100
Message-ID: <CAFEAcA-LJU1aqv1LQmQW5bAKScxV0g-vdR8PLSNAXHCuCO2BbQ@mail.gmail.com>
Subject: Re: [PULL 0/3] virtio,acpi: bugfixes
To: "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, 4 Aug 2020 at 15:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 5957b49b423fe456896e10f7e4a6c69be07f9407:
>
>   virtio-mem: Correct format specifier mismatch for RISC-V (2020-08-04 09:13:34 -0400)
>
> ----------------------------------------------------------------
> virtio,acpi: bugfixes
>
> A couple of last minute bugfixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

(as noted on irc, fails 'make check' due to DSDT mismatch).

thanks
-- PMM

