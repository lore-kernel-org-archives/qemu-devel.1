Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45DAC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32519206D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lxr3P4bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32519206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUve8-0003Vq-Fn
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 11:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUvck-0002Ed-2u
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUvci-0004IW-R3
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUvci-0004IO-NX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 11:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573662964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpU+T4qTzqt3if6DmyaPMbq6ZmoJIClv6sQNilHAx8c=;
 b=Lxr3P4bqLbPEyhhmjVQhbYhtlw5MNr9Y8UqkNSSbe//mRrfcL4FIUW2ekH3KSkE7iOQigG
 zUHIMynzYbXgxxheFuUuR7je7Qzgo1YMfTUUCSeizSLGl1TNkTl7KzGC9Y27XPEb5DWSs+
 up1Q18a1hax3nA0fms//iQW7FXDXXfU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-HyhW1OOHMr-eSodQPWayGA-1; Wed, 13 Nov 2019 11:36:02 -0500
Received: by mail-wr1-f72.google.com with SMTP id p4so1871151wrw.15
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 08:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=twTzFGr5vasz6AFOcNkEKt4SEwD6IFMW9o8bKOxiDkk=;
 b=cShkFTlS50m0Yw5yz6Zvl1kMQ23wUF9MxSwi0215ui+5YTN4Cob9AQV24oJ9roIWVy
 W9O5H9I+FD73bF1kk778ZmqLMnorrt+3LrYt/Kf9Es/mF1UHs5bTtP6XbZGsBq9T0vLK
 EDRRRky4dvlBT8hNs/ytMBS1jjcz0yKpzADMrOKpvuwOG8UjXtaZyYzi29/njW0JT1C6
 U/5/TzE3get9ddDmhHUuqF+k/jra+NokDxIKm9e1a3ScRuOVZ2cN6yz1YCT8mMJvUNLR
 pDRQ3PZGUVCOnYdQE+x1RUs5eeaED5lfWIRm4EV2LQ+E1oVmITqc3EplQNxH+p/tp774
 t7Dw==
X-Gm-Message-State: APjAAAUgnNuVnnQ17td6Wz5zrp2ePqviFZgkCS0BqTcvfVUdOsVG7Xts
 pKhztuJYL3QdzWdrZ0cKIvFc7hf2o/mMCgK+8/a0jIilpJ81STUDCCYw0c4R5mNPdU/p/UQ3stK
 hhwwGzmeNqeAXOVc=
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr3658020wro.270.1573662961690; 
 Wed, 13 Nov 2019 08:36:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzUgKXjnZvwt1mJuNlNXQ3dZYZCXKgKph4OOHE71k8kGtrqkCunUpfZMg2DXZAQxUXl1Nr7Q==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr3658005wro.270.1573662961510; 
 Wed, 13 Nov 2019 08:36:01 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id d13sm3182509wrq.51.2019.11.13.08.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2019 08:36:00 -0800 (PST)
Subject: Re: [PATCH] WHPX: refactor load library
To: Eduardo Habkost <ehabkost@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <MW2PR2101MB1116386CFE4628B6767D6CDBC07B0@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <MW2PR2101MB1116C3DF422DB5E301B74AEEC0770@MW2PR2101MB1116.namprd21.prod.outlook.com>
 <20191112194738.GF3812@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <017bdcd1-4058-c717-619a-d8362ac089b7@redhat.com>
Date: Wed, 13 Nov 2019 17:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112194738.GF3812@habkost.net>
Content-Language: en-US
X-MC-Unique: HyhW1OOHMr-eSodQPWayGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Justin Terry \(VM\)" <juterry@microsoft.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 8:47 PM, Eduardo Habkost wrote:
> On Tue, Nov 12, 2019 at 06:42:00PM +0000, Sunil Muthuswamy wrote:
>>
>>
>>> -----Original Message-----
>>> From: Sunil Muthuswamy
>>> Sent: Friday, November 8, 2019 12:32 PM
>>> To: 'Paolo Bonzini' <pbonzini@redhat.com>; 'Richard Henderson' <rth@twi=
ddle.net>; 'Eduardo Habkost' <ehabkost@redhat.com>; 'Stefan
>>> Weil' <sw@weilnetz.de>
>>> Cc: 'qemu-devel@nongnu.org' <qemu-devel@nongnu.org>; Justin Terry (VM) =
<juterry@microsoft.com>
>>> Subject: [PATCH] WHPX: refactor load library
>>>
>>> This refactors the load library of WHV libraries to make it more
>>> modular. It makes a helper routine that can be called on demand.
>>> This allows future expansion of load library/functions to support
>>> functionality that is depenedent on some feature being available.
>>>
>>> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
>>> ---
>>
>> Can I possibly get some eyes on this?
>=20
> I'd be glad to queue the patch if we get a Reviewed-by line from
> somebody who understands Windows and WHPX.  Maybe Justin?

Can we wait for approval from the Microsoft legal department first?
So we can start testing WHPX builds, and reduce the possibilities to=20
introduce regressions.

Testing is ready, we are waiting for Microsoft to merge, see:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg646351.html

>=20
> Sunil, Justin, would you like to be listed as maintainers or
> designated reviewers for the WHPX code in QEMU?

Great idea!


