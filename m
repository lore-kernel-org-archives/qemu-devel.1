Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7163FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EBF20671
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apT2XrlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EBF20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZAYA-0004Yk-CB
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZAXU-0003fA-7k
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:52:28 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZAXT-0002R9-1a
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:52:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id d191so3741731oib.12
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 02:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eKYmV5OgrICyzf7Qr5nXHFgF6kAatYGq3QhgPqfGLgI=;
 b=apT2XrlVHkVR3V9VElLMPDvnG23Rh50LnKU2gyUdQHbpFjO4TTlINrxG99hM7al1ls
 /6y8nNjgHXPkO4BRFrknWUunpuA72gcmJSxZY8U6Axgd5NZLewd+8PfStncTMHUtjQJP
 UCFF2ggrI+RKGVx/6uRq7zzae+i3rTVijR/tnUi0hLvAsRhKfnplj91dIt5ScahEFnRZ
 BlZ9D1vH4B6ZHrv1/rUQqsgrOSwCj3A6ed7GF1kmJ7k1PbzDpaKYLKemT3iure9+Rmmo
 A76WMAsl5rewZ73u/RHvMHcjpxsfOIrX2GSwls3ismcIvLEpHy6cHpwe3t1XslKDyBIz
 Pd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eKYmV5OgrICyzf7Qr5nXHFgF6kAatYGq3QhgPqfGLgI=;
 b=bwYAQVkQjjMqXCwNShzn18+cHyNjCWgDlEzT0waMToHs3BAaSDCq1dc4BqGyf420p0
 GioyIV1T4jM/4hY+o1Fb1G7H57KMIX1FbJBFqta38X4BWwSKFJkfBHvT5hQlp2SQo6ah
 jNFeHcweM3mTwWc1axnXAFXoyNjRNlLND2L8Dc2FTKEPIglfHPLKFU1dn/dHDaqv7DbM
 KoORsC7w8QpH52SYPdgYfQ6hXgGWOYMRpqYqySZwVrpuVTHPSgJFVMQ3drVm5sgFmkm4
 q+1PLSdOawAHlwXBebzrZUsxzHJTqcNLgo0Jasz2pKwz3JDjg5fRspZf+iNp6pLPEt4d
 G9fw==
X-Gm-Message-State: AOAM532cO0/bJ7IW2gRX+7IIfcbFLafqB4lvtFXn9uNOQYPb2iIPUao7
 UAf69fSRPmvnYXtBOuyL7GaCg8FQ0MeNmvx0k11eMw==
X-Google-Smtp-Source: ABdhPJxfxyCCkAQQnNlKeGpyToy8LfW88DDNeHrGSHwJ7diQ/smKbrWGaDM5j4Q17lGq2zGHv1Cn0GM4tXET/5qGc4w=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr586600oih.48.1589449945622; 
 Thu, 14 May 2020 02:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200513141544.1459069-1-mreitz@redhat.com>
In-Reply-To: <20200513141544.1459069-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 10:52:14 +0100
Message-ID: <CAFEAcA-_cu+MYqw0s=XsQEXSFtHCJMzUb+cJLbie6hxgNu+UVQ@mail.gmail.com>
Subject: Re: [PULL 0/5] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 at 15:15, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-05-08-1' into staging (2020-05-12 17:00:10 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-05-13
>
> for you to fetch changes up to fc9aefc8c0d3c6392656ea661ce72c1583b70bbd:
>
>   block/block-copy: fix use-after-free of task pointer (2020-05-13 14:20:31 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - zstd compression for qcow2
> - Fix use-after-free


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

