Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F7C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 14:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DF62084F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 14:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nprppdDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DF62084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i99BB-00053V-1E
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 10:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i99AJ-0004VZ-Oz
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 10:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i99AI-0000f2-VO
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 10:36:43 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i99AI-0000ee-Nc
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 10:36:42 -0400
Received: by mail-ed1-x541.google.com with SMTP id g12so3732436eds.6
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FTXQSoe2zNg9nL58Q9VRPf/acbfi2EIOqGSUKRdWuFA=;
 b=nprppdDCmzQG2Ymb9prptc95fiTpMOD/44QKPikfJZhKrK9RYL4GhoD6iZd37vtK5i
 Otkfukr/MEz0VHmPmIYWWyv9Ug+N4fbacpCNyMu6bSTJd0lTlB6Ac/s2FSQYUUi0h6+n
 4DCXFuEEYN1Ou2TkrL8QdvhAARwSmizNnVjS9gTEfv3Z0cOpb7TtSRd7WDV6qiUhR9G9
 HujeyDp9AWvyUukPQErVkVayXwexmcQVlRE2iM/N7k4ajaxcbHof5sh9VDDA1B8T15mP
 iTB3nIaD5cY3nnwKI3ljd00Oy7WhdkTpE8ybduLbNlBy+yvwdsgytGvFFcP8EpVE4QyP
 tBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FTXQSoe2zNg9nL58Q9VRPf/acbfi2EIOqGSUKRdWuFA=;
 b=Cpy0/g62ZCRwDHzEQeIcCzcAbf+0od9Het0ZUq5wwhW93eHp/9F/L+ENxsaXRswrod
 xELcPzvo40B0ZhH4ExEgcTpud0w0C+8+oFuksWelziMtn/oSkzlmrn/ldxF6F02b10xc
 OLA3GZNlM4lImKKAel7ZKxU32yU4+wzahGy+DW2URIuelq9Ek6ZV6AdaXZ+VwsEshOfO
 MIhqRGNd47ODKxUomoqswq2qmZvjggLVORaHJMN+Wr3C9WfWT1TxnZFhwAx3KbMLLyQA
 VD6ygA0l5U4JYwK9tTHV074w3KKNgg7f6KAqD7PBid/ZrtHh+joW150Yv5hbKZCHnGj+
 RdzQ==
X-Gm-Message-State: APjAAAV8bw7A1N6mqHbEYadoQaVQZ00521qUj76HBMQ6ARzvxMQa2ZPa
 dzdNKHaqe/eTB/clxdv4HAdeZg==
X-Google-Smtp-Source: APXvYqxtfZ+DJl7aR36yFDIMCNWLfZDJ4iaxUpzyQdf6BsCsSM5H6t/1s6OfDGu03CrkEsJutHn32Q==
X-Received: by 2002:a17:906:6d52:: with SMTP id
 a18mr21816681ejt.56.1568471801537; 
 Sat, 14 Sep 2019 07:36:41 -0700 (PDT)
Received: from [192.168.44.107] ([185.81.138.18])
 by smtp.gmail.com with ESMTPSA id k10sm5969406edb.68.2019.09.14.07.36.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 14 Sep 2019 07:36:41 -0700 (PDT)
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20190913095639.25447-1-eric.auger@redhat.com>
 <20190913095639.25447-4-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <70edd388-1dc6-5382-5dba-09ce732a608e@linaro.org>
Date: Sat, 14 Sep 2019 10:36:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190913095639.25447-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [RFC v3 3/3] ARM: KVM: Check
 KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 for smp_cpus > 256
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
Cc: yuzenghui@huawei.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 5:56 AM, Eric Auger wrote:
> Host kernel within [4.18, 5.3] report an erroneous KVM_MAX_VCPUS=512
> for ARM. The actual capability to instantiate more than 256 vcpus
> was fixed in 5.4 with the upgrade of the KVM_IRQ_LINE ABI to support
> vcpu id encoded on 12 bits instead of 8 and a redistributor consuming
> a single KVM IO device instead of 2.
> 
> So let's check this capability when attempting to use more than 256
> vcpus within any ARM kvm accelerated machine.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


