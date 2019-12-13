Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6437DC00454
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E395F21655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvgbQLxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E395F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifmOW-0003TW-Mp
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifmN8-0002Kf-FC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:56:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifmN7-0004bF-Gh
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:56:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24977
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifmN7-0004aZ-Cf
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576249009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/LSdJyy6a3b5Pg94An83/eaSwEheiE6HMiBnXzxWYc=;
 b=bvgbQLxm6FcD51akYaTM1DVI8Ak2PfKVmRBxfbYKeSDKFkkyrR3bIf0K0UJjJMRGm2idw3
 umJ966hqVHWK4gCsVdju7dFubEYn64lbNyHVo/OGkCRMDR5wXxxsOeM9Fw43C5lfhl1A4I
 4AFAEA0GY4IBF1QjF0x5jxRpLkVKPw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-vmKo2FDhMbWJ8WZo7HetKQ-1; Fri, 13 Dec 2019 09:56:47 -0500
Received: by mail-wm1-f70.google.com with SMTP id p5so1859908wmc.4
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fnhQz3+ry01+tI6rUZBpIC3HMtyaA3RO35XVPt1+Z7M=;
 b=Sf2XMp/KHscX0H+K/JiN7f5nc1AN5EunE4So1NwsB7csMyxHUImu3YR8LM/elc8/d+
 rvNz0ZhTPo84oJUmqQSk0oqe1qpVE0jnIZithnPJb0l5zvGbIKMy6wOqc7nLrgtLzGSp
 GEpk6yNyjrMTh9NrcJVURcgPd1MWXK3urfZ/0v5RTHdJaJnYY4aCPt9pHL+6V3LNWE2I
 9QJ1JlMrYFJv6W9F7euvf3isWBXufCS5A9ZhHRiPJ5xwWxd2Bvz92Q6ZNEDgEiizXjQP
 6x8BvJJ9kHReiruFQfiHwwxNFCzKzTxUTiKgBOLLGlI9S+7huy3Sq7id3b8bXbIP5vG0
 QGOA==
X-Gm-Message-State: APjAAAXyxaZnztMKZGCox2gDFKDwMqa1QI1UKb9pUC0ZX/L4ocWOt05O
 Vt2B7amgmCyWK0fpoPZMKTfVym+ilTJevNEd+0sw1nW6O7azRI9HXAYE02LtOxgxglqot4acDDR
 0bL2nmCTpaafk7Nk=
X-Received: by 2002:a5d:530d:: with SMTP id e13mr13263681wrv.125.1576249006344; 
 Fri, 13 Dec 2019 06:56:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqyO9d81Q4U5v15kzJ2p5cTCHTIHruMBsF+3191MjUZ3Za1UZ4ZkPJDqqY71OvreUGTgCMYpFA==
X-Received: by 2002:a5d:530d:: with SMTP id e13mr13263674wrv.125.1576249006120; 
 Fri, 13 Dec 2019 06:56:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id s15sm10176960wrp.4.2019.12.13.06.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2019 06:56:45 -0800 (PST)
Subject: Re: [PATCH v2 3/8] hw: replace hw/i386/pc.h with a header just for
 the i8259
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-4-git-send-email-pbonzini@redhat.com>
 <d58b507e-9d68-d112-0f6c-6f9dfb153a93@redhat.com>
 <CABgObfY_19XxcbYUMm=V7pUF-gbkyYViV7Sp4ieNiGSH+VoH3Q@mail.gmail.com>
 <448c88fa-fb82-e62a-6219-0a1038db10fb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4193c376-9a4d-b455-0de9-9567dec56878@redhat.com>
Date: Fri, 13 Dec 2019 15:56:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <448c88fa-fb82-e62a-6219-0a1038db10fb@redhat.com>
Content-Language: en-US
X-MC-Unique: vmKo2FDhMbWJ8WZo7HetKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/12/19 10:43, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
>=20
> The MicroVM series introduced changes that outdated my work, and since
> having MicroVM was more important that global cleanup, I didn't insist a
> that time. Now GSI and IOAPIC are more exposed so my previous work
> doesn't apply at all. Well, current code diverged.
> I'll need some time to figure out if it is worthwhile salvaging, so
> don't wait for that.

Can you just point me to it?  (Patchew URL)

Paolo


