Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D1C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8072081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCD2Gb7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8072081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42397 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMaJz-000618-6H
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 11:41:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMaJ3-0005Yy-17
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMaJ2-0004DY-41
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:41:00 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35270)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMaJ1-0004Af-Lh
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:41:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id t87so2496111pfa.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=J8NH6j4wRJjl9tnNHFWrJAzQEwCw/Ua6k8E4+tIFN8I=;
	b=ZCD2Gb7TeyIsuZHHdN+RSGiZB5L5YGQzxjPwZX6aKPjb0sTEJPm1zDEojwmdUntFNW
	CwGa0kr9IOIg4APBP5TgkV2zrc6jtW26ZP/nPMTFawI2Rn8mDMoCx9yjoaQKrtck1aPn
	Di6Usb4LrhksfRUWWAoZaODBZJyn12l+UMJ6p0c0koxp38/aS7yhlgiNT7z+gcs0UUZZ
	CihrWp72OqgXts+7Yn6HzyZZbZmKfKCUIAjw3PkBoIW5HTZqKaP+FaxQ7cy0+//HI5m6
	3km+1C1bnCx0TStBT4wYWBmL3DDnLHpO9RxfN0e1f/pjtjST0PxW3NnbQ9zSEIMjaBrj
	CvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=J8NH6j4wRJjl9tnNHFWrJAzQEwCw/Ua6k8E4+tIFN8I=;
	b=qnu2Ivn4d6sK4U9GTMlHfFo0VgbevvICbqxN+fP6+IplJKrg0IXax+i1BaLeusl9Iz
	G3yqdq5CSkh9vFNAn/cwoVjY9xre+O/9nwa3BLTwIIEtlLxtDHPY9jMlR9NqpOnXe/5D
	HTYVK2mwwFRtMt24q0ujTWMk+gkXvjCaZty0CVntrak+WmESo2Ei7meIJ8GsZBqMerdo
	DrLOVFbTIMf3ogI7Rx6WpAIY+nFuAz75pWLmYz68i4B/StiYpZfkuZT0HTaWLa/sudOT
	eFfwvYbF30pXYMb5TxhY3m8DNagpq3CWMWlnQ583AF+TBoQ+n/hb9Nrl7TM2Y+lLalUN
	qU3A==
X-Gm-Message-State: APjAAAXQIe0ys3MdawXrcJ1dPkp56RXnRmamFwmPULkjcRW09n9zPrCM
	e+tsaarkXQI+pcNG8deIi2ENJQ==
X-Google-Smtp-Source: APXvYqxLbBfkzZ64h/sKwKmOV0gKw27a0qpXBqOifqpFWlTOOqSK0kbR/Q6HiJ4/15ibGOsLDcuqJA==
X-Received: by 2002:a63:5b58:: with SMTP id l24mr10800728pgm.139.1556898058437;
	Fri, 03 May 2019 08:40:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	f14sm2966898pgn.77.2019.05.03.08.40.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 08:40:57 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190503120448.13385-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6aa00050-1856-b96d-a5d6-ece2f794ef08@linaro.org>
Date: Fri, 3 May 2019 08:40:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503120448.13385-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Stop using variable length
 array in dc_zva
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503154054.scm0yo93pKL6fq33u6nFQu4aHatgf7A4yCA2mbx47MQ@z>

On 5/3/19 5:04 AM, Peter Maydell wrote:
> Currently the dc_zva helper function uses a variable length
> array. In fact we know (as the comment above remarks) that
> the length of this array is bounded because the architecture
> limits the block size and QEMU limits the target page size.
> Use a fixed array size and assert that we don't run off it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * use ARRAY_SIZE() instead of sizeof()
>  * add a comment to make it a bit clearer that the
>    expected size of hostaddr[] is only 2 entries
> ---
>  target/arm/helper.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

