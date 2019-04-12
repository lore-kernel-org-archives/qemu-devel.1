Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95417C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547B72084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 23:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yqj5z6DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547B72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF5RE-0006jT-IX
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 19:18:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5QE-0006Pi-29
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5QD-0002UJ-6S
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:17:26 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:39876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5QC-0002Ss-O7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:17:25 -0400
Received: by mail-pg1-x52d.google.com with SMTP id k3so5872839pga.6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=E39KFq7XaNWLE80YXOVHTsn/V8dDTjvBAE1fW/I9Dhw=;
	b=Yqj5z6DQshbmDRd9UzVO+RTlbxYKKkPmfUSYhFyqwBvoPJul+JNgroagWx/iRlB+V3
	eJFP2SosbXOOus0nff7F2WxWM4xoxmPCq4YpfuIN/LwL1sDQXkDf5AaV5wRG2KRlF+ju
	a0CkjyaVvPyPIsfotG9nFE1l4UviWK1c5lZbdak6gDnTBT1K51YoA3Z8/uZ62qzDI0ou
	UPoqdtnTI9SJHOd39ms919ol7ahdhspQHzwwx50yrd4UFJnhcyEuKGAhTtAvhOSICuMm
	iJjda57+WuxMFhduoCYD9S4mew93gHmdnJmvrW4S+Jb0VNCUZfwZC9UwAW5yEcpY+tjI
	YJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=E39KFq7XaNWLE80YXOVHTsn/V8dDTjvBAE1fW/I9Dhw=;
	b=c8wkf3LmgLWZqYpxMQi/BnmxOjbUGO6XbCFYBnd/Mh5Xp19kU4uPq+5kGmWIapKn8e
	3KbmlUORynP92JqKouhDbQyV4TUpaTWRtbdS/9zqWeWaDlkqW80AUuXvo8hi7T8N5I5U
	CqZA4l2JjHhnavjyFrgVNnh5uakEVJAHAoTtk6T22+C2lagLwRhVQllgs41F5mm1rSAV
	nv1/DS4bjniLai5vRkycglJDZKBo7VHBwW/cqW2M3H4HtqDyRAK9PtfKMISfO/Fqij18
	TYZQVbP4GW/B3eIoqbwegiKI9YgWgOmAK77cYAQ1P9dzwTmTTw8RQn7CCgBXhYSboR+i
	sRFg==
X-Gm-Message-State: APjAAAVjULCl/AmTRoQUG3130meeuzJlMv5V6Yc0uGXrHMfzlcG1wUKY
	7huui5s86aj2nFWvLkJFFIXYvg==
X-Google-Smtp-Source: APXvYqxB/WPIm0hrxipv0jpPeFJyuJfRi2ebFH3PkQ111exN0oO/9Ri9rbrBR7BNsMfBfz1XaQFVKQ==
X-Received: by 2002:aa7:9088:: with SMTP id i8mr60329011pfa.118.1555111043699; 
	Fri, 12 Apr 2019 16:17:23 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v20sm64413254pfn.116.2019.04.12.16.17.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 16:17:23 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <846737e8-f010-44de-6757-ac09b130696f@linaro.org>
Date: Fri, 12 Apr 2019 13:17:19 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-12-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: Re: [Qemu-devel] [PATCH v1 11/41] s390x/tcg: Implement VECTOR
 COMPARE *
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
Message-ID: <20190412231719.vIUwTu6uS2fruv02ql17WoIdIpjmXIAYiX6esxjM8bE@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> To carry out the comparison, we can reuse the existing gvec comparison
> function. In case the CC is to be computed, save the result vector
> and compute the CC lazily. The result is a vector consisting of all 1's
> for elements that matched and 0's for elements that didn't match.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c        | 17 +++++++++++++++++
>  target/s390x/helper.c           |  1 +
>  target/s390x/insn-data.def      |  6 ++++++
>  target/s390x/internal.h         |  1 +
>  target/s390x/translate.c        |  1 +
>  target/s390x/translate_vx.inc.c | 28 ++++++++++++++++++++++++++++
>  6 files changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

