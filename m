Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F07DC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070BD217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaXSAhSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070BD217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSPUY-0001yW-3H
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 12:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSPTK-0001WU-Pr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSPTJ-0006u1-ER
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:51:58 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:46182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSPTJ-0006s1-9m
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:51:57 -0500
Received: by mail-oi1-x22c.google.com with SMTP id n14so6072191oie.13
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 09:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NqEUsH2EcrZErMGMTxFXMXIeTn+clFhmzG0Xt1/EcjY=;
 b=EaXSAhSAAes7sm5ssS0zKqaQDbMzV96iTB+V3ocp2oYRqqvAyUBfmK/+qUhk0QtvYb
 tR2yGEIaUkjaILjpzKfcVytV65YPq8ICtqebNVwbURgfLtGLwksY5GeMCJYvAKjOlRIh
 N8BzQzYhngOF2sczdKtq+jmttH9LWxQCtKbzWmL2ERHgRhb53bIX/pgCcRNnMm47D7+0
 QavfuWFkijmxEppF/jD4VMpYF6Q8G4doXtO9n3IQzQJIjtH01DvSFbZIBZOL0RrKUH9b
 WbJIkRui14A3PtcxTgKZMUsKlsip6b47gxqpABA8sj+Be/4zBd9z2cB9MrT8LhrntcDA
 q3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NqEUsH2EcrZErMGMTxFXMXIeTn+clFhmzG0Xt1/EcjY=;
 b=dxNu14II9frT92wnlM6laWxdYC0A3/BjHLUCi/gh//IwfD5qjqFsN+p5kyggOze5TG
 c63SQ/NEJGaYCpsy/GEwvcu4nZznRHKr/GjuUA00DU31R+j5xi30EXJTzR48p+sRoCFl
 iRYqZyAnzcv3RSehtuJpOJKZP6fX+hluW9Y+2MxdWdkDOBB2cMQNUJ+nZAFzSwG/g9B2
 j9MLWP8JWNhiqWgJ7Lnzn+n5emlqYwUacc1re8IiK/9M8KhLktRTDnt6EPvFE75U1BY8
 VyluwA4wbME0PgxkyI0hAeqJel52ybRAudua4sDxIxYbjx0j5++N1/3x15920WRBrwgc
 wwrA==
X-Gm-Message-State: APjAAAVSUM5Q8ZIrZ3K7tJHD9hJzRgPtYyObN7btSRZJD1yTPtNSKUAf
 tqcpCpyGedzaP08lepLf15JHKhRaGT0q+WyQRh3KQA==
X-Google-Smtp-Source: APXvYqx/Q1LhxF3vSxGNq28Bb/vm3ODx1nnNWkVQ+CpMxQ/LVDzTXs+NFsEUyuSXuWOQzkDMMmm64UhjX5qg2I7oATM=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr3427570oij.163.1573062716286; 
 Wed, 06 Nov 2019 09:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20191105180637.26020-1-laurent@vivier.eu>
In-Reply-To: <20191105180637.26020-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 17:51:44 +0000
Message-ID: <CAFEAcA_BvknTAbdqS7X6gL3PKd56n_hAJ33_dwCJo1G-EJ8DYw@mail.gmail.com>
Subject: Re: [PULL 0/1] Q800 branch patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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

On Tue, 5 Nov 2019 at 18:07, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit b7c9a7f353c0e260519bf735ff0d4aa01e72784b:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-10-31 15:57:30 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/q800-branch-pull-request
>
> for you to fetch changes up to 653901ca2be30299a224677a8203ff3361dbd5c5:
>
>   q800: fix I/O memory map (2019-11-05 18:52:29 +0100)
>
> ----------------------------------------------------------------
> Fix q800 memory map
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

