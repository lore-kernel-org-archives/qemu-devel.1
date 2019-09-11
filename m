Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B51C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAA32085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnxHzc/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAA32085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8AK2-0007Lv-0N
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AIh-0006t2-U8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8AIh-00035i-3O
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:37:19 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36484)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8AIg-00035Q-WC
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:37:19 -0400
Received: by mail-qk1-x744.google.com with SMTP id s18so22457766qkj.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VjoGAPkzI76OHMq+wI3WO8RY7RMfm9D74OTV0WL6Z3Y=;
 b=JnxHzc/Mysded3azuCSQ8lIo7Gb3QXRKTC8zGEHnJVTZoPwf+JOL4N5HScT51b9jqK
 CWzXV75z0GwKza2dNO+KdDS6UntfRDFcuCC9jam9lHnj+cLUVsFyPXdrLjYr1Z7drKcp
 cGKRpJI4khvuAEHIrCis6/FKe1QcRO2mZ6VgcQrK/2qoSqgQVlB6igtzZfv3A3QgNvDl
 QZr1FrbZBGvPfYPmttVoKOfVeq7Q5w8uIMfbR9yzO8GxnRI81+nU7KVZORACKckNgddW
 1zpgABySSOO9BoWHtX9oES8rJl3ZXvd0RWz/W34W7v7QZWqQhW/cUVTUQ9cl5e2uuNTz
 UmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VjoGAPkzI76OHMq+wI3WO8RY7RMfm9D74OTV0WL6Z3Y=;
 b=YccqYWCl40M4AFnFYlLdYXXw4FI9rAxGYEaSaFt1h7BIYFbIDG88g/8Ma8gmtG8AkY
 nRneNYakpi/2+/6DVZ5Sqa3+mcPhgEfOogBZHTKk7Mbi/Q/0NcZy3JLJEGtOvJOTxtAy
 V9yo4giaeJSkJrvBUZbKC4QgqHFih+p1yGMJh/jViXhHvfIDwS72+jv2mq33AwuDTYXe
 iR07cFYUB+qgyiCvyeEJj36FVKQbfP8TYcy7+HioVKiN/swvx5mQIsnzzht9svrnwMkq
 fuPAAQDeN/+eCTdF9Jm17j0FqzwnkMpiKO0CXIl3akaOH3Xd4UCwd1BVcLT9t+8AAnhT
 XqJQ==
X-Gm-Message-State: APjAAAUpZ82jxVYH7aNSV+/0SUjGEe1KefiBhBX4BFzajHPDjz/aVmpj
 gmzUqOwonNCZHFq+IbGcSq9I7A==
X-Google-Smtp-Source: APXvYqxkDDbWH5kkhqGXpRKLEvuZIz2XZRG/fv+Uktxdnt7ik+/TkrEmB39APOD0kexpuhpYU5iSKw==
X-Received: by 2002:a37:a310:: with SMTP id m16mr37373084qke.123.1568237838111; 
 Wed, 11 Sep 2019 14:37:18 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id c26sm13652673qtk.93.2019.09.11.14.37.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:37:17 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-25-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c622df54-b6be-a294-2499-473c670e711b@linaro.org>
Date: Wed, 11 Sep 2019 17:37:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-25-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH v2 24/28] s390x/tcg: MVN: Fault-safe
 handling
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> We can process a maximum of 256 bytes, crossing two pages.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mem_helper.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

