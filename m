Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6AEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798A6207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdCwDsCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798A6207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw4Yi-0008KO-O7
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw4Y0-0007U2-QL
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:07:40 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw4Xz-0002Fa-3B
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:07:40 -0400
Received: by mail-ot1-x344.google.com with SMTP id g37so4262223otb.9
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=meBHaDeM21zC9TdihiN42IiCDadZaFUBqZTAt7ipv2I=;
 b=MdCwDsCJzTWfLpJbtLQlCbtKRQ9S586gBDBEuU1pSn2ujP/fXK1Ge8yMAlt3sZc3Ks
 G7hms1wRzaRbC8GlNGawrCOTmzEDDWiIwgSTQ3A+BkFMzQfWl6md5dKra/0NbGADMzTL
 eFUAVXZq/VsQ5fjXRXYqhUiP+pjbcUtUdJgudJ6MG/PwNQRByaZN3bcQxqJVTWfvzCoQ
 r80xBFdLwxFr9op9nJd/xeIbLfLcrCs9P9Npq88DmSQy+Yya+5/SHP5fl7LGJJQIYup8
 m4f8mkPkwLrNYNNN76EKpr5FwrSQQDn7xY2NKWTM7bsO0qrKZGOrQWx8iNA+ihjE0vvT
 hBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=meBHaDeM21zC9TdihiN42IiCDadZaFUBqZTAt7ipv2I=;
 b=ht8ROXFFpbXaFo2SMA2QFACEibfpieIF2MwgrF2BY9ctXNcK/7WjICZR6p+BVEJcFI
 4bXXc08JXfJYUgGukifmkFqEvOEbSwd1ArfvvnvH9FPUFLOuV/Hr7inXmzvnv/2O8yGV
 hQBwRRm56hp55QHQgdV/ZTj8k1sHloHpbqKHCpqHq7gYbF1+h9+9vw3+/LGwvPJuf53x
 IkNrO+5zGq6XCLdLt7Y5UvNxY9EL93/pmqOszr6YbKzG8FdQtL0+Zorguj+2toGM8+J0
 W4u4K1nxVbPRKWwFOP1i6NF5lbIQ/Fe+ijO2Fk6XmcM4ZSpjkszn7kqCRZEzaP+vb0mm
 QFDA==
X-Gm-Message-State: AOAM532ZKyfsc/d/sTmQeTXf2DV1ZA2cxDJLtg92ZTvKPOVwObAeCrGs
 f1vNyAVxwNHOpw8WLfCSAg8onpxcnGZZ767cM3f1Gg==
X-Google-Smtp-Source: ABdhPJzDn6jFBVhcGwuvCWMfGsDzzhv6d9+VbKZ36AitaKnQkhQb3a9K2osDQxBeH0585SUzjP8Tj4qpeD9s3dJgrlY=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr4727217oto.135.1594908457624; 
 Thu, 16 Jul 2020 07:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200715173418.186-1-erik.lucas.smit@gmail.com>
 <b3c8ef39-5a1e-c49d-6ab8-342f42be088c@kaod.org>
In-Reply-To: <b3c8ef39-5a1e-c49d-6ab8-342f42be088c@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 15:07:26 +0100
Message-ID: <CAFEAcA9H633W4eDsXJ40o0pAje6t103MaKjkaSqrW2BHLmaP7Q@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/aspeed: Add board model for Supermicro X11 BMC
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Andrew Jeffery <andrew@aj.id.au>, erik-smit <erik.lucas.smit@gmail.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 07:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/15/20 7:34 PM, erik-smit wrote:
> > Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks; I've put this in my list of patches to put in
via target-arm.next once 5.1 is released. If I seem to
have forgotten about it please ping me once 5.1 is out.

thanks
-- PMM

