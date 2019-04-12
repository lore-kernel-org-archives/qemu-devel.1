Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAABC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3561B2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eluggI84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3561B2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5V4-0008E7-Fd
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:22:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5UE-0007uO-Se
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5UE-000439-1P
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:21:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5UD-00042m-L2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:21:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id 8so5836907pfr.4
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Ul9Hvi3hmAT406+oASAOgzn1TOpBClIR3RGKM5xG3OY=;
	b=eluggI84A/YaQD3P0xPFkabzaLQfXfBRK38biRyX5v80s9KoyUVMIala0JM5GHQrHw
	Zj8cy+PcVJLd/d2uIhaOqAb+R0c+6xPn4Wlxa9LDTCiQrgxliMCGDXmFWSappkaWQCiD
	ySek2Sju0QZnJUPdfGySIuMKagXjAl6VqJkEaCY/1E3swAMTqxkZYCm4OYvM6qtv79fz
	i+/JE+ww60vgoOJyr55Tb04bn+J8RYji5eSSjdDRvpwDqNym/hhebL0bMEapIsmf2ofg
	E6ime/Kh2QhZiHWG4e5dP8aigmvykERvPznMWGHcvROYf6L3tOLvuA+GNIghn+c8Qg4F
	TS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Ul9Hvi3hmAT406+oASAOgzn1TOpBClIR3RGKM5xG3OY=;
	b=X9guBQGRi/sxtfzSiJE4N0TAfv1LvyFYwdW6qp/fh13DAV+cdd9OI4agj1LfjWB09t
	wk7RN+QWNfv7WO2BqzzapB21EQWS07H/LGdFLg+8qNaax58Cc84GPlEFvRqhOQaGAZGb
	/k4vnAgnGCqWd+Sk991b0rWqfOZdOo6JPYFC5/7Eib2oR4N/dDq4go+5RJB4GfuQ8z8t
	otRC++eFLi5mW1c4yr/sXk9Ax3EBu2OA0n8bsUvL60srn7O/1C3efAf/Nr18gjymJreP
	BS1YdVQ3Y9ofoCyPPxlzXfSr0hxl7EA97IoDlq5x7tM17VoV5UMVacnnpTMmthnVuqos
	eg8g==
X-Gm-Message-State: APjAAAW31vS7pj+6EaCASzP4On2d/tEFHWqG/NkouLZogY5bYkhyDVZL
	0UiiPTpmxsgvUNj5gjhukKaaoA==
X-Google-Smtp-Source: APXvYqy7PThO6WurSlS0HaxXIkQo3gr7IFzv19sf0JeYfrg2XK8P7uO8LB+Oi4LMjjobF2cejd2LPg==
X-Received: by 2002:aa7:8e0d:: with SMTP id c13mr23052888pfr.193.1555111292402;
	Fri, 12 Apr 2019 16:21:32 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	j9sm46614467pfc.43.2019.04.12.16.21.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:21:31 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <03a8bd4b-3f26-445c-3a50-81fca2fe6a99@linaro.org>
Date: Fri, 12 Apr 2019 13:21:28 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-13-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v1 12/41] s390x/tcg: Implement VECTOR COUNT
 LEADING ZEROS
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
Message-ID: <20190412232128.8XAxTd4RfG2q34pQIh7mvyGcivtMF1RpwUpvQuKYlHQ@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> For 8/16, use the 32 bit variant and properly subtract the added
> leading zero bits.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++++
>  4 files changed, 49 insertions(+)
> 
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

