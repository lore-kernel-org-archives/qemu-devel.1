Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED9AC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876C520881
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876C520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hht7X-0007WG-Q2
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55324)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hht4Z-0005OU-OK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hht4Y-0007Hj-RH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hht4Y-0007Gk-K8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:58:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so13074748wrt.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dgll8oBJtYj1B8sKA527DIWHh0AAbHKq4LPxu9CgDP0=;
 b=KpSYEWdmfbaaIZavnM0df9gUolADqlG1uhkCPYUuE7ggo5qPLAHoHN4K+lKjURjFu4
 vyPoaX9NrfeA9kq416T27Xc0BMadHZBzoBVCoUxbPTmpYNbyRLdVrnDGQOj9wUlBVgmB
 ltXI7PrJfrm/5NAglXNDzSpBNFcKd6os/J5Tza3BpWAoUd1r75zGWeRTuYo7OjrHKQK/
 NYQUN8bTIY2aifsumKmO5MPXJLgzBTFR2CXgG6Hdfms9ZPWw0ElKsR68iII5h/FYWN7o
 83NgW6R96GhiM3jBgqj7jLFWkZjrO1kqc5nzlnCWAmfRX2lsF5AHaZ3l7aHn+miDuw8+
 btOg==
X-Gm-Message-State: APjAAAUz/JV4olZdk4ZiWm2/12AHVUEZgmnbm7+O5rl+fwE6d6d4SmdS
 Ec7sYKzQQZC0lAtQi9tfvu2/pA==
X-Google-Smtp-Source: APXvYqwsvcPeM9wlv9ho1VKNIhNtZNdz1sqaXGdv4HpYh10GZaBLxhfOxrzqxyPZN+13LG7N+y3yqQ==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr19763319wro.190.1561975085756; 
 Mon, 01 Jul 2019 02:58:05 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id a81sm9562617wmh.3.2019.07.01.02.58.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 02:58:05 -0700 (PDT)
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 peterx@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com
References: <20190701093034.18873-1-eric.auger@redhat.com>
 <20190701093034.18873-6-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c3ea9b07-3f5c-a454-4971-9b11afcb3d02@redhat.com>
Date: Mon, 1 Jul 2019 11:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701093034.18873-6-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 5/6] hw/arm/smmuv3: Log a guest error
 when decoding an invalid STE
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 11:30 AM, Eric Auger wrote:
> Log a guest error when encountering an invalid STE.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 384c02cb91..2e270a0f07 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -320,6 +320,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>      uint32_t config;
>  
>      if (!STE_VALID(ste)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
>          goto bad_ste;
>      }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

