Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C46AC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EB32231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ayxi2tob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EB32231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUWgs-0006UP-42
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWeE-00057F-47
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:00:30 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:45578)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUWeB-000139-IV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:00:29 -0400
Received: by mail-ed1-x534.google.com with SMTP id dg9so10549431edb.12
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PmJ2bARyOEExaWmdn95Gfu/EQleGksaAz+WndZDE3iI=;
 b=Ayxi2tobBXyltp0TUay0Cq40iQRpFbHE6frFT+jergAcWtosRB64FQ5k8rNwj1n+W8
 ypQMWnMNM823HomnBGlQ/orFvrDrF8e6HO3zCapmXcH7ZSWoAMESsIK4aEVI6WGoHBrq
 YVh18SaYYP3+7K4aIjIePeHGGX5VBqTUSI2UENo7Ja+UUENvmf+AfXe/KfYHYHVSN7OH
 lsBDTwsgaHIGU1aX2qGExvVmC6vNdIB8b6upBpEuKKof65MaIj0NwANKRs9QBDEn+vBZ
 AigDaisddDpH2WyWUDeVnErVWrQXgQmcKU8pIb0Fx5ATkp0y7bVJvKf3nkdWSdG36Gk7
 92Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PmJ2bARyOEExaWmdn95Gfu/EQleGksaAz+WndZDE3iI=;
 b=uKhN9x9/K3Wb3/LzLsj9DZs/jxwZLmS9va8745kumE9YL7jaTvGzZOro2YijZ6W6aq
 uf/5mKXeZKb1ozgFL0URyGIAMnOf9O3HpxHyIaZsCoueoRaIgIbKNWKwqlmdxciLeF7n
 zvzxsFEFgWIj5oWx8wLEZYRY/mUOVuu8fcMWqD0gficbrx+QHSanJy52UMDf0WZT/FU8
 ZiWjSy6njNx9fSlnsvAizl6XhV++17xg7EhauMFIItkk1whn1mG6tOL+zPWrmMj8mt75
 nAHnUqN60IRispNB2yw7xP2tq4A4dRDsxEEtokW8yK//FPpstlUGv8v8kIH9AUESRkk+
 HicQ==
X-Gm-Message-State: AOAM533Kn3abdd01CttSklhv3zP62PHagrd6NCT63yKpRT191I6hKXKP
 3+8qVdSbPnVDYvst+h5FjC8FSwYCkg81WfizEyggFw==
X-Google-Smtp-Source: ABdhPJwjZQLJ/8Y47Zk2AGFhn5eEd1ljRya0ikj9C/tajlZ2d/Si9+Uw1XJI3eqDNILhbdCXFM3mPNpKbG9ccHXphbg=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr261100edf.52.1603119625365;
 Mon, 19 Oct 2020 08:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603111175.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 16:00:14 +0100
Message-ID: <CAFEAcA-rL1cTReJuQdX=V0wjhCe1535UAqw8k-WUj-HAa7-PUQ@mail.gmail.com>
Subject: Re: [PULL v3 0/6] 9p queue (previous 2020-10-17)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 13:55, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit ba2a9a9e6318bfd93a2306dec40137e198205b86:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-macppc-20201019' into staging (2020-10-19 11:46:03 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201019
>
> for you to fetch changes up to 653daf38978d101d8810f96b9337ebc6b7b1423f:
>
>   tests/9pfs: add local Tmkdir test (2020-10-19 14:25:40 +0200)
>
> ----------------------------------------------------------------
> 9pfs: add tests using local fs driver
>
> The currently existing 9pfs test cases are all solely using the 9pfs 'synth'
> fileystem driver, which is a very simple and purely simulated (in RAM only)
> filesystem. There are issues though where the 'synth' fs driver is not
> sufficient. For example the following two bugs need test cases running the
> 9pfs 'local' fs driver:
>
> https://bugs.launchpad.net/qemu/+bug/1336794
> https://bugs.launchpad.net/qemu/+bug/1877384
>
> This patch set for that reason introduces 9pfs test cases using the 9pfs
> 'local' filesystem driver along to the already existing tests on 'synth'.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

