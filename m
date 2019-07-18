Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B8DC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:26:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE8121783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE8121783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho2gd-0004dm-62
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 05:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41328)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho2gR-000485-Gm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho2gQ-0005eb-IF
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:26:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33089)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho2gQ-0005eA-BM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:26:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so27939894wru.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 02:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pIVzjUgReIgEScyxaN4HvPBkTixCGv1NeIuqMxQD6X0=;
 b=h7eZhOXI4nZSadVDjA8qAnxZRYe9+U08hXoh37UbDU/F9m6XBvoVbCYsnWUbgj18wH
 wXJuOcDcp2U9DZOtCymdJkuncxH98eZqCGSg9DkEISki5fWpBXex9enoNP8UzXqq4NOy
 s2bX9NxuWa+/5RYUrlXREsfQ+w4pHgwlU468675aLNHbL0y7burNkb8hpXI3aa6TyaJz
 Pk/sw9KCn08qZfVkcvZIisU5R9D3ZWVHJGu9FhXmfVbT/b5cKI10d8mhBEPWJyA9OhsZ
 LKDAhYxpaXtWKsnJq8ggN+CEHwAQtLcMCqqkUZsS0i5M6FmghfmG/mvSTGnaUVfvDUPJ
 qKbQ==
X-Gm-Message-State: APjAAAU8wjT/DBrlRrJmgbLObhh2VpZiWhqt99OiBP2NgUbvOnsCKIWA
 r4WWDAmg0FDcHybBZvNJqjQ2Ag==
X-Google-Smtp-Source: APXvYqzTvp7C8xZhyiw7ieaFCtHF7TwfYEQCduPfbigfKXm5UWLcJXWP+JHuZ1HEwZOdGkM8LYvDng==
X-Received: by 2002:adf:e442:: with SMTP id t2mr43061758wrm.286.1563441997243; 
 Thu, 18 Jul 2019 02:26:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id v204sm24513299wma.20.2019.07.18.02.26.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 02:26:36 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190718091740.6834-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ac53542f-40c3-8e2e-c8fb-0673183a3504@redhat.com>
Date: Thu, 18 Jul 2019 11:26:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718091740.6834-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH-for-4.1] hw/ide/piix: Mark the PIIX IDE
 interfaces as not user_creatable
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 11:17, Philippe Mathieu-Daudé wrote:
> The 'piix3-ide' (and 'piix3-ide-xen') devices are part of the
> PIIX3 chipset modelled as TYPE_PIIX3_PCI_DEVICE (respectivelly
> TYPE_PIIX3_XEN_DEVICE). The PIIX3 chipset can not be created
> in part, it has to be created and used as a whole.
> 
> Similarly with the 'piix4-ide' device and the PIIX4 chipset
> modelled as TYPE_PIIX4_PCI_DEVICE.
> 
> Disable the 'user_creatable' flag.
> 
> part of TYPE_PIIX3_PCI_DEVICE (TYPE_PIIX3_XEN_DEVICE)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

This works though:

  qemu-system-x86_64 \
    -M q35,sata=off -device piix3-ide,addr=1f.2 \
    -drive if=none,file=freedos.raw,id=hd -device ide-hd,drive=hd

And it is a nice hack to mimic Q35's legacy IDE mode...

Paolo


> ---
>  hw/ide/piix.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index b97e555072..c02e768668 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -253,6 +253,7 @@ static void piix3_ide_class_init(ObjectClass *klass, void *data)
>      k->device_id = PCI_DEVICE_ID_INTEL_82371SB_1;
>      k->class_id = PCI_CLASS_STORAGE_IDE;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->user_creatable = false;
>      dc->hotpluggable = false;
>  }
>  
> @@ -279,6 +280,7 @@ static void piix4_ide_class_init(ObjectClass *klass, void *data)
>      k->device_id = PCI_DEVICE_ID_INTEL_82371AB;
>      k->class_id = PCI_CLASS_STORAGE_IDE;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->user_creatable = false;
>      dc->hotpluggable = false;
>  }
>  
> 


