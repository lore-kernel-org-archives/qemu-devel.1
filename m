Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34469C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:16:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C52820684
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M+siDYkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C52820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4Da-0001pL-D2
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc4CE-0001FB-Av
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:14:46 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:45721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc4CC-0004j9-Fz
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:14:45 -0500
Received: by mail-ed1-x531.google.com with SMTP id q3so8097102edr.12
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 02:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ByM42aUw1+jzz9v3Ni8eKcJn8vZiOQNwFUnfjsbie+w=;
 b=M+siDYkd9vm7h9QlTa0GeiBmbIydw2HsAPK+SFqD+EKYdmVDJjA7XyRyvrLXmx0R1L
 AOTgVXzbTi0Awbo2JxlOtpWn36K8xXa4lm4Ri3ZVWVvmEnsCfEsZsBRHdsU8W4sy6+jb
 v8KmbtHAmB0X1KNlpmVguB7nRhaM1WBxP6sXLrV6xS/y+delrksVsBl9xFnjvLTTNAp6
 1zKGHPXiDRclJLsGIDAln2ghKsy2y54y8n5bjXUdIeH0OeRoIfCam30TFQp/HzcBYyrX
 StwDptN7gB/MQUW0meOLo6RR8pApxLBYweYf555xq7PUnQusiToGE1nsH6gycR0UgWaT
 mZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ByM42aUw1+jzz9v3Ni8eKcJn8vZiOQNwFUnfjsbie+w=;
 b=PsXKrbRhiIMZrspEyjc0+vk1rJDW4WFtvjTo8cBM0EWL2falRlR1bfsetJ3aIGh4pB
 X4KQlPozMw6A6SGUuy9IWKXuXrkfFpp342u1WR68n+fRu5NdK5iaBwB50sRHzBD47uRL
 vUuKGgT8cB08IAk5qZ/gMCyahEi/W42coVFogihTc+twwp5b3CRuO4JJ/fPyv8iWijMi
 h53rfHW2ghcN59jPUKiKFOpZPxnZ4gB2qZLLkZ+MdWfWMq00S0ONbm4+iJPMiQoPfQyI
 EH/birdjsl8WYMICOcoregff+eZLhIFYqYrMCw7EbgHahX1AXsG+S3v++4s0AGb7wBea
 z/mg==
X-Gm-Message-State: AOAM533ljERukcetD8wSsUZLydXSGRCaqGZofmCfVaqJStxtdebQa5Lz
 ITdaj/sR20ihSJ80slozLkfbvvYrahgQU74N2ubLbg==
X-Google-Smtp-Source: ABdhPJz01FCFh/ptnglmrg7bT7g55hnn4vzavQyTNAxJW/e9/AiD0CTHYoGh5v+ge38dFpyBOu3/pADWpYqZnN/kgUg=
X-Received: by 2002:aa7:df82:: with SMTP id b2mr14078649edy.251.1604916882517; 
 Mon, 09 Nov 2020 02:14:42 -0800 (PST)
MIME-Version: 1.0
References: <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
 <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
 <c75f91b7-6972-9e48-efa9-49792fc011d2@redhat.com>
 <37a00b98-428b-d1ca-79c2-7846ccfda651@redhat.com>
 <de1d3c49-967b-bc96-220f-3deabc441dfa@redhat.com>
 <20201105155006.GP630142@redhat.com>
 <72985bcf-668d-7472-192f-502963d2b6ad@redhat.com>
 <CAFEAcA_dT_RQ8Pmk_S=zCSu1tUbptuP0+rtrsS55tEg+XD=S2Q@mail.gmail.com>
 <20201109101056.GC684242@redhat.com>
In-Reply-To: <20201109101056.GC684242@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2020 10:14:30 +0000
Message-ID: <CAFEAcA8o9X0Ebw_baDjPkTz7q9i8pHcxDBd9JhSJStVjW3s7kg@mail.gmail.com>
Subject: Re: Migrating to the gitlab issue tracker
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Nov 2020 at 10:11, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Sun, Nov 08, 2020 at 11:58:28AM +0000, Peter Maydell wrote:
> > On Sun, 8 Nov 2020 at 09:01, Thomas Huth <thuth@redhat.com> wrote:
> > > I agree with Daniel. Please let's not clog the new bug tracker right =
from
> > > the start with hundreds of bugs - that only makes it harder to focus =
on the
> > > tickets that are really important. Let's use the migration instead to=
 start
> > > as clean as possible again.
> >
> > I really don't like doing this kind of thing. It basically
> > tells bug reporters "we don't care about your reports".
> > We ought to at least triage them. Certainly for arm a
> > lot of the reports in LP are real bug reports which we
> > shouldn't just drop on the floor.
>
> Mostly it is just a reflection of the reality we find ourselves in where
> we have more bug reports than we have willing maintainer time to investig=
ate
> and resolve. Regardless of whether the bug are open or closed, there are =
a
> large number we clearly don't consider important, otherwise someone would
> have already looked at them.

Yeah, I agree with this. But there's a corollary: unless we
somehow find more maintainer time in future to investigate
bug reports, the new gitlab bug tracker is just going to quickly
fill up with more unresolved bug reports, so why worry about
whether it's empty at the start or not ?

thanks
-- PMM

