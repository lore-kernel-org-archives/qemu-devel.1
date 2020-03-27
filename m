Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13E4C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B44E20714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkdFYSrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B44E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlT4-0004PL-Qj
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlSS-0003yD-Jy
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlSR-0008N7-6z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:39:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHlSQ-0008GA-Nn
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:39:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id a81so11551098wmf.5
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8x3tJQqEa6xWrOpvUcfa0LsgUB3yoPw7wq5CyaA9iJs=;
 b=IkdFYSrZaOs/n0+8v2jYa1Q+7zZbu88lnE0sHAwPQF1Bv7Ih0BnOgto191VduOONAw
 Qi/pGcBUnrF328nrYgWhfWigpaz95NYsRUXoYAAPAWO03FQj81gl9/qEpfsR808PrnTo
 FBbVsREpqoUFQ+3VfzZRHhur1pX/0nWuG/2ceZcT34QYqDGWQz2XOPhyq0eG5lHWifr0
 9k9yvFsyLTHtfP1JmEVaeuw/T/Z5EZzszUoh+qn/R9AKXi7Dgx1tmv2Ve2D0WVpCAZQz
 kbfG1wgEPFWchGp8Gn/5IUEDFPcka9AGvLCEuQvsJEzLY16IaQevdlYhxTKxdy5yMrNR
 miIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8x3tJQqEa6xWrOpvUcfa0LsgUB3yoPw7wq5CyaA9iJs=;
 b=Z2G++SSFgj0sZlymc+SIEUG66YIalKMKPB0B205vFBAkTysY7XLwJjv6RBLg47XGye
 wnHxMpdiBhPKHif3eKhs92jhhvvf6wmzJ03MyAoR57C1OPdOJOVMY5WLJcUlzBn9kuqG
 wzCtqMpjxpUV58V4TanDUC8nwsHlj10pIKQZ7m5RldRQtb4ck2AVCCTspnxXIYRIwr8F
 xDmSqaIwRHhJ8AIwSk4PTOLqpduR42lx/o1PPsmVzwrDDKZx6rR/YfuyA3VmUVArmqrP
 D8S0U+aHqEt8gPICe1Np+m7WZTtKCsaiCZeAxJDrFvlrXK5yZm7dPl4r07NQBtWQIc+X
 3duQ==
X-Gm-Message-State: ANhLgQ3CTRw6ucSueZrfkWNjSmT/JTzuqW7tXz/5cwkClW5Zr3Kir+9c
 ArpKe3+k365lyl3xanyCRbWNfw==
X-Google-Smtp-Source: ADFU+vtqS8ohfpPo+AE7aGKLVjIYiu1mxUYl5uY2PeatUqBkLvDmXuFBPWrunIBaq5e2oBMjGlBb1g==
X-Received: by 2002:a1c:a950:: with SMTP id s77mr4360199wme.176.1585301957024; 
 Fri, 27 Mar 2020 02:39:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f9sm8165375wrs.36.2020.03.27.02.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:39:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 04C021FF7E;
 Fri, 27 Mar 2020 09:39:15 +0000 (GMT)
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <CAHiYmc476rMd71t5ZSdz-pgVZ-i_3RBY=U3bO0aYEOOt5P3V_w@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v8 00/74] per-CPU locks
In-reply-to: <CAHiYmc476rMd71t5ZSdz-pgVZ-i_3RBY=U3bO0aYEOOt5P3V_w@mail.gmail.com>
Date: Fri, 27 Mar 2020 09:39:14 +0000
Message-ID: <871rpennlp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.puhov@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Robert Foley <robert.foley@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:

> 21:37 =C4=8Cet, 26.03.2020. Robert Foley <robert.foley@linaro.org> =D1=98=
=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> V7: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00786.html
>>
>> This is a continuation of the series created by Emilio Cota.
>> We are picking up this patch set with the goal to apply
>> any fixes or updates needed to get this accepted.
>>
>
> Thank for this work, Robert.
>
> However, I just hope you don't intend to request integrating the series in
> 5.0. The right timing for such wide-influencing patch is at the begining =
of
> dev cycle, not really at the end of (5.0) cycle, IMHO.

It's not marked for 5.0 - I don't think all patch activity on the list
has to stop during softfreeze. I don't think there is any danger of it
getting merged and early visibility has already generated useful
feedback and discussion.

--=20
Alex Benn=C3=A9e

