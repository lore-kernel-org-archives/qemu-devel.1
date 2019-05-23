Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC78C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC792175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 08:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcwBcu8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC792175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTjWu-0001vi-Cl
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 04:56:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTjW9-0001bE-VN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTjW4-00056i-31
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:56:04 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35663)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTjVy-00051u-74
	for qemu-devel@nongnu.org; Thu, 23 May 2019 04:55:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id n14so4746468otk.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=4VPh3MAX51SKuil5X5NXQDTg/CO9uKSMjP45Bq1GoJk=;
	b=WcwBcu8A3KTIMZLXq5oy5xeedXwPtzEIvNq1y2OVHITLGsuMHtQr/w0uvql4dQic3i
	VJEE8mAUwpJV5OVcRWLyuoo+qZby6oaCjhub2wVPaVbkApp2iyoooin2/CtEwFIDAt6v
	A+ZEGzPpPL4yWaeIDJJYoXRWRVaoTk3XMEfFRSRJFFVtsqMioYbW6fqhHbn7irDRYb79
	xN7GYru9CMhruvT0GhAXujjvKb32CvS67j+kJI04/BLEssBVfx4W7A+pQQj7eKxa0F3C
	9Cl277YgNsh4kUHdxwDq4Bv1kGDcQhlVnMyujRgQWEPgy5LmYuVyZnpEUihvuT98rlhn
	NG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=4VPh3MAX51SKuil5X5NXQDTg/CO9uKSMjP45Bq1GoJk=;
	b=KPwqj4LTq7VWeGHRQXQvuPtqJHm92LOnQIkM0bfvTPtVERjThoapth0U9hLnvPuSkV
	MlGVhJXgIyiQJWRs778Vz8G6tCnAYQizL9dNhxedhKJVNtGwgYeYwDvl2PyzOXIFgqtg
	5pFHDwdnaCoaHKTm3dTyfM/qSAoyAjY8l1HwGTguA68ATB/nLu4CV1Yfa9qLyuBHgQh6
	/eY4o9Tf+7+fb3tX9gp3jWslY79p5o2TU2wlqCbcGkaBqPmgf4OKmqsAiTvNGUjGeZv8
	vw30YrNu7nbehjkJIWQfZGndoQl0iay8MXELW1ZYuxPWPDjeyuEHSv1U4RlKiQci4n6d
	YJ3g==
X-Gm-Message-State: APjAAAUc20OjJoO+N1Yi0w6ZOzMfKqMUai5Rcv+wlPQRA4c+woRY5Ov1
	26QGNwv1YdobeR4gcHdPJbTE7EUY7/djd4UsYH9RpQ==
X-Google-Smtp-Source: APXvYqwa5lXyQLzxxvydrAsXPhhI5+dVFTgyuhAUnn4g+smRLYKpQxRFIEpxVE7U+E1eqe72lSr7UIv/cQq5pmp85jU=
X-Received: by 2002:a9d:5608:: with SMTP id e8mr25516723oti.135.1558601746581; 
	Thu, 23 May 2019 01:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190521185059.28236-1-ehabkost@redhat.com>
In-Reply-To: <20190521185059.28236-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 09:55:35 +0100
Message-ID: <CAFEAcA-fYuFytNqFc7SPx3GTFA0qH4RvLw_PzYCCGw8Cx9rRHA@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/3] x86 MDS feature flags
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 19:51, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit a4f667b6714916683408b983cfe0a615a725775f:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190521-3' into staging (2019-05-21 16:30:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 20140a82c67467f53814ca197403d5e1b561a5e5:
>
>   target/i386: add MDS-NO feature (2019-05-21 15:39:05 -0300)
>
> ----------------------------------------------------------------
> x86 MDS feature flags
>
> md-clear and mds-no feature flags, for detection and mitigation
> of MDS vulnerabilities (CVE-2018-12126, CVE-2018-12127,
> CVE-2018-12130, CVE-2019-11091).
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

