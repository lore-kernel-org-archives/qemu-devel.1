Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5007C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB9C20857
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cavXmDQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB9C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUfj-0007K7-SV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUei-0006Mc-97
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:23:16 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joUef-00017C-MF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:23:15 -0400
Received: by mail-ot1-x341.google.com with SMTP id 18so5803605otv.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DN3lh1Nr5zE2u96hqaFCeUHGFa9MMJvRTP2Dbvmd3MI=;
 b=cavXmDQc1A8O/67PSIcZcG9pz2tskwPMxHhWknV95OFRMoU7xgbtza+behLZlLje3X
 E85SVtPKEjwvzplZiX6hiLyj+upZrxnjoKD1y34Vi4EW/PGg8LKyEnotgkEBTukBwL/8
 EYdZ7uC2uqBGxquOnWGVxRHNLnZOmnFiAQK/76z1P5m8156orOEHnA/I3ZJRvJ7/Qp2+
 YOJbDvKRl/f8HAtwBD+d/xpUmpzvlEyEMkfi6sKB8BqCkF9z0EpZtpbyefX55qcF23jk
 XSWOeGTFhgW5sVzyh5R4Wcy5/h14CB3NambROOgDjmb4rFDiiTduYegaewvTsSAkL4OP
 0+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DN3lh1Nr5zE2u96hqaFCeUHGFa9MMJvRTP2Dbvmd3MI=;
 b=t0ntHQ1sWkbBypv3nnUxJC7rpSg+NiYNRFZbd/Y7zGOukH0KBDoZsGBnWdqOTDHf5Q
 L24fKQcJHzC7/+rSfj6Zeh/Y6vdeV1X1wf5+M6oHVKR8VZPSS0FrjmgWI72FsMXCzyQk
 BQKIyffk0PlKszzSE2OzbEmRZZ9fL8KG/K8E9pTaVaCF/mjou9T1cLxBg5Kdl/PdoTNQ
 dI78B3NDaH5tixXIQUwZ9GQBU/3vV3AVvYYKJH75H3lx7kvCR1jRHDh8NZYXht8+7TcT
 avbFnAR/60KMkxNQrSiZxTKxWHk0334pxsMnfglGlCQiJyuVcgpceHDVqagg7rg07oA4
 JMGQ==
X-Gm-Message-State: AOAM530K2pvmOjDJcO89VI5dAu6kSss0uTF747/N9nsOFPsc+kFxitpk
 fkz+FLRJubBFBByRkJZXXFjQAmBN0EaLs7r+9663QQ==
X-Google-Smtp-Source: ABdhPJyUezd2AxQWh/6FCvMQwMO5mNe1MjRomz65y80+0wDALnYyOfag8/ikh5HlzfdjThMGGRDbBatxoWPJF17KdiQ=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr26272838otn.221.1593102192270; 
 Thu, 25 Jun 2020 09:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
 <20200605041733.415188-3-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 17:23:01 +0100
Message-ID: <CAFEAcA-Pd0EAQJOUQgB1nO1G1V5W-8yynffVVuO0vdSgNxhuag@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] linux-user: Introduce PAGE_ANON
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Record whether the backing page is anonymous, or if it has file
> backing.  This will allow us to get close to the Linux AArch64
> ABI for MTE, which allows tag memory only on ram-backed VMAs.
>
> The real ABI allows tag memory on files, when those files are
> on ram-backed filesystems, such as tmpfs.  We will not be able
> to implement that in QEMU linux-user.
>
> Thankfully, anonymous memory for malloc arenas is the primary
> consumer of this feature, so this restricted version should
> still be of use.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

