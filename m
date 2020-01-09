Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F40C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B667F2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uybbotla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B667F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNSx-0004O5-T5
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:22:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNRk-0003Wz-CA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ipNRi-0007F8-PP
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:21:16 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44614)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ipNRi-0007BL-HU
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:21:14 -0500
Received: by mail-pl1-x641.google.com with SMTP id az3so1891051plb.11
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vNvbvaxUyMUkkHNFuzQUWgi1KyA9aBa7ywd8667D2Oo=;
 b=UybbotlaHSba60zAB4CJtoOzQWk4NtHnV8fhDeYRB1bFtb9iaLC0SE/Ao2pddl2zsV
 +fPGVLGeyfSmqocZNbgxbJqC9J7FsdfKLZg66NC3wZ8kDKlGHgZCesDfNqRZ8swq4SJF
 wpCa+K0XBb1KSG10Hy/EL83yU/jtgvvsCag9p+tWhnlgfd+7PoiI4VUgmK43OFkeff4a
 eGTecelRJP0SLhJmSyHgvY5y8LCCRFi5hHPCkasUwuj3ZpaZa2wzeyvg3jS+mPbV1W0l
 qCOT10N3+uWigKzhB2Dor+YIOsaMkfBzg6NMw97japGYvsLf6JbAvhVacfifxhILNY2Z
 qxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vNvbvaxUyMUkkHNFuzQUWgi1KyA9aBa7ywd8667D2Oo=;
 b=XRYmjKj29dBtOHsOXDSvzAtJtKsi3RXJkomXgWSWlXTvTIbopPqmuyvcFkYgaK9nh4
 8lAwZlADMDKyEqzMF0p2VlYHc4SY22PZl/T9vPiTcwZ/aGuKQdzkS6OIUDlum+onsrx2
 MN7j28uCP77aIcG3JNMHZGzSELNlTbcEODCVNW+jAlTg2Kp+PJlSU6NI20cCCLC4WBMa
 KM8L8qImkvNlZkRdKAuoJX6Kt+c8GxxT01aJrOGSk/TuM2Y0mYcyVJdJ3RDtmSCx8aV8
 8X+py0G71HILvBSqahxFHImeOaLq11SZz92C/tSqlzKCZB3DSh1CvdJX8kkvqqSPESta
 2n8Q==
X-Gm-Message-State: APjAAAXjYIPpXQc9ab6WcCE92EvHZmnXaAPKzhLEF1b6kSQKJqO/lm3p
 o5HaTKcq1WZAeZw25hwhxGd/TOXqR345SA==
X-Google-Smtp-Source: APXvYqy3jIQr6vNF7rLb72Jnx6Z8Wf7gLZv8lZK2VICjAsKp/VAqVOze6L/uieHrNpc5u5EmjPkxFg==
X-Received: by 2002:a17:902:c693:: with SMTP id
 r19mr9444769plx.25.1578536473152; 
 Wed, 08 Jan 2020 18:21:13 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id x7sm5351232pfp.93.2020.01.08.18.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 18:21:12 -0800 (PST)
Subject: Re: [PATCH v2 0/3] hw/hppa/machine: Restrict the total memory size to
 3GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
References: <20200109000525.24744-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2cbbd1b-d42c-2cad-2d59-678c44aca046@linaro.org>
Date: Thu, 9 Jan 2020 13:20:52 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109000525.24744-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 11:05 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>   hw/hppa/machine: Correctly check the firmware is in PDC range
>   hw/hppa/machine: Restrict the total memory size to 3GB
>   hw/hppa/machine: Map the PDC memory region with higher priority

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

