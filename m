Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E02C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:24:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E273A2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCWCyLOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E273A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iChzn-0005sn-Sz
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 06:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iChz0-0005Mp-JN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iChyz-0001Bz-39
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:23:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52853
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iChyy-0001Ba-VL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 06:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569320624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=R7ol/z2w+vm5rvzrq5seV1GscsyVu4Y4Kf+mkC8ppnY=;
 b=GCWCyLOmc3g1YUZ/q6bkPJVuVjPs2G9OzHU027ETq/eZn2RzPNWPAIdQKq+tWvtQSlk7Ca
 hcdNs7gGrDHOrW4kSn6t+x2aPpTfsWynbJUAh3/KxxLireCn0K9K7UIGDH5aEdtLd+5H46
 Z2tnU1Xu1E35BjYG877SgV+SryD+XqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-lgZXlWKJO8yGI3zSiRC3mQ-1; Tue, 24 Sep 2019 06:22:52 -0400
Received: by mail-wr1-f72.google.com with SMTP id 32so392059wrk.15
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 03:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YSCqOSrtGEj63fr3mYXvG4RRrvvc1YF8PGpvmCc9DXE=;
 b=X9jIj8uA882+pBmJCsLpPKn+Bbbp61kxcba+dxbCiGTK6xphTClpGUF54W2EA6xgpI
 JhIpRpRI/zF9ABwpGBS1WRuHdWZIhqUn3V8cX75Lj7+MStHzK+Aue4TRJwTQBZXB30HD
 ntwDEX4b+3/oupajipEEeu2h8dY2gyN7SmMGXQBbBS2P8jwxrRCykKPiAhFi8HMXPzUc
 wKi/XgH8IHIcL6N507Ku4W74BpZs+oaMDMDUuUdz6cmeyeC0gA5OcCxiUPxAUGUxHRN6
 bVCvZFg5q7ZlxbY1F7VyPcOaoXv6jfKf35jfF5jwH42HUJHfDsEjmqGy0DSyWRJFaOeK
 Ryig==
X-Gm-Message-State: APjAAAUqC3rAO9pZAHviH20YsyQiOavPHmDJofPxS6Ar/JcS1BdT1f80
 iyU5bkSkGJ98VsGYAmwojmMdaj15u1mMKzViKI48QhGpJajRsYl/ElYpPmAmuvWZj9GsTXorsGR
 0fhgUJAhNL4NJt3M=
X-Received: by 2002:adf:de08:: with SMTP id b8mr1666037wrm.200.1569320571275; 
 Tue, 24 Sep 2019 03:22:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqynjyHOlbJQmkiPD+r270j+sVW/jKuAXLIwAtnswa8GHO5fuPgF4ivFL65TmlfiUDrF0yAO0A==
X-Received: by 2002:adf:de08:: with SMTP id b8mr1666020wrm.200.1569320571034; 
 Tue, 24 Sep 2019 03:22:51 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id 33sm3119680wra.41.2019.09.24.03.22.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 03:22:50 -0700 (PDT)
Subject: Re: [PATCH 0/4] xics: Eliminate unnecessary class
To: Greg Kurz <groug@kaod.org>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <c2efe040-a9f4-8d7f-f1b4-c8ef162c4560@redhat.com>
 <20190924120647.13600e6b@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <900a5a29-d247-fe96-427c-8b220d87567c@redhat.com>
Date: Tue, 24 Sep 2019 12:22:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924120647.13600e6b@bahia.lan>
Content-Language: en-US
X-MC-Unique: lgZXlWKJO8yGI3zSiRC3mQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-devel@nongnu.org, gkurz@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/19 12:06 PM, Greg Kurz wrote:
> On Tue, 24 Sep 2019 11:47:51 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 9/24/19 6:59 AM, David Gibson wrote:
>>> The XICS interrupt controller device used to have separate subtypes
>>> for the KVM and non-KVM variant of the device.  That was a bad idea,
>>> because it leaked information that should be entirely host-side
>>> implementation specific to the kinda-sorta guest visible QOM class
>>> names.
>>>
>>> We eliminated the KVM specific class some time ago, but it's left
>>> behind a distinction between the TYPE_ICS_BASE abstract class and
>>> TYPE_ICS_SIMPLE subtype which no longer serves any purpose.
>>>
>>> This series collapses the two types back into one.
>>>
>>> David Gibson (4):
>>>   xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
>>>   xics: Merge reset and realize hooks
>>>   xics: Rename misleading ics_simple_*() functions
>>>   xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
>>
>> Please remove the qemu_register_reset() call in hw/intc/xics.c,
>=20
> No. This is needed because the XICS devices don't sit in a bus and
> dc->reset doesn't get called by anyone.

Oh right, now I remember a previous discussion.
Please add a comment about this before the qemu_register_reset() call!

>> then for the series:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by stands :)


