Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13042C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F2220674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkDj7Ol+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F2220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDZ0-0005lX-1K
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ixDYB-0005AT-HV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ixDY9-000264-TG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:24:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45496
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ixDY9-00024v-O3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580405056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHNI6b90Cfq7eLwriuRYeEBHCEIObcSrg7pWukngDng=;
 b=GkDj7Ol+vKPZphmf9xpdNh7jQ6dD4Lll34YSMlp4FVQi1egfU9PicT2mSqCuq01+zbE/S8
 nNzIWAUxW+N8Bq3PQfKmbzuK3nMh3vB/MEn9a5VViuFVtfknm9dBYVV/nf3AWeg+QC/XhV
 95THvyOSvcdHDyKBlowog6l+9vjC8aM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-LMUkDR-qMB6nt4PKS9xpXQ-1; Thu, 30 Jan 2020 12:24:15 -0500
X-MC-Unique: LMUkDR-qMB6nt4PKS9xpXQ-1
Received: by mail-wr1-f70.google.com with SMTP id s13so2023594wru.7
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 09:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=e44ASm2/Vabdqe55waeZKNYo6ESc/BRrjH1de49Tihg=;
 b=PzxYBy23aXJ/7NyrHHY5IUUCIx9TWmHONjjaKqZrZGm0A6QXkNMAjGe03jd+sBFyho
 pr2DPEnmigmhOIa9cYCH5CDuTz2Q/Hj7mnLgfBdKeoOTdl6h5p5qH3evipItOgjKA2yH
 KzD2rOxoX8TbyqaxiTtgpVQTIruTGgwnFy1XGh+ldAVyGZurBngmLGC6CrLwuYhq1Alw
 oFQv674dVMVkb+1fLTcLcHu1GyIE+FYCp4B2rjeL7jIHHFWU72T+GN13vFQfyTZJmZXT
 ZbcgyaQjF434TmeVAWHyWAhDDiLenElra04GyR/pUDORnrcURi+hvkocL56I04lGokPx
 JV9w==
X-Gm-Message-State: APjAAAX4ja+8s+yImNpaYQKej/SB2njfAe3T3Yky6HgibZbQy6VOa+45
 Vm4Qc6j6NPu7eUY53q7JsIvcKX8y37zPkp1zl+N7j38hy4lvJrYYD//pT0CPJ6Xd3yv6ohlvZ6/
 YaCgPxY/Z8s0pQIQ=
X-Received: by 2002:adf:f850:: with SMTP id d16mr6562595wrq.161.1580405053816; 
 Thu, 30 Jan 2020 09:24:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqy4kvwd0gYGoqm+EmEKARVWULE+AKHcUZJ2GIy3Ep/yazNjNqrJbYUy5pZgX/x4xKzJbfQNhw==
X-Received: by 2002:adf:f850:: with SMTP id d16mr6562574wrq.161.1580405053530; 
 Thu, 30 Jan 2020 09:24:13 -0800 (PST)
Received: from [10.200.153.153] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id y131sm7563036wmc.13.2020.01.30.09.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 09:24:12 -0800 (PST)
Subject: Re: [PATCH v8 13/21] main: keep rcu_atfork callback enabled for qtest
To: Stefan Hajnoczi <stefanha@redhat.com>, "Bulekov, Alexander" <alxndr@bu.edu>
References: <20200129053357.27454-1-alxndr@bu.edu>
 <20200129053357.27454-14-alxndr@bu.edu>
 <20200130144224.GC180311@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4bc49889-081e-6016-b8d5-a5d1fd615830@redhat.com>
Date: Thu, 30 Jan 2020 18:24:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200130144224.GC180311@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HXEpzlQjqR8hxRgpZjtgchmFWCmzQykSo"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HXEpzlQjqR8hxRgpZjtgchmFWCmzQykSo
Content-Type: multipart/mixed; boundary="BecBHoReZ0SAyHCQ6kJC1SjAK9nKapn8o"

--BecBHoReZ0SAyHCQ6kJC1SjAK9nKapn8o
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30/01/20 15:42, Stefan Hajnoczi wrote:
>> +
>> +    /*
>> +     * If QTest is enabled, keep the rcu_atfork enabled, since system p=
rocesses
>> +     * may be forked testing purposes (e.g. fork-server based fuzzing)
>> +     */
>> +    if (!qtest_enabled()) {
>> +        rcu_disable_atfork();
>> +    }
> I haven't reviewed the details of whether resources are leaked across
> fork but in general it makes sense that we want an RCU thread in the
> fork child:

Note that there is a possible deadlock between fork and synchronize_rcu
(see commit 73c6e40, "rcu: completely disable pthread_atfork callbacks
as soon as possible", 2016-01-27):

- the CPU thread is inside a RCU critical section and wants to take the
BQL in order to do MMIO

- the I/O thread, which is owning the BQL, forks and calls
rcu_init_lock, which tries to take the rcu_sync_lock

- the call_rcu thread has taken rcu_sync_lock in synchronize_rcu, but
synchronize_rcu needs the CPU thread to end the critical section before
returning.

Therefore it would be best if the fork server could fork before a single
CPU instruction is executed, and then rcu_disable_atfork could be moved
right after the fork server is started (just like right now we do it
right after os_daemonize).  We probably talked about this before, but
how do you ensure that the fork server is started before threads are
created (apart from the RCU thread)?

Paolo


--BecBHoReZ0SAyHCQ6kJC1SjAK9nKapn8o--

--HXEpzlQjqR8hxRgpZjtgchmFWCmzQykSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl4zETsACgkQv/vSX3jH
roMylwf/bzJorKjagrArYgCWuralalImcbl22Rr2LRIxqYwvbRVd4VdPfsGHWQ7Q
VRoVcKazcgjlxPGe5U3cTpPVleK2FbfBsDBJMAXhdhc2WxYtvOZgMCA+0pEOpMI7
HBZV1wQUmUKDH07yAi9gFIYGEF/cKuoigNtrpnf9EE7ILrUvMsaFIQRtwSdDtjOc
+tadtdkgKgLiStgiM9gdVxyLA1Gu0qS7ydECo/cx5Ehs5r8PXeAyT474M9KJTOKw
GerRXts1LqEpjWya+UPEIMh0iKbJtwpyfSOcA1vS3Jqz9Ys+xJwuXTBMigkjkxcq
Jy7HlAJuSwp3Lv4SWOG4U86+HjcTvg==
=7Gge
-----END PGP SIGNATURE-----

--HXEpzlQjqR8hxRgpZjtgchmFWCmzQykSo--


