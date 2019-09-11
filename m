Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0350C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FD42082C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 21:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaBqY/Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FD42082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8A8s-000885-Gi
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 17:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8A88-0007gF-PN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8A87-00079u-QW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:26:24 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:42451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8A87-00079T-L9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 17:26:23 -0400
Received: by mail-qk1-x742.google.com with SMTP id f13so22338922qkm.9
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bXccQSI3WpiAevnOsQmOxEDBnt+B8OuhNuXL6NHL2+8=;
 b=GaBqY/PwoYiesDU/e3XsYkc8pmwsleq1HHG2f8ckHAuF04lOq5rrJa23fX5N5gil2x
 jpJXHcP1YDksx56l+CQAaQ1tF1+mRop2KPtUM690nwUXVrkmVrgkR8Slp2b9apjuz8Ea
 8Jqzel3rQp0zjp2oCLUrMkOCWsrn1cmZ5OCkaIyt1EadQpUdpfrLFtgkYD8e1l5Yh7Gg
 zitaBkCelqBqp51nKPBqMixz/+wL1dG3aQxVByvh4qtqvMXZ7RcmIgaqvk8Y5DCE4jTr
 OPgMPNAPu/8F24RFmn+UPrm88AKDmZ0hqzelL8oWsVFUwclpV713hT5UqaJIHGOfqfWi
 DWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bXccQSI3WpiAevnOsQmOxEDBnt+B8OuhNuXL6NHL2+8=;
 b=balck488eimxpL6+i07KNqKChzK30/NDJoC13e9G55zYrwup3iDuk4ytb+f/NxbSsM
 K5ZcJSWNvJWxTeZJYxtKwdO7nM2z+qDfaMV4D61Catmsrv0RQZZJSFRXdwZt+9m2XJq8
 4fdppCU2ETK/68Pp0zr4dfKjBOJtbkrfH3sfbyWm8PncDE2aaY6DA/g3FcNF2LUw09Cc
 0URMi5541LpX3WvCNgYEwJTbij0wqtFNzrnskRfykgYpKM97X6pa9OGPAydBJcXNDTlb
 MGn9xDbilh14Zj15b/6q9zlevBlQ4L9Xkvonz6HxZOGG7gpo89PzynFUyt3+lcMuAb+J
 xB+Q==
X-Gm-Message-State: APjAAAVzM7Mi9masEvLvUUg/oCnM93n/XR/lY/ZC7wHrj2jAeFyhYgm9
 ij0AYKFGY1dmP0P+OS0hfk4ZYQ==
X-Google-Smtp-Source: APXvYqz/jsMBhDdt5C2MtjoPeWPv7GNP6sOANm1XX/dT9wA+3hRRWpVKR/f2PklvfqhGrSRSzhYBTw==
X-Received: by 2002:a37:b402:: with SMTP id d2mr37494894qkf.462.1568237183174; 
 Wed, 11 Sep 2019 14:26:23 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id 56sm11256159qty.15.2019.09.11.14.26.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 14:26:22 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-21-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <784a16dd-9ebf-5203-e31a-aead2c219c71@linaro.org>
Date: Wed, 11 Sep 2019 17:26:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-21-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v2 20/28] s390x/tcg: OC: Fault-safe handling
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
> +    srca2 = access_prepare(env, dest, l, MMU_DATA_LOAD, ra);
> +    desta = access_prepare(env, dest, l, MMU_DATA_STORE, ra);

We should find a way to perform this in one step.
RWM isn't uncommon...

That said,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

