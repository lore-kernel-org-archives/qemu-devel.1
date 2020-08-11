Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E95C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2244020756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvg5Mm05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2244020756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WZ9-0003Mn-CQ
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k5WY9-0002Oe-Ka; Tue, 11 Aug 2020 11:50:53 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:35001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k5WY8-00050m-1p; Tue, 11 Aug 2020 11:50:53 -0400
Received: by mail-ot1-x331.google.com with SMTP id 93so10500697otx.2;
 Tue, 11 Aug 2020 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ohQrBHzB1KYDgr6Zj+iEzXWbCc2Pu3vfCbm+CWxzNxc=;
 b=pvg5Mm053WLNnfyjbbG5SvL/8WwhNFVFhYZ5Own2UWuHsxLIqKgA3SimEhz7a4Munm
 /rM5XQDSgztnFLTgWr/Uh+D8dzFLI3nlgeaUsxNfQ1+WPjORd2ZbpYjumo0AL8H4j4KX
 SBPKPXwqvUgW6yrCE5BdGfEaMXEvGf/5dQf9BRZxTsWfNnWEKXiUMUbYsIZjPOTLGKCc
 vnFgaJsStc00c4QZewq3vJ3tSon0OysLzqDZioZ2MZcVDG0S2ZUqvuSsoCFDyQpjx1QM
 ay2VtVLPSSwp1fyILBxY6GWpG74z+5IKAi+efED9IVIsWNrNGWcFpzj97vgqm8Yjg+x+
 7qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ohQrBHzB1KYDgr6Zj+iEzXWbCc2Pu3vfCbm+CWxzNxc=;
 b=MuMf6hYnuPDxEdp8At3fPdeCVZjXEIhcvU4GQ2G/w153N9kE1ULTBEH9yZai03mopi
 4vwBdY2OSGZ5StvUW8g7KnIFcY/U1zdgp3OEyfm8M6QSe61E3VkpJHZnRD32rVz/GwYs
 Wjaqom4p2M2+5en2hTtr8PMLbKnODhlBQoUBIkaQYSKmRNkO0tyg0KEn62FUFekDAeV4
 HfwNEBcH5iJUOmwJZ8N7QjLUt1FdONpZAU8D+I/66o4PIE2pyiLsU6Szw4fj73bsYaYX
 ugdRfR+6xLGUanGcOIDXvBdbPsncqA9+KMA/zxPzdygvJJiLA/jNv7+PhbzTiBQQP/xF
 VVSA==
X-Gm-Message-State: AOAM531yXzRHIOXWPsLyedqt6ttD0T00iQueWpxxte2SQvdeXiYjfDAc
 cCGNhN3vpDlrkVlqPwo6j18pbp+UXYkdc+zynNg=
X-Google-Smtp-Source: ABdhPJzs+d+G01JSqYlYvnh14B3zLV+fWjwPILg7Y74WWFnV4knpnRaZV81J+z5CtDG/oJgS/A7jlztxQCQcpvXVv54=
X-Received: by 2002:a05:6830:796:: with SMTP id
 w22mr5138726ots.353.1597161050414; 
 Tue, 11 Aug 2020 08:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200811151643.21293-1-philmd@redhat.com>
In-Reply-To: <20200811151643.21293-1-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 11 Aug 2020 23:50:14 +0800
Message-ID: <CAKXe6SJWVNgUnfpR8ZATwmeEC5Mt-o+m_T07GD=FLo0=xjkHxA@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 0/3] trivial: Remove 'and and' in descriptions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=
=9C=8811=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8811:17=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Remove duplicated 'and' in comments.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/i2c: Fix typo in description
>   util/qemu-timer: Fix typo in description
>   util/vfio-helpers: Fix typo in description
>

For this series:

Reviewed-by: Li Qiang <liq3ea@gmail.com>

>  include/hw/i2c/i2c.h | 2 +-
>  util/qemu-timer.c    | 2 +-
>  util/vfio-helpers.c  | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.21.3
>
>

