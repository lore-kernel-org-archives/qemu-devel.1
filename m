Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6513C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09C72071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fDsA334k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09C72071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJI11-00022u-Qr
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJI0C-0000ov-Jp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJI0B-0000pb-Hh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:36:28 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:40526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJI0B-0000p4-56
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:36:27 -0400
Received: by mail-ot1-x334.google.com with SMTP id r19so16378144otn.7
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=loZ8nWi/6kHwwTWWF3app5Kg+1ZzlRQrXkyokNxipQA=;
 b=fDsA334kZNKBR1KjjOBhcp/wVKedVe2JumHuz9lK5Wajjw18hqeSJPX0VQIkjkX2fs
 egJelx318lChBhQ9T+Vd6dUsOCSYZZpm+1+fHsetr5TU09mCwxmWZvfaW/Jwyl6ezs4y
 IIoLepGpJHpru6qdclO6pgFN7udA6u0Cuo5VNRh7605oXXsDBV+GSWqUkR6xTn74YGxc
 eVI40E73dmtUGVlW58NguCE2Pz+lWhMqa/MDieXCz1gnnMyhIAeecqUie/ZjF8s0zqpc
 1pIe3tcFMBTCh/Nb5Gy4fseBxmQxuQKV28PyHbyPPacQA3iomF+2luT7UpHdDpfrqRjW
 75EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=loZ8nWi/6kHwwTWWF3app5Kg+1ZzlRQrXkyokNxipQA=;
 b=sRuTLdxCp02u6+icGJ4mvcwi4AMU5suEyPAcI66wXyrjdc7ueWOMd14e7V3neAouDi
 Umf9hiuoApCpA0GcjII2nwHdtsHpYio6y4TmXUYUIV8qqMJPF9c5lwPEWnYd7WuFTtNs
 VKG7mJpZWgoQLfpUl0i5Qj4F3yjx64+LcJEHfCcOqsOJ1zR0ldrC/tA8uM5l/qLDeHCm
 8QaJkjvPrxcxt6BmaDAfb5XCV9nhSeBJ1RAfH4G9vOh2sloHgmBhvKKSpw3Etr3ET/IQ
 Jsz1+lYp96uHXu911qeT/zvp2qTAEheBE4wcTOGUAnIX9iIA3IMfVtdDIIwrCx42UfOJ
 8dsQ==
X-Gm-Message-State: ANhLgQ39MNYZOmcQBhKABp8lg8W7NzR6sRUDY5oTeSNwloSVWVd4/c3C
 FC4BLt3KP+2fra6H6TPefbbdbRKLfU7i88edphQXhQ==
X-Google-Smtp-Source: ADFU+vs0LbHle2KcO+UV+UYyyeDoPgmqTt7y9L4rUhUR4gT6G/S1cUGohI8JsG4v+eTGP+ke0icAHullS/wkaVUdiek=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr12554721ota.221.1585665386024; 
 Tue, 31 Mar 2020 07:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2020 15:36:14 +0100
Message-ID: <CAFEAcA944HHswkYR9bVELPbLheSsupYpSDyJY+EYRM4NLrc6Xg@mail.gmail.com>
Subject: Re: [PULL V2 00/14] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Tue, 31 Mar 2020 at 14:21, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 2a95551e8b1456aa53ce54fac573df18809340a6:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200330' into staging (2020-03-31 11:20:21 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 1153cf9f5b67fad41ca6f8571e9a26e2c7c70759:
>
>   qtest: add tulip test case (2020-03-31 21:14:35 +0800)
>
> ----------------------------------------------------------------
>
> Changes from V1:
>
> - fix the compiling error
> - include qtest for tulip OOB


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

