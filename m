Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB614C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7242053B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMOB7tvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7242053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0St0-0006Lm-Rc
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SsP-0005fa-8J
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:54:53 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SsN-0007Sd-Ir
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:54:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id 93so5210795otx.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rvgQW8y+nT8Mh/D9mTLdWpBUDlUSQNoWmLDrVzDxVb8=;
 b=IMOB7tvfCBFOdNTnkTYmPH/qWCel5FVdcEBW8y0J5d53udc+GvutkK8HDhp9dKcQJ9
 d2gi6CearwlOHx2Q4N5OrkfLDsNEkX82t7ajGEhhUhJYxjVlucqh1htAxBU0TSTaztfX
 /Kw+m63MIcSJNvb4vRZUocijSfuE8Tkfs7JqibSOuTvBQPrISuPNgVyX5SErHsM8PyI5
 ei/uwjHBJyIzb7i476DpsWyyBTGu7eTImghAsaQUWGxtWTDAYeFqoOigR0hVWWScOS72
 1YNVv53OVwfj4EMWuzWIXmPCj30mX4TZy9e/PMAMgOkR/ZpsiDFaekzlQFm28adaCZ18
 m31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rvgQW8y+nT8Mh/D9mTLdWpBUDlUSQNoWmLDrVzDxVb8=;
 b=Un58hDlCDGrO0DcTTndCknRLYRD4b31f2utVVy68aJVbRIZ8irMTtVZcNiM09tfTxd
 /OzBJmuoTQUHPbDGgEnn/BBFw3+0dH6BaKlMEqul5anYgnc5VN0Z9JtsFlAQtVHRPbWr
 tWfGu3m/kDzR6eU0sOE7nZVGhguQbOiauZpdr8kqCAq5PCxc/THK/ztwoNjRht/Qcc0b
 misLINpm/oYT4G6TlO0sdBelrmzOk+gHI3jWxKtKP50sjmxfXXk+FpRbGBGbvinxE9SR
 gEbIrnmGmiMP0OK6Md5ODSi+dptRt48/m7ibl6+0FB6La+yab46kO6eHvo95/aoIdQOL
 sRQw==
X-Gm-Message-State: AOAM532Vrh/nMobIyxM4555RT0BrUoq2q/yyu4ShGE5nZTj8JjeEZgqH
 vA2uAsIK87LUyENs2Lzw5thQwo7wcjZi/RJcr+sehg==
X-Google-Smtp-Source: ABdhPJySQnfrgp7JDhlDtIZPdimC5YhGyP858GxfO8ebmjQAhk+SV8jeYjpKprnxXtqek2kSFxmWGyvWbvn9UALQfuY=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24030126otk.221.1595955289805; 
 Tue, 28 Jul 2020 09:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
 <20200728155052.GA389264@localhost.localdomain>
 <CAFEAcA99fVFKwc6ju1w=2FRn9_UNhroGLRfZm+2hq_qMK-eNKA@mail.gmail.com>
 <20200728163357.GB393320@localhost.localdomain>
In-Reply-To: <20200728163357.GB393320@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 17:54:38 +0100
Message-ID: <CAFEAcA-_5a49iXJjzsTuShn27rdrtnbg-vRwQGGw7tEYRLU7Qw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 17:34, Cleber Rosa <crosa@redhat.com> wrote:
> So, I think the reason for the skip (there's an open issue on GitLab
> itself about not communicating to users the reason) is that GitLab
> does a late evaluation of the job condition.  For those jobs the
> condition is:
>
>    rules:
>    - if: '$CI_COMMIT_REF_NAME == "staging"'
>
> Which by the time the job was evaluated it was no longer true (there
> was new content on the staging branch).

What caused the new content on the staging branch? I only
pushed the once (to go to commit 6e7c2dcb50907aa) -- is some
other mechanism updating it? Looking at what it now seems to
point to it looks like it's being mirrored from the git.qemu.org
repo... Either we should turn that off, or tests need to be
pushed to git.qemu.org:staging (which might introduce a delay
if the mirror isn't immediate)...

thanks
-- PMM

