Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07838C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52E020866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qr08ZgtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52E020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59138 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLpuE-0006WK-Vg
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:08:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpt7-0005vg-T6
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpt3-00008y-8L
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:07:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLpt3-00008A-1O
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:07:05 -0400
Received: by mail-pg1-x532.google.com with SMTP id t22so5337176pgi.10
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Y4nBiVVRReISVIZ4wV4IueXFQZiS7tXJCTJtenKW3bw=;
	b=qr08ZgtKpLHIKvRKXuMSnXdmeUvPOCDGhOxOC817r+i1uJKFtdmgbxgk/i8S7i4kRv
	SYmYgjHqNOnJfEHOIsB3W6YKQW0KynBTAKAQGQ43CyPV6HBgUV/Lh76ZHf01kOJDOyhK
	g7FKLCkT1oTZzJanxbiRpApdT6HXGWoDf59alZhK6O7p8fxKla09cCRK7Ku4KePZTuDH
	46OAqDF9l3sNLtQkDN7BFEscVkdRQ3e81LeFPAUWoXaMW+eAILuThsFRE82X5ZCSwNVH
	NStWkgfXZLeV7JaqFZZdo0Ld9vf7z/Pk8B/pbbg6gQo1Qllm7oB4dPSckMXag8PN7mbH
	CvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Y4nBiVVRReISVIZ4wV4IueXFQZiS7tXJCTJtenKW3bw=;
	b=EcVD7iGT0kXhxKQ/XCgKXuP5NkirprFYnaqLTN8Dd4Oth/BMejP3VSD/k9D5JnzMBq
	p5sKjPj/Ii3npHFossL2usS9QaNJBzC+Dt0Qoal8NjTbQgYL+BFTzNW9CF48heOwvv7H
	ub0+5JZ0SLS4vbjzFXHGeRuksXhz+uUQlAj3qWq/k2wHYwaAFChP1facIR2E9AvBsP1B
	ZXD5N+UnOwezm7dZZOF7HgVmIv6G5vjUrr46r509+Cse8iOs8HI/j8M5pXlvWCd3oz/T
	S9jAzaZWkMFuLFP8T3INnmcQAmNKX/Rf3jC13kz3AWxSQVFsb728uXx+fEX8EP4Th/30
	BDvA==
X-Gm-Message-State: APjAAAVcuZSylES2FSJh9AFPok05AFdVnWderSR46cKMqcF6pqrkTMNp
	P/4VAqUPn8QtMENq1mxsKsTDkpyRip4=
X-Google-Smtp-Source: APXvYqzsj5J9vuwyd8GSL8i/GzyoukZZ72+caebhPveZF5xOfaLxClMhDvyJwtWL8sKV/AAkrRHD8A==
X-Received: by 2002:a65:60ca:: with SMTP id r10mr9773363pgv.64.1556719623556; 
	Wed, 01 May 2019 07:07:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	h187sm65718526pfc.52.2019.05.01.07.07.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:07:02 -0700 (PDT)
To: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20190501061827.23080-1-joel@jms.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d1c73e60-d828-4192-24c6-ca2f595a25b3@linaro.org>
Date: Wed, 1 May 2019 07:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501061827.23080-1-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::532
Subject: Re: [Qemu-devel] [PATCH] arm: aspeed: Set SDRAM size
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501140700.6AEM2LocbYgzYQyeDtHOWd40eIrAALfuaY5v1NxlR6E@z>

On 4/30/19 11:18 PM, Joel Stanley wrote:
>      mc->no_parallel = 1;
> +    if (board->ram)
> +        mc->default_ram_size = board->ram;

In addition to the braces, for which patchew will have sent you nag mail...

> +        .ram       = 256 << 20,

In <qemu/units.h> there are some defines to make this more readable as

  .ram = 256 * MiB,

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

