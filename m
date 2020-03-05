Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C3D2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcgaJOtS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C3D2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9qDD-00059j-BE
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 08:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9qCW-0004hq-DZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9qCU-0003Qa-O6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:06:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9qCU-0003PW-JN
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 08:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583413565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSkk+aHwgvQ/aRYstIrUcM6OXwxjlF24dtI9rq5qi04=;
 b=TcgaJOtS6zjXwdU65VKiy6WH+AtL7ljPZqydAG0LrDdutnjm6IRXJAlBFbJIQYli3df7PN
 zD2JScpByYmfwPQKwG9ABIP6hgnQiwG0wFidTdN98ogAc4R6h8zaKSrusDv4ccnMt4aWeH
 L5rscJ5G5LNv0HTkVAkwf2LU4Kdqc60=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-tiZdjfT0PNGkAbRGNWQXRg-1; Thu, 05 Mar 2020 08:06:01 -0500
X-MC-Unique: tiZdjfT0PNGkAbRGNWQXRg-1
Received: by mail-ed1-f69.google.com with SMTP id a11so2921282eds.15
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 05:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PSkk+aHwgvQ/aRYstIrUcM6OXwxjlF24dtI9rq5qi04=;
 b=BgPH01GIPyArUK8wUl5tqUg8rkp19DBvvlt3cZMu0rx97BnHhgL0fzOyr/ZBVP3DZp
 9p8X3vEo1YBcn1LravXMbgxa0OFDGyDwg6W5XwBKgshmTTf21qRWpzxSzWWqkKMvoJ0z
 WTwaoiXctMMsov6bu8IezY60lRagzsSyI4Jy56m88sb+KngClOHvIG0QURV9yeTEzK9V
 sRbehdCCScUhsN8W8Fe+ZZXrkCL533yn+hXSMhQOU9zgL6jIiz62VCXSwAVTWReWvVCF
 LOayUfega+W/WoqlV0ZS3e9FldFSU8C+Dl9P8KJTJjWSgmHjNuQzKcZLpSBSzZCv/LoO
 j6Qw==
X-Gm-Message-State: ANhLgQ1nVd9i3L9A2wGQ8WU7y9oBHbHUrXzh4NRmvOeIzH2JJRiP6y4R
 bZUa5Yt7b9eMJNQ/8MuMEK62/LZnk0sKJ4Z923vGdR2snslAUW3lVo5iUsXh8gHUDMY2TfS+J1/
 1eBG+TiZWKRKEgkY=
X-Received: by 2002:a17:906:585:: with SMTP id 5mr4360941ejn.356.1583413560454; 
 Thu, 05 Mar 2020 05:06:00 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvAREmrpYdwZyl1gr8sURctTy/6DLs1WAsL3Z3rRvVq/uPtjCmFMwWw7XuN0cpSbFoeab4qXg==
X-Received: by 2002:a17:906:585:: with SMTP id 5mr4360905ejn.356.1583413560178; 
 Thu, 05 Mar 2020 05:06:00 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id by19sm1187185ejc.85.2020.03.05.05.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 05:05:59 -0800 (PST)
Subject: Re: [PULL v3 02/11] hppa: Add support for LASI chip with i82596 NIC
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200124232009.12928-1-richard.henderson@linaro.org>
 <20200124232009.12928-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4e8c4d14-eada-4ef3-34ce-75b9a59bb7e0@redhat.com>
Date: Thu, 5 Mar 2020 14:05:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124232009.12928-3-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, deller@gmx.de, svens@stackframe.org,
 Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Jason.

On 1/25/20 12:20 AM, Richard Henderson wrote:
> From: Helge Deller <deller@gmx.de>
> 
> LASI is a built-in multi-I/O chip which supports serial, parallel,
> network (Intel i82596 Apricot), sound and other functionalities.
> LASI has been used in many HP PARISC machines.
> This patch adds the necessary parts to allow Linux and HP-UX to detect
> LASI and the network card.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Message-Id: <20191220211512.3289-3-svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
[...]
> +int i82596_can_receive(NetClientState *nc)
> +{
> +    I82596State *s = qemu_get_nic_opaque(nc);
> +
> +    if (s->rx_status == RX_SUSPENDED) {
> +        return 0;
> +    }
> +
> +    if (!s->lnkst) {
> +        return 0;
> +    }
> +
> +    if (USE_TIMER && !timer_pending(s->flush_queue_timer)) {
> +        return 1;

Something is odd here. Don't you want the opposite?

"if timer pending to flush the queue, do not receive more pkts"

     if (USE_TIMER && timer_pending(s->flush_queue_timer)) {
         return 0;
     }

> +    }
> +
> +    return 1;
> +}
[...]


