Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1866EC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:02:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA802204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 13:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfHcaKEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA802204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVbkE-0000h7-8U
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 09:02:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbjE-0000Nl-C4
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVbjC-0005cp-7i
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:01:19 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVbj9-0005JX-OV
	for qemu-devel@nongnu.org; Tue, 28 May 2019 09:01:17 -0400
Received: by mail-ot1-x344.google.com with SMTP id i2so17614485otr.9
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=X98rAM9dKZpqtF4FFpaWwEi5Kr/8DBIX8PZIwIOIvHI=;
	b=LfHcaKEQGhf5DhlcHNkhDFPCoq0vMCybE3323/Mzypa3cEk4yUuARY7oyYQIpQvYRA
	O0Rl46z5307/mlq2AlmMXW9D1Be7dv+P2SWxBZkFHIm8U4cCdpTYzNPFZozZB6eSxW8C
	w78BIB/boFYxkuvCT1/9IxkVrzwLK4jebDbGtZc0Q/12Qj9Ck9kGutfuvz0d/3/aJIr0
	5GPwquV0CfkbVxeOM98gWmZWhj1wTd/JnbRmJYOQnMYpfVu56T5myzAZiH5rbNcxdl/1
	81yaRKTYo/+fJzeYPLoR4k/Ewlt7HAtLdh2AlVTtkWs28eelA6H+XNqIJewbK/WYFcdV
	/gWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=X98rAM9dKZpqtF4FFpaWwEi5Kr/8DBIX8PZIwIOIvHI=;
	b=Df2RhlBclZVpp6HCFNAHxGhnQChKQA3k5vkBMiPNL6f7fv1GkFjwBCkXP+dtYRk/gF
	/xnoN314wYIoY1C65XLb3CmupIkBCkmg+hGcgwcUreJLA3evUQv/jV73ZXGRal0W3hbq
	aKLNUvH24xJr4DIPWUd0dMtw9WEMt9XkoXbj8h49HvXgGLq1XQ/EH9jgZspkkgKq1qLq
	TXZNcole71SZz6ndrl9m/b8u5UaVZFsHalU3ctk68fq06okTNgT4+9xRZB+fTsVYSDjE
	X5LiUt+44rNJITUwGNNuMmCpNvXZwjTlv5pUcotYm12P9sI59S9ns48vh3hTx26uUzBm
	dPzA==
X-Gm-Message-State: APjAAAXEjkwsIetLuFWCgilMVkfI1lTnGr7OQ1fv97Xj7lpiLMumHJkq
	/sImm+IPs8BX21o+rBfPxRAFWw==
X-Google-Smtp-Source: APXvYqyTFJfC0g4w0vEQxOJR85Gibe0QwnNadQVGg9Lkb5b9568xpW4+VnY0iGtYratVZ2yVC/+qsQ==
X-Received: by 2002:a9d:4d02:: with SMTP id n2mr1679460otf.332.1559048444776; 
	Tue, 28 May 2019 06:00:44 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id q3sm4437752oig.7.2019.05.28.06.00.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 06:00:43 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190524093335.22241-1-david@redhat.com>
	<20190524093335.22241-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8e9738ff-9ca8-7a42-5737-c2ae32883aaa@linaro.org>
Date: Tue, 28 May 2019 08:00:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524093335.22241-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/tcg: Implement VECTOR STRING
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

On 5/24/19 4:33 AM, David Hildenbrand wrote:
> Unfortunately, there is no easy way to avoid looping over all elements
> in v2. Provide specialized variants for !cc,!rt/!cc,rt/cc,!rt/cc,rt and
> all element types. Especially for different values of rt, the compiler
> might be able to optimize the code a lot.
> 
> Add s390_vec_write_element().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h            |  12 +++
>  target/s390x/insn-data.def       |   2 +
>  target/s390x/translate_vx.inc.c  |  59 +++++++++++++
>  target/s390x/vec.h               |  21 +++++
>  target/s390x/vec_string_helper.c | 143 +++++++++++++++++++++++++++++++
>  5 files changed, 237 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


