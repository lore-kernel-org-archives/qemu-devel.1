Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8385C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F51206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NP1eSNBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F51206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYrX-0003pg-S5
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ixYMR-0002tK-5M
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:37:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ixYMO-0000nF-Eg
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:37:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47154
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ixYMO-0000kw-AH
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580485050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtileLFHCXHe2XbeFkM9NusNK5K06fSlsbkD7oUMZck=;
 b=NP1eSNBnKj6usKm6tWBM8hoeuzfWRWWjSrTequQRIfj24oDFEuFmppQYNHRNdx3T6achGV
 gdwXlgb16Y0+dGaeyG4QASW+gJj071fna3xPUKXOsM9dJRzU5MaVYBnxRKNCdozebMO+QN
 QdcE0qCC3c2uB4Bgn9TVbCcT44prT5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-W3Mu_O0yOPOzLLWkk4LWQg-1; Fri, 31 Jan 2020 10:37:25 -0500
Received: by mail-wm1-f72.google.com with SMTP id o193so2962550wme.8
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=Kw90eqlIOjx+IKxs3valqqQlQRy2seWNM9S3LSInzUI=;
 b=UxGpQQU+uE9BICWNuGHMn0x5fW1cEpLc5jmlkLNoji5sQHSGYTyyObYCxHGF9LGWv2
 jNyvcoX4PgpkU8ZT6IR/Mm1vOO8tKJY/sSY67ygxLEbGif4m5NrlfqmZQu6idThfqX2F
 4mKlg2Tjk3JAAj0y3KcB4vTXK/Me//g9ZbM1X3ah4OcrOxqoSixyIW8U8prpAWZd30L8
 tuCFLNoqmiITZH8lBWRcnFAAKVBYOr9/+i98/3Dxypz6Qybp+KJAJ7xSM+hyni917CAs
 tXyjLNhEpzSumdbANKw/7KJHIiVn1gdWgjUagoP5yHeQNVzgf2jatYvrOPeh0mHgm3De
 2GTA==
X-Gm-Message-State: APjAAAWiFSTzeK7IQ4fwRaeuCrdGx2FL1rGHR3Jw4zMQ1Rw96RVlFIWO
 1h3dUw70LFBKsE3vqOTJ0flJOHZ/D5kb4mAZ2SxN3eKGhiy3JQwt9/xCyBut/bNTei+C5F7KWL2
 HW9MHIA3XDWffQiQ=
X-Received: by 2002:a5d:568a:: with SMTP id f10mr12505606wrv.180.1580485044104; 
 Fri, 31 Jan 2020 07:37:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqycYfn8NveAA9yLb8QeKPzLWTLyXf3v8MG4hJz0AbW0qQZvUtEZ6673m3PXzR6E8F6beg+7Ng==
X-Received: by 2002:a5d:568a:: with SMTP id f10mr12505580wrv.180.1580485043827; 
 Fri, 31 Jan 2020 07:37:23 -0800 (PST)
Received: from [192.168.61.145] ([5.255.146.68])
 by smtp.gmail.com with ESMTPSA id c141sm11415068wme.41.2020.01.31.07.37.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:37:23 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <0a626b76-1b45-991f-ebf9-d6dec2a84ffb@redhat.com>
Date: Fri, 31 Jan 2020 16:37:21 +0100
Message-Id: <17767A47-BB66-40D6-9BC6-03B56FB198CA@redhat.com>
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org> <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <0a626b76-1b45-991f-ebf9-d6dec2a84ffb@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-MC-Unique: W3Mu_O0yOPOzLLWkk4LWQg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 31 Jan 2020, at 08:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 31/01/20 07:11, Markus Armbruster wrote:
>> May I present you Armbru's Comment Trust Levels:
>>=20
>> ACTL2: The comment may be overly terse or incomplete, but the
>> probability for it to be outright wrong is low.
>>=20
>> ACTL1: Treat as helpful guidance (with gratitude), but trust only the
>> code.
>>=20
>> ACTL0: It is a tale Told by an idiot[**], full of sound and fury,
>> Signifying nothing.
>>=20
>> Most comments in decently maintained code are at ACTL1.
>>=20
>> Around the time initial QOM development solidified, object.h's comments
>> were ACTL2.  The neglect that is now clearly visible there makes me
>> downgrade to ACTL1.
>>=20
>> Paolo will have a more informed and possibly different opinion.
>=20
> I think around initial development it was ACTL3, now it's around 1.8.

Interestingly, the initial doc suggested ACTL to be an whole value between
0 and 2. Now it=E2=80=99s fractional and value 3 has a meaning you can gues=
s
to be =E2=80=9Cabove 2=E2=80=9D=E2=80=A6

How fast this happened tells you everything you need to know about
documentation/specifications and actual implementations :-)

>=20
> Paolo
>=20


