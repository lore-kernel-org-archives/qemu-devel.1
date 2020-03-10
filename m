Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31E7C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD950222D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ijyh/Sbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD950222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbHf-0000Ae-Te
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBbDg-0003ev-7s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBbDe-00045n-BY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:35 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBbDe-000436-6g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:30:34 -0400
Received: by mail-ot1-x341.google.com with SMTP id j14so12494683otq.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k7uBdixYvCEv1V1U1omjA12/5GcQSgVKz/smCnHtkg4=;
 b=Ijyh/SbrHlQ/Pqj9Jy3W/AYwOl72F1Te2EqcNTtlz+Sw0BOG59Mtw5tZnzZZi4ZTLf
 fhbQOtIGPzziQAql6DwDsWK7TzJjb8SGdN/fAsXRCPc1FVCRDh+6To9PKhsgeeftZhRc
 huhGuyW9gy48xepUwSNi0dduPtshNXKfJrWoEw3c1ZKZPd9rLgPrKEGQD8p1Lazwsxs6
 OwVWimF6fPOrrh4gBT1pxoVBSzHL+wfO5d2dQMMLDVohvS9KlzQ75+bw7vOvqFS97RIY
 Qq0p+trqAdCDYawYlXBeWCeAj3hq0cIdiCemi5VBA0ELvcHmUaq2U9jUH7+B+WUwP0or
 OiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k7uBdixYvCEv1V1U1omjA12/5GcQSgVKz/smCnHtkg4=;
 b=N/AEoVAcAcV5BRGieO8p78G0UsEpFlSy2qnj0EQOxwmpNfZnOK0MyhyDrWLdFi+NV4
 WnswHqPj515OcmPOqwlTohG9OSokcJ/O13OH09Jci+V6ZPOaNYRCDaOPLhX5S2l1AO/z
 8xgWSJsFb6vMEXbYcXHYG7u5CilmaytmS6Ih3mu+S2JGewxYT2WvhS473wuH9j/6Xyil
 Z1YTZ+7wPdWET8CxeQcCD1EhDCrFYD/+5FWMCA+dxRE4brhjRCoB1WNYT5r3KVc2EaAz
 bwKJ+ZwYU7FxgFLMMkleqVVwM3m6EyfCYklUcMMF1mqWgWHk/KrgITyNqxeYnDaXpCcK
 ey6A==
X-Gm-Message-State: ANhLgQ1oBnoXeLDvOsdbDps4AuStLHzVvi5Wn0YqsBqZy0uBuqeyj/fv
 ebm7aGdphNS+8dptQj0CRiBlkhH8Vz4l7PDyT4ivgg==
X-Google-Smtp-Source: ADFU+vsMbWNgLZCTKw9QS9xl/W6tE2lXLiIsWeix5AxotEEgARvm2qHwsFp2QYMeVCrEDbLxDbSh6kPhRuYz+mWbPqg=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr16153712otl.135.1583832633200; 
 Tue, 10 Mar 2020 02:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <a87e5634-903d-2ad5-4f33-b65f77703302@redhat.com>
 <20200207193429.GB13258@localhost.localdomain>
 <CAFEAcA8dF+1a3zjw2MBVfD5k5U4EeU21iOik1mhKqg1ubicA6Q@mail.gmail.com>
 <20200310050106.GB50141@localhost.localdomain>
In-Reply-To: <20200310050106.GB50141@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2020 09:30:22 +0000
Message-ID: <CAFEAcA9mLypcRgH6qnrcUsWaTL0Tp283M_ZaNaRezhCma8OmiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 05:01, Cleber Rosa <crosa@redhat.com> wrote:
> Thanks for the very straight answers here.  I'll work
> on those two remaining points (windows cross builds, and
> incremental builds).

I did wonder if incremental build was going to be awkward
to test in a CI setup.

Anyway, I think it would be good to start working with the
basic "do CI this way" framework now, rather than trying
to get all the test configs I have now working with it.
I can always run the builds through the new test setup
and in parallel do the handful of "not yet implemented in
the new setup" builds by hand with the old scripts.

thanks
-- PMM

