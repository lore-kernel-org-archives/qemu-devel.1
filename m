Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B04ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1485E207FC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbANcbUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1485E207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsXX-0005Oa-AJ
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMsW5-0004UB-6F
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMsW3-0008Jt-2D
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:39:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMsW1-0008JO-QS
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:39:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id r19so16876018wmh.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RVfOV6+vzCEv+4tUnGAZcmZ8YwCAFMIXrM0sehmEWx0=;
 b=qbANcbUc7xy2eD/DJaTQA5iMXa1L/VoUKJSTNfWialAMX5PYvicILnRRC/2WGIZGz0
 Pic0D4/e097ZIboKthXI6XBJBarFd2+iVBttT/n4/GFE5Eow7Tb2Pmnj94ddTCJv5KcY
 dZ2T1xP7wOhb9jEE2SnCFvI+Ky8c4RyyUR4pgcpRsgnkY/c9pQ11i2UdrSxqSCbV5w8H
 qbYAiVvocXxwLSl52xh/zdl/MHYZwMV/UxWz20L7r8QeXWQzE9y4LLVARCYNZwF/Ot1y
 wz6iFlI8TTx9tMLfRHApnkM/qL/XbMwTVFwjeIPflOO2qRUUUVqNRWuZBPI1S63XIDiA
 Z95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RVfOV6+vzCEv+4tUnGAZcmZ8YwCAFMIXrM0sehmEWx0=;
 b=KgGGl54rV27XSSlxVOeSugiGEffW4EAjvK0M8HxorbVXe1O+kkeyFw51QxItjfuslQ
 m6tWxwhMvdNagfPrPMskQOQfuDjJvbYxhJ/dub//ADFj7b9EUyvGYZPdE17QSk0NmNqX
 v75NX4NsuCvXfTOXnZINqd+OLAIjKtFLq2U8T09rTfdnYqeV+puLOiFBG3hUq04KNgQT
 AhFmdAK7FDsA81kdpSsi2MG4Muk7cqeZNuqR3XSWAZa4NRPv6LMBoZdlBeuWbn6JWX4k
 Aabvcinr/jKRWs1ndBZEdrrpLfeM+HZLQEfzKt1mSjFagEh+M2mV+usxBA7R2i9E6dKF
 4Suw==
X-Gm-Message-State: APjAAAV9q4qJuhiqGWRUbTnLCjt2hRizM3t4SzGoSfLdfzGriUijwrqA
 tfYzJGpL1+BcP5oaaUuao+6I/g==
X-Google-Smtp-Source: APXvYqwrqYEpA6QcmYbEGzfS4oB0sm2a8pCEoYizrWs+s1snBUj20FShdMRmG5Twusjj3ui5kDNYPA==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr2739245wmb.127.1571744392517; 
 Tue, 22 Oct 2019 04:39:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm11312352wrn.46.2019.10.22.04.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 04:39:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C021E1FF87;
 Tue, 22 Oct 2019 12:39:50 +0100 (BST)
References: <20191022072135.11188-1-thuth@redhat.com>
 <8e7b1ebe-edd7-6a45-e95b-dd2fd0d6f1c1@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/6] Enable more iotests during "make check-block"
In-reply-to: <8e7b1ebe-edd7-6a45-e95b-dd2fd0d6f1c1@redhat.com>
Date: Tue, 22 Oct 2019 12:39:50 +0100
Message-ID: <87ftjlvwjd.fsf@linaro.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 22/10/2019 09.21, Thomas Huth wrote:
>> As discussed here:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg00697.html
>>
>> and here:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg01388.html
>>
>> it would be good to have some more valuable iotests enabled in the
>> "auto" group to get better iotest coverage during "make check".
>>
>> And once Max' "iotests: Add and use $SOCK_DIR" patch series has been
>> merged, we can indeed enable these Python-based tests, too.
>
> Oh well, some Travis jobs are now running too long and hit the 50
> minutes limit:
>
>  https://travis-ci.com/huth/qemu/jobs/248158477
>
> ... so we either might need to remove some other iotests from the "auto"
> group again, or change the Travis jobs to include less targets...
>
> That "clang + sanitizer" job was already running 45 minutes before my
> change, so it was already close to the limit. So I'd suggest to change
> it to include less targets. Opinions?

Which one is clang with sanitizers? I think we only build softmmu for
gcc + sanitizer at the moment.

>
>  Thomas


--
Alex Benn=C3=A9e

