Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB82C31E4E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD9B2173C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i73gryxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD9B2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49288 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhhN-00061i-U3
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbheR-00042d-Dn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbheQ-0004Ox-2U
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:33:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbheP-0004MU-KI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:33:33 -0400
Received: by mail-oi1-x243.google.com with SMTP id w7so1389034oic.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k63gQA02rgFARxCpogX2Yp+9WVSdoDx+SmkcfYrmLdc=;
 b=i73gryxEKkkuHsuZw/tsCWW8KX51/d+OnddMHKVTEfSmARssJk9DfyRxxbery8oYZb
 b6WiHwfZdBapGm8Fd3TyPpao7oQ8bBQj7Zy9J06OqvfV75M0ikDA5rb/dHrUoqiNLxCI
 sXnouCPdWD3gcY1izI1sdRHrIGj0EqYLn0MlBB9Ah1KIaj4eItr9PMf3VNl2Qz+ToNSU
 OwuIvNaON0x1fdaZiDxF/2IRhgmrwfF4nGkjNuUeDnaPgjLXmClk4kcS9szXAREtMJN1
 iCICqt2iV5FWjparBi+Z/wM7n53lgKHldsFdaQzvT6w78y31DFvQK5t/ZHyEzZ7dFaV/
 TqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k63gQA02rgFARxCpogX2Yp+9WVSdoDx+SmkcfYrmLdc=;
 b=m4LrZLUL2hocA4dXehMQfV9ofdESyEQuyKQ3pSe9kor9YUbg6+WEHMGYIh2RLnr4Tu
 67/Zl+7dCV33rEnsN7rqvm+u8IIq4MwdfJaEHGpe4rUd9P9aNonif3fBfRgj5H5JjSeJ
 wwV7p/hrO3omUxdQzxSdZBu50I+uFCQqVAtCZh2LhwyF6/v2AhN1UGp1Hm2KO+NoAD3k
 mf/uNHa+MWWj1RK6+K/VhadNdHXXBR0h3ekR8Luq8BgdtnDLdI/IQxPmESBMV+Qu55Kj
 UJ6EfPflRIT8BleLOgRVlwqBN6OERIhAmm5M0UFw6/huUqaP//Kr5kanzP6RVoiakRtG
 hDYQ==
X-Gm-Message-State: APjAAAVLk9/bpGYYp0nk9yFaozBtiA6IDyToCcg6Zbcs61Z/jDyx6ycS
 tMCD6J+ETQQy5zbFMkPQbo8AQWFbEOV5n7dbe7C2kQ==
X-Google-Smtp-Source: APXvYqwH9CjtZo3x+Jzawndn3zsK1XtWeskNv26Q54bPX46VNlWJ5m01uPTdqOPWvyL4+5Der3S2Bkf0+VNJOVS1CnI=
X-Received: by 2002:aca:ebd0:: with SMTP id j199mr1052564oih.146.1560501211878; 
 Fri, 14 Jun 2019 01:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190613041619.32102-1-richard.henderson@linaro.org>
 <20190613041619.32102-2-richard.henderson@linaro.org>
 <CAL1e-=iHb5khAaQeV1za8SnW=9O8mP-xg=t2Eaw818Yc9zdPPw@mail.gmail.com>
 <CAL1e-=hQG9roHkg5vf364_A5eit1McpwWAuHYj5Sqaz=KVzK3Q@mail.gmail.com>
 <CAL1e-=j5i4hG07svv9Ponnk77LZCy5cWT-AnChwKyStzXqVCMA@mail.gmail.com>
In-Reply-To: <CAL1e-=j5i4hG07svv9Ponnk77LZCy5cWT-AnChwKyStzXqVCMA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 09:33:20 +0100
Message-ID: <CAFEAcA_77CysjzsdONnb-aVutWpGhKinGmADTjMLVYf9eGW3gQ@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 1/1] tcg: Fix typos in helper_gvec_sar{8, 32,
 64}v
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 at 07:09, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> Peter, would you please explain to me what was going on with this patch?

The original patch was posted to the list on the 7th June; it got
reviewed and tested by Laurent. This email accidentally has "PATCH"
in the subject line instead of "PULL" but it's just part of the pull
request that got it into master -- that's just an accidental
error by Richard when he put the pull request together.

thanks
-- PMM

