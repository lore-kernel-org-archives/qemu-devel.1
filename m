Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D0C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0426206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 12:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICB2fg2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0426206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsRFG-0007TO-SS
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 08:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsREV-0006yt-M5
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsREU-0002pL-Ae
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:27:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsREU-0002of-1g
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 08:27:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so37704141ote.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xOkqCXei626p4OQ5Tak5fBt3D1sIDF8ssJ+f03vVISE=;
 b=ICB2fg2jNeFCUTdaDXI9R65OxUJ31zVKflVEF03ZJyVWnStWwUM945luzflCSZuknQ
 TkP/wcEJ0ZEs2eAL4rmtUNwILb5d2AJgE0FuiTW0GVvLCdY1ITvwN5gRNAxxKhA9W2hu
 omvRQXUjYOVZ1sAZzawTeunRQGOLljWsY/Qrs6eUT5pyKkVKlWUCVEbiz7yvNvrUw5sG
 XVJzaWNo0Jv1Yn+rQex9Y+O0kSzEMQ49gF6y37UbnTe1NNrnONeDrU1skWMVAaexR7Vo
 3779hBPI/T3XHpYhX9PFJ3/kyBMplH2KsmEpqmhEr9IeGSoBZoMT4L2d+DHUk3o+J2+d
 c+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xOkqCXei626p4OQ5Tak5fBt3D1sIDF8ssJ+f03vVISE=;
 b=jG+qCrCaJ+jpvDyIHZB/re1ofT+J59xYHu+Z1RQmdyOSgEk88gowgQwf4bciZsTRiW
 t5iO2Y6sDLqLCDbWanANNY5CHhQvFqfIgzuH65HFYRp3y9pceV9oizV1mTHgu5P4tS1e
 dy4oeFsUTp/RezOhlFqjaFnCgKCnAGMBky4k0rmhDWoOa5QfyDBaQMZl9es9XytXyJqe
 Q0k1YtrjMrWQOCcSO9t2RVb7O5r8usLaKcRW3xkblUvr2FD/+/QBHzmS/asgEoK1MnsT
 qPwPbVjBxEAtwqVrw0q/fRCWqHUHxCCmniFTCuwC7c6/0yHKN3vPCUL8Z108fqE4wuoY
 Wuhg==
X-Gm-Message-State: APjAAAXfSMwGceEP/jBCs5XD5sy8A/tmT1kSPQ+fgtF/APOvMbNGHEI4
 kC+ickl/qxwageh1PFYu+ikNGryFyi0UZL0+2tGLUg==
X-Google-Smtp-Source: APXvYqyfTs0uF1MlxNwi2l12OBcZtET3KRaPuXyraT7B+v432qtSed3NVxsHLsmrBs8zP3YRqSZirybTEusYVNAIZSc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr27117947oti.91.1564489675464; 
 Tue, 30 Jul 2019 05:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190730112425.21497-1-kwolf@redhat.com>
In-Reply-To: <20190730112425.21497-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 13:27:44 +0100
Message-ID: <CAFEAcA93swjx3rX1SaCLqAWhkcE5du5vv_K_De_+hgUkBV=sHQ@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 0/4] Block layer and multiboot test patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 12:24, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit ee9545ed1543020fba52fa5fb8f2b71c63e5389f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2019-07-30 09:43:32 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7cef3d1290c9d675deff95029ba78e51fb727125:
>
>   scsi-cd: Fix inserting read-only media in empty drive (2019-07-30 13:21:38 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - scsi-cd: Fix inserting read-only media in empty drive
> - block/copy-on-read: Fix permissions for inactive node
> - Test case fixes
>
> ----------------------------------------------------------------
> Andrey Shinkevich (1):
>       Fixes: add read-zeroes to 051.out
>
> Kevin Wolf (3):
>       tests/multiboot: Fix load address of test kernels
>       block/copy-on-read: Fix permissions for inactive node
>       scsi-cd: Fix inserting read-only media in empty drive



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

