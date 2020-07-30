Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CA1C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:16:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2550120809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 10:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUSocNh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2550120809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k15cF-0000Lu-Dv
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 06:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15as-0007sF-3E; Thu, 30 Jul 2020 06:15:22 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k15ap-0003hm-VE; Thu, 30 Jul 2020 06:15:21 -0400
Received: by mail-ot1-x341.google.com with SMTP id k12so2863704otr.1;
 Thu, 30 Jul 2020 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DrqfWvmGKVXcbnWZjSh3Qz3I25VOsJ/JHkPoIG0SwyY=;
 b=aUSocNh3VLh08XCvVjK0YAmcL1RgyT49BM0Hk6EnZIYEtbdP7ANO/JR7ipX5bFzah0
 LnN09Y1sxKLgZ4HtoLyNXUUnMa5fM1nsbbgpNB1hgQwd9kQqh+hDsQq8iYJyiEDAF9tc
 SDhITKQZ6HLtIpHxB3VKpqbWdT9CCRy3qTrXCSd2u+JrPgILfw5nFBF98rXpynHNAT7l
 AmMsVFztiydGT4plukQ2gWxF+aQCx7OqLdJum3ZtcmibPziKI+HpH9jfqhbMwFaU9skB
 9d1dvSz84y0LB3YW5r90GZ/qYVbaVW2AZWd1DaF8sL8P43P7ahJoEo5/ezQjAVGRgORY
 ul2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DrqfWvmGKVXcbnWZjSh3Qz3I25VOsJ/JHkPoIG0SwyY=;
 b=ciemeQDDIvZHA34MzvWihHm0nbAhzLM1hMOEbEU3YBx8aJA9koOf56ZsnXWZ9TzVsq
 oEF49/fgPVAz0E5O6JcdjBFmWMANs73yQTRm9bHVj1B1uf1m46QLz0qNtP/3q/Ifw7l3
 FqslX+oHBLs495TkCXXdMRpqH85BUF/TGG6dBuhTyWa5cCB2sQAvp1+vH5c2gJTH51pA
 APBvGH8fZG304mmNeU+81SVIoB9ApSFf2CwwLzyOtqCxBUBXeWLGlCVnSgtk04q5P84u
 uKfX16cdrsvxMLAiad1Nh4k1NSwFWTkpfA+GrMR/oVZZCEPlwRgCaJYyI6ETrXYCV46q
 advA==
X-Gm-Message-State: AOAM531pClkxKplxdgwmPFfA4+h0K+XUynEr1o+eRlpfx4sKslZWE/JR
 J7NTMGHsyystbNdAwWP2cTl+IVEGUZeOJFvPrmV65BHc
X-Google-Smtp-Source: ABdhPJzEtNTNbHcIkx4kuB+SYTg4UUNjFEESgs8YIQrsqPDQ91PgIYMeI9GMwKw0G5ALBWuYkrZ09Xj+DUYbixVU/hk=
X-Received: by 2002:a9d:4b0c:: with SMTP id q12mr1637262otf.253.1596104118212; 
 Thu, 30 Jul 2020 03:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200729220638.344477-1-its@irrelevant.dk>
 <20200729220638.344477-5-its@irrelevant.dk>
In-Reply-To: <20200729220638.344477-5-its@irrelevant.dk>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Thu, 30 Jul 2020 19:15:07 +0900
Message-ID: <CAA7jztcEv7LYrRVogLK6iEqfp4kVHM1KnDr4TOPjT070iZJLug@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] hw/block/nvme: remove redundant has_sg member
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 7:06 AM Klaus Jensen <its@irrelevant.dk> wrote:
>
> From: Klaus Jensen <k.jensen@samsung.com>
>
> Remove the has_sg member from NvmeRequest since it's redundant.
>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Looks better than the previous one to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

