Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB651CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D2B214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="El8zSdyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D2B214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMwS6-0008Es-Bo
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 11:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwPZ-0005nG-Fb
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iMwPY-0004bX-9L
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:49:29 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iMwPY-0004aw-3m
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 11:49:28 -0400
Received: by mail-io1-xd43.google.com with SMTP id c6so20951395ioo.13
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T55s415trqTTXHVR7Eh8cnhPb29V43raCaAi11hatio=;
 b=El8zSdyTzmjyW0a8c85l4uW/VM+hCvIccqjqdPkQYO4FEHuBWgmULW5j/KOWz9tPM2
 h6iif2MXiEJIaiIDRPXP93gvyAGC1+m1nHVS/x7hmV9K74046H8wRextGvyFrG+M1LXe
 BJlf58wDx+W3qnYVfX7VGTgQla2joenhFgmsZ/TsKjtKMcRU30RUHZ0o0Pc0FjhenIZZ
 xAUHahySPNoike4oaX5OhRKQwQB7rgIkFnYZkET2eMQAjzEyuDzfAZOgG4/9LJxRcORN
 xjIH6ngt83WOyIDl0Wf/9oy4NTyjyZKce/U3Ny2H1Q9/cAE9a88ncZoU5HFIzusRp9fZ
 eMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T55s415trqTTXHVR7Eh8cnhPb29V43raCaAi11hatio=;
 b=VZ1rzREu1cyrzrFVx1TeaWnFknNzKLRJ7ff+55eoxzdIzsYhRjs1fa4RQRs3Ou9nOH
 Jdbk0m+p2TH99gP5AmIX9+AaCDxt48p5C0Sv+lp9S9LVmunCTIYC7n/vBeWAyDCk9HbB
 KFTmRjF+JFA9wpDAMIYDBRr90lbWTfOdeocrKF/zzxE2NC2pVJu8eGTKWvkK4nJmtB+w
 0hXNwjXHI66Og0lagxa3xJ80+sR1srBIGbqyeNbnHMfj2g6IE8rSh3gdwFlN764TuEDY
 jlFBvgJ3BwZB6nyt77DYA+VSFtk4sCbkget0/CAY2q8x6ovXhhh1xqS933XNlmRjpzFH
 rAzw==
X-Gm-Message-State: APjAAAX6SXr9PpbDwbcVVenymZ8DiCOPab0c40Mcn4zDlHBD5uZnjV7B
 HgoLRw22Q69RqQo2LynZEZc799XtH4oNkRIJlEUBBQ==
X-Google-Smtp-Source: APXvYqwuB1fde3p5tdew/r+aKTP+w/iHaYH3SMIHc7WwjLmbVGYzgSGtRzVUyxCnJdfUM4FtqDXMn2kZ35GkRbeHzzs=
X-Received: by 2002:a02:c90a:: with SMTP id t10mr4259911jao.89.1571759367052; 
 Tue, 22 Oct 2019 08:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-2-drjones@redhat.com>
 <CADSWDztJDUEd+_7XnBPWL1bk5Xh=V_aLc1+VrP97_Ycbe3489A@mail.gmail.com>
 <20191015105628.7ln6ph5s3vpsyfuw@kamzik.brq.redhat.com>
 <CADSWDzsKx7+4mR4pmsqi0+rddUv47q=UKwVt509B8g68UoRiMA@mail.gmail.com>
 <CADSWDzs9sdjE+-1AedPnU6o7U5XjTk=dcHf-BXQXQQkrp2O=Bw@mail.gmail.com>
 <20191016135025.k4szpqwgkhfnd6dl@kamzik.brq.redhat.com>
 <CADSWDzuXpTHDtRmTL41CXbk9GmDHO5iEgpiRgnD=buQU+nnXcg@mail.gmail.com>
 <20191016161628.rf752xuu6fzkihun@kamzik.brq.redhat.com>
 <CADSWDzvT7E9P3uEJDV9z+L=HEBuDRwQ904-GG0M9T-NUz+OsoQ@mail.gmail.com>
 <20191022134315.fuz6dou5f3pxtfte@kamzik.brq.redhat.com>
In-Reply-To: <20191022134315.fuz6dou5f3pxtfte@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 22 Oct 2019 16:49:15 +0100
Message-ID: <CADSWDzsiB5-jgHfv+JfnPzqCbkMUKshQgJaJTqaZ0fK0EX3jzQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

On Tue, 22 Oct 2019 at 14:43, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Oct 21, 2019 at 04:07:14PM +0100, Beata Michalska wrote:
> > Indeed, the patch got bit messed-up. Apologies for that as well.
> > I have been testing manually but I did try the test you have provided
> > and yes it fails - there is a slight problem with the case when qdict_in
> > is empty,but this can be easily solved still keeping the single loop.
> > Otherwise I have seen you have posted a new patchest so I guess we  are
> > dropping the idea of refactoring ?
>
> Well, without a patch that applies, I couldn't really evaluate your
> proposal. And, TBH, I'd rather not hold this series up on a refactoring
> that doesn't provide measurable performance improvements, especially when
> it's not in a performance critical path. Indeed, I'd like to get this
> series merged as soon as possible, which is why I posted v6 with your
> visit_free() fix already.
>
> >
> > One more question: in case of querying a property which is not supported
> > by given cpu model - we are returning properties that are actually valid
> > (the test case for cortex-a15 and aarch64 prop).
> > Shouldn't we return an error there? I honestly must admit I do not know
> > what is the expected behaviour for the qmp query in such cases.
>
> We do generate an error for that case:
>
> (QEMU) query-cpu-model-expansion type=full model={"name":"cortex-a15"}
> {"return": {"model": {"name": "cortex-a15", "props": {"pmu": true}}}}
>
> (QEMU) query-cpu-model-expansion type=full model={"name":"cortex-a15","props":{"aarch64":false}}
> {"error": {"class": "GenericError", "desc": "Property '.aarch64' not found"}}
>
>
> If you have any more comments on the series, please send them right away.
> I'd like Peter to be able to merge this soon, and I understand that he's
> waiting on your review.
>

I think we can proceed with the v6 as it is.

Thanks a lot.

BR
Beata

> Thanks,
> drew
>

