Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA8C10F25
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2483D20848
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 11:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZU8wKliZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2483D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABWt-0008Kv-BF
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 06:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jABWA-0007iw-33
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jABW9-0007JY-4T
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:51:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jABW8-0007IQ-Uv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 06:51:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id g134so2060973wme.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=m2+UokHNY7oLK1kRDUP1+O3hVTNJpfF2j8uXSIX7Cb0=;
 b=ZU8wKliZEeK1g95j5nZgKvogKtcdYZHQqL5FBpMl7osicGGvF9WxJhEHGN16EGzusC
 yO6lcoBT/zf3qXV8DabCqBz64RmznS3RPfJjTbdeH9NIw1m/Mjqups07N0TNP77KPCQI
 uM6MKWTaRUctHjOkmJfE14+e3+95cHaxRnvu5EmuU8gxOBvW7HbjlEACHkUzjg1tf0Qj
 keEloKeK/L3GwirAbKrwjOYNYvUs/NjgaVVMHYriZON+mPZro1fcGTwGHAldC52UZlbv
 T3ztw499nUxq1c4fM2vQ7RXVpIcZ/Ach/be4xJL8ndX6x0lDObcoTHnk1qYHfxmYoC9Y
 y8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=m2+UokHNY7oLK1kRDUP1+O3hVTNJpfF2j8uXSIX7Cb0=;
 b=eqx1xyJBmNNGqAf0BAt8HfkmfOaMtu6OxdOvN4Tv8/apqd6B47w+9NfPJNj+pdHWWA
 V9CF8ePsOqKXmvOVKwRyPCUxP0C7au5w/1ADwFP8yjBp3Khz6Wu7dNtIXoJwhAyCanGN
 jXX+niYLJ4I+DWc1bDovPOeRGkmoZfQk9fqyB6qWi5q8MvxR5MRcCTv3y2xI2LaJoaOe
 H0SoSopU9l/2pufn3v/GQI8HUFsVuIlHxcb7sa4xd1Sd/gLpHzxsCLdd3x/AajsoxR5D
 CnguL+e2wdMbMXEZhmVBwe+RlqIXpGRnosrE8k7+0/KGMwpE2AZ8F8ANxafVUdT1dhcT
 w8Qw==
X-Gm-Message-State: ANhLgQ3mWneKvf9Sa2R/PpBh5dvg5d4h3PGsD/Elubzxk02lJmxUltFc
 Ukx54Hh3ngbfnJHXFYpSJdFPdw==
X-Google-Smtp-Source: ADFU+vuU9kaapgUXDsCGhtbHBXJSGdjEULRjX0QJdxkV7gV2Au288J9qWqrdMZkmKOR5WOvz+2hVZg==
X-Received: by 2002:a05:600c:2951:: with SMTP id
 n17mr3490886wmd.97.1583495507831; 
 Fri, 06 Mar 2020 03:51:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s22sm12705397wmc.16.2020.03.06.03.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 03:51:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3051C1FF87;
 Fri,  6 Mar 2020 11:51:46 +0000 (GMT)
References: <20200212202709.12665-1-philmd@redhat.com>
 <8b511e74-b965-dc42-be6d-fa70d752cf29@redhat.com>
 <fb494baa-33ef-addf-0866-f3ef5befefd3@redhat.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/3] tests/docker: Fix linking with VirGL
In-reply-to: <fb494baa-33ef-addf-0866-f3ef5befefd3@redhat.com>
Date: Fri, 06 Mar 2020 11:51:46 +0000
Message-ID: <877dzx66r1.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Dave Airlie <airlied@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> ping ping?

Queued to testing/next, thanks.

>
> On 2/24/20 1:20 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 2/12/20 9:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> We link with VirGL in our debian-amd64 (cross-host) docker image.
>>>
>>> This series includes few fixes to keep testing it.
>> ping?
>>=20
>>>
>>> Philippe Mathieu-Daud=C3=A9 (3):
>>>    tests/docker: Update VirGL git repository URL
>>>    tests/docker: Remove obsolete VirGL --with-glx configure option
>>>    tests/docker: Update VirGL to v0.8.0
>>>
>>>   tests/docker/dockerfiles/debian-amd64.docker | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>


--=20
Alex Benn=C3=A9e

