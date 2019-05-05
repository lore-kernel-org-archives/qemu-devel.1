Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC5C04AAB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE20206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3KSTnve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE20206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42303 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNIiu-0000wd-U7
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:06:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIfT-0007OS-AS
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIfS-0000ZJ-Dz
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:03:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:42437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNIfS-0000YX-55
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:03:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id 13so5051306pfw.9
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=p4hUepoox6wJEwX/WDpygO1FVd+FIU3XpJhTElbmFHY=;
	b=t3KSTnveHrZJWX0/H9z2QMnUQN3M3wIn70wwF0SHq+XqRDcMsXTN4Etnu48zKMWIrW
	Rwovps9ndK+2v1EehjNmM3UhDzlF0dpkBqomZbW3+rOe0pp/Lm67eqAuvKbTRPgCirjV
	vKBGsC2FcXaLsNG9t+aVVR04Kk6MI65Zi+S+myXDQcTqsC96nAiKaWWRAmiFsyuzp1As
	WC/6HaA1P+fY0/fwyXSL90GYCYt4Oa2qf9FSfjLpsTKroa48mXZi0cAjAN/k5unaMjFX
	4llnKK26rUjLRxHF9rkBBrLbrXhDkFlP1h01Q/CIsP4Yy9U2QaZyotxOXmy+hZcqQwnj
	pY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=p4hUepoox6wJEwX/WDpygO1FVd+FIU3XpJhTElbmFHY=;
	b=XuBsbr/OuOP3VfVOw4tMo7tgTHMZEdZM59mFgsqmStOjEuToVT0cCxOJnZ93PPch03
	8jghQs1qVzjXTMGhobwSjX2l+TzPPgauVZ8RRo/WuGFKlDLY8YyovTKnT3icgYvKqhZN
	Mh4YlKdFF6lj0DTcOb/XUB/U/p0hBKwBPyiMlidtWHc4t8Mm3bksT3udDEp3laJXrZY2
	IktGwDqBgLIiRiJwROwUCnM1EsDBzGHBFc3jNsTH7dFW3IzNEnL14y/u5qhXFn2fZ9H/
	fv2sB/xH7UNMYP3EJT0pYPBu6Fwi+Chl7r9LfKUqvTSb9+S+QU7usBoAHZTJ/vCRth5v
	ew/w==
X-Gm-Message-State: APjAAAVgPrURo8ehGO/+b+beU/4yZdjWs/3y3h4TkyphEKlQnri14Aq/
	YLZbk/zF2EVpz1AS/s4udRt+Uw==
X-Google-Smtp-Source: APXvYqyzB/MLJ+qpQ6Q9InVHl6aoKDA4bWfI6bxa25mr9VD0LO5+1loR/dvh+NXfHUFdHuki12hkjQ==
X-Received: by 2002:a63:87c6:: with SMTP id
	i189mr24476521pge.367.1557068584999; 
	Sun, 05 May 2019 08:03:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	n64sm7496343pfb.38.2019.05.05.08.03.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 08:03:04 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
	<784adbd2-0447-9d01-cff8-e7234f9d9679@linaro.org>
	<ca2255e7-79cd-2ef1-5ddf-89edac2ba959@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <08ada731-8295-1295-a196-2f456f6de40f@linaro.org>
Date: Sun, 5 May 2019 08:03:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ca2255e7-79cd-2ef1-5ddf-89edac2ba959@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::431
Subject: Re: [Qemu-devel] [PATCH 05/14] target/ppc: introduce
 GEN_VSX_HELPER_X2 macro to fpu_helper.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505150302.EL5Rkk1mYQ5IaIA5gIJT3eL5BwTnsGoiFtdH3boYSXs@z>

On 5/5/19 2:57 AM, Mark Cave-Ayland wrote:
> For reference the culprits here is helper_xscvqpdp(). But again if you agree that it
> makes sense to create separate gen/helper functions then I can remove the opcode
> later on in the series.

Yes.  Or indeed in a completely separate series.


r~

