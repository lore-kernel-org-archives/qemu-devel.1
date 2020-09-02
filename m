Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0702C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A8D206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plHZqgfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A8D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSFn-0000US-JF
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDSEk-0008TI-QN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:51:38 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:37494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDSEj-00068A-1w
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:51:38 -0400
Received: by mail-ej1-x62b.google.com with SMTP id nw23so6470562ejb.4
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FV2TZEeKCg4x2bc0gaygMUNRT0wuoZnfJJ0WeTdiw8Y=;
 b=plHZqgfsGvs+0gGrp2cwGPPK2j0PLJd+I7zc05tRYowrwAstqe4zmBJqn+kRourpxB
 ggKsA/GhqhzfyDEw3lxFKdM6Pr/vIzRDR7TnB8QKkEJijo+VR9g6mbOJCZygj6RUx4kM
 eLNcV5KUB4uAPh1s7hh5H8IJu5yhUpZRz1np8efDUzFbb/yImHXYhQsQi5UBdvOHmtBp
 x4nRG9Y4WQYL+BlFIawvGp3dXacVv5DMlyfKkxrjxSrE3EsfCAqYtm9hab6Nh2HbmLsQ
 2e1qd0pafhI9zKmVH8zsksYrAIdbjbL/qIS9Vr6raaKu+KA9zCKo3wfCtA+R5FmhSCba
 a1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FV2TZEeKCg4x2bc0gaygMUNRT0wuoZnfJJ0WeTdiw8Y=;
 b=dFlwH95bkBeU+wSEtqZCu5tyCzQeXmSWZFGjdzSCP9l6+Nr9EtQMbevg2nvRz5lQWo
 fal8E23TQvNji2ik4+aN8P8gbVzpgeC4Lkl66rfI+lzREFln0R3X/a7XM6dv9g4pYTmP
 XM4labb9joWUEyOYocIeWzj5MgKnEla9QvwbZKp4FX83Yf5NKEw5sSD+lD1cQ3aTt+LL
 odzdUPC0Nr7IXx7Lx+EJiqSoKvchWNWzesqgsxqUKhRoFue9xRDdYYo+5P5a1W5e/zlP
 L7Nk8vxjetGhGnpERpFraf6GX85LiYMPtE4xvmMVNHjQdxNj+72/gEfkg5gg2zE7h58L
 603A==
X-Gm-Message-State: AOAM532CX0tJ+S/7NobbpHR6bDQCk9pdFpE+V+QFo7578hqjwyLZci1z
 P0d8owZ3Gwoo9Pwdh6giWAQKaKLkY7PDjLUXESoULA==
X-Google-Smtp-Source: ABdhPJzOGxnHUwbVtEmdN0v1bmvWG2vQen71l8T8KKumfuTpYiVwhN5L5xKzE1Ri2dHKQ3tK+owh/XLVl/8dn7QBcqE=
X-Received: by 2002:a17:907:728e:: with SMTP id
 dt14mr6168855ejc.4.1599051094540; 
 Wed, 02 Sep 2020 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200901173842.5882-1-pbonzini@redhat.com>
In-Reply-To: <20200901173842.5882-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2020 13:51:23 +0100
Message-ID: <CAFEAcA_erWmQtYfhV7W+Oe7Lv1jFdca3vCVkk5rgwt4cVatsrA@mail.gmail.com>
Subject: Re: [PULL v2 00/26] Meson changes for 2020-09-01
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, 1 Sep 2020 at 18:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 9f5d95976895132976d9d6c14e7a35781d6f1e15:
>
>   Makefile: Fix in-tree clean/distclean (2020-09-01 12:11:00 -0400)
>
> v1->v2: add Greg's cscope patches, fix static build, fix option typo
>
> ----------------------------------------------------------------
> meson fixes:
> * bump submodule to 0.55.1
> * SDL, pixman and zlib fixes
> * firmwarepath fix
> * fix firmware builds
>
> meson related:
> * move install to Meson
> * move NSIS to Meson
> * do not make meson use cmake
> * add description to options


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

