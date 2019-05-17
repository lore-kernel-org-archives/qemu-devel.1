Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C322BC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F10920833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmbAzbWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F10920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52425 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhoR-000346-NX
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:42:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRhjX-0007lJ-79
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRhjW-0002zc-AS
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:37:31 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRhjW-0002yc-2P
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:37:30 -0400
Received: by mail-pl1-x644.google.com with SMTP id f97so3717472plb.5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 11:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=eTkkoGI5De1W5MzjhGv2Jiwf5fz/0V+kUSLw6kMRTb4=;
	b=rmbAzbWDWg447gDNCMMys0oYakYt6MEE49ZEA7N80GZ5knZaSEOMkFwJjbpNrOCwTP
	u/VkKPus2Zo5j0HL7rS6gfa9524rYTW8Y1dSTInK+To4xjfAAC2GTL932x86DvmqW1e6
	TAAihrz6JM+qbcDyosxZeBz50nYxQUeWi8DCgxkh0/01LqwXX8hZmoftxpQhdW4a20a9
	Y5oCQ7gnfBcx+Wi2GQOIfWnO+pgyoDsurmO7tT4aRKJ1pqI6nRHXhkhwpxpJn08ZMyYF
	Mu7Vlrk+dCHmz6qgLKWn9BeAN6Ii8INTQZoNKikv38mv3AVZAiQ3dYhMBur+3iyp52/+
	D2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=eTkkoGI5De1W5MzjhGv2Jiwf5fz/0V+kUSLw6kMRTb4=;
	b=QzisczLpOpkEABEKiU8cTo4w2O5xRWKsj38Adyz5dxdNRxRYikRgSBFkz3NqUcuMGl
	9ICtrubN8AlAmBUkXJmiuBvdwd2celM8vU+oImRJiymchoNYN4767YOqq83hTgtno9Pn
	RkwhQC7+rSkjkf2dK6KagKPG3b0RX4dTT0YVc7ymOreAQicWaSNizx0JuTMBPcOWiKbV
	nCcInNS4l2UpuvT0eW6zC9MRhFrmaOZjMY9oOV5ddEfLJbd8CuvG4nnMWKwB4ARsQFKE
	B2FFEqUZu1c6K25XiCU8v+PUTm2J5yV3WYMSiQJ69bXOKJfPuzbKz635l/4v5ne3piTl
	yoeQ==
X-Gm-Message-State: APjAAAXf23iguBYKD7yNESz9yhXy7gAuYSmX1kvOEK3yTWqevDviY3d9
	yXZCQGbApRzX7Ks/B5dj4os5cA==
X-Google-Smtp-Source: APXvYqyllv75P+gyJB2KZUzo3LlRh3qKwLGW9RcOjUQLe5N0zy87p7Loohf7kWkAjWSSNUGYoMTBew==
X-Received: by 2002:a17:902:8a81:: with SMTP id
	p1mr58660911plo.106.1558118248660; 
	Fri, 17 May 2019 11:37:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	a69sm23051292pfa.81.2019.05.17.11.37.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:37:27 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <788d345f-db74-4922-284c-2800b000d834@linaro.org>
Date: Fri, 17 May 2019 11:37:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515203112.506-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390x/tcg: Implement VECTOR STRING
 RANGE COMPARE
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 1:31 PM, David Hildenbrand wrote:> +    const bool equal =
extract32(c, BITS - 1, 1);> +    const bool lower = extract32(c, BITS - 2, 1);>
+    const bool higher = extract32(c, BITS - 3, 1);> +> +    if (equal && data
== l) {> +        return true;> +    } else if (lower && data < l) {> +
return true;> +    } else if (higher && data > l) {> +        return true;> +
  }> +    return false;
Only one of the data comparisons can be true.  Better as

    if (data < l) {
        return lower;
    } else if (data > l) {
        return higher;
    } else {
        return equal;
    }

Otherwise, again, let's see if we can turn these into inlines.


r~

