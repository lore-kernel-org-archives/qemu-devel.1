Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A76C3B19D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C28206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSKJueX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C28206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2bwV-0002lH-AD
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:27:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j2bvP-0001Ns-B4
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j2bvO-0006L2-7t
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:26:35 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37558)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j2bvN-0006Jm-6a; Fri, 14 Feb 2020 09:26:33 -0500
Received: by mail-pl1-x644.google.com with SMTP id c23so3800031plz.4;
 Fri, 14 Feb 2020 06:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eY3vOUcsAaeAD2/crVnO3Sv19z9so2Ylgmn74tRhRJY=;
 b=gSKJueX3l3dr2qZdd+ylScIdzAymHKUVG7Iv3uTlVnuksvx7uhSdzcqhGjewDMEkyE
 Bq3s8bnLV1ELoO2FpdK5DPuMe/beQFvsn68LWMOUM69zGi1gB5SMooVxCoR/6Z4e6K9E
 wktfj69BscRhb9+1OwnrlvpVdtCfPkgALOWabglkWyOLhRNnGzy5g5QooEAvIrm0WHfu
 NPzh6RRwZzwwnAJZf519PsJ86eQzXs/WYzvmjMN9XzMZ9K98hZdzW+KKnQSigrUnh3jn
 tHR0yYTcHaupAdT7ZrW1QHdFd7R/W5monjFNbrDbUe8MiJkLtIW7arMZCs5dwqemCoks
 mS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eY3vOUcsAaeAD2/crVnO3Sv19z9so2Ylgmn74tRhRJY=;
 b=L0xR7ICID/0UCIeL0CDzvuZLaMzEmTGbVpzgefUxI9mT0SqbiQAUmqjEcoAhAqM3QR
 8T6akk/CIk+Sg/zfl85aSCuAivHcJZ0bcA2Z2f4NPnyU2PXby+eB1IEJ0oTb0sSqBhhK
 KlQs39dqsknkGAlOQBSBVzQgYiCQux0cuUxuGr+QDOO7RDlIfRleaN1gH+AOgB2zpWBQ
 ji5txOX+lETtud1t/jqzqKPWMQqO/sUWhRtNymbBGHdY5YlgIZkemdxpddW+s3ds9+Xd
 fTbukiZux86RdOtf/CDpic4UjYAPMfVXvDQrbwD4iPKMA7O65YbOza+WPXao3iPj/QI0
 S3vg==
X-Gm-Message-State: APjAAAXxXc4ueCchpiloFEwdXJmoE5b6dx1FhZRPAaYO+nOmkxy+OwG9
 84DF6FYtXXVhHgwuggQ3TJQ76/Zk
X-Google-Smtp-Source: APXvYqy1ax5MOAlIt9oHjXUOQ6cqenkDtcVv3UNDS33PcoZXuwkOr5IAMgFuUn7NgHT6zxsNTSM3Fw==
X-Received: by 2002:a17:90b:97:: with SMTP id
 bb23mr3709789pjb.53.1581690391132; 
 Fri, 14 Feb 2020 06:26:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 t65sm7171884pfd.178.2020.02.14.06.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2020 06:26:30 -0800 (PST)
Subject: Re: [PATCH 3/3] arm: allwinner: Wire up USB EHCI
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200214062109.24494-1-linux@roeck-us.net>
 <20200214062109.24494-3-linux@roeck-us.net>
 <20200214100837.lv2cok5he7epmu7i@sirius.home.kraxel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <db087bc9-eb23-0b6e-b3aa-5309d824f6ef@roeck-us.net>
Date: Fri, 14 Feb 2020 06:26:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214100837.lv2cok5he7epmu7i@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 2:08 AM, Gerd Hoffmann wrote:
>> ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 2
>> ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
>> ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
> 
>> +        for (i = 0; i < ARRAY_SIZE(s->ehci); i++) {
>> +            object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized",
>> +                                     &err);
> 
> I suspect the ohci controllers are ehci companions, i.e. they handle a
> single usb bus, with ehci handling usb2 and ohci handling usb1 devices?
> 
> If so then you should initialize ehci first, explicitly assign bus
> names and set the masterbus property for the ohci controllers.
> 
> See also docs/usb2.txt
> 

Thanks for the references. Makes sense; I'll give it a try.

Guenter

