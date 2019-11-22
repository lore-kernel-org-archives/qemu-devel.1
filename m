Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578ADC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 23:10:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F23320704
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 23:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIT9RlGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F23320704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYI3u-0008GY-95
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 18:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iYI3G-0007l5-F9
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 18:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iYI3F-0007Mw-4n
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 18:09:22 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iYI3E-0007MU-SJ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 18:09:21 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so8117111wmf.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 15:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=L9PQ/94vz1xFCXF17Ukk+dt8Df98cS/OqxrhTl1xE/k=;
 b=VIT9RlGmyS16b5V6oiae5I7PdxxtHuqUFOMffufCT9ReX/5ml/NAk8TElnQ4pEJ5G1
 w3rhxhYsx3EFYbGiqtI5x7FUdbIxzdSjnDcA2VeFYjZ5mRsE2tXo0DLQYrdn9kYESJKO
 FFC2OwdjEMAg2JL5GEn+pZx4PA4FL43q5BwmW141pTTT/B582p6hhnljhHX/NHdL8h0F
 qEhQjniig9JK6wbXatCzUeb9Qj2o2HZAuHLbzvel3/5sbwQaQTb+qXenIgGx0W7/XJmI
 y4ySQSFXtgNtz037f1gGYJRr45hdLWjQlkmSeAZwqH71lQmILgb5IzJt5qh0QWmo3gEh
 2tbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=L9PQ/94vz1xFCXF17Ukk+dt8Df98cS/OqxrhTl1xE/k=;
 b=Hr5Z9HjmdTXo7Y3RAsF92CKFNbyyGimrsiN2qA2K7e8bWRu5ovMEfkPRbfCqvPHsIW
 c0quLwZ/+rIfBmOcDw7x9G+EU+kHTlzEM6qs7lsac7sq9DweyNpKy/aWxsrsJM3cAWvp
 ZOeGiLG4dKZZgGtycfpKGcEz4gt9sLz8uBIjQYQBJepb23c6riiP0FBT6HXyAH1Nsob4
 DU/RJtF4trbEYFztMP5BQ8HgNGPWLSWwKToWy7+GxLaFW0+7TFbKAIEclAoctsRTAkV9
 aVnZJK5WpuuLskgiXJKO0OvsKSib748iA9SrYmbf1/ziDBmAqE+6zf+HPsJji/Hcry6/
 hgZQ==
X-Gm-Message-State: APjAAAWTdss3P1Bl2112dg6tx8VhpzoPsp7zL7Qcx41v160C25e7wBAI
 NhxyIYh3/HnrMrcma226h62StA==
X-Google-Smtp-Source: APXvYqxbQInfzl2WYwhszdhBULUE6I0LrBWN13RIeG0kbKwog05KubvRUn//xbNrOn93f+IFonk5AA==
X-Received: by 2002:a1c:2395:: with SMTP id
 j143mr18138015wmj.128.1574464159365; 
 Fri, 22 Nov 2019 15:09:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 2sm9334629wrq.31.2019.11.22.15.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 15:09:17 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E79EE1FF87;
 Fri, 22 Nov 2019 23:09:16 +0000 (GMT)
References: <20191119170822.45649-1-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/6] Enable Travis builds on arm64, ppc64le and s390x
In-reply-to: <20191119170822.45649-1-thuth@redhat.com>
Date: Fri, 22 Nov 2019 23:09:16 +0000
Message-ID: <87wobr7bkz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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


Thomas Huth <thuth@redhat.com> writes:

> Travis recently added build hosts for arm64, ppc64le and s390x, so
> this is a welcome addition to our Travis testing matrix.
>
> Unfortunately, the builds are running in quite restricted LXD containers
> there, for example it is not possible to create huge files there (even
> if they are just sparse), and certain system calls are blocked. So we
> have to change some tests first to stop them failing in such environments.
<snip>
>   iotests: Skip test 060 if it is not possible to create large files
>   iotests: Skip test 079 if it is not possible to create large files

It seems like 161 is also failing:

  https://travis-ci.org/stsquad/qemu/jobs/615672478


>   tests/hd-geo-test: Skip test when images can not be created
>   tests/test-util-filemonitor: Skip test on non-x86 Travis containers
>   travis.yml: Enable builds on arm64, ppc64le and s390x
>
>  .travis.yml                   | 85 ++++++++++++++++++++++++++++++++++-
>  tests/hd-geo-test.c           | 12 ++++-
>  tests/qemu-iotests/060        |  6 +++
>  tests/qemu-iotests/079        |  6 +++
>  tests/test-util-filemonitor.c | 11 +++++
>  5 files changed, 118 insertions(+), 2 deletions(-)


--=20
Alex Benn=C3=A9e

