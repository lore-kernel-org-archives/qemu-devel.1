Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86958C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508CB22309
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZMAGLDV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508CB22309
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpbT-00069Z-Hs
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWpWy-0003HK-22
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:30:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWpWw-0007c6-1l
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:29:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44315
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWpWv-0007bl-Uj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574116197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zgYrd1RDY7yMbwX/8pum+cR7F3LacLrQiBELhZA6OY=;
 b=dZMAGLDVGzqJkWOymlBy2PKvRaVMG4y+eqAOfwYejl+vIxjvJ+3XVu27fW+kLw2n0DUEg4
 QB6k+MNQ4SAiIVyXT5J2owPbXL65M13aNWgKWSrMWvNEpSjreDPGQJi731X3Rms0OX35pV
 99pJgQYINW5UD0jhiT/pe5004S2Lt/s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-HI3EYUsrPvKkGW0HhMoBXQ-1; Mon, 18 Nov 2019 17:29:54 -0500
Received: by mail-wr1-f70.google.com with SMTP id b4so16857041wrn.8
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 14:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zvJkwaO2rd0InAQv7m0WZmhIMtP3vXxJWq90jY36iXU=;
 b=qIWLH9hG/P4Yh3Kjem9/Sc0dqkPoma2HKVLo4kFuH6XQlAMhxJc0ttNpYVIg3NL/Rg
 yeVAfmpp53ika7tC+MSXv3HJPhgGHDakqc5oKH08YsiXqv0/AKytW0bi9h2DUFeV5xqN
 oHY2rG8Cvx9ukK3ukkEa/ioPmnPWWOY5hmnL/1V8Fss5arJiWGi47U1mg2Egj1LQn5G0
 qoSxTR8khBnRfPMFfLgfEUKwE64MMdnuj4AsOTv3YXTRpMLu4mvP1+1dB2upBsBu4ldM
 43/UDTrhxIn74L3hgDf5gC+QZymtBRW8pgCY4STnWFKgfPQFqjwto5bR5L5cuGBRE+mt
 IYEQ==
X-Gm-Message-State: APjAAAVwh349cmtoGck+0ApEcIYwthKBe61iGNeesuOJIHGR040kISVL
 Z87HeCLyJ79T9HIuSXkY5QIwahQh23wcEUG2kIeYJQwEQP9nN/nzZBHQ6/wvDuA/cLhSFqpR4Cc
 nJNxXGBlG1jHoI6o=
X-Received: by 2002:adf:f0c4:: with SMTP id x4mr30497886wro.217.1574116193235; 
 Mon, 18 Nov 2019 14:29:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxv9c3H4HrbTHwa8NiCvBiAo/ZvHo/HkJVQI2Z9P78wyZiutj2x7zs+AP6SIEGPZfDBpMiP+w==
X-Received: by 2002:adf:f0c4:: with SMTP id x4mr30497857wro.217.1574116192939; 
 Mon, 18 Nov 2019 14:29:52 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id k1sm25206184wrp.29.2019.11.18.14.29.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 14:29:52 -0800 (PST)
Subject: Re: [PATCH-for-4.2 v4 0/2] hw: Remove dynamic field width from trace
 events
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191118222746.31467-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7b8db299-0d00-d8d2-8612-7f7beccb84bb@redhat.com>
Date: Mon, 18 Nov 2019 23:29:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191118222746.31467-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: HI3EYUsrPvKkGW0HhMoBXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is material for 4.2-rc2.

On 11/18/19 11:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This series fixes LP#1844817 [2].
>=20
> (Eric noted in [1] the dtrace via stap backend can not support
> the dynamic '*' width format.)
>=20
> If they are trivial/block/tracing pull in preparation, this
> series will be happy to be taken, else it will go via mips-next.
>=20
> Thanks,
>=20
> Phil.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04720.html
> [2] https://bugs.launchpad.net/qemu/+bug/1844817


