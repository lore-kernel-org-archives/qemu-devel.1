Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D70C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C801720989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1P2DEDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C801720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLSa-0005wG-1e
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLQW-0004Sj-7C
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hjLQV-0002Bu-9x
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:26:48 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:37998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hjLQV-000293-3j
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:26:47 -0400
Received: by mail-ot1-x32d.google.com with SMTP id d17so8598937oth.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=16fA2OsXVR6dcesRp2AEGiS/kRZSFACyxCBCFuQSuyw=;
 b=m1P2DEDfdd6/pRLKDn2VnZqtC9gpzXPMRsUUwPBoTgCd5l18hEJbgQV/ETOLw/Tzt9
 /782jWpd6roUrp9Gbluks+lm+QblY/g7MgUNBS+Cd4YybxIthoG/RzUMR5E0/1EiI76X
 xGl6qx6SOoyWzZteGZj+85oT3JUKO6jgIYlJZEuFEHrJuIlvuPrmiRl889BWblaJjIwU
 qK965lf10p0EWK64hoChTwhfBKMc9fdv2ZRSpFyrHmL0JcFwdHB1BLs1Yk3wTUi7qGJ9
 iLnGK/Yki5zkCToM8xcWp/YHYDiIzw5isoGMksq6ejtR9hQ7oJyt7yiM50mkUZWk21u1
 40yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=16fA2OsXVR6dcesRp2AEGiS/kRZSFACyxCBCFuQSuyw=;
 b=mifp5B+f1+CEPiaZCCnCHFj8cLea+44ddcPb2pskK97jdJYURCwq2ETyK+yI8RELYH
 ZSRCF9VO0bnjc2iMfDHqAlgQ+X6pf43/Q0vTWqUKCp/0f8sY67thpfY/dLDa64rD2mq3
 7jFLJQTzw0+sPHmJPU5rAPUfOYHBVs8EoYmqf0QyOK/1Bpp9sak0CHGFEF9K/CjXQWVB
 RXMKxEPp+iSMIkhTklshocv7rSSWok1Wrq/CRl4CI4pYdD8O0NVydbjG8F4NSPIgCXnt
 rwEqONvVWzmm8+vuDQM+dMPR0uFJSj7nPr3dTQAcKsaRxFPFFfy45hhQ3g9KdjLBjuXa
 ECWA==
X-Gm-Message-State: APjAAAUPDpcX3ZHfXc+C4JCq1uREeudHa3EsK3vJl3NQcfILMlWQZ4+k
 0mDZnrLn0FqWF/YXUptpU+iE0LvHhzLDFyIEecLaH9mkRKc=
X-Google-Smtp-Source: APXvYqzmuKhWFTGP/MDsg2Vp7U5D2i3tRO1DlDSWzyG1sb0praI51hx7GZKflSkNdG/l8kNhs8NUYIH6rK5av2HHiBk=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr2331356otn.135.1562322405599; 
 Fri, 05 Jul 2019 03:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-yzWhwYPzC9px0H-=x3XEPVBjZOhk402is49YpbmJX9g@mail.gmail.com>
 <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
In-Reply-To: <ac682594-fac7-ca67-2cef-85db15920c7c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jul 2019 11:26:34 +0100
Message-ID: <CAFEAcA-=SkSiafeAQ0W34bgwdQYnN_WeqZMyrz6UvdSHROuyCQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] pl031 time across vm save/reload
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jul 2019 at 10:48, Paolo Bonzini <pbonzini@redhat.com> wrote:
> By the way, the data sheet says "the counter and match values are
> compared in a comparator. When both values are equal, the RTCINTR
> interrupt is asserted HIGH"; QEMU compares the RTC value (read from
> RTC_DR) and not the counter value, but Linux code seems to expect QEMU's
> behavior.

Rereading the datasheet more carefully, the RTCMR register
description is clear about the behaviour:
 "An equivalent match value is derived from this register. The
 derived value is compared with the counter value in the CLK1HZ
 domain to generate an interrupt."
and the section 2.2.4 on the "Update block" confirms this.
So in hardware what happens is that there is a free-running
counter, and an offset which is used to derive the actual RTCDR
value from that. For comparisons, the RTCMR value has the
offset applied in reverse to give a derived value which can
be directly compared against the raw free-running counter,
with the equivalent effect as if the RTCMR value was compared
with the RTCDR.

thanks
-- PMM

