Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF569C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1032190F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 09:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1032190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFE9l-0008Kq-AV
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 05:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFE5N-0003Lx-5B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFE5J-0007LN-JQ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFE5H-0007JJ-Hi
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 05:04:39 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BCE4981DE1
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 09:04:35 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id q9so1094278wmj.9
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 02:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nf75tsytWvVa5P211CUNaR1QAPyTR04F82rf9r4wK14=;
 b=ctfO4ENaxqmZZu+0hcj4kAson2pkVONLufOPiHZKWwg94IxXfDLLEhxTmWHSAHo4m4
 rppVl29Za+5orMeccM330XS7OX5cRVsVjSsdIXAxO+cbU/LtzsdG2RXD27yLuzxkAMJ8
 kRnqCcL4AY8W0fRN25vJf88Dp/K5jM1lU7kVbY6XsDAOd51AtCAcMQojgRxpiuH3Nzl8
 bd4edLK6M9yxq8XDeMO62mOrVfLadHrYgOEp2QufVH/8VgbYatrS7oD+4SxxdqiNdBSV
 gX6dWNSkPDd34GVwzAc3KSAjCkxCKmYWASVc0ioazziApglIYCanW0wsxpq7mW2QFqbr
 cgNg==
X-Gm-Message-State: APjAAAVjFcmQomaKLmUqfgn43W5VAwZ5BRRoF7Jw5u6OLnYhslFsXn80
 jtpWXAvK4iSBM4eujLY1cm87qbt+3yWYH3Wio5eooeN3JXgnTy6FJAJZFcD2rd8Mu2ZIkkUr8N9
 oyqd0Ii6+xL+EV9c=
X-Received: by 2002:adf:e387:: with SMTP id e7mr3403134wrm.306.1569920674570; 
 Tue, 01 Oct 2019 02:04:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygadFdU2jgr0Hgc4B9WtbBBfEto1389QeZVeWsFBXEQkl3QjTCygkfWyhOQseAFqQrvTVF5w==
X-Received: by 2002:adf:e387:: with SMTP id e7mr3403121wrm.306.1569920674400; 
 Tue, 01 Oct 2019 02:04:34 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id i5sm2315426wmd.21.2019.10.01.02.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 02:04:33 -0700 (PDT)
Subject: Re: [PATCH] slirp: Allow non-local DNS address when restrict is off
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
 jasowang@redhat.com
References: <20190929181303.19960-1-samuel.thibault@ens-lyon.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b49bd2a3-5280-136a-cc35-3d7c14b0a19c@redhat.com>
Date: Tue, 1 Oct 2019 11:04:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190929181303.19960-1-samuel.thibault@ens-lyon.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Samuel,

On 9/29/19 8:13 PM, Samuel Thibault wrote:
> This can be used to set a DNS server to be used by the guest which is
> different from the one configured on the host.
> 
> This fixes LP 1010484.

Wow, 7 years old...

Can you use this format, easier to understand for newcomers:

Fixes: https://bugs.launchpad.net/qemu/+bug/1010484

> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> ---
>   net/slirp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/slirp.c b/net/slirp.c
> index f42f496641..4d158b0542 100644
> --- a/net/slirp.c
> +++ b/net/slirp.c
> @@ -456,7 +456,7 @@ static int net_slirp_init(NetClientState *peer, const char *model,
>           error_setg(errp, "Failed to parse DNS");
>           return -1;
>       }
> -    if ((dns.s_addr & mask.s_addr) != net.s_addr) {
> +    if (restricted && (dns.s_addr & mask.s_addr) != net.s_addr) {
>           error_setg(errp, "DNS doesn't belong to network");
>           return -1;
>       }
> 

What about the IPv6 DNS?

Regards,

Phil.

