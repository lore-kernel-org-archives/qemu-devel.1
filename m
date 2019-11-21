Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61463C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8C920637
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKKQh6oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8C920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoxb-0008VZ-9s
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iXowX-0007q4-Pg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iXowU-0005Qh-TU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:04:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iXowU-0005Pk-Py
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574352266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=FJI6C+iP+wxBaM9PqMfAFE2UmIl4eN944YRM1yl+Luk=;
 b=TKKQh6oQnyXoxdnRFvkfM6+17ISu+yyyirCgAA8vgYibZECIzzkm0kmjwB54X7jaxvBUg7
 UpkrmwvNDEsdw9wALbRYdG0YI2MPT04aTwv9JDjH6a9tRpJ5svOxbMyJPqL98dBxuXkRV9
 2Yi5uFxeAjIcvT/r54dED/+4jA99Zgo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-FwT_nnl7M2yEQgzzY0o0Vw-1; Thu, 21 Nov 2019 11:04:24 -0500
Received: by mail-wm1-f70.google.com with SMTP id p19so801756wma.8
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 08:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mBbdnq7qr6LKZhQ4DlNn8YxYEpTat4deNAbVcr9qYRE=;
 b=QFp3Q6wYHA6iV9n+O5N3O3Xquk6UT/+SCNVgLazS+uRP0dzk9teXj3ohXqTipHpM5m
 XfFtM8vqabbDHJGokdS25QNsA9SS56nz/Kme5InTpdOIVJAr97BfgUPBcJqj2eG7GLa4
 zSCweBnr9PcZu354wC4shPqHdwVYKP3MT/jVxXV/ch680stN5kp+VrLL5e7dus0FUN95
 LCfi7yFXRxO/CKlRq7RjQ8M5UdEq1tJ/vTjO099o6jAZCuqh7GoiqG+4KsA/kZYU4IWD
 rYgQZULCTOjLwO00kJx5WugEXRHYj7Buayhz1K6BThSzGCRNTL0coxIOC9i7UV9m8/VJ
 2x5g==
X-Gm-Message-State: APjAAAUm5SZ3QrWcAvh5A2W4Uv4HRNx8RGML9l2iXhvsNmMvwzCgLpEu
 Rv+BBcR0kZRl/C9HM2MRHngq5GNSg6t83p6NOMSB7aR3CckgBcsmruuEImRvAXO+7bYUukbUz8O
 8e3TT1GV2ENZ+XcY=
X-Received: by 2002:adf:e942:: with SMTP id m2mr12350354wrn.26.1574352263349; 
 Thu, 21 Nov 2019 08:04:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpQw1MiXdrNC4qJybDfGJ11apgrT9g64t1D5M0zCkZFoO3Mh++PrcjCJaKKpeS1rGjLGS7tw==
X-Received: by 2002:adf:e942:: with SMTP id m2mr12350323wrn.26.1574352263064; 
 Thu, 21 Nov 2019 08:04:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:71a5:6e:f854:d744?
 ([2001:b07:6468:f312:71a5:6e:f854:d744])
 by smtp.gmail.com with ESMTPSA id z8sm3866508wrp.49.2019.11.21.08.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 08:04:22 -0800 (PST)
Subject: Re: [qemu-web PATCH] Add a blog post about the QEMU-related
 presentation of KVM Forum 2019
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
References: <20191121115207.5832-1-thuth@redhat.com>
 <d25b1eb9-343d-f8bf-f090-4e8d77ad8383@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2cc0abb3-095e-8c40-3056-4c7265492a0a@redhat.com>
Date: Thu, 21 Nov 2019 17:04:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d25b1eb9-343d-f8bf-f090-4e8d77ad8383@redhat.com>
Content-Language: en-US
X-MC-Unique: FwT_nnl7M2yEQgzzY0o0Vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/19 14:59, Eric Blake wrote:
> On 11/21/19 5:52 AM, Thomas Huth wrote:
>> There have been quite a lot of QEMU-related talks at KVM Forum this
>> year - let's provide a summary for the people who could not attend.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 Note: For some talks it's hard to decide whether they really fit =
the
>> =C2=A0 QEMU blog or not. I've assembled the list below by quickly skimmi=
ng
>> =C2=A0 through the schedule and the videos, and that's what I came up wi=
th ...
>> =C2=A0 If you think any of the other talks should be mentioned here, too=
,
>> =C2=A0 please let me know.
>=20
> Perhaps:
>=20
> [Making the Most of NBD](https://www.youtube.com/watch?v=3DPMa6KFX9AxM) b=
y
> Eric Blake and Richard Jones
>=20
> which mentions optimizations to 'qemu-img convert' made possible through
> NBD protocol extensions

Agreed.  Also I would remove the RISC-V talk, as I was going to write a
blog post about it too.

Paolo


