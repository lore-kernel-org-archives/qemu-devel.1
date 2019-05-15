Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F47C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 156F520862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTPRvU5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156F520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39835 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQx9E-00058h-Cx
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:52:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQx8O-0004qm-AX
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQx8M-0007JB-Fo
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:52:04 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQx8K-0007IX-Pz
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:52:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id t87so275061pfa.2
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ecCwGEZWl/0ixL9wiJsXL54bOGoCvgaxqkKrtPY06u0=;
	b=gTPRvU5G+2tNU93ZZ56qSdzdTmK/bAj6wjhI+5/TsAT9L4TvpYC33+qx3DWTNU8rFd
	J94yGCQFwwH9EoI6oy0A8SacWAsApszpKruuINb4+WcaX46iULmcA6eEMhcoQuinCv3f
	mDXSCfD42IRWjJnkFKVgqSrKjXi9ixcmGZY7qD9mr1tkQcIhq76jmv127ySVFbnazWwg
	79MGY2M42ztFVNEBP+zO7M2iH6cBx2FuAJzjkJlIg+vWb5kQF1tyqqjJqWY9CX9mjnyY
	7Sn9kYEoqJvthIIsQdX4rohPR3OkJv25z3cDufe23qMeEYTqpDQgu5+vc9JS/CMr9Djr
	evyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ecCwGEZWl/0ixL9wiJsXL54bOGoCvgaxqkKrtPY06u0=;
	b=glg80CHYocBFn+D59A6W6Kl6B3b9IILxUFJ62XzUaGiApIBf4ArAUAoDGzl5kxVzq1
	lDWOhtpf0eX0C+tbZzyCHQ3FGwz8Uan/iZoqdUBayvWbdgNyFOjzYg8svsk5PyAQhpuQ
	5totN2IxZzqaKYragwW7qe2seXEMq4k5z+1/6ODKytHFKR3MQwyPKUL+pPdgMtQZgw/d
	GZGNyuV9oCeoWLqBFeUUHoQKSLm97W/8brk46SEaae0Sfb9/UIZNWNTIeGo9e8JjrKlR
	t/zkCBdeHRAFeNhBjE1vD5PGHpIKPTEcMXCzshJN5h6ESszMfrJzh+re8GRuru3zabyh
	fgYQ==
X-Gm-Message-State: APjAAAVQORNDdtfnXXrllDibXvWnBRp3DyFQTXzVgdviL7XewvzxSabI
	QbUhVwDURHCFynoIgNSgWvF5Bg==
X-Google-Smtp-Source: APXvYqzgfdWjYL5Xkai5s3YGXM1YQfd4DPPJejnuI8wiRKBV0l3gupEcfok6XIa5C3CcRi9KaksgkA==
X-Received: by 2002:a63:234c:: with SMTP id u12mr46649237pgm.264.1557939119575;
	Wed, 15 May 2019 09:51:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	f28sm6264864pfk.104.2019.05.15.09.51.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 09:51:58 -0700 (PDT)
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
	<0574ecaa-ed9a-40d5-5e09-050266455c90@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b35d9332-95b3-3d70-bcbf-9c4ae13d18ac@linaro.org>
Date: Wed, 15 May 2019 09:51:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0574ecaa-ed9a-40d5-5e09-050266455c90@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v7 01/24] build: Link user-only with
 crypto-rng-obj-y
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
Cc: berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 9:42 AM, Laurent Vivier wrote:
> On 14/05/2019 21:16, Richard Henderson wrote:
>> For user-only, we require only the random number bits of the
>> crypto subsystem.
>>
>> We need to preserve --static linking, which for many recent Linux
>> distributions precludes using GnuTLS or GCrypt.  Instead, use our
>> random-platform module unconditionally.
>>
> 
> Perhaps we can rename "crypto-aes-obj" to "crypto-user-obj" and put
> aes.o and random-platform.o into?
> 
> The only aim of crypto-aes-obj was to link aes.o with linux-user binaries.

That does seem better.  I'll make the change.


r~

> 
> Anyway, it's only cosmetic, so you can add:
> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  Makefile             | 6 ++++--
>>  Makefile.objs        | 1 +
>>  Makefile.target      | 3 ++-
>>  crypto/Makefile.objs | 1 +
>>  4 files changed, 8 insertions(+), 3 deletions(-)


