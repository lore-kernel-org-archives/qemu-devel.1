Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F719C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611452082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwX3c0zc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611452082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41909 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNIBc-0004AZ-JE
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 10:32:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIAt-0003tf-2A
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIAn-0004zP-ML
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:31:27 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNIAk-0004uE-Tv
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:31:23 -0400
Received: by mail-pg1-x541.google.com with SMTP id i21so5119466pgi.12
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=riruDpyllqu8bKJC1MSxQY73H43e1hEBZlYO6NbzElk=;
	b=ZwX3c0zcAjGRXm+95hl0PxKWgwVVQ1pYjRG5Q4Yac6Lu9pxhlUNTVgbz0/LhS7AGi3
	Oky8WmXsRmBiIjTkxI5fpmCDmZ6YReuGR5/+AU9VtlMtuNsnnO9m+n3+puAEdxzsM97a
	jUpxOD1kkz8yyHRr3zuW216Ucx9fJIzXnbVT4tiGuYKW7kZkCfFPJ1DQsS0rJo7V52LU
	R9/BF9QTH/tgw8AaZN2MsPEQHzicWzn7a7G7YSZWQxK1I9pUUqS+3FBkAsetAuWoMnd3
	8tqDbqk5ou3uDdsTGXBWo4rLDmh1jvQCVepDMu3yHUK2mSlgl3KXMshQr8c9cv1MoosJ
	3NOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=riruDpyllqu8bKJC1MSxQY73H43e1hEBZlYO6NbzElk=;
	b=C3VBcCn655D/o452ReVeNuAdhIErRRS8AgPYj4jHrL80mVFUJKGFj/7crs2XQIbWFp
	3vjv0XS7edcxoTCVi2gqsgfxgBWNgHZZDAZBYxExOOflzoFahXeJ/ObZbpu7tdParbwt
	Qj9xw8BWyVx9FE3plWjFVvV3H16R4vukrYEJjAHZn/Gq2Dpx2WlttmNl8iVGpALGTsOd
	68mGKPBmL1I1vPbjymLfkJ33X8CBYL4uiGFGY/pABX5DtcjN4Iwll86THVkjA4Ua+jcR
	mxN4Qm4Tbv1pILIycSDHoGPsjPLJezXllj1bO1ohPXIm909T8jyDhCSPYOqGVXQ5ImKL
	HrNg==
X-Gm-Message-State: APjAAAXExhVJVoh757OGXdWrHqLnL6S0HZEbdrJzdJEUVUtg1LXTyCFI
	5QYZqPjxSFRh1yqatRWN9dHU5Q==
X-Google-Smtp-Source: APXvYqzwYBKVgo5lov2KxXye3PGc2nYVBH9bcoT1nsknlLPDH+9fqlxytPualatruqKtS50aRLay2g==
X-Received: by 2002:a63:db55:: with SMTP id x21mr24193957pgi.219.1557066677182;
	Sun, 05 May 2019 07:31:17 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	y14sm9709783pga.54.2019.05.05.07.31.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 07:31:16 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
	<fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
	<98ba8d01-dbab-ecde-ffbd-bb46efb29215@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9059f977-6ffa-e701-6c1b-2f8d8cca2c64@linaro.org>
Date: Sun, 5 May 2019 07:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <98ba8d01-dbab-ecde-ffbd-bb46efb29215@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 01/14] target/ppc: remove getVSR()/putVSR()
 from fpu_helper.c
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
Message-ID: <20190505143114.lEmXwpUvgnkVu52gwXTsXr5TpzunkUCeBg29aeR_tDs@z>

On 5/5/19 2:27 AM, Mark Cave-Ayland wrote:
> I've spent a bit of time today going through the functions and it seems that all
> functions which have an xt parameter, minus a couple of the TEST macros, require the
> result to be calculated in a local variable first.
> 
> I think the best solution is still to remove getVSR()/putVSR() but replace them with
> macros for copying and zeroing like this:
> 
>     #define VSRCPY(d, s) (memcpy(d, s, sizeof(ppc_vsr_t)))
>     #define VSRZERO(d)   (memset(d, 0, sizeof(ppc_vsr_t)))

Local variable, yes.  But I see no reason for macros.

  ppc_vsr_t res = { };
  ...
  *xt = res;


r~

