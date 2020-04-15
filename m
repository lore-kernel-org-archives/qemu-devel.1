Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB7BC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CABF120768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtieEXpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CABF120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOckN-0001J5-5x
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcjj-0000oA-FC
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcji-000602-Dc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:45:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcji-0005zt-AX
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RG1i/kj9BkXbF6Fx4h/vDtcxA4gHmCn+lgCeNKWiZ70=;
 b=EtieEXpJ4CGGDY5p8+6HTPYOzEr22j2mS5w8YOetI2asseBee9Q8O99gAmcnIMZhk7Mj/9
 5pf6zpcqT5QjtAU9BHOBBqI/S/XtRbZbyL0Z9/wdK5hkGP39Gm4kVh//yYnuEvHH41K8Py
 UCAsrBAPYurgMplg2gwW7swN5ME9B9g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-rWZQIdG2OOePz3zIqhvbuw-1; Wed, 15 Apr 2020 03:45:28 -0400
X-MC-Unique: rWZQIdG2OOePz3zIqhvbuw-1
Received: by mail-ed1-f69.google.com with SMTP id u11so2170588edy.17
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WwjbbCFoSMkDg9gSf9lJjjHc5ur8kt9s8X0CPvA1TWA=;
 b=i9F0FrZpuwnc5g8NrkGSFEk2SZ+P6pQMi12Lmx2sL+F+XZDOxJFEcexbQAADF/8QAd
 /wyWwLMPLJnctPUYyd/u8/wsVV6T5x9s5VFTxNQUIvUwEyoliP5QqFDs4rhssGTgo3O4
 0WAs1reMdtT+yjqNipeqaTvEgeql/VBmO3GdHNkeUunpgBEd9+bfa6Zr/jBwHH3B+hs0
 +05y1CyIgpyXmlrpNpWlqQkJn/2vamzEbx3Ky+M19kkMKxTx36CUSKa3GZYaWmbfslCg
 M9sf5u3tbXNoCmi4PSSnJ/ZcPRr+j7ZsxRgsQ7CvEhJzJxUqb/axVFi6cmOCTS1KgKYJ
 WejQ==
X-Gm-Message-State: AGi0PuZegBnkr0eLG9BxJK4lYzI/o5VAUsbSmikzfxKuA4Up1HnvVFCb
 rkjwbHo1lNljfCRiRLZnidsou+D3eQNs69VGTGgbHHP9by2PxuB4yXFUcGPbK9KfAt1fXEimOPt
 n/LtMt5YXNRMOI+4=
X-Received: by 2002:a17:906:7282:: with SMTP id
 b2mr3901068ejl.161.1586936726969; 
 Wed, 15 Apr 2020 00:45:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypI0AAjj/HU/oI5yiNyolLaSnxiOwh+40khrwgD5W9caK9zGEtNNN6NDbwQAtHL5w64TsGBLxQ==
X-Received: by 2002:a17:906:7282:: with SMTP id
 b2mr3901052ejl.161.1586936726789; 
 Wed, 15 Apr 2020 00:45:26 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y20sm1016579edt.32.2020.04.15.00.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:45:26 -0700 (PDT)
Subject: Re: [PATCH v7 12/48] nvme: add temperature threshold feature
To: Klaus Birkelund Jensen <its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-13-its@irrelevant.dk>
 <0ab46987-8026-c059-1470-6cac2e6cbcbb@redhat.com>
 <20200415072453.cs4urfwreedqlmbl@apples.localdomain>
 <20200415072810.2tszvrv3lo3ypue2@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3a1eda71-0f3b-3219-1a27-767be6cfdd61@redhat.com>
Date: Wed, 15 Apr 2020 09:45:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415072810.2tszvrv3lo3ypue2@apples.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 9:28 AM, Klaus Birkelund Jensen wrote:
> On Apr 15 09:24, Klaus Birkelund Jensen wrote:
>> On Apr 15 09:19, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 4/15/20 7:51 AM, Klaus Jensen wrote:
>>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>>
>>>> It might seem wierd to implement this feature for an emulated device,
>>>
>>> 'weird'
>>
>> Thanks, fixed :)
>>
>>>
>>>> but it is mandatory to support and the feature is useful for testing
>>>> asynchronous event request support, which will be added in a later
>>>> patch.
>>>
>>> Which patch? I can't find how you set the temperature in this series.
>>>
>>
>> The temperature cannot be changed, but the thresholds can with the Set
>> Features command (and that can then trigger AERs). That is added in
>> "nvme: add temperature threshold feature" and "nvme: add support for the
>> asynchronous event request command" respectively.
>>
>> There is a test in SPDK that does this.
>>
>=20
> Oh, I think I misunderstood you.
>=20
> No, setting the temperature was moved to the "nvme: add support for the
> get log page command" patch since that is the patch that actually uses
> it. This was on request by Maxim in an earlier review.

I was expecting to see a QMP command to modify the device temperature at=20
runtime.


