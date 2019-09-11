Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5584BC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2310E2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3Lv/4xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2310E2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i849T-0001jj-QL
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i841G-0003WW-Ip
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i841F-0001XL-Kn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:54:54 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:36509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i841F-0001X5-G5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:54:53 -0400
Received: by mail-qt1-x841.google.com with SMTP id o12so25639012qtf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 07:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G5/CADZqGLijcT4leWgDs+kJdsgAQR8uQ5ymjPddeZ4=;
 b=A3Lv/4xdgiXNnXqnSgUK5dlrSDVdaslzEXoXZgoXOIBy2QgRSJBZHWn96OOHLKlmrt
 LmxFSCi+b7C8B/H/2hiXo6wW8Kjhze2JiWx/SF19/qeFZGxuZXAplljnykTWg9cOXPho
 qU9KA0MF3uz3QaMhtW5hgLyekvhS7PKhNCHdZ8dhuL/num3P/OTZzetIzd1o+S2aY6/e
 CGWDPFYiYV9GoMWST4NpD2XD0GQnnQdAkEygznrg5FIyu/OVwuh/cdBd2kuRnBzcFdCR
 PDfoOaTV5oEL7JYUBO5uxCxAg5T7PXu1xj2g3KctXTV1I+EA+tskCoGjodz9iZieC/jn
 uToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G5/CADZqGLijcT4leWgDs+kJdsgAQR8uQ5ymjPddeZ4=;
 b=UxHsarynXsbmqU5EX7S9Tpf2DSLdkhLRn6AVlobmsuKzsxjqmGCutSe8RyFQfWZK1I
 zWmwmpWyLk/k0yoUJ9VJAJ7LCX4se83PGznP0SS4V1cilzCT4dCc73OJvhUaI1CufS4q
 zKopOCr3OE1vC69s6mVTeKNLvslmKBRf3XlLiUJ7eRaGTFXSzHYYF0G08ne3cK4mMziY
 mkSIEUzdlZ97ayNKVHobSTCmKtXKgr/L3o0BN8PXmi1Lmb9DPc1e/BGIoTn17yVavXuV
 uSQdDX8XHkV9kn4QkdTHkff5lHAkV5NbTiPJArkZZM2fO41wksdlFWATiJM/WZ1e6FNz
 kosQ==
X-Gm-Message-State: APjAAAVov0DTPUadr9/jY4b7uBLaO8va8sibAbm+Zx+GGG8nK0kC82gh
 AtwXrKZ9s+ZbPDd8KeNF2e3CRw==
X-Google-Smtp-Source: APXvYqxNxp5Jq3cE7XHBRnakPypNbYcyqGtZeAvSnU3ZyUK2DrGapejAP5TtttSSfjkAJmS0fUqLXg==
X-Received: by 2002:ac8:7192:: with SMTP id w18mr2892565qto.361.1568213692838; 
 Wed, 11 Sep 2019 07:54:52 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id y8sm1451018qki.0.2019.09.11.07.54.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 07:54:52 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9bbb541b-53ac-d96b-78fb-d81edba05070@linaro.org>
Date: Wed, 11 Sep 2019 10:54:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v2 06/28] s390x/tcg: MVC: Use
 is_destructive_overlap()
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
>      if (dest == src + 1) {
>          fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l, ra);
> -    } else if (dest < src || src + l <= dest) {
> +    } else if (!is_destructive_overlap(env, dest, src, l)) {
>          fast_memmove(env, dest, src, l, ra);
>      } else {
>          for (i = 0; i < l; i++) {

I suppose, though last time I checked fast_memmove didn't support wrapping.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


