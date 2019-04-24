Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC38C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FF3218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 02:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSBebw8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FF3218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34340 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ7I6-0003oW-1l
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 22:05:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7Gr-0003Fl-B9
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ7Gq-00038J-8l
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:04:25 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:46150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ7Gp-000377-VD
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 22:04:24 -0400
Received: by mail-pl1-x62b.google.com with SMTP id o7so6195353pll.13
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 19:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KDivsViAOfCo4RFhgtCHKlZh3xZHxL33MKFDeHxfAbc=;
	b=YSBebw8diX/h5thr/IuP1swEcz+IuMhACpHorx6w0G89/8/weuAXjmExTeGM6EhagP
	xEG6Va/HBpM2Uyr0f9tKoXmHct5yyZwPHYwNHALPCrR/RAZxWzI+QoD2yVi0rZqxCFnI
	qmUTq0azoGokAHT6hjwhJFdbQG3bvlHjt4LIOCZDdL0GmtOVEmmqemMhclWhIsJUSOKz
	IriRchJOG0Wu5EP1B2ZxyEynWMj1RFi3P6nTE5qNUcUVh6k2gZX6Mk10RL9XpjtiEoxb
	GzOa5eqtfoTFT7v/gH0shISIlnxU+4bet4agsTu9FSfW7YNP9J5L1wlO9yJ/+zjzOX/P
	iCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KDivsViAOfCo4RFhgtCHKlZh3xZHxL33MKFDeHxfAbc=;
	b=UeiBuVi3A/UUe3xrEUnCrGPBhyRcR60qoM6msNoEf/jT85vJeBUux82b7YVO/o1CMX
	S4EvW/VvttR5bYcHS5+rYjyILQDBdIcI+aBqjen6fgsSDCo5scMhW4iwz8JcQwUPkAWh
	IBlUwFttmMlcEtKnV+yhUcwoZ6aKKVV2c9K3HPPg/xJC7bkM0Obu+nSVZzPspEEsCViz
	VJCwmOL1kDAF+/Uw9mRad9HHPBXRIfASEQxcuyua/hsoQFdTMlnEi8mMFGc96dNh0dcg
	I4/ctywEH6V0Z4M/t/RK7XFuaE8GnGoWEH6BTD9FqS+6l2M7bgj45/WcXsEkXKBHuTYH
	dKWA==
X-Gm-Message-State: APjAAAXUt7RRRlfMJCfv0K578X50TBtWtNMo1zsCTKlv6sD24U2/Yotn
	kHnVx6i0Ic/vvUZkVeqgHRI6VRgbW2E=
X-Google-Smtp-Source: APXvYqyu0TRt+zq169Y2vRAobmml+s9bAtn/OO2HS9ys2E1vuOTzD0DLGUkdml40GPAU6QgC2kXbIg==
X-Received: by 2002:a17:902:2b87:: with SMTP id
	l7mr29867358plb.130.1556071461788; 
	Tue, 23 Apr 2019 19:04:21 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id i2sm24611611pfo.9.2019.04.23.19.04.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 19:04:20 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-24-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <88fec784-bb2c-b80b-9e71-104296f063ed@linaro.org>
Date: Tue, 23 Apr 2019 19:04:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62b
Subject: Re: [Qemu-devel] [PATCH 23/26] target/arm: Implement M-profile lazy
 FP state preservation
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
Message-ID: <20190424020418.VV2hYPOVg-8rJ7I-oRi2vtZY_Iqr9QRkF-huAriMPoY@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The M-profile architecture floating point system supports
> lazy FP state preservation, where FP registers are not
> pushed to the stack when an exception occurs but are instead
> only saved if and when the first FP instruction in the exception
> handler is executed. Implement this in QEMU, corresponding
> to the check of LSPACT in the pseudocode ExecuteFPCheck().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |   3 ++
>  target/arm/helper.h    |   2 +
>  target/arm/translate.h |   1 +
>  target/arm/helper.c    | 112 +++++++++++++++++++++++++++++++++++++++++
>  target/arm/translate.c |  22 ++++++++
>  5 files changed, 140 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


