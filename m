Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE83C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A6820665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 15:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYg3Xflq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A6820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyp7-0007ae-7h
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 10:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iZynY-00064j-LN
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iZynX-0005Xx-A8
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:00:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22780
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iZynX-0005Xa-6Q
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 10:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574866806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyzngowKxrGjldfNuQv5yRqGYrFPLOX8tjzaN5YB/C4=;
 b=RYg3XflqSNcqiK2X5AuwJhmZ+v5g6GlYFVAvUgEZE5jN2b2Wgnzn9EVaW46t5cx42+70mT
 wOE52YLAXJxZBrsI8pycUB3DMPRnvwVUxpac0TcqD+RsrV0RfJwgqnVkqFj8DMVEaNSVbU
 rRMc6ltlS7COk4gQrjSipalXEtJIons=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-AF_G9UuiPEiPOYEWJUyv4g-1; Wed, 27 Nov 2019 10:00:04 -0500
Received: by mail-wm1-f70.google.com with SMTP id f21so2499248wmh.5
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 07:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GiHOdfclgvjov3z0ZNoe2YTzn50vuzE56Nb2oYxMn30=;
 b=oMVTqTAd8wFF+nR1HJRua8GYmdOUzc4/sFlhpHDr7WSQ5QbFavX9SrlMeD3vqP3y9D
 AsvRe57lBcv6SR5jMMGkR9EtalDDFVXjyjU434YfSvd3cDegLs7Qjg9m2TwF5DevdYwl
 Y50FMx+SmP8Pmlx3G19AMIwTXY0btBxhv6lP9uDmlcPadsfgDmJtjx1oItBr0Ofsd7ib
 BePJYQ/lje2jESc0bpKnJsOKjiMk+0mr+VsoZUBtRrkqCJKxlbt7O/ybN9dWGoEJHAZq
 2NtqQ3BBkpffJxkDZYseTqlT5GK/3U7LVEvZkdxETLzN2PnC5/9DyyErYwDDSkLDCgmF
 UQCg==
X-Gm-Message-State: APjAAAWp6PVNVdQmYaXb58pP9fijc32LzpjLlhdP7bbP5H9zWDSMkjty
 yO4P1Ka7b7GFo0MwO+XkXZRjeZw0aO9be7HaeRNJQ+2o3jETkPmA/pfwH4thRlRxEXq4RuSQUaT
 iD4IEmEvfBj3qJYs=
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr41828976wrw.383.1574866803441; 
 Wed, 27 Nov 2019 07:00:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyg7D1ODP/zqesJW8iJfMbJptS1J0rtjtNym72upROmBMegwbGrB2AUrvQanz+/9iDj3Z+sTA==
X-Received: by 2002:a5d:6ac9:: with SMTP id u9mr41828962wrw.383.1574866803238; 
 Wed, 27 Nov 2019 07:00:03 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id y8sm6758216wmi.9.2019.11.27.07.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 07:00:02 -0800 (PST)
Subject: Re: [RFC 00/10] R300 QEMU device V2
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Aaron Dominick <aaron.zakhrov@gmail.com>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126141924.GQ556568@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <09273ecd-be76-ab61-304f-7ea0f1f0b107@redhat.com>
Date: Wed, 27 Nov 2019 16:00:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191126141924.GQ556568@redhat.com>
Content-Language: en-US
X-MC-Unique: AF_G9UuiPEiPOYEWJUyv4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel, Aaron.

On 11/26/19 3:19 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Nov 26, 2019 at 06:14:27PM +0530, aaron.zakhrov@gmail.com wrote:
>> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>>
>> I have removed the botched patches and have got the code working upto th=
e GART initialization.
>> I am not sure how to implement the GART. I am guessing it should be an I=
OMMU device but I think that is a bit much for an emulated card.
>> The earlier problem of display probing seems to be resolved by using an =
R300 bios I got from TechPowerUP's GPU database:
>>
>> =09https://www.techpowerup.com/vgabios/14509/14509
>> I am NOT sure if we can distribute it in the QEMU source tree. If it
>> does cause problems I can send a patch to remove it.
>=20
> That site seems to be a repository of BIOS uploaded by arbitrary users,
> with no information on what license terms might apply to the uploads.
>=20
> We have to therefore assume the worst and treat the BIOS images on that
> site as proprietary and not re-distributable, despite the fact that the
> site itself is acting as a 3rd party distributor.

We can not redistribute this BIOS.

> IOW, we can't have this in QEMU git I'm afraid, unless someone can find
> a trustworthy vendor source for the original image with accompanying
> license information.

Daniel, I think there is no problem if Aaron contributes a model of the=20
R300 device to QEMU, right? This doesn't involve redistributing any BIOS.


Aaron: I never received patches 1-4 and 10 of your series, not sure why,=20
maybe they are too big.

I recommend to rebase your series, squashing patch 9 over patch 5.

If you don't know about git-rebase, this blog is quite easy to understand:
https://thoughtbot.com/blog/git-interactive-rebase-squash-amend-rewriting-h=
istory

Regards,

Phil.


