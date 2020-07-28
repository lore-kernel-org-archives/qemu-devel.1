Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EBFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A6B2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0TcChfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A6B2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0SAq-00024b-Uw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SA4-00013w-It
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:09:04 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0SA2-0000fm-Rr
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:09:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id q4so6199619oia.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hRPqJt8XnHgKa6XfGxyZQSTqoP/vm4IhrWzm4zMFVxI=;
 b=w0TcChfgKFSyvlqPIU6YtSX30tmWSVaWy2ZRSSkj2Ap3PKzW04otmGOJGiYZNUS1K9
 HJe4gT3w5dRR7OWURNQe5pib8Czqh0eqObWa4mBQyPIO78fjeT7jA545kQ2eq8/f0+iw
 lyT/aPPB89YROj5phfmRt51PW2blyoj8pOAqELLvIdKrxHQwby0nbvvr9/GL84HAPRMF
 k6n1iOBiSH5R2oUhSH73eEkAFAjeingK/eJHD8BeecSxIT7EwWImPenOvKqyCd7bxSX/
 53fLrtiTTv+KvKm6/dK7i5Nln197exytDahkCD1B/Rr5WPz0ePunxXKgmONIzssK7hJz
 GzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hRPqJt8XnHgKa6XfGxyZQSTqoP/vm4IhrWzm4zMFVxI=;
 b=BWVm3r1TG1vRkR38N27iwqKriudPdmIwZiW132wSUvU6aaxJj/pTGkT+r1rpxN+T1P
 1lXpecI528Fy1v6fzLP+K75z0edBs6Q2pA5Rb/RwcyRcB6Jnx84YMxHpErA3/iDbNG6o
 S27U7kg/WH/PeHeCxnjaWkggYphmrq4UptbthrRHbNbiurX4yy/FHV7GSAq25Qs7aifw
 bAH2qfc787Efnlqu7tkpgl/aEWadJn5zrYTp5laUaFwGmpirJPMHSUodFW82DSqQZTat
 lt1KRgmUL7jd2MrBznXHVmEEMHeDQ5RA0VxT7UzIkCA24t+v/ryfJpATnmcUJjCpKAkr
 YKUA==
X-Gm-Message-State: AOAM533PIWiO4UN6edIkfoNGYNg365finG/IOaATDq5Vc91H0U3Ksh3o
 c5oJA5nXYCf54PaK1b0X3KeRqrx1DQZWb9aCm77ZOA==
X-Google-Smtp-Source: ABdhPJxlyUlnxJEzP+C0rHa5BHqD1TxIbLxMdTmBuOoYpCOXjOE+DHSpd17Op7AfKGqy7mW/aK/3Z+YzecQhV/K5/Do=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr4122937oia.163.1595952541536; 
 Tue, 28 Jul 2020 09:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200709024657.2500558-1-crosa@redhat.com>
 <CAFEAcA9qdYm+a-PTPE-Vbhmp4iZ5Bo0Gt-2RcCrO7CS2yp9_CA@mail.gmail.com>
 <20200720172210.GA3987025@localhost.localdomain>
 <CAFEAcA8BD3BoJB9FAmeuZc8fKFNZywJT2LdGON670uM8ATdhZw@mail.gmail.com>
 <20200728155052.GA389264@localhost.localdomain>
In-Reply-To: <20200728155052.GA389264@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 17:08:50 +0100
Message-ID: <CAFEAcA99fVFKwc6ju1w=2FRn9_UNhroGLRfZm+2hq_qMK-eNKA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jul 2020 at 16:51, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Tue, Jul 28, 2020 at 03:48:38PM +0100, Peter Maydell wrote:
> > On Mon, 20 Jul 2020 at 18:22, Cleber Rosa <crosa@redhat.com> wrote:
> > > Sure.  It's important that PATCH 2/2 in this series is included in a
> > > branch that you need to push to the "staging" branch on the
> > > https://gitlab.com/qemu-project/qemu repo (it could be just that one
> > > patch).  Then, you can run:
> > >
> > >   ./scripts/ci/gitlab-pipeline-status --verbose -w
> > >
> > > And that should be it.  You can drop '--verbose' if you just want the
> > > final outcome as the result.
> >
> > I tried this (local branch named "staging", pushed to gitlab
> > remote "staging" branch), but it said:
> >
> > e104462:bionic:qemu$ ./scripts/ci/gitlab-pipeline-status --verbose -w
> > ERROR: No pipeline found
> > failure
> >
>
> Hi Peter,
>
> I think this may just have been a timing issue.  GitLab usually does
> take a few seconds after it receives a branch push to create a
> pipeline.  Let me know if you'd like to see this within the script, or
> if you'd rather put a sleep between your push and the
> "gitlab-pipeline-status" execution.

Ah, right. I ran the command again and it does (eventually)
print "running...". I think the ideal behaviour would be for
the script to have some kind of "waiting for pipeline to start..."
phase where it sits and polls for the pipeline to appear,
with a pretty long timeout (minutes?).

> > It does seem to have kicked off the pipeline on gitlab though:
> > https://gitlab.com/qemu-project/qemu/-/pipelines/171671136/builds
>
> There's already new content on the staging branch, but supposing my local
> staging branch contained commit 6e7c2dcb50907aa6be0cbc37f81801d2fa67f7b4
> (https://gitlab.com/qemu-project/qemu/-/commit/6e7c2dcb50907aa6be0cbc37f81801d2fa67f7b4),
> the command you ran:
>
>   ./scripts/ci/gitlab-pipeline-status --verbose -w
>
> Should have behaved as this (output from my machine):
>
>   /scripts/ci/gitlab-pipeline-status --verbose -w -c 6e7c2dcb50907aa6be0cbc37f81801d2fa67f7b4
>   running...
>
> > OTOH I can't see anything on that web page that suggests that
> > it's submitting jobs to the s390 or aarch64 boxes -- is it
> > intended to?
> >
>
> All the jobs for that pipeline have been created as expected, for
> instance:
>
>    https://gitlab.com/qemu-project/qemu/-/jobs/659874849
>
> But given the recent changes to the GitLab YAML adding other phases,
> it's waiting for the previous phases.

The page now says "This job has been skipped"...

thanks
-- PMM

