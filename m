Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C70AC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7C820825
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRgkFCi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7C820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRI1-0002yu-AY
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYRGJ-0001z7-QK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:03:59 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:38154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYRGI-0000dx-4x
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:03:59 -0400
Received: by mail-ej1-x62c.google.com with SMTP id za3so7784736ejb.5
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V7hHksdi7121375xjyasD1T425KKf7isP0CezUhthqM=;
 b=tRgkFCi/TrLTZK+tQFJ2ccNGSibUXx9H7+ch9hIuGSHPXuTxRlgx7Pk12ExjpbBCnT
 hLYQpYmxz4EfLdMZ4xWkeHfiUWb6wCApSQq9wqQyG90fQG95PYUBTJ4BqKlv7Mj8FWEA
 OfYyeaRH0YcSkuKPSFEtxlXjSA72Dij5NWQkz8jp+fpQ23i0+/akEM6Aq35BFmGc86WF
 y9nqZVMdTwV/w4IAIxnSfzHGzanu/TKXWPhWlqZXobnzM3Beyzjvm4W/ns5fDtBl6GyA
 G7+iXlmIxMTnlTRdK5oOGxCrt+OaT1XIXmBSVI0iq26POuyCoBLJI4axkW+T4rMmR8FS
 Lg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V7hHksdi7121375xjyasD1T425KKf7isP0CezUhthqM=;
 b=DeFFWSfTCSgXuo2mVz3ReScbqQmfpJBHC4Vuu17o9FEuk7iNpHROfPvJYaxhyySQkQ
 6FBtnuYMaiCeDWaEk7GAL1zngjb8bM0jsVc1dwlSvSQsG3Mw1TZHaD4UQRPzrOmzPDXC
 iJ7BaVNz8spEIjkcR5EUcXNRbjPTPpSyAgrsYdaz5uAqckZfIXYPrJsQ4AV52m2l01t8
 RayWMTu45CeNP7FQGdp7WLIPnTYQIa4K66KDs9sXj9IlfzM5u0b8ztRxBhBLRnjb9L5H
 +R4mG7bXnKIerw+/6YgIdSnEsQHwD1//mCT5sHWFqnKvW8Fo1dAqGZkh86GYgMcUT3Nu
 ErkQ==
X-Gm-Message-State: AOAM533qkBaiG3wXPV+D5vsT5RO49aHlzcAk3UA9Ts0CSBY+oG3pyCfE
 AZGYGz8icl/CRMPayz6lCMp9rf0GOSl71GuDl35/Zg==
X-Google-Smtp-Source: ABdhPJxE5a9ey6HrSNyGgF2ZLdWBVY0FrssaunrrNBmXgGpQHXvju8iB0ZZSrjKAYNn5Sf23TeRFia5u5d3HvhgtL2A=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr1734553ejf.56.1604052236061; 
 Fri, 30 Oct 2020 03:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
In-Reply-To: <20201030092324.GC99222@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 10:03:44 +0000
Message-ID: <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
Subject: Re: Migrating to the gitlab issue tracker
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 09:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> My convincing strategy is "do nothing" :-)

I am, er, not convinced :-)

> Most importantly we need to be able to make the existing "QEMU" component
> in launch read-only to prevent people filing new bugs there, ideally with
> a change in the description to point people to the new bug tracker.
>
> We can leave existing bugs in LP to continue their discussion. If there
> are some we explicitly want in gitlab manually re-file them. Aside from
> that if we periodically auto-close any stale bugs, after a while we'll
> have culled launchpad down to zero.

Minimally, we should have an easy way to refile specific bugs
that doesn't involve manual cut-n-paste. Most of the Arm bugs
in launchpad are valid, for instance, I think, and I really
don't want to be spending a day in unnecessary clerical work
copying information into gitlab...

thanks
-- PMM

