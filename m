Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD43C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:00:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532DE20862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 21:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwDbGFh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532DE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAKab-0002pH-Gu
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 17:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAKXM-0000ff-9e
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAKXL-000287-7p
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:57:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAKXL-00027q-17
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 16:57:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id y135so3278513wmc.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=np129mybhd/vuVCXo5ULaQj+GDt3pkAqILKA3NJ0Bfc=;
 b=fwDbGFh6I0+v7PctVwJO5Et7VPKhrk69Bn8Pw0BeoD4oE1MZ1K+O1FQgX3uNjYeoix
 om5nTceBlIQWQmEhNZ2/446Xvh4Ee0AdFnlEmRlWo6RapaARVEwBAtNjKJH7FcVFs0g1
 iloCgnXuqv3RvSnYiNN50UWIqxHPq1RpEd1+uPkJvdEOp/fub3a43wW8/B7QGVue1pK7
 6ZgesSvUKFb2R+2oJnsFOEmMXGnDbPdH9Y/zu34sYiexyW7HVKh/DKxcVHcQFuXCVy6E
 EfiP75tM7TBac2AT03z9qw95vv8Y8yd1sw/QRrvdsW0NcoClLG2/yHJ+J1gYvAY3kOi7
 fERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=np129mybhd/vuVCXo5ULaQj+GDt3pkAqILKA3NJ0Bfc=;
 b=dfbDlrnb9IcCjLRdieQ3q2PPXCfTcWjA5BmyVifp0h1Sr1rSKRNV03UhK1pran0EYy
 SSU47iFKd8EvKW8uRWm/13OAe8gemyGDdqhf3ndcTzFY9goEF+DXWZNn5GrFFUYdWMxo
 9qxkNOinIujxERRL4HG62XrouRLEEd1GsjAGKAsICCqNPpXeVTV85sHEgl7U6PmAIN+p
 dn8msUlWmYfatJ5dj0ixxInBlCV+0YHfXGunB9NzU2uCTOahwJvbz8QP1PfGr6z0gExp
 rSqJtAVIU5I6609VF96S1BWyYaBnQ7GMV569kH5llRog2DhHemj37A3uVFEwZd4GBwRZ
 kdSw==
X-Gm-Message-State: APjAAAVRnKQhuMW78NdaO717xQGgyEY147kusEykr3z3JSF7F3JhGgCk
 pTZCslvmTG+K8VLqZv5L0X6Fvw==
X-Google-Smtp-Source: APXvYqwoiUdhBKgFIYNRjdK/ekEcrJvqznkL3mxdmBAcwson8+7LFsnIPJDQ5yoCzIZRJ5IHTfqv1w==
X-Received: by 2002:a1c:9615:: with SMTP id y21mr27704wmd.5.1568753841535;
 Tue, 17 Sep 2019 13:57:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u68sm42377wmu.12.2019.09.17.13.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 13:57:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2FE211FF87;
 Tue, 17 Sep 2019 21:57:20 +0100 (BST)
References: <20190917184109.12564-1-alex.bennee@linaro.org>
 <20190917184109.12564-9-alex.bennee@linaro.org>
 <73df6b9e-d096-f58f-dfeb-aad0c8e50d39@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <73df6b9e-d096-f58f-dfeb-aad0c8e50d39@linaro.org>
Date: Tue, 17 Sep 2019 21:57:20 +0100
Message-ID: <878sqm1w0f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 8/9] tests/tcg: add generic version of
 float_convs
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/17/19 2:41 PM, Alex Benn=C3=A9e wrote:
>> +    for (i =3D 0; i < ARRAY_SIZE(round_flags); ++i) {
>> +        fesetround(round_flags[i].flag);
>
> If we're going to make this a generic test, perhaps
> continue if fesetround fails?

I ifdef'ed the missing symbols? Can the symbol exits but not be settable?
>
>
> r~


--
Alex Benn=C3=A9e

