Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B81C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567FF20790
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KojSiefr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567FF20790
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRv6g-0001ie-TP
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRv5D-0001Cs-5c
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:29:35 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:45816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRv59-0006p2-VM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 06:29:34 -0400
Received: by mail-ej1-x62f.google.com with SMTP id dt13so22474184ejb.12
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6ls/uFm7SMm9xwI6vEsYPU//pwi4d62rfmubsThLcj8=;
 b=KojSiefrQw7I9M6jRKmBkOAAbHH6057OSXAd+7NuL5gBz5zEODQsE1z9GEQVKiPV/x
 qlfqfxtCgrzkBBM8Tn2dW7E7G15tKSZp2mNge7QJnEhqEqy6Qz+Xin+KQV26rF1x+JdW
 NlC86jJAAVhH9no2eZs/jIT6tHKlfjaZnJLwaOAgygx8tuRWZAfwPnGyEh6oA08ciQjT
 j+nZ0Xjcx43f+/Gs0PmTW2GbSkQQPrHKrjLuCOrSr58Ak95mcypiAC2pe7YpqDvy7YT2
 XEDkuHKoL8VsOxLUMI8a5FHq/IF2+/GUxKRBdEWvHHoraPJULO90mMT9jGmJYzNWokXt
 RTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6ls/uFm7SMm9xwI6vEsYPU//pwi4d62rfmubsThLcj8=;
 b=pcOg0zXiNt++OpQ2WqCl2cuNkhIcgToX0hhtLg4gucEJew24Y8NY9UZ/fIi9RItKls
 aTJquxsO7V/xm6YCNqOpBJvoXTUC6rnXEKUwB/qYOc8d3nKKEDKrt7DlVj9fa19eZLq/
 C0hGpYQmrUfJyftWNmXQoDna8fCavjNVCyYgoBW5d+hWolMZbZ3+3aTHa19UTSFVdIp0
 N8VPqMof/CsuZjy/rB57T3zjZJDQJ+hheop4xgH1nD/UcgiQENpUeW9IBiLds+Of7gDD
 FFbl4cX1KEIRAazrZsKZHEog8awIwS7GDhiH+qHkfmqZAhuuaGYEWvDU4TRE5BcFlPTj
 /OOQ==
X-Gm-Message-State: AOAM5321yTGlNGEbZel89WsljCRpZ1YsGE6LR/nZ1BGNPCZ+LGUf6Dbx
 RonvDierCBr3dacf9vsdD1tr0LNIkvm9ULA3NcZbXw==
X-Google-Smtp-Source: ABdhPJw96bsHFyHIfVc3JqRRMCB9amoOwldp8yVp5hRpGGAK6Fx0AHD5Kdcvqead7H+ccsBu6etTSUsPGftx6OAoDz0=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr27503602ejk.250.1602498569901; 
 Mon, 12 Oct 2020 03:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201010075739.951385-1-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 11:29:18 +0100
Message-ID: <CAFEAcA_L0h-0==uP4FrB-QeFsFOcSu5BZFRskO9w4LB2cEqxHg@mail.gmail.com>
Subject: Re: [PULL 00/39] SCSI, qdev, qtest, meson patches for 2020-10-10
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Sat, 10 Oct 2020 at 08:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 15:48:04 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 1340ff2adb2624e61c5fcb0eb1889b932b76f669:
>
>   meson: identify more sections of meson.build (2020-10-09 13:19:50 -0400)
>
> ----------------------------------------------------------------
> * qtest documentation improvements (Eduardo, myself)
> * libqtest event buffering (Maxim)
> * use RCU for list of children of a bus (Maxim)
> * move more files to softmmu/ (myself)
> * meson.build cleanups, qemu-storage-daemon fix (Philippe)
>

This produces a new warning, I think from Sphinx:

Running Sphinx v1.6.7
loading pickled environment... done
building [mo]: targets for 0 po files that are out of date
building [html]: targets for 2 source files that are out of date
updating environment: 1 added, 2 changed, 0 removed
reading sources... [ 33%] index
reading sources... [ 66%] qtest
reading sources... [100%] testing

looking for now-outdated files... none found
pickling environment... done
checking consistency... done
preparing documents... done
writing output... [ 33%] index
writing output... [ 66%] qtest
writing output... [100%] testing

generating indices... genindex
writing additional pages... search
copying static files... done
copying extra files... done
dumping search index in English (code: en) ... done
dumping object inventory... done
build succeeded.
/home/petmay01/linaro/qemu-for-merges/docs/../tests/qtest/libqos/libqtest.h:241:
warning: Function parameter or member 'event' not described in
'qtest_qmp_event_ref'
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
[build continues and succeeds]

Not sure why it isn't fatal.

thanks
-- PMM

