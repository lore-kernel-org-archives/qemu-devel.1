Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F19C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812DF2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJm7pmRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812DF2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSpG-0005GZ-Kd
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isShM-00044p-Nu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isShL-0003PF-Jb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:34:08 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isShL-0003OG-FA
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:34:07 -0500
Received: by mail-oi1-x22a.google.com with SMTP id i1so22321158oie.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9WvEzAvPL8u4pJp9g5bxX8KKFoR0aqDrFgs6z5SyGnQ=;
 b=qJm7pmRJPW5EyB6nh4VIBHtQeZ82xfuF5zIlbe0M70Q7T4nZfHTjHvKGTl3GB9SlXk
 Wb5vr1WWoHROlUjbRghOP7Z1ZZYnCZRKNog5XkQp+CFE3RyHQ38SC5jHTtS15FroPI/o
 BwlZ0Zl7mc/mSytB14bed9H08sJHkVyUFZARIQ2myL0ovpEqJtSNWzxlvJx1WkVCuy0Z
 cPFu628AGUzWW9+x5VMciXW96HC09+Ecuwr2yosDhfKPgnn1JY7rFNYzaXmSMvTZYBdA
 W9zS2sXQ/fZ5RLj3QufILd4hZ2nc+KuGDAAn2ozOE7zO6v3rBDk13MvJZ9Myz2OEKUJx
 1dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9WvEzAvPL8u4pJp9g5bxX8KKFoR0aqDrFgs6z5SyGnQ=;
 b=Ke2kzRfl5k/7DLkGDo/aWwbenkW9gQdAF5GRoQBIs1S51RHHf1iRcQQ0O8o5dYIc8Y
 Jsv5v/C5wM74RpWvWv9wF5lbSl7+vdVAHe2h6B8gFkeQCATMqff6uR2xCVIZVozC9I1P
 9peF8NPtfSsPMt39B/WmSpOztHZxmFgX2ePfmrrTnyy30pb3GeCnMeGIPUyLOiL5+tI2
 1HbrLdfL/iuIiH3qhkV20U/Ch0dIjnTplooWyakPAy78swOVs0hzjYfPpZqQRPUrmKtC
 6O68e59WLwVBLMVV+KwQQovFgvASQT6fJZfpmj6NLe3dJXfodM1RKzbcqlyJxI3dC1pY
 pYrA==
X-Gm-Message-State: APjAAAWlUHUxEl8An9sMXXbK0VkzRCJfEtDXNE08qtxJUVRBVjjjmh4y
 JN/GgBYSULfa5/OxVGDwV6Y+4Af+xhC96HBEjsEnEA==
X-Google-Smtp-Source: APXvYqzZvFqm7CUqFzauwhksgcimgToQz7QxO2Kq/o5dD+kFJo9RzjQP9zn/HqEYzAL2EG4Cb9Bjl/EXOpeNyamgg8g=
X-Received: by 2002:aca:d78b:: with SMTP id o133mr3659949oig.163.1579271645950; 
 Fri, 17 Jan 2020 06:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20191202140552.GA5353@localhost.localdomain>
In-Reply-To: <20191202140552.GA5353@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 14:33:54 +0000
Message-ID: <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
Subject: Re: [RFC] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Jeff Nelson <jen@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 at 14:06, Cleber Rosa <crosa@redhat.com> wrote:
>
> RFC: QEMU Gating CI
> ===================
>
> This RFC attempts to address most of the issues described in
> "Requirements/GatinCI"[1].  An also relevant write up is the "State of
> QEMU CI as we enter 4.0"[2].
>
> The general approach is one to minimize the infrastructure maintenance
> and development burden, leveraging as much as possible "other people's"
> infrastructure and code.  GitLab's CI/CD platform is the most relevant
> component dealt with here.

Happy New Year! Now we're in 2020, any chance of an update on
plans/progress here? I would very much like to be able to hand
processing of pull requests over to somebody else after the
5.0 cycle, if not before. (I'm quite tempted to make that a
hard deadline and just say that somebody else will have to
pick it up for 5.1, regardless...)

thanks
-- PMM

