Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C855C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F512081C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dL7Eu2xF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F512081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbh9-000899-EZ
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 08:59:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbgP-0007pW-3O
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbgN-0003IT-VD
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:58:25 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVbgM-0003Hn-H1
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:58:23 -0400
Received: by mail-oi1-x242.google.com with SMTP id y10so14156668oia.8
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 05:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KCYHqGX5MknDR23eQXghnViXj1k75S2MOW76GYPTsCc=;
	b=dL7Eu2xFGVdN/GpFsYJS363RXoj3FKMXjbsGg25cnTstl5tQIIqBrgTgXO8FGEX0V1
	SYE+YOLrothTnYRmawJkN16YWRg4pSuem0CtEyRfvT9EW+su31gV0AM7okO2+omZWSVa
	0n77MzglMd573zB+XzoQilLl+f/gUUuWI+WjLDffOfL/mS8tiJN4NeQyj8QlF9WYnzS0
	5AG43KG2w9OlHRJTYH/RQLQEuvLfVI72NwyHdrSU+5YCf8hNqm4z5tJfi4gNhSnx77N4
	Uv0L6Gh1Ye4bpdhPcAgUBy2/eRIzxXLQqcxLB2MzhEILvXlIQEGwq1VKEPylMDGDTfUl
	UWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KCYHqGX5MknDR23eQXghnViXj1k75S2MOW76GYPTsCc=;
	b=hGT/wxIkIekmEZUhH8IbulxW/L+qUxbljgv0Eu6HWcleasDxGk13wqB796Qmn7XQUW
	C9gjG6rbX2UtdZ3+PZA7zQ0pO7fxVVuZ3Ghn5tRjbMORS/EMEw2g6yQohr1YY2NhY4+o
	kyqOSSWNiyX7FcEGCk+xelblUbLgaicamaXY0DUxTNqbRaDzFCqO6GmAxcN6ysHZ/kVb
	GhQSzXAZG3NvEfCbEvoa+k3vW/c0bhihzJFUqcxPEkv3+AvVexwysRR0vdaiI9PJUctx
	anBJAJkMNVt/Zz3fkcCzV6M7Nc9DP2XTFEcbgkh2qMvdSe0yxtf1sXnrYt34YNoG993k
	NG7g==
X-Gm-Message-State: APjAAAUQEFd9Wxsb5/NsM8ftFJIwcRo9Ycn2aAh/2X+vO2m9sgo4AZeL
	pJ+Roqu3XoFsNx1YXx+5Gm3wmQ==
X-Google-Smtp-Source: APXvYqxRKOx2TkY9enAqAtPntx2ps1AVYO+HbELD3dQjZtSWihlLWxrJgZLTKMrybT0tBU+Z/vzIIw==
X-Received: by 2002:aca:f2d7:: with SMTP id q206mr2525097oih.52.1559048301581; 
	Tue, 28 May 2019 05:58:21 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	z190sm5319343oia.21.2019.05.28.05.58.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 05:58:20 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190524093335.22241-1-david@redhat.com>
	<20190524093335.22241-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <182e48f6-f5fb-391f-0ded-d9c08bd8565a@linaro.org>
Date: Tue, 28 May 2019 07:58:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524093335.22241-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v2 4/5] s390x/tcg: Implement VECTOR ISOLATE
 STRING
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

On 5/24/19 4:33 AM, David Hildenbrand wrote:
> Logic mostly courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h            |  6 +++++
>  target/s390x/insn-data.def       |  2 ++
>  target/s390x/translate_vx.inc.c  | 34 ++++++++++++++++++++++++
>  target/s390x/vec_string_helper.c | 45 ++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


