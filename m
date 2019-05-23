Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5A520665
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhmoTjMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5A520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpWD-0000Jz-RN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:20:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpSM-000640-IL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:16:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpSL-0000U5-NP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:16:34 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:33017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpSL-0000T3-HO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:16:33 -0400
Received: by mail-ua1-x943.google.com with SMTP id 49so2321052uas.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=q6BkwYnA3LMZb/vPh5D5GjjEYEOUkiYkYmHrGxhJUXA=;
	b=FhmoTjMD2CnFaeEx9TKlKnLLavxclyxPPEbvJ+DH3iJrUGTXrQikT3OVBOAVYA/cjH
	Q6EG3mp7VsbS30IKt8SfhVvuM7FcMkZIpXS8+ngBXPM+RX4fzHHtT4XlrXW5d6gy4hYc
	Qs9Y1PAL1X8UD21JcTvQHmV9OFai21y+JbXDTJ6qkSEiAhnPTrNb1MtvZZbSaO6ta5Kq
	akv6Z7Xu2F7ibUVXSy0SCesUYuBHKw0KDtp3CQMkHkC62o4yS+sctARYS/j8XeF6mVIG
	VlkQW5dEAtgUiAHSKscndI9Qi0w71IOuVobEMO53kHMEE2XjmEnsd/ArrgRvnhx+OVdi
	Xuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=q6BkwYnA3LMZb/vPh5D5GjjEYEOUkiYkYmHrGxhJUXA=;
	b=crw+BKZMybLCyu3ZQ2jcBKX18TrDm4lXeohQbao1SHIQEncr1OqjhUtKt8u/+vjasy
	QTpU7dP+HmO9oqqYdo1mx/q1h4k5Xk7JAqyexQLmKVAeoUqVZdKxmkOJDpYEP0kdmqIy
	A/phjr27LPuCtUmweHcM4AfYzTF8nEFHVGk3t22ckEOnMCdQB3KRGJQxiwc0YPQAGQwX
	VNMh6AsDovNJhrG0e6JLZ2/02/2iROoYPRXRoQAm5anrpVfFUaxCGdhhZH2qYC8Uyulr
	ZAPny4zK+Khjn6jUXgP/H3RBG9yYy28WK51GN+FbVI3+jcenWd1P7MgOkUVrpgVBDQnU
	wkYg==
X-Gm-Message-State: APjAAAUrBE9gjV50bs7mp+Uab4WF9f12m0YTEeufPIadz1VE29rIXpYo
	mJ1pIL25oqA8yrcA3WVAn5Qmaw==
X-Google-Smtp-Source: APXvYqzLLSEp8TL4I02ItwwJAllEBsL7Jc3agltwOs5gI4gwyVh3dT6f9lDMxt39FGWPkUKk1V/Jkg==
X-Received: by 2002:ab0:1849:: with SMTP id j9mr599743uag.75.1558624592004;
	Thu, 23 May 2019 08:16:32 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183])
	by smtp.gmail.com with ESMTPSA id s65sm222053vkd.36.2019.05.23.08.16.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:16:31 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0426116b-6141-34ef-a6aa-a269c6d624d3@linaro.org>
Date: Thu, 23 May 2019 11:16:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::943
Subject: Re: [Qemu-devel] [PATCH v2 04/28] semihosting: enable chardev
 backed output for console
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
>  int qemu_semihosting_log_out(const char *s, int len)
>  {
> -    return write(STDERR_FILENO, s, len);
> +    Chardev *chardev = semihosting_get_chardev();
> +    if (chardev) {
> +        return qemu_chr_write_all(chardev, (uint8_t *) s, len);
> +    } else {
> +        return write(STDERR_FILENO, s, len);
> +    }
>  }

Can we not create a default chardev that outputs to stderr, so that the
conditional is not required?  Or does that somehow interfere with how this
connects up for linux-user/?


r~

