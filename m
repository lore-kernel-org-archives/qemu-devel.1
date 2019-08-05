Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A12C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51ED520880
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 11:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJjT0aL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ED520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huam6-0007ib-KH
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 07:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hualX-0007K1-FZ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hualW-0004S3-HA
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:02:59 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:39385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hualW-0004RY-CC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 07:02:58 -0400
Received: by mail-oi1-x234.google.com with SMTP id m202so61709552oig.6
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 04:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kiD5f4HESIE5SMZ1TAGkyNwLLJDhHZEdMm6vWOAewWs=;
 b=zJjT0aL5nTqlebCUJHmMH7JQs8WeW/kpZ4yL/ufDdIbn9lUpOmIXJPsiwISEX1EYS1
 kgTK9utUwp7oI/FNFUubsfHAJn8EWLekq9MI+XQExZCH5s2NhD9tCrjWa42wfuufQXqh
 Plokf+FKEuj45L6m93W2GDnLDDOIUvJouex5BZSIjQeJudHAI2IcwpTR1hno4FmpXdE6
 C0c+kp/pJunsf8v9u5reGNk9q/U+yu40F0Wfftw0VnaleqwBkQ3p80WCLOyv1/ij13zi
 o38b2nl3YPzYz5/cM38JZIenVpc6sbqUnSr2rB4/quSiS1fbPuzjIdzLLLEFfVTKid+Y
 XGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kiD5f4HESIE5SMZ1TAGkyNwLLJDhHZEdMm6vWOAewWs=;
 b=cJOWN6vmz0S6o9jf7yOL5KFjbN/QRLOTO3xaqKKZaJm5ljxhpkFnAzfStwHTjDNxFW
 1SsADmT8iFOvDuWriby5X/Pcrgva3KQusJ5WYBvMnOo22iOie4mD35L3h67edlzQl+qu
 0K4BE9w+GPBfbCUy8DH3YsGS9lWYDxl29OhMW9/1O+dueRwoxvP9hq+/ZSK7EfzPqkTu
 3G9d5vbQ45Cedu5F66nXjMJL3HrbO5X1tbBBbnpi5XuYr9mKXoT+AJfPxt71jIv/2s6P
 3WEvZfJSdaXJTsvcO0xdmM5zXjmdrU+syHAMwrKPjYCng+ZG1ekaq30CBFByuZn/x9D0
 u5CA==
X-Gm-Message-State: APjAAAXzfuE+Ey8VK2NK20Fl6cMCRjwhMlFX5VocGFPkV2xpmW7M2jUi
 B4XdXLiDQJCROHrNJAF+p97zumnBTOy3tcIPiHUCfg==
X-Google-Smtp-Source: APXvYqwLMwV1JZKI72WkzJTlOdCiyOIxCiPcpVMkAo3oc2TQfPoHaLXbgct5FDyWNWl/Z6odWRal5tj47anQ4/4sCOU=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr11122582oic.170.1565002977219; 
 Mon, 05 Aug 2019 04:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 12:02:46 +0100
Message-ID: <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [BUG] gcov support appears to be broken
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 11:39, Aleksandar Markovic <amarkovic@wavecomp.com> w=
rote:
>
> Hello, according to out docs, here is the procedure that should produce c=
overage report for execution of the complete "make check":
>
> #./configure --enable-gcov
> #make
> #make check
> #make coverage-report
>
> It seems that first three commands execute as expected. (For example, the=
re are plenty of files generated by "make check" that would've not been gen=
erated if "enable-gcov" hadn't been chosen.) However, the last command comp=
lains about some missing files related to FP support. If those files are ad=
ded (for example, artificially, using "touch <missing-file"), that it start=
s complaining about missing some decodetree-generated files. Other kinds of=
 files are involved too.
>
> It would be nice to have coverage support working. Please somebody take a=
 look, or explain if I make a mistake or misunderstood our gcov support.

Cc'ing Alex who's probably the closest we have to a gcov expert.

(make/make check of a --enable-gcov build is in the set of things our
Travis CI setup runs, so we do defend that part against regressions.)

thanks
-- PMM

