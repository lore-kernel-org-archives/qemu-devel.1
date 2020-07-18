Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034FC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 16:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE53C2080D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 16:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJshXkvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE53C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwpgH-0001cW-3e
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 12:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwpfX-00017M-IQ
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 12:26:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwpfV-0002tf-9d
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 12:26:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id g37so9101560otb.9
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jnVw9+7mS4ob7oB3wUmuIrgx2fHwyWXSlsgQllmWp0A=;
 b=lJshXkvx6a3WIjTnT0LghxYlUGA2Tt2FBXHGzR8C98OzKyMlhsdcno+VR9CrmXeZld
 P3d12KANUDi0aFcKTSGEgiH/0EWZJV1dDNRKWI7NqS19Iou9wHKZ4EH+4dc0A6fTOyiu
 e01B6z+yamdmzE8eIJWjImF9nYaivqH7ELrfWY0s+Kp1DwCiZUd/xpq4fEZUr2YOstkv
 bdEToCuYblDcdHzTmFidDaO/466mMdV7LCUA9FZSAjRqUz4E4VWFUzsPIt0ZJ8RGgDZ8
 LHD8KE3qmXzJfdbV7wq+HAVeOLsheZcZfGjZbLqk+ilw+q2dsWKZynG8GH5TlK3Yb5ui
 +ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jnVw9+7mS4ob7oB3wUmuIrgx2fHwyWXSlsgQllmWp0A=;
 b=cXvVLfrz6c2wk40KxFytsUkGGVWKj8/5LT24vVot+ORWWyiGpkC7MRDmrJdNjxWhxt
 lQm4HjbN1ywhuHNNXKXzEpNm8aJLldFqFxJfam8xNXpQ0AwfNJWB6XuXSg8sEGdWL8ED
 v7mAYb7Ibk/qKLuJbphBqGn2xYQB0oLBQSX1dd+fbhZqAj5PA7rdKGIppKcJFW6lbJhj
 AzcwzBWUvs8gl+dmSFdY5pmjxgIvvlzXBxixBLdRce3g0l5rBM9dIcXQABzE8b6wAl0i
 0JTx1Vh3xf8LIxw97CKGeM/lNPyR/jVSvCTwxX827oGDScF0Tj225Ak67rO9rQx1Ofh6
 ageQ==
X-Gm-Message-State: AOAM5334nOT7PB9e/0YfT9/7BeveS3PnqDtqU8RpHYWRppRunn4wJd4W
 ZHtsh7U2U3QqC63HylWPhbLXLFHsoJe0FsAbmUVdvw==
X-Google-Smtp-Source: ABdhPJzqqwf0WvjML2IjWXZ3CwISAo2V+7KC8GAQIz3W+1Ba2V7k6KrntaUwcofw9yj51PoI+new01jrW0hoEaYFW/M=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr13736262oto.135.1595089591918; 
 Sat, 18 Jul 2020 09:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200717125510.238374-1-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Jul 2020 17:26:21 +0100
Message-ID: <CAFEAcA8gFgGrjM3xapYn8eg0NL0HfTPtXcB=L95=R6nvO42StA@mail.gmail.com>
Subject: Re: [PULL 00/12] Block layer patches for 5.1.0-rc1
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 13:55, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 151f76c689b1ff4c2c59e6d8469a0d4fe5346f55:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2020-07-16 21:46:18 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to a8c5cf27c945d392edd85b0b0c64cd5c52cae658:
>
>   file-posix: Fix leaked fd in raw_open_common() error path (2020-07-17 14:20:57 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Fix read-only Linux block devices with auto-read-only
> - Require aligned image size with O_DIRECT to avoid assertion failure
> - Allow byte-aligned direct I/O on NFS instead of guessing 4k alignment
> - Fix nbd_export_close_all() crash
> - Fix race in iotests case 030
> - qemu-img resize: Require --shrink for shrinking all image formats
> - crypto: use a stronger private key for tests
> - Remove VXHS block device
> - MAINTAINERS: vvfat: set status to odd fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

