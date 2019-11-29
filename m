Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C0C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A7320833
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Du0Qysq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A7320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadGB-0002D7-Ei
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iacxd-0005qC-Nh
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iacxW-0000fG-7u
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:53:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43675
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iacxV-0000Rp-QU
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575021182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G9vurAtotf8R/71XQlmxYgExuHEcLajFRppiFZySOoU=;
 b=Du0Qysq6ha2Z/JKngkET+ydJPKMFJQT8gogJ76Uc23vh6rMGOCGEgiTNcjNi3/TWDW6G6s
 gn4DMCPqF6lTyN7E10Q1HkjElSfVEiEIi+GDUobcdG8C5zh0HUKyOcF/4Eoo8c7UbOs7W4
 vSzOPjaElInvE3iKIgaI17AwURrpU+0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-vxzAkzwTPGWGsL7g302UZA-1; Fri, 29 Nov 2019 04:53:00 -0500
Received: by mail-wr1-f71.google.com with SMTP id q12so15369022wrr.3
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 01:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uwHvZtXS7dRyGmv2nIlunqWCOnSZBeS8uZMDrsfda/M=;
 b=nMvHQVIht0PVAmBYQXwakA2h7wa1uEGG0QRBmmXJxS8UEJGJ3XZmI3hG7rBoOSmFEd
 /F0Y6n2zWotbsF9BYcKYmqzuO8H6eM/WPv1+1r2GeTKuIIo/vzrJUKtppL6PtLExyPK1
 jkCVc+6j7rc9WnXvgA6mgY44LaRPSktnX8CI/RFV8Ao9Cjd4iEvq6HTg9HM7Q6zXQpjh
 re2MUJiLh8RYK94Lx/LPJte0TSGqYw4KOscI2U8HuOiqSDE3mBXOOeXjbGd+XMTvXcSN
 BYM5gDVpYQM2+75rEt095NTXuH4EE9ZZEARADFkTL/8Y5QZOV0w9+OorfoZLx2NVMuyQ
 4J7Q==
X-Gm-Message-State: APjAAAXxJefwj4dmHwfFriI8txxKqPhOy9xPIHVlut/f5bPOcNiuJTe2
 i92LfJI81bSH4NQmbnHlbZF+iaIit5W+o5mpvFRzscMLu/+5TTPMXw7V2BxibrB62F6XAiPfaNX
 O9mcj6pg/1mSMDfI=
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr110110wmh.22.1575021179180;
 Fri, 29 Nov 2019 01:52:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNgjiypjC4rsoN/C6tzA40X+v6zGfe/AObWpq7XBqWZqXmOOQFqtytryyvaAST46v4Cd316g==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr110086wmh.22.1575021178877;
 Fri, 29 Nov 2019 01:52:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:459f:99a9:39f1:65ba?
 ([2001:b07:6468:f312:459f:99a9:39f1:65ba])
 by smtp.gmail.com with ESMTPSA id h17sm1446198wrs.18.2019.11.29.01.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2019 01:52:58 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: add -mem-shared option
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191128141518.628245-1-marcandre.lureau@redhat.com>
 <20191129070253.5hwksjrapomk434x@sirius.home.kraxel.org>
 <CAMxuvawieN7JQZkRku19v5X-o6q664Wz1Rtx3+Wz3d33m-7Tug@mail.gmail.com>
 <20191129092713.GA2260471@redhat.com>
 <6b441014-1852-3257-2bc5-897cc51d08dc@redhat.com>
 <20191129093941.GD2260471@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <49e9c7b6-bd0b-655b-0f19-174382ed763b@redhat.com>
Date: Fri, 29 Nov 2019 10:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191129093941.GD2260471@redhat.com>
Content-Language: en-US
X-MC-Unique: vxzAkzwTPGWGsL7g302UZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/19 10:39, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Nov 29, 2019 at 10:33:39AM +0100, Paolo Bonzini wrote:
>> On 29/11/19 10:27, Daniel P. Berrang=C3=A9 wrote:
>>>> Yes, with a fallback path currently using a temporary file under /tmp
>>>> (we may want to use shm_open() instead, or a different location such
>>>> as XDG_RUNTIME_DIR? - and use O_TMPFILE)
>>> We can't assume either /tmp or XDG_RUNTIME_DIR is on tmpfs as that is n=
o
>>> where near standard across all OS distros, and even if on tmpfs these
>>> dirs can be size limited to a significant subset of available RAM. IOW
>>> we can't safely use them unless explicitly told to.
>>
>> Agreed, mkstemp+shm_open seems better.  Perhaps this could be done in
>> hostmem-memfd.c though, basically as a fallback option?  In principle
>> one could even use getmntent to search for a hugetlbfs mount.
>=20
> With mkstemp you still need to pick a location, and I don't think it
> is clear there is a reliable choice that will always work.

Sorry, I meant mktemp (which is almost never the right choice so my
brain fat-fingered it...) + shm_open(O_CREAT|O_EXCL).

Paolo


