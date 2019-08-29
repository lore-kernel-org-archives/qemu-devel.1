Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C0FC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243642189D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Njc2UZII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243642189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NAN-0004cR-5l
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3N6E-0001e0-8F
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3N6D-0003ZF-4z
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:16:38 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3N6C-0003Vt-RO
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:16:37 -0400
Received: by mail-pg1-x543.google.com with SMTP id m3so1819688pgv.13
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/q7CIWO/OfhM33UMbm61O6MEwF9V16DoxzsziImS8Sc=;
 b=Njc2UZIIeOTa+7yjDKp5vIU31MVrVv3Qh7bLIToMTS70w+ARQZ70MvhsjoGbN8ZIM+
 Kk5FSZMAn80mXo2AcBGi+E3CSNnWz59kURZKy4uroAHGZ+2UU7WVD1g+/jSclcQBibPh
 Aqv1LDuHqMQMlga2F39L11OvVJofrwB6dWfab9GAV9KlTy59uVOq9NC8QNgvHRlqrfz9
 gkt1y6p23WBP8x1uIBcuFC93pPVglBQHpb6dXWExjVm5laPxytNaG2Rz6CtRqr8RQ+nq
 dWZCAIHVRJqR9oETRwIlSDIYHk9dzXjdXAIicxUoOf5tmlez5FK6YHHQFtdRyHQumFll
 M5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/q7CIWO/OfhM33UMbm61O6MEwF9V16DoxzsziImS8Sc=;
 b=FSTpXVgUfbwCfj8KqiXUQwsDORROFsr/flib1Rx56u3kifjVEFO1DjyHcWlUKz6Qop
 66W6CbICrg2ClaAZNcbrt08yVLlkgA62hPCYEYlQH0MoFUOah3cSSPgprcvx8NfmYLOd
 XqzZTYKcc/vakwS90IYlGa4+V3dl0F0twEOLsBhQ4eWusRqO5J8KhVP6wtkdv5kOO9aG
 Md/1P063Ma8B2Nr+wWnqK3LmFe5SQ9WT6ZvDV6vRBFBCdPxFjsQHA7mPjUm2NlklqpMk
 svgnWU1yYtVtCFMehoH+wuXA0mg66R1d3uNpZ2LllKw/4bY1NysHGov3hu4+rTE9k76A
 lo8A==
X-Gm-Message-State: APjAAAX+M1ib4iBMbeKEFktfmWiuDeAaPMK7vEcNFwMXDaEvxQl0Z487
 rUmklj5b4NLKkrXe50S4GE7Nhg==
X-Google-Smtp-Source: APXvYqyjc/w6UXFfRRCgz7Sq2cmjHsbKEHyvlYYweWZHh2KZoFkR2+i06ep/qyuDYXaI3/ESXVUUWw==
X-Received: by 2002:a63:1341:: with SMTP id 1mr9285054pgt.48.1567095393013;
 Thu, 29 Aug 2019 09:16:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 4sm3624041pfn.118.2019.08.29.09.16.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:16:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190826075112.25637-1-david@redhat.com>
 <97734c60-12ef-274e-96ea-ebaa48e01935@redhat.com>
 <3a0506c1-8c45-d933-1fed-6cd0a02cddde@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d688d81a-dba0-e6f8-fe10-9bdfaef63281@linaro.org>
Date: Thu, 29 Aug 2019 09:16:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3a0506c1-8c45-d933-1fed-6cd0a02cddde@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 0/7] tcg: probe_write()
 refactorings
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On 8/27/19 9:09 AM, David Hildenbrand wrote:
>> Richard, in case there is no more feedback, will you take these patches
>> via your tree?

Queued to tcg-next.


r~


