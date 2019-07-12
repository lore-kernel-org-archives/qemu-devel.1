Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A429FC742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E492080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E492080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlw4p-0001hn-7Y
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34148)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlw4X-0000gr-K5
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlw4V-0006cd-K0
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:58:48 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlw4T-0006ZO-IF
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:58:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so9031351wmj.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rNwCNC+10yBlH4kZSa0yz2zQiOhFu6g5HiGNj7NQhQI=;
 b=LyYJcu9+/Cpd83UtNBraZkNilpAb5BFpo2ZzNpl4p85o5DXY7oACv498mspZurdG4E
 dSiPsK/2arAldPj0YWm/+v5ukLI7YV98YcGNY3A00FHDA39F1/z1PNa6ITkPUPbfTxDr
 gVrQt07mwji07dHNSX13BnzqbrhLd2VRAlUf9JtF4CEfs0y1UFaB7Cvf9cNmJxVfbM9N
 7NuDkEJYNot0ASHmy6uVncKP/6muUykNqERsW4hQQBBFMxxjC8MlAkClNlV+W+Hct4Ut
 zWEZPTllY1EGXY7jGViDX7wRuB196J4AcGSEB/3p9fFe/RIqtfXhDGjDh5XYx3e49z+m
 SHjw==
X-Gm-Message-State: APjAAAVO1P+ff+itP7dMJZ9TMWN5+XrvVqo5uIz/1NW0rt9VUVDzYIER
 7K4F45/doWkhZuZyOIbW5we78Q==
X-Google-Smtp-Source: APXvYqySp+FyO13aelVM7Yn9C4rkCbEDrz83vngwqeGCUT/Lyrw/iX2G52prwC3iFqhsYPzY32TlTQ==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr10025266wme.47.1562939923853; 
 Fri, 12 Jul 2019 06:58:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id a84sm9230592wmf.29.2019.07.12.06.58.42
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Jul 2019 06:58:43 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190712133928.21394-1-philmd@redhat.com>
 <20190712133928.21394-3-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <64a41af4-e635-06e3-05a2-d2cddaf02af0@redhat.com>
Date: Fri, 12 Jul 2019 15:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712133928.21394-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH-for-4.1 2/7] hw/usb: Bluetooth HCI USB
 depends on USB & BLUETOOTH
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Miroslav Rezanina <mrezanin@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/07/19 15:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/usb/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 564305e283..1b435ec002 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -82,7 +82,7 @@ config USB_NETWORK
>  config USB_BLUETOOTH
>      bool
>      default y
> -    depends on USB
> +    depends on USB && BLUETOOTH
>  
>  config USB_SMARTCARD
>      bool
> 

Shouldn't it select BLUETOOTH instead?

Paolo

