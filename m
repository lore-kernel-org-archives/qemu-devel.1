Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCA32071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 08:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuyX8DWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCA32071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUls-0001pP-KI
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 04:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUl6-00012M-Bo; Tue, 26 May 2020 04:16:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUl5-0006kf-LM; Tue, 26 May 2020 04:16:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id f5so2331379wmh.2;
 Tue, 26 May 2020 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xtv3pfI08ph+Vnmgl5CRTzpt6lk1dLDI5NDSsSeV5NE=;
 b=XuyX8DWNsDZzoxOWgZP2RYH/wao6LBYcz3c+h9E1RlN0+O0pbtm2ZgyEPpB4HFrSZl
 Vzk9MWgufj/PgHh4bxiYnlvGKfMqBQ5Ps0gyIKNdkGQlfKdMmNy2BL1cZcfPvpMbvYeQ
 mQiK12iPqCWPNWg3+0KZqyWyt7dI6j4dEmRCDo3OO68/Rb39HqdnktXngS7aXd1Im4md
 6PkBZZLPU9+G8qMArSJbSIEEgb8qM93Ruzrqg9adbbxe/IrUZ5G33+x6OMyWHBTL1uC2
 ZKHEgA/PTBOBzQfgqpF5pvajUhRq2R0APL36U1rneQ8GJzAFPjMKL9AEPFehz/L3qyOn
 iTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xtv3pfI08ph+Vnmgl5CRTzpt6lk1dLDI5NDSsSeV5NE=;
 b=Z5NCXVjPvYJ6cx5hcKDzMGWnQf0SXNSg9K9b2YFIOogXhsBMte/IkP9IbcyEVgeewK
 A0S79l1SSZFACkJeBlsB8V02MnYQAoXPC9QMxCRN7DutEy/NUWmrC0Sw1QBon1B/+S8T
 A40m83WJtp9jUJl9eZZfkhDbs8aUzf1yujfi61SmmTiHiUgimSkoofVR142iyf5xWtrL
 1Nmtc11RdAvQR6rmAuLT2BtLgZ+4b4C/DxZ6476Y2saakad/kVDXpo98Y3BPRje/zJkW
 kgdpCzF6aWfwk8rGeFMroiZ8UznqsbBHJtz3DCUeaqNzqEIVBci1VzDMQWAtTQl3nFVV
 6TRQ==
X-Gm-Message-State: AOAM530u7GGOCD92/S/qMCmMQkmyEj+LDH6ZdJeZaifBfSd3Nul+vDyx
 g1+Wkf0ZIviyvotzLrIzEAw=
X-Google-Smtp-Source: ABdhPJxFIzWUGLU+DjwiXREVvpqVyDfTwQ2HTwdQKxBbh9zXAyDl3DXP4Psk7OsNwFjlEY4/EJR5ow==
X-Received: by 2002:a05:600c:297:: with SMTP id 23mr305757wmk.12.1590480981152; 
 Tue, 26 May 2020 01:16:21 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b185sm170016wmd.3.2020.05.26.01.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 01:16:20 -0700 (PDT)
Subject: Re: [PATCH 11/14] hw/display/vmware_vga: Let the PCI device own its
 I/O MemoryRegion
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-12-f4bug@amsat.org>
 <20200526080123.ul5r4abphqfi7lkq@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4a6478f2-6b70-40df-093f-e81d2437bfa7@amsat.org>
Date: Tue, 26 May 2020 10:16:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200526080123.ul5r4abphqfi7lkq@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 10:01 AM, Gerd Hoffmann wrote:
> On Tue, May 26, 2020 at 08:22:49AM +0200, Philippe Mathieu-DaudÃƒÆ’Ã‚Â© wrote:
>> To avoid the orphan I/O memory region being added in the /unattached
>> QOM container, register the PCI device as its owner.
>>
>> Signed-off-by: Philippe Mathieu-DaudÃƒÆ’Ã‚Â© <f4bug@amsat.org>
>> ---
>> RFC: This might break migration
> 
> --verbose please.  This doesn't touch the live migration data stream?

Oops, this is an I/O region... I was confused by this warning form Peter:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg681970.html

But it is restricted to RAM regions, so this patch is harmless.

