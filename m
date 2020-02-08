Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECF5C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B23221775
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pu1Hn1WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B23221775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0PrJ-0005Ai-Ez
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j0PqP-00039M-UI
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:08:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j0PqO-0004ev-Oj
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:08:21 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:33262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j0PqO-0004e5-KO
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 08:08:20 -0500
Received: by mail-oi1-x230.google.com with SMTP id q81so4880162oig.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 05:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dlrmj8ti/csItRZ3yLTPaYdNFExOcxHQv47BJKF4Um0=;
 b=Pu1Hn1WOXbDHWAdbjf8OoN3ruJVku2SLaaeju5J8zKkNDdaX0zHN8Wpb1ZprPxBtDh
 9/Wn/I488z/Vgpe4SrPQ0RwHFgOBj+m6vRg2T1d/q2J+7VXaJIVmxszAawNP7B3GGC8S
 CQEAfeYwg5knWfl4mcYroyvWNUq9BCt2q92BVGFVykOZlp330G469LWdVCkljJ2FJ9nr
 uwx0qvScON9ob7oebmMnsKMK2/uJUb0YH0RpiPmx5A9COBYyg8m18U6zryBfy6JRKkvF
 34QY52mb197B4sU1x5t4YkfUY2cy3Jh8zSFG7G8B2ZbtHV+1yZ6RqFtOBvOM4ANXxrvC
 AIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dlrmj8ti/csItRZ3yLTPaYdNFExOcxHQv47BJKF4Um0=;
 b=cbQ+gGgPsgu2QGPiew+RMqKCPsmGPZ2C0BNUxJ1VF9wl8qQfnMxzrBg7+8OE10dEzK
 ir5bgyc3lqAwwi8SyNvpqVPpEMYm7UUUFh6YxV7isxdXlkFpXGaHgpezmH8gG8gibKJr
 upk4ScOGzFNqmau/IOrS/3clO+WsvcfmyNFF853bTUf4jzQSQzMBSfRXtBKUYGcujN73
 FXRj/frxLRfW/dLSfDATKxGjp9mefbndzdOCnJYB+Fa3hH24j4OgRCYsMQgZwe9nlcbz
 n/RcHOKq1d1YbkAOGqDVZyv0sAPXR4qvdv82kY6xmydYcZPihPZGMf4qoYKDTJUzxAlt
 iylw==
X-Gm-Message-State: APjAAAUOE6P1RRyfA2l91wlxUB2vgW7/aanJX3315AZMZ8hlyxTdADhE
 aM2X/jBDp9yUe+mAPd0nvKt26IZqlhs4PU0tWABcZA==
X-Google-Smtp-Source: APXvYqz3y5Vediewh8oHRhOIA068mYmYZfMljeIsWyEF82Y/B2hhqoYNe2jlYKAXb12UqtgP2zl+tE7VTofSHMDVc44=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr5365462oid.98.1581167299253;
 Sat, 08 Feb 2020 05:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
 <20200203032700.GA12127@localhost.localdomain>
 <CAFEAcA-h3fJaBm+DSn6VQ=sgdS4x67MT_biyeTohk__JzkACMw@mail.gmail.com>
 <20200207203856.GA17041@localhost.localdomain>
In-Reply-To: <20200207203856.GA17041@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Feb 2020 13:08:07 +0000
Message-ID: <CAFEAcA9uodvAUzObR1dS3ecm-sqApO3LFHHfzqG_G+n35w_OXw@mail.gmail.com>
Subject: Re: [RFC] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: Jeff Nelson <jen@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 20:39, Cleber Rosa <crosa@redhat.com> wrote:
> On Fri, Feb 07, 2020 at 04:42:10PM +0000, Peter Maydell wrote:
> > This all sounds like the right thing and great progress. So yes,
> > I agree that the next step would be to get to a point where you
> > can give me some instructions on how to say "OK, here's my staging
> > branch" and run it through the new test process and look at the
> > results.
> >
>
> IIUC the point you're describing, we must:
>
>  * Have the rigth jobs defined in .gitlab-ci.yml (there are some
>    questions to be answered on that thread)

For the non-x86 architectures, do we define the jobs
to run on those in the same .ym file? (Generally the non-x86
machines just want to run a simple make/make check; they
don't need to check the wide variety of different configs x86 does.)

>  * Setup machines with:
>    - gitlab-runner (with tags matching OS and arch)
>    - packages needed for the actual job execution (compilers, etc)
>
> At this point, the "parallel-buildtest" command[1], would be replaced
> with something like:
>
>  - git push git@gitlab.com:qemu-project/qemu.git staging:staging
>
> Which would automatically generate a pipeline.  Checking the results can
> be done with programmatically using the GitLab APIs[2].
>
> Once the result is validated, you would run "git push publish-upstream
> staging:master" as usual (as instructed by the script)[3].
>
> So this leaves us with the "musts" above, and also with creating a
> command line tool that uses the GitLab APIs to check on the status of
> the pipeline associated with the staging branch.

Yeah, that sounds right. To start with I'm ok with checking a web
page by hand to see what the job results are, so getting the
runners set up so we can test by doing git push is the place to start,
I think. Once we've got the actual testing going and all the machines
and configs we want to test in place, we can go back and look at
improving the UX for the person doing pullreqs so it's a bit
more automated using the GitLab APIs.

thanks
-- PMM

