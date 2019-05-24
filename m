Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C716DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A27C920673
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27C920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58523 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUEzm-0005Sp-Qn
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:32:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUExg-0004VS-MT
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hUEni-0006dj-CS
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:20:22 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hUEnb-0006bU-Uk
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:20:12 -0400
Received: by mail-wr1-f48.google.com with SMTP id d18so10917945wrs.5
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 11:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Dn3/qwSfxbWLAs6qAs2Cw68jIcfGOwRniAfC44iCdYc=;
	b=A7PAtfbZlEND7rW+bMjGzYc7hEF60WB69Txf1DAEKFjmS9P5jihusC+9qreRuyEuej
	lLiRJFYJaFg4u07tVQ1X3TMP1mf8KAff1g0zlPLPuPAQ+8rSXQg0vcVOwf17TBjsCuRv
	khQswI6bQkcwLqtTEYZHzW9rXhYCTemt+bh2L2cbkQZvXoYe01MnmZ4SkEoLFBdqy4Lv
	8F91FHi3jSy0CRyWv/Vy9uaYJ2y49cChwTZK7CmCAVpTA66O1Dn58yCxI/9B9qKNmNuE
	2dpvYDWZ0RHHVYZyOIQqAmzh2wsUxlxvqNMCYuD6oPYFWqM+9/Kp3I2AFrrLDIsqX+tj
	jyrA==
X-Gm-Message-State: APjAAAXGtBQDzhnmvZoeiGklYKp1sfLfAsUroSShjHX64qSVFLjE+hBh
	lxOT/d1KIoDEWxohGliL+a1cKg==
X-Google-Smtp-Source: APXvYqx1R0TDumj61uJeJAr7NdXbQdv51i5iAQqbISxIVa7BsO8r2H/ZJEN65tQAbWRTl87Pz4A+bA==
X-Received: by 2002:adf:9022:: with SMTP id h31mr9048367wrh.46.1558722009868; 
	Fri, 24 May 2019 11:20:09 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id x2sm3736787wrs.39.2019.05.24.11.20.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 11:20:09 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Markus Armbruster <armbru@redhat.com>
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <863feca5-192e-ae14-7a57-8d839b54e603@redhat.com>
Date: Fri, 24 May 2019 20:20:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.48
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 8:04 PM, David Hildenbrand wrote:
> On 24.05.19 19:54, Philippe Mathieu-Daudé wrote:
>> Hi Christian,
>>
>> I'm having hard time to understand why the S390_IPL object calls
>> qemu_register_reset(qdev_reset_all_fn) in its realize() method, while
>> being QOM'ified (it has a reset method).
>>
>> It doesn't seem to have a qdev children added explicitly to it.
>> I see it is used as a singleton, what else am I missing?
>>
>> Thanks,
>>
>> Phil.
>>
> 
> Looks like I added it back then (~4 years ago) when converting it into a
> TYPE_DEVICE.
> 
> I could imagine that - back then - this was needed because only
> TYPE_SYS_BUS_DEVICE would recursively get reset.

Thanks for the quick response :)

> Did you try removing it, to see if anything breaks?

From build POV it is OK, but I have now idea of the effects with KVM.

I don't know how to test on s390x systems, but luckily Patchew/s390x is
back up so I'll try my luck with a RFC patch, but I'm not sure the
default tests cover this specific device uses.

Regards,

Phil.

