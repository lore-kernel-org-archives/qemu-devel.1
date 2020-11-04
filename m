Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1914206F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/1V9bss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1914206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaPuf-0002qB-LJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:01:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaPt7-0002Da-Tq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:00:13 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:41280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaPt3-0002HI-PI
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:00:13 -0500
Received: by mail-ej1-x62d.google.com with SMTP id cw8so18235046ejb.8
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E4WjwvX76hWxO/jjnNrz+gLq3En9lQGeWplxRyxXQHg=;
 b=j/1V9bssxmEIreRGcTEqx+rkllCy0rb8iB/heFAS6Kx3kHYt/HjNn06hQ3gTiUZeO6
 OKFsujIpjX5Qo391FcbJBHDvVxnpp4oAU+Vhq+iLeLg4wu77loaiVvYYFgz63D+me5ZI
 lL3JwsImAVvnw20KMqZO6fxf5DpJEScEJ/edT4RoYCVAJ0WPf5OS+6dadl28Pp0/O+DV
 KicnqQg/bENuJ0y537NtKFL421LKSSW4t0ZVBqhULvmBJ9Cjkv6BQaVVKfWKAA2c89Op
 b5b/4eJjxFs8YB4GUSIM98Js1jp3A5Q/YUy4RqQA5gMrIHQ+lWnmCJVLTv2Lf/qKHYfn
 XaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E4WjwvX76hWxO/jjnNrz+gLq3En9lQGeWplxRyxXQHg=;
 b=p6ypsE0CWPny01bDAN5zIgabnvnkIX+ftiHg+cibiI/c9wxPuDIgpPubXGfoBNcgAT
 IlCcNV/LD/JuTT/RrE+jMkp09zDe4Y3Sd9xVblEyshURJd+mOkzk5ihoH2Z4xfp9FH9A
 HRw7Ap29V/KA/xRn/mngZouWTUPtndd8zvB/ADoEa2pZzrFGuec4ImJz1Ah1kCsB/Bs/
 Rcrkhs+ov5RPaiYLfwhzOdHf9O3WOR6XHMzT9NxXBkmJVWjqbf8T6Cj4TXyLqJF/uu6b
 mIYiDXG9zdIUxNXRzGkjQaGaUugl/QN4jRsK9gQBs8SiWWOflHnWGQ2pANgVb02BV7kE
 pFuw==
X-Gm-Message-State: AOAM5338YaASkwm6tQt38nOpqttlDB3kzGGU1L8A3s+2XKrIKKT1EIJ4
 y7FDwnhcI9xYhabcKPlg0MVwsv/CsnTS/jSSWN3OLg==
X-Google-Smtp-Source: ABdhPJzTp3ZvGYQkhhsdlGrNNSN9lhK9dRQ4wLobyY1Aeai2n/vmogGkkpRzAx2U+4v/8JmtF2QZ9zlKDATyYySlwnM=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr25926268ejb.85.1604523607720; 
 Wed, 04 Nov 2020 13:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20201104151828.405824-1-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 20:59:56 +0000
Message-ID: <CAFEAcA_fer-r6tJLRgQwQ+X1bAe0ODSA5UNWxZbSCtS1VHDO9A@mail.gmail.com>
Subject: Re: [PULL 00/33] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 15:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 8507c9d5c9a62de2a0e281b640f995e26eac46af:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-11-03 15:59:44 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to fc107d86840b3364e922c26cf7631b7fd38ce523:
>
>   util/vfio-helpers: Assert offset is aligned to page size (2020-11-03 19:06:23 +0000)
>
> ----------------------------------------------------------------
> Pull request for 5.2
>
> NVMe fixes to solve IOMMU issues on non-x86 and error message/tracing
> improvements. Elena Afanasova's ioeventfd fixes are also included.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

