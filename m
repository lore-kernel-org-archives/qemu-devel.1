Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78610C388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF3920735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+DE5Ufx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF3920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6c2-0007fA-PD
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb6Zs-00065E-9s
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:35:12 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb6Zq-00067K-GF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:35:11 -0500
Received: by mail-ej1-x644.google.com with SMTP id o23so3254178ejn.11
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 10:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bid9L2l71ryAEZrdck7fYPssKawT3LRygbcGiQgqTdw=;
 b=H+DE5UfxGLXPLcfrHbbthqYLsKAs+BLtCP60VdXrD0EriQlhAYZMxAQ7me78jdvrxi
 8ZO3pbKLWzLopI1DQPUWU/sA9hqvYy98GL4+pBBn2Yj2d+zR4wSLyPKB6tKAL8G1Z+VD
 OgBzWiSYsCAfYIyFnMxEMZMXbsqBcFQwj1PGEm18BWwkUZpbnNDq2zfCU5CAZRySGd/R
 7GmKJD7EW5SVP1XJWav4EwTO727NQDjXko3HErxSJEiTk3gS+FK70YFWB1eTkSzRexWA
 aA5p9LiuAz5ZMIW7zPmI4aNG93CsxiD2SXbtbPPH2PWYq3LC+eOYVbx+VLg9FICSr3kI
 lNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bid9L2l71ryAEZrdck7fYPssKawT3LRygbcGiQgqTdw=;
 b=XaCKYHiW5qeLzKmPOpRm0buqeYuCTBUU3wNzTfUs0VWL8sOzXLlsBch3yM5/28AAKD
 h8/cBbIJ4fUVqTfmkobWTTGj6dziUJSaXgeNo5u4Rped8fbRZvINPFSiIkamB7j3nGoN
 okg5JQMFg3FViHzA/wnMCgYJ5DWp9H1dRRw92/SESCP6bs+TQkhGJxkYuoEBXI6xAfjr
 if51xBzs4oWoX943W5GGNyLEfIyeTQvUSDLE6i3XVkBYs5SC7xTpkIBPjrkfQi7DAgwq
 2cGNystoD1jbmcGTGJGmsniue9zA2bkdyL+zvd42xudGj/YZUC02Exy7p0psaKktqzAJ
 oeeg==
X-Gm-Message-State: AOAM532HvWY+SlG1lQYlKvJPuutBDW6FH2Fha2UDoWneSbOiwXW3ZfsL
 VmWx4DtTDWxhiYkUfO868yKaIHFXhRyRmZlGur9qNg==
X-Google-Smtp-Source: ABdhPJwpMi/rCjocBakhDNXQk6b5P0ab5SuZvaAMvnGdTGtuk7EXAvNBX/ouYoom4h8V2gkiCYYG5oZa7Cu91l1cBvs=
X-Received: by 2002:a17:906:6949:: with SMTP id
 c9mr3390785ejs.482.1604687708752; 
 Fri, 06 Nov 2020 10:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20201106171153.32673-1-peter.maydell@linaro.org>
 <20201106171153.32673-5-peter.maydell@linaro.org>
 <202011061918.33313.pisa@cmp.felk.cvut.cz>
In-Reply-To: <202011061918.33313.pisa@cmp.felk.cvut.cz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 18:34:57 +0000
Message-ID: <CAFEAcA-Q9AgjBN4e+zRWyehKZrcwEX0Ojsn7i99ezz_9BeRDbQ@mail.gmail.com>
Subject: Re: [PATCH for-5.2 4/4] hw/net/ctucan_core: Use stl_le_p to write to
 tx_buffers
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 18:19, Pavel Pisa <pisa@cmp.felk.cvut.cz> wrote:
> On Friday 06 of November 2020 18:11:53 Peter Maydell wrote:
> > Instead of casting an address within a uint8_t array to a
> > uint32_t*, use stl_le_p(). This handles possibly misaligned
> > addresses which would otherwise crash on some hosts.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---

> even that I do not like stl_le_p name, because it differs from the Linux
> kernel one. cpu_to_le32 matches. The pointer variant is cpu_to_le32p
> on Linux kernel side, I think. stl is strange name and l for long
> is problematic as well, if it is st32_le_p or st_le32_p I would recognize
> that much easier.

QEMU is not the kernel. We have our own naming conventions
and our own APIs. I agree that the b/w/l/q suffixing
is less intuitive than 8/16/32/64, but we have a lot of
functions using that convention, and the API is what it is.

thanks
-- PMM

