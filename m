Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0641CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F8720781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 21:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGqOWGpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F8720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5yMu-0004pB-PS
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 17:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k5yKO-00039c-EU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:30:32 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:44164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k5yKN-0005uC-0i
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 17:30:32 -0400
Received: by mail-oo1-xc44.google.com with SMTP id g1so791098oop.11
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:user-agent:to
 :references:in-reply-to:message-id:subject:date;
 bh=QtYbMU712JOQdoZmayulerj4AtmJHL+3nUNdUn2Uxmc=;
 b=mGqOWGpNUK8oybHQi7YhDwqLUdep/WjYAzM4lO8O/NYcj0CzaTnkfckNQyi27rCIPe
 jreWsaPllvXrVDgYkRmDw5d++Mv8YfClnqpEcZCkIXwnHI6TAw+i9i1RPM/9OIBz+PDd
 dwG8Y/kHaeBr/HqvYyyJZv+etilw5sPulMdBFFg7Qch0NISPAcydNfMroL4FwIIcVW4b
 kydywFrElULADGVHpAyQ4tImI6zkWjSVcvdM8l8lJtrkzHXbtFwuJB9kj0VPS9VxXquR
 /wAyOEKwci761rSXM/SED9dYj02KU7vvRxm6+j+fgdpjCKqx2Gvc0mQjOLcs9Pzw03xG
 SVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:user-agent:to:references:in-reply-to:message-id:subject:date;
 bh=QtYbMU712JOQdoZmayulerj4AtmJHL+3nUNdUn2Uxmc=;
 b=esPJ6355BaU4t50i8g1bsBk0E+4D2VxXjoGbaKkVGZdjussyszUgLEUiQNNdTPUw3p
 OxrjSeu7uJ7eJ5ZBjl77qDhUbkJTPhqImHUpbxMes54hPkEVmjpBpvNQrZoZM51ziOj2
 Na9pdgy0ml3xh2oMzScyA8bR++Tw2W+ut4Lc8jVeB1y1BlVDLQko7NdadVRlsrNOkqGq
 MXuShlPg7VKgN95AFTq01NnLwYo4agFyRSD80AfnAhPNGw/sSfDRrQIiNEpAdbn57Zcl
 TwMF512e8mQMaVwDCBEYSXRQXTcdr9UcN5V6pfJxnmvnJZ6jjfhdkJ8byketfMVdwsNO
 O9Zg==
X-Gm-Message-State: AOAM532Y8DT3T/Vzk+f3yOAE2LzH23QLoOJ5NO49G4Ba5vutlzXkDDPd
 XMZNkm0TDmPlZ7EhadELRi4=
X-Google-Smtp-Source: ABdhPJwlxXpTF72eOfp1AEfecH6NVFKjlmnnYTLWJ/foIH3r+26OXUzi5k7UhZwHSE+b+l06H4jfdg==
X-Received: by 2002:a4a:e92e:: with SMTP id a14mr1846531ooe.23.1597267829547; 
 Wed, 12 Aug 2020 14:30:29 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id o13sm698096oop.13.2020.08.12.14.30.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Aug 2020 14:30:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <cover.1596704579.git.tgolembi@redhat.com>
 <c6994b4db0f59b487f235aca692ca3430317ea2b.1596704579.git.tgolembi@redhat.com>
 <bd4987e4-606b-6d52-4d59-602df71f6fb0@redhat.com>
In-Reply-To: <bd4987e4-606b-6d52-4d59-602df71f6fb0@redhat.com>
Message-ID: <159726782559.7191.3871887312955779787@sif>
Subject: Re: [PATCH 1/1] qga: add command guest-get-disks
Date: Wed, 12 Aug 2020 16:30:25 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Quoting Philippe Mathieu-Daud=C3=A9 (2020-08-06 05:44:44)
> On 8/6/20 11:03 AM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD wrote:
> > The command guest-get-fsinfo can be used to list information about disk=
s and
> > partitions but it is limited only to mounted disks with filesystem. Thi=
s new
> > command allows listing information about attached root disks of the VM.=
 This is
> > usefull for management applications for mapping virtualized devices or
> > pass-through devices to device names in the guest OS.
> > =

> > Output is similar to the list of partitions of guest-get-fsinfo, except=
 that
> > the disks are mapped instead of partitions.
> > =

> > Example output:
> > =

> > {
> >   "return": [
> >     {
> >       "serial": "SAMSUNG_123456789",
> >       "bus-type": "sata",
> >       "bus": 0,
> >       "unit": 0,
> >       "pci-controller": {
> >         "bus": 0,
> >         "slot": 31,
> >         "domain": 0,
> >         "function": 2
> >       },
> >       "dev": "/dev/sda",
> >       "target": 0
> >     },
> >     ...
> >   ]
> > }
> > =

> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> > ---
> >  qga/commands-posix.c | 91 +++++++++++++++++++++++++++++++++++++++++++-
> >  qga/commands-win32.c | 83 ++++++++++++++++++++++++++++++++++++++++
> >  qga/qapi-schema.json | 13 +++++++
> >  3 files changed, 186 insertions(+), 1 deletion(-)
> =

> Not sure this is better, but splitting this in 3 could help different
> people reviewing (developers not familiar with the Windows API might
> feel not comfortable adding a R-b tag for the POSIX part, and
> reciprocally).
> =

> 1/ qapi + stubs
> 2/ POSIX implementation
> 3/ Win32 implementation
> =


+1

