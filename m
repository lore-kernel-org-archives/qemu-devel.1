Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E637EC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9A9206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsUddEN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9A9206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLk7m-0005xq-Ra
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLjqd-00050h-Kk
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:44:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLjqR-0000fw-U2
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:44:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLjqR-0000fD-NS
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586249071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iyD86UCPi7qWmJzIdN9nBj/+Pd6cSGA9iBteF0/HihE=;
 b=IsUddEN5uAGipBsTbRPkzkIsCfA/Ks/XIcypdqqEfqzVZPccwT7M3CAUppiKKg621aqSUQ
 dX9EnQyXY4j0jG0Eo1qLw24aHu3p4ddTlWsl4f12cp/5rjhF1+9rLmaeJL9CE1ydZKB1mD
 7ImgZEiE9FKPJNd5KHbji34QwB/lV4s=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-hZV1sdeJOdG_40yAydx0aA-1; Tue, 07 Apr 2020 04:44:27 -0400
X-MC-Unique: hZV1sdeJOdG_40yAydx0aA-1
Received: by mail-ed1-f69.google.com with SMTP id b100so2437780edf.15
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iyD86UCPi7qWmJzIdN9nBj/+Pd6cSGA9iBteF0/HihE=;
 b=ZWVETOyUveDzMKdUa41kIbFvFXWQbv4wLWBOUkZc30ucmjqBa5BEADYt3WjJf2zi6u
 ZszCd5/9bn/ZsQFCVH72jVdPQGOVknfxCghQZP4TF2pOWW49Md5XYDrxWs6jMZtwwDw6
 aJQ+5lz/72hO0EjRHjU9SYfOEGsAzxJ2rR0cnf7YbdNUqtSaKF6na1Me7EHZCvus47+3
 TydCBegWxcedLnvzUasJ/0S9g7IVpdv+0FMlYdzG0g0dSbTJDb0IacU4rwRC/Ms4ijVP
 8ioomd5Zt8ky1465HWSikXxB+iHERSjs2P2amiUZrTtzGPPeCXTYuLY6W4Owek2TyvzV
 SuRA==
X-Gm-Message-State: AGi0PuZvlssdwxtJvR/1WCBps96TpPqBzvOEwdxGg6Ck9PDjsibcVaTN
 GBAClls1JXgeMLNbJFLYYvW67ysHAE/xb+5Mk25Sdh3yuTrgsCf1BfJmAXaJqOG9LuDJEMlyB5U
 Bgd+5hgw/dmXXAoI=
X-Received: by 2002:a05:6402:31ad:: with SMTP id
 dj13mr924069edb.60.1586249066047; 
 Tue, 07 Apr 2020 01:44:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypLUL/2/cZ6Zgv9tjQWH8/IEa4fyWtEb61Uk/4RuAKsPgruOYqQk1NQHIWUN4nD19i5aJfGOsw==
X-Received: by 2002:a05:6402:31ad:: with SMTP id
 dj13mr924059edb.60.1586249065808; 
 Tue, 07 Apr 2020 01:44:25 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n18sm2631405edv.93.2020.04.07.01.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 01:44:25 -0700 (PDT)
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
To: Cameron Esfahani <dirty@apple.com>, qemu-devel@nongnu.org
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6aac0d31-d0a4-d103-e3b5-89feef27c018@redhat.com>
Date: Tue, 7 Apr 2020 10:44:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
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
Cc: peter.maydell@linaro.org, kraxel@redhat.com, joel@jms.id.au, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cameron,

On 4/7/20 12:55 AM, Cameron Esfahani wrote:
> NRF51_GPIO_REG_CNF_END doesn't actually refer to the start of the last
> valid CNF register: it's referring to the last byte of the last valid
> CNF register.
> 
> This hasn't been a problem up to now, as current implementation in
> memory.c turns an unaligned 4-byte read from 0x77f to a single byte read
> and the qtest only looks at the least-significant byte of the register.
> 
> But, when running with Cedric Le Goater's <clg@kaod.org> pending fix for
> unaligned accesses in memory.c, the qtest breaks.

The 'fix' is from Andrew.

> 
> Considering NRF51 doesn't support unaligned accesses, the simplest fix
> is to actually set NRF51_GPIO_REG_CNF_END to the start of the last valid
> CNF register: 0x77c.

NAck. You are burying bugs deeper. This test has to work.

What would be helpful is qtests with unaligned accesses (expected to 
work) such your USB XHCI VERSION example.

> 
> Now, qtests work with or without Cedric's patch.

For the other reviewers, the cited patch is:
https://github.com/legoater/qemu/commit/d57ac950c4be47a2bafd6c6a96dec2922c2ecd65.patch

If you look at it closer, it has:

          /* XXX: Big-endian path is untested...  */

              /* XXX: Can't do this hack for writes */

Also Paolo Bonzini made comments that are not addressed, about 3 years 
later:
https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg03684.html

> 
> Signed-off-by: Cameron Esfahani <dirty@apple.com>
> ---
>   include/hw/gpio/nrf51_gpio.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
> index 337ee534bb..1d62bbc928 100644
> --- a/include/hw/gpio/nrf51_gpio.h
> +++ b/include/hw/gpio/nrf51_gpio.h
> @@ -42,7 +42,7 @@
>   #define NRF51_GPIO_REG_DIRSET       0x518
>   #define NRF51_GPIO_REG_DIRCLR       0x51C
>   #define NRF51_GPIO_REG_CNF_START    0x700
> -#define NRF51_GPIO_REG_CNF_END      0x77F
> +#define NRF51_GPIO_REG_CNF_END      0x77C
>   
>   #define NRF51_GPIO_PULLDOWN 1
>   #define NRF51_GPIO_PULLUP 3
> 


