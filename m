Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8902080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWFm63NK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8902080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlalg-0003xj-O8
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlakV-0002l9-2p
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:17:15 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlakT-0001Dh-70
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:17:14 -0400
Received: by mail-lj1-x241.google.com with SMTP id z9so3542653ljh.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JlAv11C1KjfHQS1dNi/Keut44lKvJTdgD0Lm6nIw9ec=;
 b=HWFm63NKJi8A/WSLVSSH0ySEUt82FICt0lKHi/kehDStUTaENJZ1XhcAcOERGtoJ85
 WTxmCUexrotgwe/fVKWiu+EyUMLNPremBhfrEvsq28L+DgMjBB7OasbNxIEeFO1t+3mR
 +5w4ryRSp0TrVsJ43CvMQibPeDX6pb8yiyIRvLXHIspwyE1fWnFfZF+/fR40rPAxJtrn
 RvgxW2PmbrqgSkwuZYwHygrCgvZAa9y5neMNue4acfvIwSSbU3aazZcjJcBE6nooWl77
 yqCwziLJtwLD/RuPkkrOk3crDsLx3Be3jT8FSv+ecsbCEN386jk1D7ygOpmZfCEA9hq9
 ijdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JlAv11C1KjfHQS1dNi/Keut44lKvJTdgD0Lm6nIw9ec=;
 b=pHIkaVcWTg3FjNaJ3q+5kgCDZazAJD9NZJqfXtiexVQLrG+6uGvJe5NlZlM2vZadlE
 qQXKBrxjqY9GZTY7vZDsoKFG4fbLhcDpVxMe3uH6VTJ6QFXgriWejmH/F4qlBYWfiONg
 Gs990sxal5iPG+m0dSeutykmQfzSAOUwMboFyIx6+PYgsqXyFA+lyNstAI2TAwQ4xFEg
 U8RsSV1l8zzuJgdamxHEiLb0wRRODtF3V/DfxYwyhTo+uV7m4SX1fJX7OhAT6ohLTajU
 j9lKD0q54+Cm9KlXTgvu3Dn5c412aRh0widt3CD42waOqRukoiQSkbOVISzNM8ea4jdX
 ekeg==
X-Gm-Message-State: AOAM532V760Ut9hqwubyPk1uha1189HPVx9a6+4CWramDn2vtzI5X1zW
 kZRTmiVyZyHvz/WSQloR11IiLDlnlYXFcqAGgEA=
X-Google-Smtp-Source: ABdhPJwAc02pJJ4tRQyRa6YvrPDsRuEpPZUNYxWd4ttm5U+MRoYcc9f5DmsSqUC7SpJsZcsjclTuZsX/w6xn3KFS4r4=
X-Received: by 2002:a2e:9ad6:: with SMTP id p22mr18270ljj.3.1592410631639;
 Wed, 17 Jun 2020 09:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
 <1944be57-7253-c3d5-737c-16537e1e71ac@redhat.com>
In-Reply-To: <1944be57-7253-c3d5-737c-16537e1e71ac@redhat.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Wed, 17 Jun 2020 18:16:18 +0200
Message-ID: <CALTWKrVEKUDdwzsgS+eg2vwwu5Zz9NecnYA3ymWBim1AEafRVA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add Scripts for Finding Top 25 Executed Functions
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, ehabkost@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, crosa@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 3:53 PM Eric Blake <eblake@redhat.com> wrote:
> Are the new scripts supposed to have executable permissions, or are they
> always invoked as 'python path/to/script.py' where the executable bit is
> less important?
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
The execution permission will be added to the scripts in v2 of this
series. There will be no need to invoke them with Python when this is
done.

