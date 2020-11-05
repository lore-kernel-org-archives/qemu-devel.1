Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DE1C56201
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEAC20729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 08:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEAC20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebsd.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaafB-0004eZ-Ig
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 03:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu@freebsd.org>) id 1kaae8-00046a-At
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 03:29:28 -0500
Received: from mx2.freebsd.org ([2610:1c1:1:606c::19:2]:44437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lwhsu@freebsd.org>) id 1kaae5-0002pU-Kw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 03:29:28 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits)
 client-signature RSA-PSS (4096 bits)) (Client CN "mx1.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx2.freebsd.org (Postfix) with ESMTPS id BC41299669
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 08:29:22 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
 client-signature RSA-PSS (4096 bits) client-digest SHA256)
 (Client CN "smtp.freebsd.org",
 Issuer "Let's Encrypt Authority X3" (verified OK))
 by mx1.freebsd.org (Postfix) with ESMTPS id 4CRcBV4ZHZz4N6Y
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 08:29:22 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com
 [209.85.219.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "GTS CA 1O1" (verified OK))
 (Authenticated sender: lwhsu/mail)
 by smtp.freebsd.org (Postfix) with ESMTPSA id 8A9D71E8C0
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 08:29:22 +0000 (UTC)
 (envelope-from lwhsu@freebsd.org)
Received: by mail-yb1-f182.google.com with SMTP id h196so636697ybg.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 00:29:22 -0800 (PST)
X-Gm-Message-State: AOAM531Ez7ruEMfcukYXVGiiWJjprFp4qFswaK0IMAkTjUJChlqJ20LK
 aC+00nzJkaNERzEQW338WOwSuj15vYH3tr/4yIc=
X-Google-Smtp-Source: ABdhPJzDEJpQe4CodqyR643QcpW6PTOxqmvoHJ/0pouV8sVBH4m7NRZU+689s1q+NC4iqvbe70kQ0Fu/cliQgfe/mdM=
X-Received: by 2002:a25:6892:: with SMTP id d140mr2022375ybc.492.1604564962076; 
 Thu, 05 Nov 2020 00:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20201104002821.49600-1-bofh@freebsd.org>
In-Reply-To: <20201104002821.49600-1-bofh@freebsd.org>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Thu, 5 Nov 2020 16:29:10 +0800
X-Gmail-Original-Message-ID: <CAKBkRUxgEva6YX8h8FMfbdbZWbmyuHgRTWjdP2kq1Qe_h04wEg@mail.gmail.com>
Message-ID: <CAKBkRUxgEva6YX8h8FMfbdbZWbmyuHgRTWjdP2kq1Qe_h04wEg@mail.gmail.com>
Subject: Re: [PATCH] As FreeBSD ports MAINTAINER add myself for FreeBSD Hosted
 CI
To: Muhammad Moinur Rahman <bofh@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2610:1c1:1:606c::19:2;
 envelope-from=lwhsu@freebsd.org; helo=mx2.freebsd.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 4, 2020 at 8:29 AM Muhammad Moinur Rahman <bofh@freebsd.org> wrote:
>
> Signed-off-by: Muhammad Moinur Rahman <bofh@freebsd.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd16606bcd..89d6269888 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3137,6 +3137,7 @@ W: https://app.shippable.com/github/qemu/qemu
>  W: http://patchew.org/QEMU/
>
>  FreeBSD Hosted Continuous Integration
> +M: Muhammad Moinur Rahman <bofh@freebsd.org>
>  M: Ed Maste <emaste@freebsd.org>
>  M: Li-Wen Hsu <lwhsu@freebsd.org>
>  S: Maintained
> --
> 2.24.3 (Apple Git-128)

Reviewed-by: Li-Wen Hsu <lwhsu@FreeBSD.org>

