Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A749AC4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773992168B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTOGWcDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773992168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCROZ-00063T-Cp
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCRBm-0004kg-TD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCRBj-00062n-Jf
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:27:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCRBg-0005yY-Gb
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:27:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id w10so8274597pgj.7
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rO0g7EOh0tvBPdiYHt6dI9Z8ycD2hhFeMn5mbp6DCbA=;
 b=LTOGWcDcnNoswoe5TgZIZOf5cP++4irgGg4OBpcnUYZ0gObyhkSLewJJHYPmSpzKjh
 ppgHwYEpf/lIlf9mj9FvB0MhSUlbxKJbU71iLjIy4UF0UMGLVbT/A0lsQk3YnI6NgMp8
 dXmoVyTQ97rmdm9PwSyIfoBJz0z58N0enD/rQx6JATDrnyewD8ckQ6eol3UFciXj2Ml/
 MT6v41zOVGmPsP54dcTGiduNSBc1FH9QVD2Pm3qJqN/qqMcOITx2hhGGuoQZiGneqDA9
 TqrWsskr0WmJnE0jbvp/9Vd526MXi6jRCujEnHuRJPq4vR7w5rYOct5qKDVVP+K2dUjQ
 9b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rO0g7EOh0tvBPdiYHt6dI9Z8ycD2hhFeMn5mbp6DCbA=;
 b=IiCRp52fojfFkH+LT+wi9tvIQaKR7KswMAR/c9NgDfhDTg+ML+Z/8ab55hZBOQWsbW
 I3T0mTyBiW1GT7fv8wqArxxGLhO7WWbTVsLpbSh13Ezk9pk2oxoMo0YpS/vW3iP4wxaw
 vwcC4PoKF7K5qM2L0iyjecGH78eyc5OseRDC9dOCRKo3Ow+I0GcebjyRuxd6/3SZCubZ
 dVBsz2smHXmYw1lxfE4lXLS+vv48opE4d0ihqZaOWkHuay6tY8v3tL26Yg7RVB7Y0fpV
 GTzOSGPysOsz4xtUc4tiv7zLJhEV3rJpj8lytZ5oUe4mwbRsCaYWUp2qQksxrDd3wyRY
 +Trg==
X-Gm-Message-State: APjAAAUL/D6XpGWyzM/rQE5HF3SjbycH97G8Rpm7p1KX0MkfqlJ0doUv
 F+1wQsJiegoESulszpZebwuvtw==
X-Google-Smtp-Source: APXvYqwXcpOHeFuD92veW7nwg1FYnMNcVwgqw9574LI9s0XkZwzFQe0n9EhHk9D+G6iPR1hZHIVEFA==
X-Received: by 2002:a63:7016:: with SMTP id l22mr708751pgc.443.1569256060331; 
 Mon, 23 Sep 2019 09:27:40 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id l24sm9719432pff.151.2019.09.23.09.27.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 09:27:39 -0700 (PDT)
Subject: Re: [PATCH v3 02/20] exec: Split out variable page size support to
 exec-vary.c
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-3-richard.henderson@linaro.org>
 <b0ac3ea7-3aa1-60b5-127a-6476003adaca@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a072a488-07d1-2981-4f52-20121f12690f@linaro.org>
Date: Mon, 23 Sep 2019 09:27:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b0ac3ea7-3aa1-60b5-127a-6476003adaca@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 1:26 AM, David Hildenbrand wrote:
>> +void finalize_target_page_bits(void)
>> +{
>> +#ifdef TARGET_PAGE_BITS_VARY
>> +    if (target_page_bits == 0) {
>> +        target_page_bits = TARGET_PAGE_BITS_MIN;
>> +    }
>> +    target_page_bits_decided = true;
>> +#endif
>> +}
> I wonder if it would be nicer to handle this in the header file instead,
> providing dummy functions there.

No can do, because set_preferred_target_page_bits is used by vl.c, which is
compiled once and so does not have access to cpu.h definitions.


r~

