Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAEBC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06A8208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuV4aeM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06A8208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqVC-0002Lk-5w
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:46:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqU1-0001xv-A5
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqTq-0001GZ-Vo
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:45:13 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:44602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqTn-0001FL-4o
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:45:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id l2so5516519plt.11
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=IqiOM+wpOEZCeB7Mus74BtlcmVq2X0DTRYyU8lE62DA=;
	b=SuV4aeM3OgFjvIyCDhfqdLsz3Ajp0YHPpnMgLB6z2hmle6o/1HgYuczEmI9XKgZTFg
	OVSkEf2pptmmEFEMt9AggIDSTx+CAgwD6/rZWywHRnkY/JsZ4JWQzS8lyWAyVGCS9uYO
	2EF/MMw2eudr5QvuW6Xrgxj9zbJSuF0+4K5/fsS9rNuseWN9A3L5fIQXRa3RJtzknbGe
	2jImIN7iBrTFshWqxdZkKRA3i9lM83/6nIKxFiT9+vsWHlmX4T+VkTzUpFIgHiLiPdsi
	sKDHAeM4kKsFVcI6jOUyR6EiqXkTWb+SFm4WrS0dNTMHZxMGoLn2oTT0RskyWexwdRVc
	L3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=IqiOM+wpOEZCeB7Mus74BtlcmVq2X0DTRYyU8lE62DA=;
	b=Mbeb7Td44t/BlYjzn6Vn9qdYbXdT1XP6/tNkAMlrl8psUPrEeeLR5nYu7ptIxS+T2Y
	WuDEhXduOT2885ydQm77WY8md9zmHbtBVbw5zdeENs4NR91lR3vRmz5gv51dbS4FiY7m
	uH9d0XV3gRpOdow/tNI7zPC+At7cMXuQUzJlD+Jza7A3iFnvhjIvroauxQzdbnHQtu6g
	My18EFTl/Fv6sTlI7KWVq6bO+7cZg4001otqaIK5gGMiApKSRnsOdzaMdBaR65HSgxry
	IZ6RTfShJRNkAMxm1cgZrJJRMBY93xaRD5h+7HGD50DvxJJxkwLBmwrBL5RhHFjMptZt
	LXqQ==
X-Gm-Message-State: APjAAAVixgIG5EV0M5semv44WpA2IubpHkIf5fz3WHGlS1UagssRpS4W
	U51FSPANG7WBulQEGg13WQWR8A==
X-Google-Smtp-Source: APXvYqw4Z1Hei0XcAHyYjCvt7J5fxagJmgpHou0JOC436h6OqxXlxvwuKMFHtfTGu4BzULJpFBMQTA==
X-Received: by 2002:a17:902:a585:: with SMTP id
	az5mr43202467plb.261.1556721901239; 
	Wed, 01 May 2019 07:45:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	s20sm47870322pgs.39.2019.05.01.07.44.59
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:45:00 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <272feb46-4da7-7834-7a5e-5f54ed416f05@linaro.org>
Date: Wed, 1 May 2019 07:44:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::631
Subject: Re: [Qemu-devel] [PATCH v5 06/15] tests/tcg/multiarch: expand
 system memory test to cover more
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501144458.wNUDBa6rnVJbl9eynCjJhDv3R68Uojc8RF6vONKAl7g@z>

On 4/30/19 9:52 AM, Alex Bennée wrote:
> +int do_signed_reads(bool neg_first)
> +{
> +    int r = 0;
> +    int off = 0;
> +
> +    while (r == 0 && off < 8) {
> +        r = read_test_data_s8(off, neg_first ^ (off & 1));
> +        r |= read_test_data_s16(off, !(neg_first ^ (off & 1)));
> +        r |= read_test_data_s32(off, !(neg_first ^ (off & 1)));

You're testing unaligned reads here.

While admirable, and necessary, that's going to limit the number of guests on
which you can run this test.

Do you perhaps want a compiler command-line -DALIGNED_ONLY to control this?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

