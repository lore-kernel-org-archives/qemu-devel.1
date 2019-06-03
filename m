Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA04C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E1126FB1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zi1s6O0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E1126FB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37623 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXph1-0005TK-6k
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:20:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpf5-0004VK-RG
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXpf4-00072t-VY
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:18:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXpf4-00071f-OI
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:18:14 -0400
Received: by mail-ot1-x342.google.com with SMTP id z23so1643284ote.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=NBbL+t+4z5uGn6n/IUmrYtZrVWMwOUIxdDcZc43z18s=;
	b=Zi1s6O0tdtEuqsKetPH/RYF3noETrYij4KZ4qgbtdjK6Yx5krU+NeDFDwt1+1zT6ZD
	i52jQP1di/fUmkKW9MyxvtX6ON4HX6fgWbjSCBAtWGSNgTTeDzx2c2HwKzCKeACfmE7o
	l0dBi2+QqGXg6GqNDpodQwfWZQvBZnfDyCy+qaxmd66gLKCXRAhsfN3GsOnghh6eqQwa
	FAfZ4HIJ9omimU0lNb6FJ3MgqhNeQ+Dx2aAUBDL7Us8RQIZ6isr2MSKHlc1OEU0fqN4a
	glMcSLgg3iCe9LyJ2i4Wqh/NzjiDxj1lI+5ruVemd2UMC3tdndtEaLooDpOfslkdmd4T
	6t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NBbL+t+4z5uGn6n/IUmrYtZrVWMwOUIxdDcZc43z18s=;
	b=T7jycGN1AVH3PwLp2EEyoKQ+KL14Fi7q5cduUifJnqarL9frRlMR5icp2dq0x7tM2R
	utc6MrbJbZ24UMVMPQYabx+TfItxJkQZ0cXMm0L819LRjbqiGpfqL806nk40r/gJ69gx
	Wn+8g15OjwU3HX0R2+RvcRu0fAx6TomIEg/2l0/XwUx7GCZdPbhozDKeXKdIsk4Yaf5A
	IAtRLM2n1l12DgrnF9EaJug3ioQ+RqPKwwdCc4ZoyL3tKTSf4flRdKhcZyBdKdXgk4Qh
	Lo413a0qFFzMbZz24Ner7t+FR9iW20tXQZ0qcMc3J6ltX+U2w+QUEhH4pOHiAMf2R0hm
	0uxA==
X-Gm-Message-State: APjAAAXyeohDbav/z2TrUze5EU30pzPYZsouccbez0OQHl0+KI0k5wy/
	z67NmXky/NTobeVmikhk4OtdhA==
X-Google-Smtp-Source: APXvYqx/HS/tcTV9ZZPDUOurlYGDtEd6bTM8Jr1XlCy/1HtWxnyuBGdAkQ3pFg4J9fMcVZRhrcNoBw==
X-Received: by 2002:a9d:2af:: with SMTP id 44mr1783473otl.187.1559578693825;
	Mon, 03 Jun 2019 09:18:13 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id u9sm5188537otb.0.2019.06.03.09.18.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 09:18:13 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190603090635.10631-1-david@redhat.com>
	<20190603090635.10631-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4d2c8a9a-0409-12ec-649a-7c1b97050721@linaro.org>
Date: Mon, 3 Jun 2019 11:18:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603090635.10631-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 17/22] s390x/tcg: Implement VECTOR FP
 PERFORM SIGN OPERATION
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
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 4:06 AM, David Hildenbrand wrote:
> The only FP instruction we can implement without an helper.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


