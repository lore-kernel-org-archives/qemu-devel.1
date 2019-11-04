Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC2FCA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AFF21D81
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxxBJiIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AFF21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRajl-0003wI-FQ
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 06:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iRaj7-0003X1-9w
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iRaj4-0005jQ-Rh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:40:52 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iRaj4-0005dl-Kk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:40:50 -0500
Received: by mail-wr1-x42b.google.com with SMTP id a15so16647425wrf.9
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 03:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UbBo53fq9Gq/A6nJM42Vcs+1hCTj/ozFqDpYJVpbANY=;
 b=GxxBJiIR85WrPSjJ6vqO1D6Z+FmFiH4Qye68Mk6TZbj5/nNtTWRoZ2m3HrFfVzAsMa
 EH93QPbBEoZwKiHLHi/wwxjzyVvHZ4HRP/YUZ6bvy3xDNy38KHzs1przZyCsMoc5/ZEA
 a4p3pMGgdc3gWqtRB5FBJSkNroD4qQbjN6gbJTnDHn9UqdodEabv0+kaM00C3MTbIU6L
 G4kXXwnzv3gPVdI56HSWfL0FIY07UEFyEhzrxPoNy59bh36mKrUxbdfDLCJfXTkB+koI
 V+z7iKuhuN05vfbU/6KMtUAPMwaroYzcAGJjiZNxkC5WpNrpmL9AYSxRJcF9gYIYRrAx
 yZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UbBo53fq9Gq/A6nJM42Vcs+1hCTj/ozFqDpYJVpbANY=;
 b=ll9WtqCpJPGYWpPK/ZxYLqdlsOf+EZXSqOklNuoAKqAo+qnROs+YLK6c+Sp2616U7f
 clv/7j/ySIfvNlstId2K7vrGvV+KHBd88X5W8k0CIEglR51JzMB3qttjB+7t14YWmXKL
 MTlWZZ9gxGz//45wW4AwxpErGLkDdjsojFp1+HPF4dkGhSE73T8K89/y2HKnkBmhfLYY
 tiCBT+Ec0SCfRPUis4NVTfRyPWDrqjh/4Uo20XcPFWclgSFET34EGkOR5xIkB3+c5w/l
 I1DhbBkvNaiPaNACMevs5S2iRc4j1wvxu5YLw4a+Ynm15f6swjcnexbncYTEEdD/M4qv
 EKlg==
X-Gm-Message-State: APjAAAVUqc+xBmgzULq0L9kiQi0naS15I2vXCqi+ElpMhEx9HENn3sbf
 cMRSjo85x9FqZ4W0OKOn/AdjTUYLwHw=
X-Google-Smtp-Source: APXvYqxGPcXko4koYh/J6M3LYL1JbUGJ8AMNZM+Ae8DBso4OFGQei2DZ/cRv3b171dhh09ohBldPPg==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr24126611wri.16.1572867646509; 
 Mon, 04 Nov 2019 03:40:46 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b14sm6354140wmj.18.2019.11.04.03.40.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2019 03:40:45 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F40CE1FF87
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 11:40:44 +0000 (GMT)
References: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: Feature Recommendations?
In-reply-to: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
Date: Mon, 04 Nov 2019 11:40:44 +0000
Message-ID: <87wocfkgxv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dinah A Baum <dinahbaum@utexas.edu> writes:

> Hello all,
>
> I am a university student whose Virtualization course has tasked me with
> contributing to an open source, virtualization related project. I have a
> little more than a month to complete this. I was wondering if you could
> recommend a feature you'd like added that could be done in this time
> frame.

A month is fairly tight for adding a new feature to the core code given
you would need to get up to speed with an area before proposing some
sort of change.

That said review time is also a contribution to open source and there
are plenty of patches on the list looking for someone to try them out
and poke around. Have a look through the list and see if anything jumps
out as interesting to you and review that.

If you want an area that is fairly self-contained you could consider
experimenting with the TCG plugins interface and try to measure
something useful about the behaviour of a virtual machine. See:

  https://wiki.qemu.org/Features/TCGPlugins

and the example plugins in tests/plugins - which you will see are all
self-contained experiments.

>
> -Thanks,
> Dinah


--
Alex Benn=C3=A9e

