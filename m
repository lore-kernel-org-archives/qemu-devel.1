Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7967EC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E0320797
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSIN5fLF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E0320797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kED6i-00088J-Et
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kED69-0007fz-LJ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:53:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:40363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kED67-0006rW-V2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:53:53 -0400
Received: by mail-ed1-x529.google.com with SMTP id t16so1602991edw.7
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NVtBE0lqP61enJO2bq2SJuIZ97nED1kMiIJPWW7zAVM=;
 b=nSIN5fLFWliDP5BTV8JIOkDoMrvF2tXF8y/td29+x2T7nFFfhietNWnmn+VuqNDQ0e
 iduBMb5B0N8vKcFnj7gUTcD1YvW2Qpkd+iEs+WI//3BzRgCwlGf0KcLfMvXNKI05X5ex
 jKrbxCWnC7FRF0h1+beY1Ft8QD9B6D6gXCFUYnOkredE3grxvgthoWmLs0Ekus/8ih0v
 RuCS10DG6LUpe7d/lbFXEW2XuLDsCk+tv1MD1yitJGNcDXFv+t6jQeRmRmAknAYBwRFJ
 mVfncfVX47lMJKipUQVsw/UM1ZIwTS3S6KsQtXolupbIB1SWndV49vkmWHLpmUFHkLwp
 9gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NVtBE0lqP61enJO2bq2SJuIZ97nED1kMiIJPWW7zAVM=;
 b=i0+Exlff5lfmXU/GZ8sW+pWr9EuFIeAcNUnWqzcjSmuEMyEHcGK2PORdqfggqhNZcA
 DixT+PBfELogSQLSEPxHF/ozGCt3P2puELmGmUOGTO48muA+oxIr/zamI6XpnySO2Xmd
 PmavS0d9kTdSFskRkZdMX6kO6A/RT661Vqbh5ElTfjZ6W9nnFFBLQv/opt7lPwenNEj0
 mhUxs20uDeURraN719mIFzjvzwdUkLQo+d6kpmg+TBRZtui7TLLSJKRj7S+hsEh56xKU
 nkoaQaxhWhRguxJOrWRYAcJmbH13jtMqR5CDmI5p7fYU1/dMBUonezpyhmmS1n2hIY79
 i+EQ==
X-Gm-Message-State: AOAM531RGXONImLTgHu2Fhn2XwCvx+bj8WMYG+Yw30pqyfEJrfXgPfHA
 zgHOCNiduwRaxa2mvbW+pEm3D34Tc7lgtyrpTo1ZZQ==
X-Google-Smtp-Source: ABdhPJxf0xAQ9zIwfBHJYT3O7AkUdGv7z08/f58nacm7RLnBp3+VAOk2gqjc1TpoCEe32pjOYjwukomnlvsjDBOqzhU=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr8709476edm.44.1599231230267; 
 Fri, 04 Sep 2020 07:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200902215400.2673028-1-eblake@redhat.com>
In-Reply-To: <20200902215400.2673028-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 15:53:38 +0100
Message-ID: <CAFEAcA-nMygOxrZYrKNKxtj3=L3+BXohka2dd5kT=9J_u4Z+SA@mail.gmail.com>
Subject: Re: [PULL 0/6] NBD patches for 2020-09-02
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 2 Sep 2020 at 22:58, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit ed215cec0fcaeaece064b0fdf37fe3bceb06d76c:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2020-09-02 15:26:38 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-09-02
>
> for you to fetch changes up to eb705985f43d631438a318f1146eac61ae10d273:
>
>   nbd: disable signals and forking on Windows builds (2020-09-02 16:48:21 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2020-09-02
>
> - fix a few iotests affected by earlier nbd changes
> - avoid blocking qemu by nbd client in connect()
> - build qemu-nbd for mingw
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

