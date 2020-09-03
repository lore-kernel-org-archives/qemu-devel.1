Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0D9C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C0120716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzAu/Ctu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C0120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDxTr-0008Ae-8J
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDx1C-0004Oy-HE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDx19-0004kz-Eo
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599169418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1Eu5FAmo3br8/kZmQpMztZdSEQefBmXBNkP0m2C1VU=;
 b=bzAu/Ctuw/hx8F9l7rkSFNrZe5r4HhnGopk5F1/kH5n1gKMh5C0Y0uIRYdd1pbZa+T/HX9
 rZg9aScff01JYWfa28ZtpSM2Uq/VW9uQYfULUPRhngXqfn+Khl2eVIbHK34FH/0QpqYjEs
 oRMR9DZ6bGn2qVcJzyUP/62fHsheUc8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-N1TRk4wUMG-r4BppfdwW0g-1; Thu, 03 Sep 2020 17:43:36 -0400
X-MC-Unique: N1TRk4wUMG-r4BppfdwW0g-1
Received: by mail-ej1-f71.google.com with SMTP id ml20so1719150ejb.23
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 14:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K1Eu5FAmo3br8/kZmQpMztZdSEQefBmXBNkP0m2C1VU=;
 b=ali6fw/RyF9QdmbaJySb+3JZGCGk5uudmjVUSxDSLT0VU3V7UqqIZv3s5mgsJCGSEe
 GBuZzP6r/vRFLyZXyqS4gHiHSxpP4ePRTZNBuF2t4lgltngiVvhseHCxtZ4caH0ir8nU
 r4ZATVpWib+sT3CaKnv6b4VtCYlxpGHp3FKndSatnfp8tAoqWikaqyJlDSG8zGwL4bEh
 jOi9IXDmYyc7sbh1LSwnaLMddH7j6IP6e8abd7QhO+foB98/eck2lHzAfna0reTv3U26
 s/W12VlhtcavfmhzoXNIC7bN1JLWCz71FeV+m/ejJTfbjZEd89gBpBwLv4akSt7IhX+T
 FA8Q==
X-Gm-Message-State: AOAM5312D3bFGPP1mvwDfMYNDabgX+LcALXR1QSJePkaAWJCeNe5W8BW
 lUVekOTQ5TAiZAgs26BVPJ81g6TMODq1V120L6CZZ6HQQbmx6j3X0BnYr3KPCEzxMrvt3MW6B8w
 mlyGmfC1IkAPMOwo=
X-Received: by 2002:a17:906:2f02:: with SMTP id
 v2mr4042632eji.465.1599169415518; 
 Thu, 03 Sep 2020 14:43:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzem05YsMlJDWEOVqCxuEW9+ld4nwCdNwI6ao+5XPy6rtMXVXY/bpNQA5W2KghJJ7JrxrxGjQ==
X-Received: by 2002:a17:906:2f02:: with SMTP id
 v2mr4042589eji.465.1599169415293; 
 Thu, 03 Sep 2020 14:43:35 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id z23sm4166518eja.29.2020.09.03.14.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 14:43:34 -0700 (PDT)
Subject: Re: [RFC PATCH 11/12] hw/pci: Only allow PCI slave devices to write
 to direct memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200903110831.353476-1-philmd@redhat.com>
 <20200903110831.353476-12-philmd@redhat.com>
 <7e4fd726-07e9-dc09-d66b-5692dd51820f@redhat.com>
 <245445c1-970f-124a-9ebc-489d3ae42d5d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc67c282-1ea8-9750-70d6-aeb8fd99f846@redhat.com>
Date: Thu, 3 Sep 2020 23:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <245445c1-970f-124a-9ebc-489d3ae42d5d@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Laszlo Ersek <lersek@redhat.com>, Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>, Klaus Jensen <k.jensen@samsung.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/20 15:18, Philippe Mathieu-Daudé wrote:
> As of this patch, all the non-PCI, but I plan to add a similar
> check for USB on top of this series.

Do you mean for memory-mapped USB host controllers?

>> I'm worried that there are cases of MMIO reads that would be broken.
>> They are certainly niche these days, but they should still work; the
>> most "famous" one is perhaps the old BASIC
>>
>>    DEF SEG=&HB800
>>    BLOAD "picture.pic", 0
> 
> This looks like ISA stuff. I don't think ISA does such checks
> (and didn't plan to add them there) but I'd need to verify.

It works on bare metal even with a modern video card.

> Do you have an acceptance test?

Nope. :(

Paolo


