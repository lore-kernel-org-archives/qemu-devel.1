Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A281C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B4A206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ybg2tS15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B4A206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK53D-0000Iu-3N
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 14:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK51x-0007ap-Ix
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK51w-0008Ei-Kb
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:57:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK51w-0008EV-GR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585853852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZuCZFAA5P7ZgsFQNAzT+49J4A+HTVWAqozIuaPXJAE=;
 b=Ybg2tS15nmT86Fit2sGv2GZNVin/Uw/E5lbuE8bvEC4yd2SovrIDlsQn/p5vEIepGcA/Ll
 nC3RbjqJwbFSp9MAXMuRqVH+PhLR5C/H+t2PY2eT3OvrRFCN/aNUtFFL+ahYVr8cFHb2FS
 h0ulb6qjrPCJ5QFdDB+9EjNAa60oHuU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-pa0nCQ41Mr-Iahd0QWHMCA-1; Thu, 02 Apr 2020 14:57:30 -0400
X-MC-Unique: pa0nCQ41Mr-Iahd0QWHMCA-1
Received: by mail-wr1-f71.google.com with SMTP id e10so1890270wrm.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 11:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cZuCZFAA5P7ZgsFQNAzT+49J4A+HTVWAqozIuaPXJAE=;
 b=Q5xpGBiQV2KdtQx1LxpBmV7m0EPOruLYhd/9rE3muYjsjvq8Fhod7ibaONCLs+3kvN
 Kyc1cZLzlc6CrapUeCQiX8k2giagBt2qRaQq4CJygwQnqrXJ3CAnY9/ZO+wTWBoO9Q4k
 eaKaontbrwTXm0ej1ESZq5F1wsuQumYTnWdVk2EuVezmzl8wVWBUg7wwsQNnc4XP7j3f
 IpifdgKkhihiF9kjKlgyfWzz39dDxUc7FcAXEtx642BDUzD+jPNykl/T/ytUvc1mUds5
 3uWGuSNcfr6UAx1wNAXJDEv0RzUbEGfD/gZjoMS7R9PrLS6AcJtvHEnZb0uzpIWTFvwC
 H4JQ==
X-Gm-Message-State: AGi0PuZT6bkLNVoTM0WVdIqq/bRC5azKWWznkfVr6f9JDZ8QvW92mbeE
 B078ihPgRbhLjmi8ypeQFvS+MFdnteRw9MtkacsCHMncW1NQfYSS5SZ/mSQEEeUqw0/5s2EJJpe
 5D3UTU7m7efJGhE8=
X-Received: by 2002:adf:e70f:: with SMTP id c15mr5190860wrm.217.1585853849314; 
 Thu, 02 Apr 2020 11:57:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJoctJEA1eXEgK+eRrmuSDiNvlcccklUfWS5c9TD73vexier0K/p875GHmhKxhu7omkRQosyw==
X-Received: by 2002:adf:e70f:: with SMTP id c15mr5190843wrm.217.1585853849099; 
 Thu, 02 Apr 2020 11:57:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1868:42dd:216c:2c09?
 ([2001:b07:6468:f312:1868:42dd:216c:2c09])
 by smtp.gmail.com with ESMTPSA id m8sm7943142wmc.28.2020.04.02.11.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 11:57:28 -0700 (PDT)
Subject: Re: Questionable aspects of QEMU Error's design
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <87o8sblgto.fsf@dusky.pond.sub.org>
 <CAFEAcA_b1gZ-B4NaEdQS2zffdvobW=FUx4ysEgXVAz+=cZ+R3Q@mail.gmail.com>
 <87sghmbfgc.fsf@dusky.pond.sub.org>
 <44b5ff2c-6dce-e516-a9cc-9d80354c5a72@virtuozzo.com>
 <CAFEAcA_cmOkR4YsDmP7mDdKzs0jTu3WDO=d1uvMxHguvZjGW_g@mail.gmail.com>
 <877dyy9shs.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1dda409-7065-5047-c474-18ff065259e6@redhat.com>
Date: Thu, 2 Apr 2020 20:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <877dyy9shs.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/04/20 10:55, Markus Armbruster wrote:
> 
> When you return non-null/null or true/false on success/error, neglecting
> to document that in a function contract can perhaps be tolerated; you're
> using the return type the common, obvious way.  But when you return 0/-1
> or 0/-errno, please spell it out.  I've seen too many "Operation not
> permitted" that were actually -1 mistaken for -EPERM.

Hopefully that would be avoided by the usage of Error itself.

Paolo

> Also too many
> functions that return -1 for some failures and -errno for others.


