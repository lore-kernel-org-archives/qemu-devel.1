Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993ABC54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BEC20720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZMMrgaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BEC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5MC-0007hb-I3
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5LL-0006gA-2V
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:07:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5LJ-0007Ju-Ph
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:07:26 -0400
Received: by mail-ot1-x341.google.com with SMTP id c3so7051207otp.8
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8EjRi9ySL3Tz0yDS6ccI0RxNhDmzKn+FWgwK4HEIf9U=;
 b=KZMMrgajFRAtqwFkgOUPwJ2UPbvldwdR7502nB4bc1rJYMAkTL182rphT7a2lphQuO
 csRzavTy52wk71T45fxxkrj8HnEy5C+USrXYxRCad+weNhmSw+NGuanWfkj1vB8lK93i
 0V4/DN1HQflWytq17bKL9cj6RpdRPpWX2+UFYbivi8gtAxZZdEqC25sSz6yEadj0QBgI
 yMgmhvzGg/CIRZIQtg6UC2eG6sqd9FSZn012if3iuYgWCR0Xi1l63glSDxotPgYOzLxf
 AcBDXBvCkZDdm7Nh3RelFXSMTyL/cN0YYTdKfT+JywCuz1S2/plmA/VkR6pBxXWlX8aJ
 uXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8EjRi9ySL3Tz0yDS6ccI0RxNhDmzKn+FWgwK4HEIf9U=;
 b=rSJrgNZ41o6WI46bBHMLbVyUc4+hrBg7XN57lSMlq0Zx76imxaUrgLmKStEAKSWnBy
 oEzHqu96V6hViOuVZjZiL1yNo8P+2zXHWmTwHZt0HL/0YqeOdxLRdMr1MAZBwwQZGtgl
 CefLx5BH6Z/T+VTHeWChcb8VywDYeKdZmUZsn7z8fD7tw2qmy5rrqrDk+uKMj9FW+RYB
 Rokl6RXRQVNqHMap1Hm0lbFSDkkzALuNBg2nkkn+QUTujbqUVA33qWUlE1Cvi68R+LjX
 fo718IwATSwWahOstqPm08olMyjMUoW242RlqTIOv6pwP3XW8TAu5u7OVLSNVC01G0Ph
 NR2A==
X-Gm-Message-State: AGi0PuYB+OBWCNwNGxNTLOFJ5rFouWtJ+8uEgkZd7+NpJlHDJUTI4N9z
 SCGiJ6G1g6Bl9Qt9eSquhCwFVtQiCMLNOpfNH6cepA==
X-Google-Smtp-Source: APiQypKTrNCdxD2pDmydAibY8twANvZMBEA5OU6jArtd0+2+Ch4B3a8WmVRWPv8gLubpnu5/MBFEhSyM64HOa89iWsM=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr11409938otc.221.1589191644455; 
 Mon, 11 May 2020 03:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200508204716.1279160-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200508204716.1279160-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:07:13 +0100
Message-ID: <CAFEAcA-dARnN7pqm5BGPZK20ho8Gj6U3jzgt4cRwNn9Gq3+Kig@mail.gmail.com>
Subject: Re: [PULL v2 0/1] Merge tpm 2020/05/08 v2
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 21:47, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This PR submits a fix that changes improperly used 'FALSE' to 'false'.
>
> The following changes since commit c88f1ffc19e38008a1c33ae039482a860aa7418c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-05-08 14:29:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-05-08-1
>
> for you to fetch changes up to 441adbb4540423c90e4628a3c553e61d38445d73:
>
>   hw/tpm: fix usage of bool in tpm-tis.c (2020-05-08 16:40:45 -0400)
>
> ----------------------------------------------------------------
> Jafar Abdi (1):
>       hw/tpm: fix usage of bool in tpm-tis.c
>
>  hw/tpm/tpm_tis_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Hi; the commit in this pull request is missing your signed-off-by
as the submaintainer; could you fix that and resend it, please?

thanks
-- PMM

