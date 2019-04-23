Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7593EC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F3A8218DA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoPDTzQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F3A8218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ4Qw-0004UP-GT
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 19:02:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4PM-0003Fc-18
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4FI-0006jb-BV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:50:37 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4FI-0006h4-1O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:50:36 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so8212396plp.10
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=X6Qg0UxUwsh7DxVq8KHeKxEs4+PVKw2QcqHUsUh4EEU=;
	b=YoPDTzQqOBt6uQD0eYXr4sNjgNb60VU7SkS75XGKbbhiv0MhyUWv1FW5F7cIcgNApt
	r8pX69+zUpiYwI8CSKDIXL4as3Ok0/TwdJhFu+lfyWEtLHRrls1NlipkmyK+1BgWP6j7
	NtMXVgW8RINa5DqEE2fusCitUoKeeWUeQyWA2dTLiH8b+QOsxxhNo/uQAO8TkC2y1cq0
	FJRduwCD5nikck4VJ57CHvPpiigP7Nj/YPTNGBSlM552lJiUsDn6FFHdOdGqptoKVRXC
	NnIL3HaXG4birqaBYIiLqnSvWKRnUvjIx0rmTtuqSASx/6AIEFKwy014bRe+GAa8e1Hk
	jfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=X6Qg0UxUwsh7DxVq8KHeKxEs4+PVKw2QcqHUsUh4EEU=;
	b=er7vgwhX5EABZ3DRTA1gblTb3KyUf7PtzQ6sAYB1O9QnSY3dyzsnx+pTweCzFwBqUL
	G9cht19LLUlyyvb9EuZXnlAduW2bOyUNOVqReGg9jVAgmxkqy0p7RgCpxZCCy6SNFizm
	upaYkRaRd9fDpn9Mp8Aa7KQ4G9wZjVxLvUO2LKALX7nOqA690eBkjl4H3w3ntnSlpv1g
	9s43aQFHBCrPP4HvUTkK8Zewxr0cSfzcoK25MBheVMJTIMpVSguLmthcXDwMftHhMXop
	AUHIt833A/XjTFQHCaexHWtkuds5CkcuiE1+eZy7lxMBQUEDrlTZarWeQTdXCBiDylpV
	cHCw==
X-Gm-Message-State: APjAAAWo6DLsJPMgU6XtHS4/5Sg5ZGN97xBwFJMZgwuvBI+5TKf9iU2+
	ZK4wjKB8HeoI+3JuAlx+YWLZMjckNDA=
X-Google-Smtp-Source: APXvYqy9geMurzDjIpSmsyi40BtGfdRaS2w6rLXrG5/RC85XFuVAsv0YS9e2Aal6B9qTVhtcPYntcA==
X-Received: by 2002:a17:902:2a:: with SMTP id 39mr28524637pla.64.1556059834592;
	Tue, 23 Apr 2019 15:50:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	p3sm22089176pfn.167.2019.04.23.15.50.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 15:50:33 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <67aeb166-5e80-668a-33aa-3c556a843ecd@linaro.org>
Date: Tue, 23 Apr 2019 15:50:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH 12/26] target/arm: Clear CONTROL.SFPA in
 BXNS and BLXNS
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
Message-ID: <20190423225031.9j1Pfs7AJP7dmxNJrdPjNqnkY5NJs5nldhaOL7yTt7U@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> For v8M floating point support, transitions from Secure
> to Non-secure state via BLNS and BLXNS must clear the
> CONTROL.SFPA bit. (This corresponds to the pseudocode
> BranchToNS() function.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


