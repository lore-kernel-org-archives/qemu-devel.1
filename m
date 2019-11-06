Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32932C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9472067B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ntq7UL1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9472067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJLO-0003Ex-So
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSJK7-0001ub-QP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSJK6-0000kX-MR
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:18:03 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:37357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSJK6-0000Yd-Cc
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:18:02 -0500
Received: by mail-ot1-x335.google.com with SMTP id d5so8459102otp.4
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 03:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YNT8S/9LeIj7psN7Vf7sCgvzleyXwOoW7DNAR86XYG8=;
 b=Ntq7UL1nTr/k2o2yPUdts9TVnL0RzI6ccS7PbB2pcVSvQsOqfWFphgh3cAAd0yd+FR
 HtwqhxBKTJ3ljp2Udq3lIps/Bmm0vNXnE4KI0k4Zqtvlgct5IzkbUA6g6twLjwy9xFY+
 0OLfu0Ql70g0PcMUM3RQGofL/G/SUtvmfFXoEG25hVD+mwZrgV0ora5BnFL1fa0iEPZ6
 5fanElZMHOVaLPTOkFQ5ftT+yhWKPbxi3IxLOF21vQHOt8t/xI4Xhr41wiWJ2C8Zg4QJ
 5CnNtLYcn7hioEW2JuqQT3pz3Tq0NLo5rtgDycsgqsAv9IgoIlBHbEl1uX2elx038IW8
 UP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YNT8S/9LeIj7psN7Vf7sCgvzleyXwOoW7DNAR86XYG8=;
 b=UOqROdjKmytJHA8N0RY/78h9T/T0GldY3TwDNDt4gAWUzp7w7jyzLMwv2fErmRYJ6e
 GluWH41eWCYCaftUO/U5+oXqai5KiWwZWZzoT4zCU23bkXJffoHQB7c8YZE0iKmhtpL8
 5x1kF5ZU9WII6vsyomSXSJKw7U6/cpOCjP5AnRFsc3VtHWTcUmPxtIj61TXujA65pabL
 GmuzOIo8DLi+tgsCwbvfssAe/DIzt+xbuFpWJttTsNm3gdSxdOigZr1yyk7eR+S5rukX
 P/WTQGK8BboPozE9uLScWotsf5ULaCqmwW5+h1T6Qg4cVS6PUCajCj2VDJXXU+gSUtOf
 hCdg==
X-Gm-Message-State: APjAAAWaDqLrRgNORx3tSxkzofioad8hxg2VR04pAAlRMLmAIzOXicNw
 LSkhqWZuL7tZ91bLjeU+ga+O8TxLrk1LDNgR4BZPzg==
X-Google-Smtp-Source: APXvYqwp3Bd8Rpp93n752lmg7eKOF1kVOX2MlCpxbt6zBFivhSYPPmOuQjQUMKaFKmTYpGwdz1xF/NLxbicWezQ8leo=
X-Received: by 2002:a05:6830:c3:: with SMTP id x3mr1415236oto.91.1573039080274; 
 Wed, 06 Nov 2019 03:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20191025203427.20181-1-ehabkost@redhat.com>
 <CAFEAcA-F0iB2vzi3Z0J9FPAt6JpuMh+V0wsfXWLuAGX5_d69xw@mail.gmail.com>
 <20191105195748.GG3812@habkost.net> <87y2wuhy00.fsf@linaro.org>
 <20191106103633.GE91675@redhat.com>
In-Reply-To: <20191106103633.GE91675@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2019 11:17:47 +0000
Message-ID: <CAFEAcA9LqhboQH5_NAJF5XbE+PbX16dYuRd60Tz_R_Y215QhMw@mail.gmail.com>
Subject: Re: [PULL 0/1] Require Python >= 3.5 to build QEMU
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
 Ed Maste <emaste@freebsd.org>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 Nov 2019 at 10:36, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> At what point do we declare that NetBSD CI is broken and is no longer
> considered a supported platform from POV of blocking the merging of
> PULL requests ? It has been preventing the dropping of python2 for
> quite a while now. It isn't the end of the world in this particular
> case, as dropping py2 is mostly just a cleanup, but I feel like we
> might benefit from setting expectations for ongoing platform maintenance,
> otherwise these kind of issues could drag on indefinitely.

It works fine for me, and it means we have coverage of a host
OS we otherwise would not. To me that is definitely more important
than being able to drop Python 2 support. Also, AIUI the problem
that's blocking updating the NetBSD image isn't related to
NetBSD at all but is a bug in some combination of QEMU itself
and our test framework -- both of those are things we need to
fix anyway.

thanks
-- PMM

