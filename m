Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB283C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:52:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8588A20717
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgT0XpgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588A20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihASu-0004Yk-M5
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 05:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihAS9-00045e-St
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihAS7-0004Ut-QF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:51:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihAS7-0004SY-MS
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576579902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JTQ74mHwLgedkvjXOuy+I8/h5ZD/mC//vMaDp5U/ds0=;
 b=GgT0XpgUODAMFVnIsF0NFhiqMYLqz/1ziXl76Cn1cHvsXzb7CHGbSrijGmK5ZeY6Wj4k3w
 Uvhd7KzYB3dUMTLQ3v8ysaJQQpg4RGAh3FZ/888YH2xa0a7enXQFame3HKGlzbavdZFVSr
 B1aePzopou4Rtkd6cDjrhhYnAmz7tF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-dt3eX-2kO0mO5YTvf63VHg-1; Tue, 17 Dec 2019 05:51:41 -0500
Received: by mail-wr1-f69.google.com with SMTP id f10so5216473wro.14
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 02:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=plq2Rzwu71zO+Knh3il3t2LD+vigMr1gcAdts+PFypM=;
 b=JORwPQOPvwzn5Krq1YtO0uObNdPa9Uaa2RNdrP7K0U2NE40XJ2zQe1VKIY+sXg3VAq
 J/NTRVBWFy7SojmJhja0H8JtLVbrvAPlfk/o9eCXzoEcHw7TY/ewe5rlHXUCbU5znfSK
 5R6XBluCD6fdM2NGCY36nn9taOVP/TDETegbW3p6TL8QWlH/IUgshFLxpHMFTqROzFA6
 rhnq/i7DEt+kELzghoCqL/G+ZorPq7Vc6o0H+diXBhJSeesml/7GjDlENXSy5QtUWhLN
 72xmAdcWzN/GGem4kDLoKtXHXeAlgKYoIeX519g3pGnfTxu2Vep869t+GG1heCYjCluk
 KysQ==
X-Gm-Message-State: APjAAAVBzch7ZPLs59p/9xRLve6ib7Rs7u8FOETMLhmpxc11QFm1axZA
 EPy1Mr6tt3Z6mSr+gn5gtsygd4MqrbhO6PfFE52+q6CxqIHc2l5B0Tkya8e2rNsvJgtE9eTYF6W
 J4bXB4G7LPWvQb58=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr4758590wmi.107.1576579900082; 
 Tue, 17 Dec 2019 02:51:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxFSPXjVUE+7zLbnkqIL1trgOzD0GyEGEjIExRSJAIrD3D4OXOweWSVVDhsE0BT6KvhfGCI3w==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr4758550wmi.107.1576579899736; 
 Tue, 17 Dec 2019 02:51:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id f1sm25774091wrp.93.2019.12.17.02.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 02:51:39 -0800 (PST)
Subject: Re: [PATCH] memory: Do not allow subregion out of the parent region
 range
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191214160223.20012-1-philmd@redhat.com>
 <da81a3e7-62a8-f46e-c12f-4dead2a9091f@redhat.com>
 <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a07cc6f-8762-145e-2b54-c61b0e287f19@redhat.com>
Date: Tue, 17 Dec 2019 11:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <92bb8e12-3ece-9811-438b-8fa64d2bde66@redhat.com>
Content-Language: en-US
X-MC-Unique: dt3eX-2kO0mO5YTvf63VHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/12/19 18:46, Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>>
>> I think in some cases this could be intentional, for example if you have
>> different models with different BAR sizes and you organize this with the
>> same tree of MemoryRegion and different sizes for the parent.
>=20
> But if a child is outside of the parent range, it can't be reached,
> right? I'm confused, maybe AddressSpace can do that, but MemoryRegion
> shouldn't?

Yes, the idea is that you could have for one version of the device

   parent 0x000-0x7ff
     stuff 0x000-0x3ff
     morestuff 0x400-0x7ff

and for another

   parent 0x000-0x3ff
     stuff 0x000-0x3ff
     morestuff 0x400-0x7ff

where parent is the BAR, and you can share the code to generate the tree
underneath parent.

> In the PCI case, you will simply alias a subregion with
> memory_region_init_alias(..., size), and size has to be <=3D parent size.
> But you won't add the PCI region, you'll add the alias, so the assert
> won't fire.

Yes, this is a workaround though.  You shouldn't need the alias.

I can see a case for your patch but I can also see one for the current
behavior...

Paolo


