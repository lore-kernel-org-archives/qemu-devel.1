Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365ACC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EE221739
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMFnoQyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EE221739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9YT-0000RH-34
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iw9Xm-0008SD-Cw
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iw9Xj-00071J-KK
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:55:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34954
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iw9Xj-00070j-BT
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580151326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcd6kW7h4o7nQrXMnWPmR/miiN0RHIFwQ5s5lLKqHwc=;
 b=bMFnoQyNnirqAyz/1zQGZoJUXDLp/ifwJf3q9OHxxYhdgRo8s2gHSIUCO3Sz7abTJnkzyg
 vLNil6T9vv5hVm8jvoYUYjPbs1d4qyPqExZQdoI+oFULTXIKqgF3wgVdvG7LIXj65sIyfp
 cQqOJO7hRWWSpkDmpCmA66WIYWQOMgg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-SYXQnX0QMKGMne545LqQzg-1; Mon, 27 Jan 2020 13:55:22 -0500
Received: by mail-wr1-f70.google.com with SMTP id r2so6573479wrp.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 10:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t0/trFUOGUnbLAlW1Rzf50dZIp6Bw3FJETdQaqR6sIM=;
 b=EXz8pCUWPt2XaNsbZBBxwWk27DM53FbEXkWjuyXa6Cj6w3ICBrVg3yB0ajT62DHV7X
 PRNguapziN6W4nt+LF0NaS/KW/2irK2dNrWVCmplSwPW9tEs+cvJBvrgkVbKLi75BBwM
 JHNb7DMTv05MVy2Q1OgCNmb2X1cdh5krqj2/qX0VdNRggGnr+vevqw6gepPDEtrirWzh
 LuNNeAD34UAnI9pzZIhSz2ErK4uuY/lUoja7Zy9rjbeWysAocKhlBcSlmbfcoxt+pefC
 eJRJ00kJlnbdy5jnxM/T4Qx2ImoT8S8QGynjtZA3fxs1AVnAEBKL/8aezSDmvylor9X6
 9Bgw==
X-Gm-Message-State: APjAAAXBNapCaZuoGw3BqiqWOH4/egE1H4dPn3Q29LkTMUDzkx9E1Omb
 TJ4HdeTOtZgvDaooF9ZLVJL7GCgnzwWiiBPkGyp7gte9VzecLO6jRED7hhamY+aawj07YgN3au5
 oluSZLwj6CmoQZBw=
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr24611316wrs.179.1580151321004; 
 Mon, 27 Jan 2020 10:55:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqz3aI18CZaX7gO2jmZxJQGkhCzqiqgxWtuE57npzSb6qZHjteOXErAP28z9WALjsxjVpiM4vw==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr24611295wrs.179.1580151320765; 
 Mon, 27 Jan 2020 10:55:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id r15sm19761853wmh.21.2020.01.27.10.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2020 10:55:20 -0800 (PST)
Subject: Re: [qemu-web PATCH v2] Add "Security Process" information to the
 main website
To: Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-devel@nongnu.org
References: <20200123171150.12782-1-thuth@redhat.com>
 <b24abc8e-032c-c95f-89ae-c6480cee8b3c@redhat.com>
 <a0b6986c-3732-9326-e383-675596dc61aa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <def5fcf1-ed1e-96d0-fca1-79c2221605cf@redhat.com>
Date: Mon, 27 Jan 2020 19:55:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a0b6986c-3732-9326-e383-675596dc61aa@redhat.com>
Content-Language: en-US
X-MC-Unique: SYXQnX0QMKGMne545LqQzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 Stefan Hajnoczi <stefanha@redhat.com>, pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/01/20 11:00, Thomas Huth wrote:
> On 23/01/2020 20.43, Eric Blake wrote:
>> On 1/23/20 11:11 AM, Thomas Huth wrote:
>>> One reporter of a security issue recently complained that it might not
>>> be the best idea to store our "Security Process" in the Wiki. Well, whi=
le
>>> the page in the Wiki is protected (so that only some few people can edi=
t
>>> it), it is still possible that someone might find a bug in the Wiki
>>> software to alter the page contents...
>>> Anyway, it looks more trustworthy if we present the "Security Process"
>>> information in the static website instead. Thus this patch adds the
>>> information from the wiki to the Jekyll-based website now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> =C2=A0 v2: Improved some sentences as suggested by Paolo
>>>
>>
>>> +### Publication embargo
>>> +
>>> +As a security issue reported, that is not already publically disclosed
>>
>> publicly
>>
>>> +elsewhere, has an embargo date assigned and communicated to reporter.
>>> Embargo
>>
>> Reads awkwardly. I'd suggest:
>>
>> If a security issue is reported that is not already publicly disclosed,
>> an embargo date may be assigned and communicated to the reporter.
>=20
> Ok, thanks, I've added your suggestions and pushed the changes now to
> the website.
>=20
> To the people on CC: ... could someone please update the wiki page
> (https://wiki.qemu.org/SecurityProcess) to point to
> https://www.qemu.org/contribute/security-process/ instead? ... I don't
> have write access to that page, so I can not do that on my own.

Done, I will add a server-side redirect when I have some time.

Paolo


