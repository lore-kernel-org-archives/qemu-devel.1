Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C904C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BB2206B7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BB2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk1Rj-0004VR-JW
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 04:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jk1Ql-00044Z-CG
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 04:22:23 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38090)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lwhsu.freebsd@gmail.com>)
 id 1jk1Qh-0001kj-7I
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 04:22:23 -0400
Received: by mail-yb1-f195.google.com with SMTP id r18so6167124ybl.5
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 01:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uh08MthlBEsJc2QaJKZ43ph3nvdh2hUlNtIMRQiZ9vA=;
 b=rZtbe9fYLzxoEeDr/dbU/i0liz9edbaj9sZBITXb+aBiCXYnna7JWdfLjLsj6XG5ZI
 6HJ+Q0uy5RPWRDye48a1X4jy/zuRsBJBn2U039HfZKQmloWnzb5/emmaJI7H9u+ikygi
 +1ecz5JOQtAOm6nusalAKBkAjgA/dKmgRJIhRsCHgt8EIcdXtnKI6mkQYSxDb5+wsDnl
 8WKeTUCNdP9EpCcgpc0BPxZvWLL05tN3QVbZNT5VC1co2vRd71PWkCA4dYe765oCsn00
 hFCYRjkx3XEW9BET2ErqLiLttxi2hy5pmG/b2HWp9LRpCP9luXxz8xWo6AS+hw1xoJus
 N4ZQ==
X-Gm-Message-State: AOAM530Y1471D3jhIkEmy97GvLJF99Yeed84/e3WUkxD9aHaxmr94xz1
 fFXrVE+KfO6xEdz5TVl6Gp1HpdQw9clFvLeisMk=
X-Google-Smtp-Source: ABdhPJwd5Uz2Djmrwi1plqIqY4HwL9e1On7FMuBjTYx5YwVxps901MjhNYItnSt84Ag4u+9o6x7G7HM6q/H8yGSS19o=
X-Received: by 2002:a25:aa70:: with SMTP id
 s103mr29072112ybi.492.1592036533027; 
 Sat, 13 Jun 2020 01:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200612190237.30436-1-alex.bennee@linaro.org>
 <20200612190237.30436-19-alex.bennee@linaro.org>
In-Reply-To: <20200612190237.30436-19-alex.bennee@linaro.org>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Sat, 13 Jun 2020 16:22:01 +0800
Message-ID: <CAKBkRUxVFTEiT3_ieYwZb8kGCOwH0BF2=A+ceMaRe6O-ts3X1A@mail.gmail.com>
Subject: Re: [PATCH v1 18/18] cirrus.yml: serialise make check
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.219.195;
 envelope-from=lwhsu.freebsd@gmail.com; helo=mail-yb1-f195.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 04:22:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, cota@braap.org,
 Ed Maste <emaste@freebsd.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 13, 2020 at 3:08 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> We do this on our other platforms to make it easier to see what has
> broken.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Li-Wen Hsu <lwhsu@FreeBSD.org>

> ---
>  .cirrus.yml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index ce7850a320e..69342ae031b 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -14,7 +14,7 @@ freebsd_12_task:
>      - cd build
>      - ../configure || { cat config.log; exit 1; }
>      - gmake -j8
> -    - gmake -j8 V=3D1 check
> +    - gmake V=3D1 check
>
>  macos_task:
>    osx_instance:
> @@ -26,7 +26,7 @@ macos_task:
>      - cd build
>      - ../configure --python=3D/usr/local/bin/python3 || { cat config.log=
; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> -    - gmake check -j$(sysctl -n hw.ncpu)
> +    - gmake check
>
>  macos_xcode_task:
>    osx_instance:
> @@ -39,4 +39,4 @@ macos_xcode_task:
>      - cd build
>      - ../configure --cc=3Dclang || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> -    - gmake check -j$(sysctl -n hw.ncpu)
> +    - gmake check
> --
> 2.20.1
>

