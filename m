Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3510C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB3F2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efNA6GIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB3F2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDtHM-000823-LD
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDrBb-0002Qt-IJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:57:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDrBW-0003RM-RS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:57:47 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:47095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDrBW-0003Hf-Ir
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:57:42 -0400
Received: by mail-oi1-x241.google.com with SMTP id x5so306217oic.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LMkxuNZp1x7K7kF8fUz7qKbme8Dr4Ol6lMm5Q8gGMJ8=;
 b=efNA6GIAAI0c0M0d1+7twOVhRieTBERAMr4UqRdohi1GbiKNfhv6hg+tu5fRnCEyAj
 obNSicBiPLbRcIC/bKQeIlk79augb+JRWUdqvF5yB39qtYP/ENEN4s0hTKoJYsIZGkX2
 q3JIcz1AC3aDz6cNoXn75wpU9Lrrp+VXKevNdvUBaUXJ7AeqbmnnLtuZxfFkyv7UISoO
 AINNdjRy51R7QaFhLZWQBA5tSv2IpL9ACvFfHJPHDgEpcNfy2TgTHGLbEMJvZgGcnAA/
 DFJTxaD/sEXwbjx2glCWYq6U7bJyqGatNmgPEV+8C549h43G4AhtU7qnYxvBULRInxj1
 fSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LMkxuNZp1x7K7kF8fUz7qKbme8Dr4Ol6lMm5Q8gGMJ8=;
 b=itJS3Q/CwsB83UibibkMkvX7fANwoB3Bch6v4ZFzCKww8Y7WAwIcP1Dax69ocGk2Mz
 ZTFQW0sudM+xDZKja4aIJro15BnnsApCAmNqaEqYHvSqOErVpK5wwoQMD/rGsj38wpK4
 3uWZvPrj6ao3QmazL6GJ+VHD5IzVXkzG/d5XPwYCgldtUE1JNAo5Hu5XT3jbMCc/aLjJ
 Uy3hAZ9UlYDofL5HnIG8oV9FnPTEpvYV4KOlV99WwzoPA+C80iYFZTr+q3863qYU4QXX
 lDXND9adXHqm6PadrC4Jhphy9TXNDF18JGrUfX1p7N/9maGjz+aZw7mJJmMaSX9FpvqP
 nnvA==
X-Gm-Message-State: ANhLgQ3rL2PhTaslBTczQiW8lkFQ8T/TKQ98mb0Ufrjm6JKf10geWylm
 nfpyoWITdCTL1gbTt5I/tzco3FTRDpmnEboMuvt1ew==
X-Google-Smtp-Source: ADFU+vulDdcYA2iR8QOJnj/lP/+vV2CuhkVXQikXFRTSfoFbdN7ZV+xSDQvBpfp7uLkn3RoKR2XASnpUCyciTaDVt2s=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr16919130oib.146.1584370661630; 
 Mon, 16 Mar 2020 07:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
 <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
 <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
In-Reply-To: <849930679.1334346.1584361606961.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 14:57:30 +0000
Message-ID: <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 12:26, Cleber Rosa <crosa@redhat.com> wrote:
> About the runners and the fact that the job is stuck without them,
> the message seems straightforward enough, but I can't get to the
> project configuration to look at the registered runners with my
> current permissions (set as "developer").

I've moved you up to 'maintainer' status, hopefully that is
sufficient to look at the relevant config ?

thanks
-- PMM

