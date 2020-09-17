Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F21C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B02B21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 19:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IcgsMj0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B02B21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIznQ-0002Ep-7l
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 15:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIzlW-0001Gg-Eg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 15:40:22 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:42565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIzlS-0003hY-EI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 15:40:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id j2so3708581eds.9
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hFKIL3VmFFOwqpPnnnEVbdaItm/e2bRjRgWgEjdNSi4=;
 b=IcgsMj0E8IR9XNoUk1zAnf8oXluhHG15Fqu/rgduicHU6+L9z4zBoDzcjz4SnmIMKL
 lJF2b173uzwbohHYTpHhGRAnAPrQecoevkRMYwSlZduer2MQwKr6eZJY2E9f5pFxfjqN
 NdPPM48cuZsAD305A0oxuGKvVO6opgJtZW2jv3O/IMEKBlZn+QQo/EBX1ICmbMMSMfC9
 XyCQXQkMBheop8ZpcOGGpkcaaDlnvGTsLmrWflP3vq5djSLwc7+ZHC/JBQzDXrI3868R
 rAqVHQFuNymGyszXi3AzgrIvDAk2c8FcKY6/Dsgf/y6e0dBl+8DgTNLqf2Ga5+faGuOj
 Tezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hFKIL3VmFFOwqpPnnnEVbdaItm/e2bRjRgWgEjdNSi4=;
 b=DlLSq5j78tF//1ymnypyUmzpYsJkjwT/snLiPlLXeatvyrcIW3bk/KMG1nbxEYGfrG
 RHeTx9cKQNPLC1tm0Fds8iYEkGFDrELnV8xUSazTEyiz53RoXpyT/m9vE78Ot5Jjo2zN
 Hg/L/gWoQMObzGGPAGdAdOoTR1ZpQBWfypy/4eLDaLYWBPDclwOSJW3/vQu4HKy0O2ai
 wxBAa4/AhUPusaKi7pAyJmZoA/gEMbCilH/oHy0lN0f2lsWxbHN52TsNVNYBvUZ8IXTv
 ChghJKpz2CZlOU/L+UoiOVrg50NVcvWmjqAJDWE5Yx3x7q3ZlQk4V+Ll8CW+HZFKL79w
 vxlg==
X-Gm-Message-State: AOAM532S/NyiBe5F0tYX+TyVywGtxmgycfgKNtR7fHI/+MeHt1YQ+HkZ
 L4w3XBqYMWidl5Fl+HZ2UR6YyjOb3XvBz60Bj3JG5A==
X-Google-Smtp-Source: ABdhPJwU/RcFKZ4i8Rwm1kEQ3aykDr3b6Fs2x+r7sUyxRqf4z+JaZXZkrE9UPXgDeWMPTZRGUBldN4OxTj5QLVRJpqY=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr25283744edb.36.1600371616022; 
 Thu, 17 Sep 2020 12:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200916122648.17468-1-alex.bennee@linaro.org>
In-Reply-To: <20200916122648.17468-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 20:40:04 +0100
Message-ID: <CAFEAcA8Cv1W5Y_owh7U-qCcifts_iT5VwD=ZprHeEwLuOhyrpQ@mail.gmail.com>
Subject: Re: [PULL 0/8] configure deprecation, linux-user and test fix
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 16 Sep 2020 at 13:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit de39a045bd8d2b49e4f3d07976622c29d58e0b=
ac:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200915-pull-req=
uest' into staging (2020-09-15 14:25:05 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-configure-fixes-160920-1
>
> for you to fetch changes up to 3ffc7f013763bf4fc50c3b403cbacca2bee68cfa:
>
>   configure: add [lm32|unicore32]-softmmu to deprecation logic (2020-09-1=
6 10:07:01 +0100)
>
> ----------------------------------------------------------------
> configure tweaks for deprecation
>
>   - iotest fix for readlink -f
>   - linux-user, report rather than assert on mmap failure
>   - clean-up and re-factor the logic
>   - add tilegx-linux-user to deprecated_targets_list
>   - add [lm32|unicore32]-softmmu deprecated_targets_list
>   - add a gitlab deprecated builds test
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (7):
>       linux-user: test, don't assert addr !=3D test in pgb_reserved_va
>       configure: move deprecated feature processing to supported_target
>       configure: also skip deprecated targets with target-list-exclude
>       configure: clean-up the target-list-exclude logic
>       configure: include tilegx-linux-user in the deprecation logic
>       gitlab: create a build-deprecated target
>       configure: add [lm32|unicore32]-softmmu to deprecation logic
>
> Max Reitz (1):
>       iotests: Drop readlink -f



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

