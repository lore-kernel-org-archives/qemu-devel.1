Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC36C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2E4208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 12:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/JTo2yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2E4208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbZj-0005Hn-0l
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 08:51:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbYg-0004gd-BF
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbYf-0006NN-Ch
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:50:26 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVbYf-0006Mi-74
	for qemu-devel@nongnu.org; Tue, 28 May 2019 08:50:25 -0400
Received: by mail-ot1-x343.google.com with SMTP id g18so17572239otj.11
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=DafdoCQJbeiO0S+GkViDFrkKrg4zzRUbLRvGY8A3tDQ=;
	b=g/JTo2yMOjGv4BfpqguOmsPpKx0IdVF4iJYpV2gl2G2xmKqFecJjiKLkzrEkLhPelA
	x8Y7k4BCnIc+7R5BOqHttxCC0HeQvRbA8SJyLONmFMqHS5BgfJQh5JBLUqnjCS9w0E0O
	Rv5n/qay2HzjuCpzC2cYR5Vq6djnq23u7jTarmQLjhUlFemSpeibN3DOeHEMCcn3okAZ
	xhcoI1XsXPmrLJbMV9W0UKMupoWADd1FHdnUtIytTjgZo/lEhiNP4mHtb3lGaEHoLLbb
	Lmsm/ckU6gz+9I+EQYhHPUynJ8BdRecNXhPNHtewOrwmKwzGgDCROjuUWKTSObI8+jdP
	8Hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=DafdoCQJbeiO0S+GkViDFrkKrg4zzRUbLRvGY8A3tDQ=;
	b=lieGZhp+1Eq6gBO6zVMgN6Nych7AXnHTPcdWgczqr0AfHcYFp4kurku8D2l5SIgNYS
	x1xHeNfFFa0Cnbvw0mccf874RNq4KDibrhCz0sX1HuyfECgUlxTNmpEjOeL1bN6uSzWY
	rqOmp/+9vYYkJ4f6DZbGQ2duAAKDd4VOeKQWKxGGRcx4UYo45iMQZQHEfhDjNvOPpvT9
	+Rm1MpoLuQkl1XLNEDk/M0J7htbRFwEFW/GYeojg3fAvJQEkpOGW4r3WyYP8T+ta6Mm/
	Ttk0fKhS1Sz/MzUYxec10qXnsicKygUUd1T3PnT1u6uKyQNVxsANCdsXYAnrKFIWR3od
	6MtQ==
X-Gm-Message-State: APjAAAVIFgGtR18NZNAZOJ3QWgKbk4D6R3NWmmQzv0PRudR9nqTjSyvR
	ioINHYua3CE8Z7PRfiqupej5ow==
X-Google-Smtp-Source: APXvYqxX4+2gJrlGbVH4qG0e5CfD2jcMmFogucl8Ult+33YGBPcnP2rkjIBwnlBguiK7sphbZdbYew==
X-Received: by 2002:a9d:3d5:: with SMTP id f79mr40593256otf.164.1559047823980; 
	Tue, 28 May 2019 05:50:23 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	k23sm4890072otj.39.2019.05.28.05.50.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 05:50:23 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190524093335.22241-1-david@redhat.com>
	<20190524093335.22241-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <83d7121f-a41f-ef9c-813a-bfd71f311e9b@linaro.org>
Date: Tue, 28 May 2019 07:50:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524093335.22241-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 1/5] s390x/tcg: Implement VECTOR FIND
 ANY ELEMENT EQUAL
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
> Complicated stuff. Provide two different helpers for CC an !CC handling.
> We might want to add more helpers later.
> 
> zero_search() and match_index() are courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/Makefile.objs       |   2 +-
>  target/s390x/helper.h            |   8 ++
>  target/s390x/insn-data.def       |   5 +
>  target/s390x/translate_vx.inc.c  |  30 ++++++
>  target/s390x/vec_string_helper.c | 154 +++++++++++++++++++++++++++++++
>  5 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 target/s390x/vec_string_helper.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

