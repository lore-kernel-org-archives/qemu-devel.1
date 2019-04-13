Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E13C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4862084D
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 06:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhvQ6atG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4862084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFCPU-0006Sm-0L
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 02:45:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFCOi-0006A0-LW
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFCOh-0008Ik-RM
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:44:20 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFCOh-0008I7-As
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:44:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id ck15so6156454plb.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=16S4FrZPJ2TxzL3p1rNqfOMdTgsOFL3ezmaDETn3S6s=;
	b=GhvQ6atGD9B9B/oqCQPtsHrrhFFRwAlbQBAycaO2ONAcXramy675nL4+gxICJYMDsl
	vNy2EbvnhQkBK6r0tOllqDYSarFmkFraANESQ9Gtyb1gOOYtm6MKPxrt6imL5kKvT+5d
	nFSRPIeBjCwG8939pYHQZNcOJwl+dAFz7faMoIkXr3tU/mxzXnTeRZtz7ChSH7MwpzzD
	3VhZdZo655UJ0pQzZbGy+dq5JnK+eHa1ZA1ScygAAkVgIljnnbKbsAYbBBHyq/vUuYYQ
	CF02xCyKCB99MDmRNDOWSqUkXBLSE2e/9WBfwXeboJWYaI8QiAg97kT54m5/ZyriLCNq
	/3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=16S4FrZPJ2TxzL3p1rNqfOMdTgsOFL3ezmaDETn3S6s=;
	b=Mqw3tBv/OK9PuqeAQvwV1eRG+mueCyOMCcRP/gPNYNL0PegPuxn18NeSQZWaEHybRO
	lMKxi2cRESNEFjpt1WTLG/4UzG470Ubzm5aeYDZ7Q6sE20/wKGBfefF84ZIXLsYp3USe
	l8okY5ZhlNQpzCCI4B0NgDx4qM+yu2XlGyD8Mb+PLSjrwhtPkVhN/pFpG2e40V7w2Bpc
	3VFU//jL5eE/n1ep1LOjd2yhD0XoITnfMPFwpu2dITe0lGaw6U0eHmtFJUXsGxrhzjVB
	K0jSVlsvSugMTBhuAF9Trmf39+rhXANT4M05UAmvW8rI9xLwe0ruYC/2TBF9ZXqh3u8g
	9WXg==
X-Gm-Message-State: APjAAAXjTGBJLZaUkrEPDtYRd8DmVCeFKvJN1V/o2EOOJVfSJbCPWz0h
	yBZLg9znV1NTDWIPteD7RUd50Q==
X-Google-Smtp-Source: APXvYqwcYuyx+cSSXkXwFsjvUu4fQm/MHEzhmvW9HhnlxKeMOH0MH24fKQU4LvkOUjPrxr2YcIC24Q==
X-Received: by 2002:a17:902:31a4:: with SMTP id
	x33mr62370535plb.24.1555137857741; 
	Fri, 12 Apr 2019 23:44:17 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	q80sm84238546pfa.66.2019.04.12.23.44.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 23:44:16 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
	<6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
Date: Fri, 12 Apr 2019 20:44:12 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v3 12/23] linux-user: Call qcrypto_init if
 not using -seed
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
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413064412.MZsl8h0K4rXIqqhtCrg4C084Ahqtnud08lTFhsc0P1s@z>

On 4/10/19 11:49 PM, Philippe Mathieu-Daudé wrote:
>> -    if (seed_optarg != NULL) {
>> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
>> +    {
> Since 7be41675f7c we use gnu99 C, so this extra block indentation can be
> removed.
> 
>> +        Error *err = NULL;
>> +        if (seed_optarg != NULL) {
>> +            qemu_guest_random_seed_main(seed_optarg, &err);
>> +        } else {
>> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrandom.  */
>> +            qcrypto_init(&err);
>> +        }
>> +        if (err) {
>> +            error_reportf_err(err, "cannot initialize crypto: ");
>> +            exit(1);
>> +        }
>>      }

I could, but it also limits the scope, which is of more importance to variables
who have their address taken.  It means that their storage could (in theory) be
shared with objects not overlapping in scope.


r~

