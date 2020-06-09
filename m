Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80522C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430202063A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cw9Trb18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430202063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiajD-00021N-Fm
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiaia-0001To-Jh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:38:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiaiZ-00036H-Lm
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:38:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id b18so16092127oti.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 02:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uceSILUB8eUj+wn7zNiyYInUIlWMYM8o2B3VNA8F+Cg=;
 b=Cw9Trb18SyrQAYmO6fk7kKcKu23/uVpD7j8mNuCsaeyab2RtrpflZbJHPXR9t1Ptn7
 VB/iOqC8D5BZchLjmbLm8n/cs0FzWixzFh9fjlJm7LEUkDdQQA6A258jE61eqpwSfhF4
 RzjwyUjChQh4EBsRnRfkdQdNyQfjEzEETa5pVrsci+ybonSX6fPRvGyKcCzNkd8mKSvr
 4zywtvg7+1zorkGbfj+KRQ3yvUJkuikyFTP2MNv63xaSjWyrR2jccGvTgVdhUqFYhrcC
 rWQ+oUbfS6/ejWbnUtjHilABrC0OYMvZG6XHAHCSM3/ou6cAPIeBDIbNYUN3eprZc41Y
 Wl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uceSILUB8eUj+wn7zNiyYInUIlWMYM8o2B3VNA8F+Cg=;
 b=obsmJC53vWQ/OuxsM4MpUVIQ5oRX+XFmhZnenuT+3qBjF5NH2OwqlxaxABok6/ql2D
 tL9Cu1N616cwvT2Wb37DPNjrLKZFadaXHJ3gc6TbFeYzotxnz/KsH55iAa/NkvnLbXFC
 Sh+ThdGpmK1qIeQR91bsUHsxFP2BSu7+TVXkINMWCXJBQzwZfexKVaKHnqU9ITxi+kBp
 Bxlf2jECZQ6ZBnFERvjA9YdAQbAYX4JVVka0hX4q6JnPIcueiEH1BOYICy1EOtczndEy
 ViKJvxk2ssKzwtoXAXFJeETUXSRTze52zj5DcntDbVE/rmYftiNLzRgLt6ulomnWgf20
 Egzg==
X-Gm-Message-State: AOAM5318iD1iL8e7/ZordmxN/2PbE2bXR12CVvRWpr2MTXvmPIUHtMdC
 qqJqpwVfBlLWKx2t3LVcD+elxBcm50ECFpRzwrgYkQ==
X-Google-Smtp-Source: ABdhPJzAGQ4NO3qVaClZ1uhYknDp/l/yWe9Q0asJLC6fy8IrT5lZKJItUxE3UTmeuBjd2lLoJ0/LF7Lr35o/sQ9ih0Y=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr8281704otn.221.1591695530172; 
 Tue, 09 Jun 2020 02:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <CAFQmdRYYhoWu7q350n0vNOE+pesp-UG975v1f1Yjwf9Ao0mjcg@mail.gmail.com>
 <60521645-6e85-cc59-7048-94db9634ad0a@kaod.org>
In-Reply-To: <60521645-6e85-cc59-7048-94db9634ad0a@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2020 10:38:39 +0100
Message-ID: <CAFEAcA9ph6R1wmPps9BZ1aBvaiJ67AEVWN_URuYTKVCfCg1f5A@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 URIBL_SBL=1.623, URIBL_SBL_A=0.1 autolearn=_AUTOLEARN
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
Cc: CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 9 Jun 2020 at 08:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The first series was nicely presented I think, but you can extend it in v=
2.
> Documentation needs an update in :
>
>   docs/system/target-arm.rst

To expand on that: the new boards should have at least some basic
documentation in a new docs/system/arm/something.rst (we have
one .rst file usually for each "family" of boards which are
similar enough to make sense to document as a group), which is
added to the toctree in target-arm.rst (note that it is supposed
to be kept in alpha-order-of-document-title-text). aspeed.rst should
give an idea of what ought to be documented: a basic summary of
what the machine is, what is supported, what is not implemented,
any machine options that the board has, that sort of thing.

thanks
-- PMM

