Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45868C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 20:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0767A21773
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 20:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXQPHeFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0767A21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ212-0005aH-4M
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 16:27:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ20B-0005IX-4r
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ20A-0007CJ-4k
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:26:51 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ209-00079I-RV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 16:26:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id g8so8183357pgf.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=8OcJAm2I5F9gSL1RBU01vChctbg94jNsUR6bBzupv0k=;
	b=aXQPHeFmoVmw2yUVFt3Jtt/LfTXnfI0aJRW6HzQzq2PS4da1U4qSf+4KaL7DuHNWsZ
	58YutNrkxzY+5G7qHJdbP41e6J/f/7Yzqr9Xop0BLJ+SFVkU5uwnvRe2CWyKLaubJMmy
	4uo6ZzSUkh/10eWR9wHWAYRK0n+kuUsoak+qO20duQY+WQbMdzXNhB+MGqbG5XOC9cKO
	p3A1bOgLPcGfsh/eJBJsCivS/YnhkiMWFaoeeVpcWsq5p4Rq2TE9broxLxbmQnIytxHU
	PLrxnBh58ze1G+M2KbHe/8fZbbucyuzgMKZfBhGClUSns2L9Amj7HEWypmVsu4M8gjgy
	cq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=8OcJAm2I5F9gSL1RBU01vChctbg94jNsUR6bBzupv0k=;
	b=MZwO1bRhe9L7C8yqMOmwuRSyg8EE9MR+Mhm42i+Y8xIovbajX8jKaNihH4NN9HfCz1
	ytwJj4hQirm0uTwAeJbwBjiyiB5QA748Tzr7T3a5HBc14kog+wS8P9V2uF8H5gxCfwIZ
	9VNkojosOW9z01Dphfjg9wwpo8ojZ0bDlaf8QAE2SvI5CG5MQO+P/t4zEeDHFKQ/8Ckr
	D8sq2DsCVDy3yPZzn9+L/Lj7xY+G/grDdAPNsw8J67nazQck+7B8du13NcV2c23+nyR4
	6DAzIUGsfcqzIQ2bGijb9kaJMFqFCJ/8EutXf2yr8gDYOWMlxhlHk40jWBI/YYw8TOlf
	q/sQ==
X-Gm-Message-State: APjAAAUZNcclpLbJQRhzGz+q9X58wIR7hQWzJaUzjVcUoWR6Qb4e60lP
	ZVxUiD8DJ97q18JOBZ/0LvnowOjS8co=
X-Google-Smtp-Source: APXvYqyZK0kjTnlzznN46NQ9xG7l4FrNMYIky9CzGhIiXiYtbmWHSUtxtxgGzxz8temrGDwODOMzow==
X-Received: by 2002:a63:5057:: with SMTP id q23mr26801399pgl.30.1556051207562; 
	Tue, 23 Apr 2019 13:26:47 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	h187sm29529345pfc.52.2019.04.23.13.26.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 13:26:46 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<e2359b84-622b-d7ad-c9cf-92121934e123@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6206270f-2994-ae8d-db89-346a06a684f1@linaro.org>
Date: Tue, 23 Apr 2019 13:26:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e2359b84-622b-d7ad-c9cf-92121934e123@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 00/38] tcg vector improvements
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423202644.AR1L5Og-phBAWJe9Nm8Aj3gTJonHznPWppi7Sdah--8@z>

On 4/23/19 12:15 PM, David Hildenbrand wrote:
> On 20.04.19 09:34, Richard Henderson wrote:
>> Based-on: tcg-next, which at present is only tcg_gen_extract2.
>>
>> The dupm patches have been on list before, with a larger context
>> of supporting tcg/ppc.  The rest of the set was written to support
>> David's s390 vector patches.  In particular:
>>
>> (1) Add vector absolute value.
>> (2) Add vector shift by non-constant scalar.
>> (3) Add vector shift by vector.
>> (4) Add vector select.
> 
> Remind me, is this for VECTOR SELECT on s390x where we already added a
> vector variant? At least VECTOR SELECT on s390x works on bit, not
> element granularity.


No, this was more for implementing _vec helpers, where we can
reasonably use element granularity (since that's all x86 has).

I thought about adding a bitsel alongside cmpsel, to work on
bits like this, but haven't yet.


r~

