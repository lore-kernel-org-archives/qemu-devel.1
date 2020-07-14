Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656DAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3487C22282
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeWtR39j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3487C22282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQXR-0005ht-F1
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvQWs-0005Dt-L4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:23:50 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:46185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvQWq-00063H-W1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:23:50 -0400
Received: by mail-oo1-xc42.google.com with SMTP id s190so3550455ooa.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sfYdRUNNTOZDxJMdeRb0idzQDRe9PU4LdohaP9Sb8Dk=;
 b=KeWtR39jUHHJBmMVtyqIDeajJvQIAIcxwvK4j7vciJACfbuu/P0gPbOrGULDAa11u2
 a8lo0bBbv5NxBOzdNjliXx/V5DB43q8xxRyQlu0mhSOyJFYCdQlEKbBgmdEFUTttKWwa
 7k/P6tlgG3DnAuf2Zfnq5ZqU67Cbnx0QAq78Q2cFNnyHXeK57WQqbGZuJ4Kpqmmj2NB5
 mgBGMPC5CzsRyKyvDzBvX66tHxxD9DZf3TVpLBSW8FEigU8ngdztnZWuQfI9ToI4jih2
 kIm3MXokvOkXZncHf+XpigYz941rh2h073pomco9ezcd223sB8oiEGJTg0t0jlUoG7tE
 0AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sfYdRUNNTOZDxJMdeRb0idzQDRe9PU4LdohaP9Sb8Dk=;
 b=XXor3StlxQ8VoHrNSlORgXIpJ1lgik7xcoX1u/Qvhiq6+TyQXnfqxGNT3zTZ1UtZj4
 FGPAhul3+9Tv1vkX8MaXZSpSFiQW8EtDFwGr7XFRgJdyWEVIkBb89G60cgm38q8zrRcE
 IkuNA4kGyiUw0ogMXkzu0hLzGH0kdyeqQJdaJKv32qBxsXzwd71/BCkNLFvf7wuA12Z3
 K/s8WxOKav0oSYUrJRaEKorV1dK5cM32NAZzuY6PnzQ1us/KhjdniyFIzxl+pnfovjVc
 yjKpUqW8ue4M9GCNA67Onccpy2/iJMwsv+D2YwtquVn+c1AUrwPRmgvBRJSdFw/HI3NS
 ubtw==
X-Gm-Message-State: AOAM5336M00zShWiJhxJBOQ7ANsLUlXs9TIcqUPmlAuWrW9JMOkdt/mm
 cM1/HI/Kx79qkPsqGuZ/npKJukWrZHxUlu01GOiWdQ==
X-Google-Smtp-Source: ABdhPJwn0E+SBIZvE/+LtygVyyH8J6OPJjYM8xKj11ZemXRm+iLW60muFWOGzjrEO9Pfm9YeQSSDN7UJbqfcmOCZvbw=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr5972248ooi.85.1594754627867; 
 Tue, 14 Jul 2020 12:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200713143306.311143-1-kwolf@redhat.com>
In-Reply-To: <20200713143306.311143-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 20:23:36 +0100
Message-ID: <CAFEAcA8Z8cdm1qqWkbbMqTyVJOEQ2E6VHxMZ_EmSQiW6b4=G1w@mail.gmail.com>
Subject: Re: [PULL v3] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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

On Mon, 13 Jul 2020 at 15:33, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 6c87d9f311dba0641bdc2df556056938a8bf2a12:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/chardev-pull-request' into staging (2020-07-13 09:34:24 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7637b225a8d59a3b9b0e31bbc4eb8a0788792ac5:
>
>   block: Avoid stale pointer dereference in blk_get_aio_context() (2020-07-13 15:57:13 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Mitigate file fragmentation with extent size hints
> - Tighten qemu-img rules on missing backing format
> - qemu-img map: Don't limit block status request size
> - Fix crash with virtio-scsi and iothreads
>

Applied (fixed version), thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

