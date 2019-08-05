Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12475C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF17C20665
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X88q2QcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF17C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hudi9-0002JZ-Uc
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34594)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hudhn-0001sN-Bp
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hudhm-0004jN-9Z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:11:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hudhm-0004iU-2r
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:11:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so84701154wru.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Xt6UXRCxFBJRvWwckGEqLVkKph1Wzb3PwxOQD2KXTdc=;
 b=X88q2QcYnpmVzIc5yBwoEbG2mJGeHeR7/nuoWe0rsaWbSL+AEMlaHn4qJPj3csV3fZ
 NgTIBqLML0hDqUrhA+lzu9+usCZHo5ikIPZaz3sthxik+i7oAsxcAA5pR6zfFcEYUO9V
 PUjhwC0bKWG2JV8xKhRHlosyKtrqROXxiDcvjpNFje9dFHYXbTfSpKvGE3qJuOJbQ76w
 poBXCfTCa6xvjuadqlFzMwzHirGBqA/4tzgg/Nz0x0hik8XiMTwmvAonbWPdHXjH9nYQ
 ZWTiFrm7ekK8G+eiv2GIuHMepoFhGTR/Ci12iQ5defD+4VydW7YcZ5fztPZ9UThHRcdA
 I6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Xt6UXRCxFBJRvWwckGEqLVkKph1Wzb3PwxOQD2KXTdc=;
 b=P30t5PuemS2wM/q2ySNJfGDLdC9BTB5dSvU4jnnRpmkGhywT66vRD1UogO2JRuHoNa
 RWuWs6uO770Bjkw7kdoVt5USlCo92rn1wyvNxUsGbWSSrAdjKttn4UC8uS7Bv8Szy5Et
 iNduX4ClZo1jdhTcGpBTKLcW6TNwLkGcsWn+VYE0IpyrVIeuJ+dlj6tRLusXWAskcUDm
 /a3fRyxphhT3ZjtAUNhXgUXtivKAGpLoX1WfXFoKmCmAn73/ohqqvxt5zb/5G8BNnTBE
 +g7RkDFuINrGINMEgdcjxS+kO56t9CtO2SD9JKL35r7TYd+fyfLIY4CxZu3Hya5hmr/X
 g5vA==
X-Gm-Message-State: APjAAAVQmWHLOTafzCLeWAN6Zg0HEelmcauwHFD8PJC/5RvmW61kkSQY
 hkUwI6R7xMTzBW+9p6JORuoVQg==
X-Google-Smtp-Source: APXvYqyTIkMtowxzb3Ya8I8vtR+SYAFJFKlmP3sj15JGbFM4wyFs2/AoKuCzlPoZidfU+2uMB+Tssw==
X-Received: by 2002:a05:6000:1148:: with SMTP id
 d8mr5171916wrx.354.1565014276738; 
 Mon, 05 Aug 2019 07:11:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v204sm101751531wma.20.2019.08.05.07.11.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 07:11:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C10EA1FF87;
 Mon,  5 Aug 2019 15:11:15 +0100 (BST)
References: <BN6PR2201MB1251F757F3129C433E540F9AC6DA0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA8NE=hy4a-WuDuKeysi3KOjy8=ybHbLKkvzPM=ELvXBnQ@mail.gmail.com>
Date: Mon, 05 Aug 2019 15:11:15 +0100
Message-ID: <871rxzk8ho.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 5 Aug 2019 at 11:39, Aleksandar Markovic <amarkovic@wavecomp.com>=
 wrote:
>>
>> Hello, according to out docs, here is the procedure that should produce =
coverage report for execution of the complete "make check":
>>
>> #./configure --enable-gcov
>> #make
>> #make check
>> #make coverage-report
>>
>> It seems that first three commands execute as expected. (For example,
>> there are plenty of files generated by "make check" that would've not
>> been generated if "enable-gcov" hadn't been chosen.) However, the
>> last command complains about some missing files related to FP
>> support. If those files are added (for example, artificially, using
>> "touch <missing-file"), that it starts complaining about missing some
>> decodetree-generated files. Other kinds of files are involved too.

The gcov tool is fairly noisy about missing files but that just
indicates the tests haven't exercised those code paths. "make check"
especially doesn't touch much of the TCG code and a chunk of floating
point.

>>
>> It would be nice to have coverage support working. Please somebody
>> take a look, or explain if I make a mistake or misunderstood our gcov
>> support.

So your failure mode is no report is generated at all? It's working for
me here.

>
> Cc'ing Alex who's probably the closest we have to a gcov expert.
>
> (make/make check of a --enable-gcov build is in the set of things our
> Travis CI setup runs, so we do defend that part against regressions.)

We defend the build but I have just checked and it seems our
check_coverage script is currently failing:

  https://travis-ci.org/stsquad/qemu/jobs/567809808#L10328

But as it's an after_success script it doesn't fail the build.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

