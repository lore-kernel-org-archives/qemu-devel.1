Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E86BC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79E6205C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/bsEHhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79E6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONhT-0008Ru-57
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:37:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hONd3-0005o8-8x
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hONd2-0004JA-F7
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:33:05 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hONd2-0004Id-64
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:33:04 -0400
Received: by mail-pf1-x444.google.com with SMTP id l132so1109143pfc.8
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=K2jc9dNMDIPDj/kjeLus5RuR9URVn2943gkVig1NC18=;
	b=O/bsEHhbXTb8MhouNqAL9bgNRFHu+TZv8tfkrEgG5JKeBDqEAXI4elzpD/CHVSkq2G
	t+AAdogcMUzGU2dvdWZyv6k3d+1x6rEH3n8M0C8MwgnVYN4vMgwHkkSswByxlfM9NUGP
	0V6kw6dMyY+V6iQUWqOLXQxPOLeTKJBQFHeRSpZJ8+tH1v6MhDhRunAqSgZXggl5wAw/
	ec/jtsdTOzvGYj+aOhjT0qqRjgIM9ZdWCxbcAg+yqfiPzIa6Qo67yh19gccUVCJb6r0/
	u8kQTXzSeCoZe48jzegJiqdHa22fYa0SP/1LmmFVhqjAlGQQnDOA9aUtDOuIOa+aOVtE
	83KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=K2jc9dNMDIPDj/kjeLus5RuR9URVn2943gkVig1NC18=;
	b=mXOgrKwO4aasuXNGvZbo9N+YMXtw2LpJRXwrgd7Gi3er38S3F6/c1KacoUpVxsk0PT
	ddAaaBVunSl4DDdIsBrwRMRqQ9XGDTl8n9zLbrUE75k02He/G4Sb9p9TYoBjWDYY41gJ
	qhYP9w2JsPVf6Zxm+tRdhr1ipBWJwV+UTOU/CeXo06rQk2Gk9fWxsCkcQMtILmbBfnGM
	ai8nk6O86wTeRVqS1DVuuOTAAs23g4MhTdzjS0IqbZzb1zLyesIsnMMhUKGfrC5sjCDv
	zSZ+n8FHRnPVH/8jAn3TpXvCqV37HldggjnF1oXdLZfDvxAML9ihnUFxZbMB+P/9qEbT
	B0aA==
X-Gm-Message-State: APjAAAXIz6B8pRZIyPyKoLJ8OaQXyVh41jq5G+QclPUVWQn7PmHIb35Z
	nFEO2alprcJRs6tOCJEzNwEvZha8JAA=
X-Google-Smtp-Source: APXvYqzI5XzETtBkzNFqQAC/CyqNr/jmluKADzIq9k6LiG/3ljveEcooYUyL94fSp85j16usidrTdw==
X-Received: by 2002:a63:a1a:: with SMTP id 26mr46080480pgk.11.1557325981936;
	Wed, 08 May 2019 07:33:01 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	x4sm21080238pfm.19.2019.05.08.07.33.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 07:33:01 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190508000641.19090-1-richard.henderson@linaro.org>
	<20190508000641.19090-19-richard.henderson@linaro.org>
	<CAL1e-=iRwS-1LvP2m5oS2PAKigiDr0g8jRNP6xPV2b_9AYU08Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <de1b6006-866c-b3a8-9726-4620821a9657@linaro.org>
Date: Wed, 8 May 2019 07:32:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iRwS-1LvP2m5oS2PAKigiDr0g8jRNP6xPV2b_9AYU08Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 18/39] target/mips: Use env_cpu,
 env_archcpu
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 1:15 AM, Aleksandar Markovic wrote:
> 
> On May 8, 2019 2:19 AM, "Richard Henderson" <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
>>
>>
>>
> 
> This commit message doesnˊt explain the reason for the change, and why is this
> an improvement. The underlyng reason for distingishing between  env_cpu and
> env_archcpu cases is not explained too.

It's certainly explained in the preceeding patches that introduce those functions.

Are you suggesting that it is beneficial to copy-and-paste a common block
explanation into 21 commit messages for each of target/foo/?


r~

