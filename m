Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B66C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C133F2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5TnFHVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C133F2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifENS-0001KF-0F
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 21:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifEMb-0000iT-DQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifEMa-0001X9-F7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:38:01 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:42612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifEMa-0001X2-8h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:38:00 -0500
Received: by mail-pg1-x52a.google.com with SMTP id s64so330546pgb.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 18:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pSHE4/4kZo4fmk7WZTpI8ZXurfiJ2m59mz49KBX6aNE=;
 b=O5TnFHVp7jidZfGX1NaAxdPAQ8fDH2FKgEOoM6KTaCZ9CrNiVQ1FZbyiDh8X++Y9M2
 BWh1HjskUxNlZn1kVAk8WRc8lMUqPXQH1wXFTQsMLyDFo58B12nGKiulFJfJtpcgxSY3
 GvBzArwvPK2uuBjfuhxN6VZtAm5VpUsn/8s8occ7DYLma9zlZsB7dlX1GjyNhXJ1MM3q
 wcJ4jVzdieq4NcKRPQGM0JcyzemUr/InjlBtvUnD+Qjm4CwGilw5DMuytoXUWlTVf4mR
 N3ZBV66fAuJ1MA4I70OW6sXxgOER9WWZGtpNx4wO4vIaGb4qOw0XligjcYRUUFrCwUH9
 SWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pSHE4/4kZo4fmk7WZTpI8ZXurfiJ2m59mz49KBX6aNE=;
 b=TQo6NDcRIrPap9pRNirDw9CsGk6rYs5i/AwK1AjTV82mDqravPznMZXpNk/Q56ysNW
 SxOMedC/nJssp54rdiqe3+Pi7qKPxmSR6buLOtKzBSpySiK/x8os0N7MZx9zijA9ED5g
 5LcH8xWiQlvFOO8f+fzVaIxuDk6SQcbZ/ROqyb/NC3ULkHX7c+zJIFK0HFqm0smgHnrw
 wIm4PYRadda0rbN/vguBbQzE9SsMpHOuf6gkjh2dtPZ2s2j07te7Ww9wOYcSoUoxHrRw
 uY1gxhomR7yvsPz+dBHUlIIUNyQzJv4cObsa0GxWpPJDejk0QLbaqERDwHZxgg3Niz7I
 0ypA==
X-Gm-Message-State: APjAAAVzgLcMdRa1RxE94BRS9RwdXQ79y8Sr+qWoi9F46C7mZpvL+YQg
 j6EjwNlTIMJc3oa88E7HXI8AlQ==
X-Google-Smtp-Source: APXvYqxQPTooAJBxcMUkp7dyDemkvXFk6+p0VEGbeOIoo/p9UEc19YOBL3QyQZdz4JU4X3t8MftpXg==
X-Received: by 2002:a62:b509:: with SMTP id y9mr7114028pfe.12.1576118279208;
 Wed, 11 Dec 2019 18:37:59 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id b10sm4754340pff.59.2019.12.11.18.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 18:37:58 -0800 (PST)
Subject: Re: [PATCH v3 19/20] tests/tcg/aarch64: add SVE iotcl test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e17f7512-8936-4926-6558-75b6dd6e6786@linaro.org>
Date: Wed, 11 Dec 2019 18:37:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 9:05 AM, Alex Bennée wrote:
> +int main(int argc, char **argv)
> +{
> +    unsigned int sve_feature = (get_cpu_reg(ID_AA64PFR0_EL1) >> 32) & 0xf;
> +    /* Exit early if we don't support SVE at all */
> +    if (sve_feature == 0x1) {
> +        /* we also need to probe for the ioctl support */
> +        if (getauxval(AT_HWCAP) & HWCAP_SVE) {
> +            return do_sve_ioctl_test();
> +        } else {
> +            printf("SKIP: no HWCAP_SVE on this system\n");
> +            return 0;
> +        }

I don't see the point in the PFR0 test.
Testing HWCAP_SVE should be sufficient.


r~

