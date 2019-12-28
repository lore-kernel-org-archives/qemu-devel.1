Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC96EC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3B82168B
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0GK2Wbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3B82168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLsD-0003xx-NS
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLrW-0003X1-7o
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLrV-0007Ng-6D
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:51:14 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLrU-0007JA-Uw
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:51:13 -0500
Received: by mail-pl1-x644.google.com with SMTP id y8so13208017pll.13
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OYBcHSgAZZppt+F1lcVOa23QZD0sSrev8sPpCVYTgt4=;
 b=s0GK2WbqcqSV5IPKaowao7st0Gs0XShQNGxq+fAzq+L5My3NAbkxE9U90yI6JiaJ1S
 PvZxZKuegB8jaL1lo8X1t5fLq+bXYPn2MzXiFDPC1scF/B1JmEcdV6ruCjxp7Cv9zUfz
 LmzPs2bVsxW0ekj9KtRr6cEOR3IVfzc5IVs6NJTPaMUs8wt6JgxRuB456A0LXnSIsgjt
 yRO4GA861xf+lUBZqvLdjRQM6v5dzoiKhEIAg2jvZYvM2piYFNzRDMwnnKA5wLuJ+NM1
 k/bZD7F27fRAwdyMuFDm33rNjdHnFUCwbqyzxarG7Xo/hfU755V1FRIoQ7IlT9YueZ1S
 fHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OYBcHSgAZZppt+F1lcVOa23QZD0sSrev8sPpCVYTgt4=;
 b=MASfT9l1GGiLL8I5Jjadn076ypx5f+LSkD7zwGU+i1gI/KRGIFW44YOhAnpTIe3sgg
 WP+EAnkksUY87ZKiThry2CpRFi25ooPSiqjbgIDRShnaTMabZSp+d7RAui6vGRhrCoot
 JKUWTF8IDmHg36o5mJLe87quLKeyzdLfXOV5iVuL1eEWsu/NKtyY90IbN/ImFKWQDIj7
 R+YgEaNwVerjuLpuQ7M82VNDVyqbeY1DHjBs161399RVakiacqUC0PVzN0+qDbB9n8Ej
 yq/hsk406pOrRth8FP+YEOIt4AcCVAAnupcG+iKOLHGkVAN29wfynI7AqxQbkEpTsWY5
 9RWg==
X-Gm-Message-State: APjAAAW7c/EU3ix+Pn+yOS85v9lyyGdsKMO10oVWSeY+GlBlVdkTLnJd
 9IgWzN1eVH6YQ22Ef13Kx7hP7Q==
X-Google-Smtp-Source: APXvYqwxyYwl/x/sAJNYLBSUBium2GA59CKs7TZgJDdQeEjpbGkgytrg9MuJtWwk9mHylq0oZOFOHw==
X-Received: by 2002:a17:902:a50a:: with SMTP id
 s10mr34791519plq.136.1577577071817; 
 Sat, 28 Dec 2019 15:51:11 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id y128sm44292293pfg.17.2019.12.28.15.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 15:51:11 -0800 (PST)
Subject: Re: [PATCH v6 06/11] hw/core/qdev: handle parent bus change regarding
 resettable
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
 <20191220115035.709876-7-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <af6d26db-595b-4e39-8d9c-1bcbf338983c@linaro.org>
Date: Sun, 29 Dec 2019 10:51:03 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220115035.709876-7-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, edgari@xilinx.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:50 PM, Damien Hedde wrote:
> In qdev_set_parent_bus(), when changing the parent bus of a
> realized device, if the source and destination buses are not in the
> same reset state, some adaptations are required. This patch adds
> needed call to resettable_change_parent() to make sure a device reset
> state stays coherent with its parent bus.
> 
> The addition is a no-op if:
> 1. the device being parented is not realized.
> 2. the device is realized, but both buses are not under reset.
> 
> Case 2 means that as long as qdev_set_parent_bus() is called
> during the machine realization procedure (which is before the
> machine reset so nothing is in reset), it is a no op.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

