Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254F9C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 05:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E02206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 05:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tc7PDnHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E02206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jInND-0002Wm-WF
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 01:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jInMY-00026s-B1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 01:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jInMX-00033F-9A
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 01:53:30 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jInMX-00031t-2E
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 01:53:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id a23so6313239plm.1
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 22:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IZgIX4hCq1yyGNnYP6FJkY61QsVVDSFodDb51aywDNY=;
 b=tc7PDnHWpDVyPPFwFnkjxNi0Lj4csNMtAGCpyBJKL866+DFM1M47GzaioxmGCH5qXl
 OQAPwJjRv4VbrLbhCeBRJPLiUbtXOIdS3dIS3Ta+zaXFQFDzGx38A3awLXJtHNl2e/eB
 rx3SwUTrjD5DkyxVLDwNihMsOSRLYQW6wx9l0+i2ezAH8cC8LY2gpMqiVkP4gQtETJRV
 rQbltlAnxHFVLirHXMxodIYeSr5jr6TZx05PiGURIm8t6hAeqpqCoq2WPp2aOI3EetVS
 drRIdJmv7L5OzAINjtZKEvoXLCzdY72P/GniHFgxDHcy6s5WkaOZ9NaSpYoeT0p76zZJ
 Qp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IZgIX4hCq1yyGNnYP6FJkY61QsVVDSFodDb51aywDNY=;
 b=DfVLaZjY0ldw8lI4zSMbSrXNfZJJXg/xQ73MW4ZX0HO97jctSRHhiJ0H5FdD190mKL
 RbTVYL2tf7zEpelkDzjjipSGPI893Ina9MTdET2N8bygmhCDviv7KtDsug3CsJMXC7dZ
 DXxV2U9TPnb1IM5cjRF2QryoX/COOV1Ztp4o3Db28WjWXT4YZnOOk7bgCGHnB3zAC7Br
 wZ2cRCcmYyqh+kYF0agdIGnE45Ty0OWdQno32Ao9VAmXYwQlWyS6jsUK1t914gfLjAjm
 zpNUz+QWEnWakc8SIWsv6O6MTwEeMzFhfQc83AuylTC/mCgdQSc11YL95/ACVnwRpcdS
 QoFA==
X-Gm-Message-State: ANhLgQ2pd3B3TYomL4VWOllYJAtCQgvdd1E/mMXMzkSNfY5ZQMkCp4HW
 vsG7zqJhIw/WPGFywrqkxjYJzOtmgA4oTrLg6O0=
X-Google-Smtp-Source: ADFU+vsthtKE2DhXY0qAfYWdcMYUXMDt0ee8h7HT4wp/F6b1iRXTDFvuCwj76KnQtxHNw9HzcSMvxTFLFs1k/XcfbPo=
X-Received: by 2002:a17:90a:14f:: with SMTP id
 z15mr13729645pje.137.1585547606637; 
 Sun, 29 Mar 2020 22:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
 <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
 <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
 <CA+ZmoZXfrGh3+jnN4K-cfZitR+DVPL=ieZpTZGzH3cYSxko=eA@mail.gmail.com>
 <CAFXwXrkkOzuS=4Gfqm9XtkL5kc5m_5-9WmuziGgTfhFdm8VD0A@mail.gmail.com>
 <CA+ZmoZXvQ0iduKP_zWA0wTnpVSjjx=M6d5knWV-cayVuSQ2usA@mail.gmail.com>
 <9072334f-e4a9-cc6d-7c72-b97110e74cbc@linaro.org>
In-Reply-To: <9072334f-e4a9-cc6d-7c72-b97110e74cbc@linaro.org>
From: Daniel Brodsky <dnbrdsky@gmail.com>
Date: Sun, 29 Mar 2020 22:53:14 -0700
Message-ID: <CA+ZmoZUwTYsFv73sfhgexRDU-+qqk0P-Teje+mzu4Rn+D2=YQg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 28, 2020 at 9:12 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/27/20 11:38 PM, Daniel Brodsky wrote:
> > On Thu, Mar 26, 2020 at 11:01 AM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> My preference is to add -Wno-tautological-type-limit-compare in
> >> configure, so we don't have to work around this same issue elsewhere
> >> in the code base.
> >>
> >> r~
> >
> > What do you think would be the best way to add this? I could change
> > all additions of the `-m32` flag to instead use `-m32
> > -Wno-tautological-type-limit-compare` or add the flag if qemu is being
> > compiled with clang and `-m32` already enabled.
>
> I was going to add it unconditionally, with all of the other warning flags.
>
> Except that it doesn't work -- clang-9 *still* warns.  Clearly a clang bug, but
> there doesn't seem to be any workaround at all except --disable-werror.
>
>
> r~
Using `#pragma clang diagnostic ignored
"-Wtautological-type-limit-compare"` suppresses the errors (on Clang
9). I could go and drop that in for the problem areas? There's only a
few so it wouldn't be a major change. I'm thinking of adding a macro
like this:
#define PRAGMA(x) _Pragma(stringify(x))
#define IF_IGNORE_TYPE_LIMIT(statement) \
        PRAGMA(clang diagnostic push) \
        PRAGMA(clang diagnostic ignored "-Wtautological-type-limit-compare") \
        if (statement) \
        PRAGMA(clang diagnostic pop)

and replacing the problem conditionals with it.

Daniel

