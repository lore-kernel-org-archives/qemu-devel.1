Return-Path: <SRS0=wjfX=SQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40487C10F13
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 11:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DCB2148E
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2019 11:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DCB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFdCY-0002Qb-65
	for qemu-devel@archiver.kernel.org; Sun, 14 Apr 2019 07:21:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hFdBk-0001tD-GG
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 07:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hFdBj-0006fN-KF
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 07:20:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1hFdBj-0006dW-7s
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 07:20:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so17932615wrn.6
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 04:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=FNtXuBfO45FgsTJgAwqzdSB6ghxBH7iWSSaS8qseFMM=;
	b=tMRu9wOWz3IeNXNWvEjooo1nfWqt18kzJNYysAL6UzKdgVYB1X8dZSYiie0v4BSl7M
	S/uCjwzfyaueaeYDQOldZ3mQdx1vOCaCBTB7H+X9fGuEFtaR5Wf9h8Hpyc+IQws5a/ew
	FeMAAGZhPI1ez9La2oQVIQHPtlBVDwiOPO6kjJaqw+toSJVt3ZXA6yVcgBPC/khcx+D+
	yLJCmyqqtBlkLJbbAHH3YI2EKEnXBFGTOSzdsksUaKIYhQ6Vq107Iezb1jGn00yjAHZc
	ckYlccRfgqRmOWX2RDAMirQwTvs1FQ6rFlY8Kp8epgA6BF9X7oI8+roHPOSXXVllOVAq
	l2Hg==
X-Gm-Message-State: APjAAAV5Z90zMygTbbmWKM0KIDAh8aODALMltr/lGdnIuKVUuLtCCTwP
	kKtZwmCkq58rUAnyOGjtJiLZ6A==
X-Google-Smtp-Source: APXvYqx9T6FUMYnJkCS0ds9se+HoueMi/j90+KlbyyKT0rjvsRzcnYs+eeAX2xvzw2lioTrz6IBN0w==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr43899095wrm.52.1555240838902; 
	Sun, 14 Apr 2019 04:20:38 -0700 (PDT)
Received: from [192.168.2.101] ([5.29.212.195])
	by smtp.gmail.com with ESMTPSA id
	x5sm51427351wrt.72.2019.04.14.04.20.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 14 Apr 2019 04:20:38 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
	<1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
	<CAJSP0QWYS+UHmXyvhtLcLW9iumfi29Fa7AJdGPC9OwagwekWmg@mail.gmail.com>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <f5f1fafe-4eda-03bd-ba1f-38c08cb381a3@redhat.com>
Date: Sun, 14 Apr 2019 14:20:36 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWYS+UHmXyvhtLcLW9iumfi29Fa7AJdGPC9OwagwekWmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Amnon Ilan <ailan@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190414112036.ESb2pTVlzvQq4Ua03ir78ID8T7hEvuszOnp5aAhAT8A@z>


On 4/10/19 10:25 PM, Stefan Hajnoczi wrote:
> On Wed, Apr 10, 2019 at 4:45 PM Yoni Bettan <ybettan@redhat.com> wrote:
>> On 4/9/19 4:17 PM, Stefan Hajnoczi wrote:
>>> On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
>>> There are multiple problems with the code, but the larger issue is that
>>> this example device is just helping people shoot themselves in the foot
>>> more easily.
>>
>> If you can point me to those problem I will be glad so I can update the
>> code and understand those problems you are talking about.
> Please see Eduardo's reply.  I didn't review much since he already
> pointed out many things.
>
> One thing he didn't mention:
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>
> The return value can be NULL.  Spurious notifications could happen so
> the code shouldn't crash when this returns NULL.
>
> I apologize for the critical replies.  What you're doing is valuable.
> I think explaining the VIRTIO device model and the order in which
> things are done will lead to higher quality devices so I'm making a
> lot of noise about it :).


It is OK, I will write some basic specification for the device and start 
iterating spec-device-driver according to Rustie's paper, Eduardo's 
review, and you advice.


Thanks.

>
> Stefan

