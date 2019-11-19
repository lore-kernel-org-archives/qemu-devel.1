Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA37C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A5A206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 21:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0tAaDNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A5A206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXAwA-0003Vx-Va
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 16:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58473)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iXAvT-0002zh-Rc
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iXAvS-00042T-Vo
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:20:43 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37197)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iXAvS-00042F-SH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 16:20:42 -0500
Received: by mail-qk1-x742.google.com with SMTP id e187so19288469qkf.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/vcIsL+7uCitU/6S8jEPh5wvIdzcyxB8WmvnNnI+dL4=;
 b=h0tAaDNUrKI3W8IMn8i2qDHcshX60B8aLYC2AG+Zr5nAEk39qbIIPR6ZVJZQSDKGe7
 oUfBMT+YsLDq21OM1JaoVwW6bZrsyNqi81rN/psmFx6xVJpGYZTYrb2KKh4c5YjC4rBp
 VdKN7OX2lUVGSvMzXXFRd88tkn072YZUeIGBnjl8B1E7kvHdmgo+tGwyqy0bsKD+7xWm
 loIFObNQeQg1Ko6i+rUNd/SE3uDNDJPTbOUpXBkVMxNiF3sAndWjo7mYZ3yyPfSwru7M
 7o1pOTDV7ZdxIzwpZr9MSekE9waTFIjzl0vR4LZpq9tRVcFkzAL3sRhrvMF3At71FmH2
 VL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/vcIsL+7uCitU/6S8jEPh5wvIdzcyxB8WmvnNnI+dL4=;
 b=OGpUt9bleSdgHZag3iWez6zbmrgp+dQAjhfd+p4QG2AdRMnGUvli3gUzCYuZ7pgVoU
 XMXz06Am88tB/Xi38KE95sKFnIaZsDmVn0f77IqWJodY1+TftVz4dzYF6po2P1jaey+c
 ULVys/hCiDImjD20MPeZCI3aq5wGtL7s0ixlqYRA3imQjYCszmMFMyCe0D8uT3LhnQVU
 2eeRQgRfvPgXmTsWp/ZdpeKPffE+H5z6HHJv4HmlBjep+KWG6nIadEdN9xcV7IRGXxN0
 D6vbqAM/s2v9zzJ4jJm8Id6rD+JewVl1uvXVKJd7kpqkrz0Ud3vZo2OcbdAk8QYP6i7r
 vZyA==
X-Gm-Message-State: APjAAAXzhPo6D4TP230XbnhEHfPGQxLYNHRh8NJ0e57j10+jvAS46eIr
 LG6pp+Zuf0n3opOCIjgNV7gk0UsIuNwnO8LlmOU=
X-Google-Smtp-Source: APXvYqxx4P6gIaZS+BzfgYlgqlL8BSbf85OAIXtc/+E9PbK483WfNvkvZOjLpU7qCu/k/+qSSA2Op2KWPDLGsdvADe8=
X-Received: by 2002:a37:8a05:: with SMTP id m5mr28759436qkd.181.1574198441961; 
 Tue, 19 Nov 2019 13:20:41 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-6-mrolnik@gmail.com>
 <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
 <CAL1e-=gXr5KJ7W3_bnuBaupuz6jYr0LnAX7FXJ8+F8rJ=ARKxw@mail.gmail.com>
 <14d51697-9415-14b9-8f92-3ae3de2fca58@linaro.org>
 <CAL1e-=g6ctnzUSgq3eRn98nOMPJ88ucUNX7xc5MxCr6J=k4YMg@mail.gmail.com>
 <CAK4993j1a6Eo+FjM7rrOZgL7u955-fTXboyOWR2BriCcyFmCuw@mail.gmail.com>
 <CAL1e-=gQF3CDiYnim6NCQu=n8=S8V4J0Ej8fMaWC7bzLJKFjjA@mail.gmail.com>
In-Reply-To: <CAL1e-=gQF3CDiYnim6NCQu=n8=S8V4J0Ej8fMaWC7bzLJKFjjA@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 19 Nov 2019 23:19:46 +0200
Message-ID: <CAK4993gDA85yHKgHN-5J5g-KoEOYQYmkBgx806OLxVe4MqWJ3g@mail.gmail.com>
Subject: Re: [PATCH v35 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sounds good, thanks!

On Tue, Nov 19, 2019 at 11:18 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Tue, Nov 19, 2019 at 9:09 PM Michael Rolnik <mrolnik@gmail.com> wrote:
> >
> > Hi Aleksandar et al.
> >
> > how is it going? should I rebase or not?
> >
> > Michael
> >
>
> I am just in the process of taking a detailed look to the whole series.
>
> I don't have any serious objection so far, I may just suggest a couple
> of things that will improve readability of the code - so nothing of some
> really serious nature.
>
> Stay tuned (and be patient). Will hear from me soon.
>
> Yours, Aleksandar



-- 
Best Regards,
Michael Rolnik

