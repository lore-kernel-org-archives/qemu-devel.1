Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFDBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:07:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB55620656
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 11:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3TT+qkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB55620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmxh-0001bm-8N
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 07:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkmx2-00014i-49
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 07:06:52 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkmwy-0004BS-6m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 07:06:51 -0400
Received: by mail-oi1-x244.google.com with SMTP id i74so15536330oib.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t4jnwsfDh4rQUgMQ8ScaNHjXqaxBLjFZUQJluio1Pk8=;
 b=E3TT+qklclIkRzn9FsH1hqTIRuHGVitCx1WtrZfB3ulVSPeyCZUWeXlsTsIvP19V3a
 gocVZ1Zsg8iT75wR8SbfSPv09EOGMC0dkId8mbey7ONEKfYvuMzvxNvwBrm0j09fO801
 IU3Qem6COa7Es4ZscXPqN9zxkaIze1Xv0hjw0T8gbtbMwKsw+1a+Tc/fsvOuF2pr8yv7
 gu2TE74JXHFFwMLg6qXU5dgE0cahNb8tplZrln9kdAGGEM8sUpii48vFWArwYeOpJm+E
 V4nuVVDMStbvHd20ObvtHyXugvUNMD5MMEXFoSRThLgv1CAnJJ0qsvLzDlQRMQnsAwSo
 yiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t4jnwsfDh4rQUgMQ8ScaNHjXqaxBLjFZUQJluio1Pk8=;
 b=T3vQed0B6JqhZQX37GcV8eLrTXPUhW+TQzmbF37NZ9JSs7VS+60eMcQv2UKjjIGt+D
 pTqBRA7wVnsjRdTi5q1DAOTg4LDvtLd778j4L/qOKW4gxN+gI9X4EFcUdcJ3tPOGFKm8
 jSF/j5CLpiRzT33zP0gKZNJsrLN9ITQoR9dZpHI8MLkYEny8TGBjzA71jTnpSSAh3IY1
 0dFIv/Fd1nC+HMLWq9fNsqrV2mALY/25n6sAbTwpKjaqArTXcODpdESGxFJ4bNLkj86T
 diEUS7+TqkR9hOdbbcmmDJAZibdESrc7IDG/0nZbZl5i4rr096VdXLksDYBamSw84uGi
 /mMQ==
X-Gm-Message-State: AOAM532uZF98Y6XV80eGZ12j5XW1gjeGYiR5qRCxfj+4O41Qwd5ekkto
 sBwnO4c4RtWK/dymikRrESmpVLYT0+WfjtNr2GLC7g==
X-Google-Smtp-Source: ABdhPJzFKqKhYNghYN+iMhagwhFX4c2ofNyen5T/OGdgD/7Cnq9JINvKuh+wJuh23C5vBzvyX9sbLRuHpwVz/5fOU+g=
X-Received: by 2002:aca:5152:: with SMTP id f79mr8121333oib.146.1592219207018; 
 Mon, 15 Jun 2020 04:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200608133508.550046-1-jcd@tribudubois.net>
In-Reply-To: <20200608133508.550046-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 12:06:35 +0100
Message-ID: <CAFEAcA-q3jzqXvm5_bkBH_Yhbf_aeaiu_PXHeCD3iD5S0bpg=A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/imx6ul_ccm: Implement non writable bits in CCM
 registers
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 14:35, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> Some bits of the CCM registers are non writable.
>
> This was left undone in the initial commit (all bits of registers were
> writable).
>
> This patch adds the required code to protect the non writable bits.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>
>  v2: simplify code after feedback on the first patch.



Applied to target-arm.next, thanks.

-- PMM

