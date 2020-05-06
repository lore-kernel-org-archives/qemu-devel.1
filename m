Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25B3C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D714206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfIepVPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D714206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWLC9-0004av-HW
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWLBV-0004AG-IE
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:38:05 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:33060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWLBT-0005XW-5U
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:38:04 -0400
Received: by mail-oi1-x22a.google.com with SMTP id o24so1939097oic.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I7nzq7GckMB5Fzkd9eoVjyTReVKPT+li2pdjgO0xt9Y=;
 b=BfIepVPC2KFyNxBUqUKPP9964pzaOQBYvFjOiEA3xx+Ik80SbWqxb9c7mHl+wGYpoK
 MUEtlgZgrxs6njOF9GVcfBA24qM/b8n7DOZsg19GIvL6N7YTKgGC0ynrlWPp7JMtqaU7
 A0SdPOBEvA9OXyHGStM5YFhLR79TNMn5VasyiEmn0iEalMWaidZNUHKvsoyzCAesJ7Wb
 gYGdjOwKKUuyFOxW8JJ18OFAtOyVfj9/g+LgwI/TS8mOOSvpxo93SjeipFbl0tQiqEpe
 RAOfTNZEuFASvcUF2BTGJdeUlKPKS0gpI5b8MUygb2Owy4RSGT26ZTscNX+1hNmpicjJ
 /APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I7nzq7GckMB5Fzkd9eoVjyTReVKPT+li2pdjgO0xt9Y=;
 b=svwxC+QdknO6htpY/hGEIGBvgRIfTakofiBQIK3upaCcz6UNMke2fdMo4KCEJC2zp/
 2YRtw4l0VNEo7kRSffTJDKXhNzPidTw6P57VmjtYRK5GyM51E70ahXH7/XBcwZdZaXUs
 s8SXIi9FTV3xcOlSaQ4RM57QiZ+ZBA5OK4enqZrRWdjCFUMQ5HWB03fEw9K/Tn7adkfm
 UipjJqUCIab9XRWWTQVW51jO0/FT+HSaoQwtwauJN1E0ScpfgLmsIag11W55EXhP8zbN
 eZCvWiTR4d7rA7NpfFjrpPZ8QnQ6mFFThtO94j7IK7lW/ikRh9T6pABO01Q9PQz97fIe
 MzfA==
X-Gm-Message-State: AGi0PublufD1zudKJkuTdGMB0h51C9TkqiPYUYViDnx2QULZ/fbxyLp6
 qB7yhEYYdZUmdDxSRSoUHMDIec6QZdXHk2J6fr/GYg==
X-Google-Smtp-Source: APiQypJoqWiQQ3JdcXlhbEwrc590BeEcs39blnIJaqUVi63BxzJTZiI07ZBsxs0vQKYxCDks0d5HPomr5NHe1JQ4IgU=
X-Received: by 2002:aca:895:: with SMTP id 143mr2824396oii.163.1588775880273; 
 Wed, 06 May 2020 07:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200506120529.18974-1-alex.bennee@linaro.org>
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 May 2020 15:37:49 +0100
Message-ID: <CAFEAcA8BDiV3Nj7kWw=d=6-sBDcotWibFGSdPc2MUsv8vR+cgA@mail.gmail.com>
Subject: Re: [PULL 00/14] testing and gdbstub updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22a.google.com
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

On Wed, 6 May 2020 at 13:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit f19d118bed77bb95681b07f4e76dbb700c1691=
8d:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2020-05-04' i=
nto staging (2020-05-05 15:47:44 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-gdbstub-06052=
0-1
>
> for you to fetch changes up to a976ed3ffdede7f64c89ac235d0154d048981b5f:
>
>   target/m68k: fix gdb for m68xxx (2020-05-06 09:29:26 +0100)
>
> ----------------------------------------------------------------
> Testing and gdbstub updates:
>
>   - travis: drop macosx, tweak ppc64 native
>   - cirrus: fix FreeBSD, guard against future breakage
>   - gdbstub: support socket debug for linux-user
>   - gdbstub: add multiarch tests
>   - gdbstub: fixes for m68k


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

