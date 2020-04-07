Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914DC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8260E206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxa2BZCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8260E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkQn-0001kY-OJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jLkPX-0000oY-F8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jLkPW-0007SY-05
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:20:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jLkPV-0007S6-RW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QwZ3XtVQFs0Y3EpBnjZpiqX1UIQXYnuxajk5p5dqo9I=;
 b=bxa2BZCo9+pFWYIRMUXbjpEvS708fTxFlvmW5TXZ1ZtQv7HB9SI4uondFgb64W5Stz0DLm
 U4iKTjR95+v82alo6Qzno1msg1Fe95wUzckbDYNoek6q+XCXbK6VTO1mmvW4GHaCjjlPhq
 eb7sM3Fz2W01gsexATf9IOYr+7rAN5c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-vBc5tHIINLqFYof-J2rmZA-1; Tue, 07 Apr 2020 05:20:41 -0400
X-MC-Unique: vBc5tHIINLqFYof-J2rmZA-1
Received: by mail-wm1-f69.google.com with SMTP id y1so346440wmj.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 02:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=JiJ6Re47sciZMMJtOm3Knv3ylEO0SgvvUA0xSLo8A1w=;
 b=e1XNo65LuODJ9fEHMQtFyokaSla/oFQQluFZNIMv8WOsRRHmkcJda2ZDRte7vixULy
 UMMzCUGzDpz0cLlFGn5kC1KY1usw3mGPjpA36U5XxFvuIH7fI/U+tC+H+h+Eh2mIAsB7
 ZV7KCeiWe3AMCOKjfFzIz8G3Y40oTSalPmQJK2Uk0nVXF2OzPzXVwbGNlgkNtJ2fDI73
 gsNKczWF81ybXTrcabahYSdj+Kfqw8YtDpflIlMb+SQxpoKLbs/Nb8ABubltMOQZ8Dvj
 +I3Hp5uU91kvNJ+3DN0GTBVXU7UPIkZZV+wD9Y0twRduDbDx0UYnNSCFVE+baXhaVXMM
 4xFQ==
X-Gm-Message-State: AGi0PuYbXuktbMibB4fo2atgjlffo5K+vDYE9gGiIXDdpafg1BITo0yF
 uXg/FhU8vWtM9qlVCWaRy9XUTneYIJju2v7N/o+h72NOZMA8NyGnRzD0VV9Rk+8dpVP0HjxQ5eE
 BSwDPSbLuQKa1Z9M=
X-Received: by 2002:adf:a54a:: with SMTP id j10mr1587797wrb.233.1586251240656; 
 Tue, 07 Apr 2020 02:20:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLfzMFMQTKqBTmSWg49KUt1bLfLbefPvQmzuHpYGOsYHz3Jjv2c/mSRTOlwS2lAYUbCO6qKmg==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr1587779wrb.233.1586251240428; 
 Tue, 07 Apr 2020 02:20:40 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
 by smtp.gmail.com with ESMTPSA id a12sm1468550wmj.22.2020.04.07.02.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 02:20:39 -0700 (PDT)
Subject: Re: [PATCH 4/4] async: use explicit memory barriers and relaxed
 accesses
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20200406191320.13371-1-pbonzini@redhat.com>
 <20200406191320.13371-5-pbonzini@redhat.com>
 <20200407090954.GC247777@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f157bf5b-10e0-7cee-795b-330e1d390cd2@redhat.com>
Date: Tue, 7 Apr 2020 11:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407090954.GC247777@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VrQmAza1ROJipQmlZH8oYa5Y7OhE1CFlC"
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VrQmAza1ROJipQmlZH8oYa5Y7OhE1CFlC
Content-Type: multipart/mixed; boundary="J4zmRLqEhKMrLE2LyHJYgCsmEYB5LMf5x"

--J4zmRLqEhKMrLE2LyHJYgCsmEYB5LMf5x
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/04/20 11:09, Stefan Hajnoczi wrote:
>>      if (blocking) {
>> -        atomic_add(&ctx->notify_me, 2);
>> +        atomic_set(&ctx->notify_me, atomic_read(&ctx->notify_me) + 2);
> Non-atomic "atomic" code looks suspicious and warrants a comment
> mentioning that this is only executed from one thread.  This applies to
> the other instances in this patch too.

Yes, that's the patch that is missing from this series, which
strengthens the assertion to ensure that we're in the home thread.

Paolo


--J4zmRLqEhKMrLE2LyHJYgCsmEYB5LMf5x--

--VrQmAza1ROJipQmlZH8oYa5Y7OhE1CFlC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl6MRWUACgkQv/vSX3jH
roOaigf/egk/ci7gvCbCTbToDMV5mmqXFxolvaO58eA2FIt4QV++vpp0Re+HI7tF
Ti0Gy0rkIqtDnVYlTG4nbGenJVT1ilAW2xdeejf4rXw1/43qPAkzXl64y99VxWa7
sUw/AO3hR4PR4qAUSoMHenIwaMIQlh3jD5Fe8dH+n/u+OF4Q1qOaV3+CnhIIQqGX
dXErv+Y54MFU2l3jpggGZowfcMtQMFITRTG3ceo3kirePkBlpfyadU1ooxzBegmr
Y4TeSx1k/qWfz8x5TZRi8PbiBLBvIHrpOowJ9bX7LIlRS0/4o/l2KDowk3KOIONT
SyUpkaHC5WWPjvkVhEy1B4PkvlSKWw==
=U75V
-----END PGP SIGNATURE-----

--VrQmAza1ROJipQmlZH8oYa5Y7OhE1CFlC--


