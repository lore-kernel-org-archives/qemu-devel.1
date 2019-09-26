Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30033C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 23:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4260206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 23:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxkMgfsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4260206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDdYH-0006qI-3H
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 19:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDdXL-0005bL-R5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 19:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDdXJ-0007a6-5S
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 19:51:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDdXH-0007TG-3x
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 19:51:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id y21so4294988wmi.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7umqgr4M8ne7SR4/etrMVzOow3OW0bvV7ZnqNQAmkpg=;
 b=yxkMgfsRUqpFZ15YeJVRP3gmOggaN8TCo2qto5nwIhCK3z9+g8HCmV4Ie0Sdsit4WB
 Bn6y5oN1XD3GOSRjiJZaZrSwcISiNMRQt499ALj57VTEYO1/r5KY1TP20P7OC4EtMNRK
 ucOFxF6lljBZGqkNKkcY1nBDssHSDVZDO93cONgs0p6Jw0/7At3tL63e6hjnJGq+/bw2
 UiWrpGbLP12Izi+DP2kMwbpyCbOXoYRLEaypCBDboKcXGBjrpXF9IQPQAZ3vtvf1j3w3
 a3Zw1Us+XrjyDO/OYuKMAryT6+1kJXbhmx7DEuNOo7buUa9uPnXYgHen0zw4YYwbQxto
 mgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7umqgr4M8ne7SR4/etrMVzOow3OW0bvV7ZnqNQAmkpg=;
 b=GiRcg9IRbJCIkJHlmqnuCzjz7fvwKfSy0VRb6wlE48o3i97feSBV1kme3CLuTz4/BL
 lUR3gPy8unQWpcTEoe8MbGor/FI0ne0yPs7Yc0YGA65FRm5RXI5uiaF16DeeNfrpWn2A
 GdPHj/y9F0G5dlRwmtCrsX9uVizh0sh2KXvXCtHpLvIhXr13UqunS3oNb1PC7HZ+RCYz
 Oe4BwD2XigUmFslqT+v25AwmJF4G4H2dlGmpe1fNk6/xB7uAuDg4z+xmmqU3eDAedXxS
 uEt6llQtft5TdYiVXeHnhgtyLXlISzani/YWcAhKUlTKv7J4qkgpTAiTwLRCtnk9iU1v
 y/rw==
X-Gm-Message-State: APjAAAUmMm2N1841mpqURV2G0WrQGT6DryQEd678JUSBSKpEhO8nyicj
 +9mtfxEH+OP5EHq3ltdS+Iylbg==
X-Google-Smtp-Source: APXvYqwOoryv4/oRCQqFNPWggxPQmtHFNrhCDdXZPCdSVRkCQc7Z9kC/G8W2es5RRYwZpkZgTmAEHA==
X-Received: by 2002:a1c:80c6:: with SMTP id b189mr5216972wmd.34.1569541857362; 
 Thu, 26 Sep 2019 16:50:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm2418111wrg.55.2019.09.26.16.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 16:50:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4D73E1FF87;
 Fri, 27 Sep 2019 00:50:55 +0100 (BST)
References: <20190924113105.19076-1-drjones@redhat.com>
 <20190924113105.19076-5-drjones@redhat.com>
 <2beb840f-99cf-d928-0926-c284933c78d9@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
In-reply-to: <2beb840f-99cf-d928-0926-c284933c78d9@linaro.org>
Date: Fri, 27 Sep 2019 00:50:55 +0100
Message-ID: <877e5uaa74.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/24/19 4:31 AM, Andrew Jones wrote:
<snip>
>
>> +#if __SIZEOF_LONG__ =3D=3D 8
>> +#define BIT(n) (1UL << (n))
>> +#else
>> +#define BIT(n) (1ULL << (n))
>> +#endif
>
> There's no reason not to always use 1ULL is there?

Also we already have this helper in bitops.h so should just use that.

--
Alex Benn=C3=A9e

