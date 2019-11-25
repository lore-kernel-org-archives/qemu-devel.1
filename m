Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D38C43215
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE5A2082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CPM+NTZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE5A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBdS-0005HD-T4
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iZBbu-0004KS-4G
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iZBbs-0008Nu-Nw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:28:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iZBbq-0008F0-Pw
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:28:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id t1so17265207wrv.4
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2kGHdoRCx641DJsEOZ/vpH54AjjNTvEMMEbWsSP/MZY=;
 b=CPM+NTZsmi57+VMUq17QwBLcdqdw2wccKbVs9ex8+8JvAGBul8mxuqocsvqukjUuDD
 FlBBchKKOqX2DVhhhjdkHNefu1LuMYZyJOq/UxEH+ymuVRhGuf0L1oqKTE81hf9D3gVC
 L4Aj2qc484ifeuxFAfCQWjN6VN64Z4Hqc6VCwOjklJkedAo4HlNkvLial943si1VdYbb
 4Y8Q6O57DtFuF734ak38QcjljdozGRft1qwljeX/82c0hr48mPNViwYxw1vIBhzEdRor
 kcm1hDXlxR9JYzYoXMUGkygt6lj+9z7w6371gfyg5/WuDtSWmLgi/UGk7rBN9xHW59J+
 e+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2kGHdoRCx641DJsEOZ/vpH54AjjNTvEMMEbWsSP/MZY=;
 b=NvGjIjdK/kJgG+LKNwm7YNBMLqizedp++VzKCs5zeBPOyCWIITu/CVP540M9xC2JRI
 t1M0zq6p1oEReVqaZbhj+cQU5DuaZYQUjX6fPUESpOATGD7sM8YTsC/xtndnXW2Y022M
 +7Wa2Kj7Pzh3iCUnDtLTVrC45xMl10HxZf61S4aafBy6K9O/ehECRnbpMm8q8PMn3+Da
 4fJovP+GmmPweCuRP4/OYgYBnj8ijeEh7aIXSmkD/Z2QYiz8wCgLUgLO3HEaUnxRhPgX
 FUTN8niB73/6B2yifbD3sfAvYB1T2gGS3jYLqLMi+iYoNpTngwt9/bADBZ1csjnyZ+V3
 5wIA==
X-Gm-Message-State: APjAAAUaKTFVcrMmwxqG3eF0NoSm74BIaUNxzDsmcGk6lqm7Rcli149o
 0MQIzrCdIkFLKG7L4RbthMlNiA==
X-Google-Smtp-Source: APXvYqzJdud2GJqjeE+PUAnuQltD/aVUSIeaBuebdVBNfvDofZl4TUbfzI/BGrvZafWyAZ8owSY8Sw==
X-Received: by 2002:adf:dc0a:: with SMTP id t10mr29566788wri.138.1574677724693; 
 Mon, 25 Nov 2019 02:28:44 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v184sm8308801wme.31.2019.11.25.02.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 02:28:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EFFA71FF87;
 Mon, 25 Nov 2019 10:28:42 +0000 (GMT)
References: <20191119170822.45649-1-thuth@redhat.com>
 <87wobr7bkz.fsf@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/6] Enable Travis builds on arm64, ppc64le and s390x
In-reply-to: <87wobr7bkz.fsf@linaro.org>
Date: Mon, 25 Nov 2019 10:28:42 +0000
Message-ID: <878so4gsh1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> Travis recently added build hosts for arm64, ppc64le and s390x, so
>> this is a welcome addition to our Travis testing matrix.
>>
>> Unfortunately, the builds are running in quite restricted LXD containers
>> there, for example it is not possible to create huge files there (even
>> if they are just sparse), and certain system calls are blocked. So we
>> have to change some tests first to stop them failing in such environment=
s.
> <snip>
>>   iotests: Skip test 060 if it is not possible to create large files
>>   iotests: Skip test 079 if it is not possible to create large files
>
> It seems like 161 is also failing:
>
>   https://travis-ci.org/stsquad/qemu/jobs/615672478

And sometimes 249

>
>
>>   tests/hd-geo-test: Skip test when images can not be created
>>   tests/test-util-filemonitor: Skip test on non-x86 Travis containers
>>   travis.yml: Enable builds on arm64, ppc64le and s390x
>>
>>  .travis.yml                   | 85 ++++++++++++++++++++++++++++++++++-
>>  tests/hd-geo-test.c           | 12 ++++-
>>  tests/qemu-iotests/060        |  6 +++
>>  tests/qemu-iotests/079        |  6 +++
>>  tests/test-util-filemonitor.c | 11 +++++
>>  5 files changed, 118 insertions(+), 2 deletions(-)


--=20
Alex Benn=C3=A9e

