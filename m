Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96568C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7A92080D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+pgAW92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7A92080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2Ns-0003mJ-8f
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1ir2Mj-0002h1-01
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ir2Mg-0004BC-M5
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:14:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ir2Mg-00048i-A0
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578932093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGsP8GKEgRUUqq2gfeDxiGtVaLBs8N4bvgoe1+zaWbQ=;
 b=d+pgAW92Jx/GgPqZBSZJuC7GdNSwYoKqSIIzF2f6z4wjG/XOHxgjyD0UGPUBK3BqYjC5kG
 OURfNaHrdNOiglGbCK2CHIC+BSlVYxPNjO9G21NHQpzDKhjFLyDSKwdNrWsOTkGypyuzOg
 wyAFoZ2mISbqgtZYwylpe+dx4mSB3Wc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-6COnVfXbP8CcESpH7J0pIw-1; Mon, 13 Jan 2020 11:14:51 -0500
Received: by mail-wr1-f71.google.com with SMTP id o6so5170639wrp.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 08:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=iw21gEE6xY3lfhfqMa681jgo83m9ADLcvBXs22rXYwA=;
 b=DURRLTLPMJlmGLC4P6lA9qB5MCRxNssfGmgmbkIkuwk/M7fNxjcaO5JdK+K1857N+o
 ULZaLErGtV4snq7ROURFizBEEs6skg1m4vXGMmluroHX4dRExreXLCfM1Itbyz0Gj9to
 laG/ieAR0M5g2ehrxp6FLvFrGAc1UQuyNaXGlG7dpgOXCYaE7P7MDH/E31LdR1WI94vB
 ZXX0Rs+VAM3uDQ04/DITY2oji94sY8OME6fN+xrQYL9i1eeYRyd3U463s3UkoOCO4FRw
 GqSPca8R4CkHsDhX/ohM49BLRStmeUUh058Fr3mbqh+5xqzwZVRWwugZLBXcXeI4ZX4m
 HBaQ==
X-Gm-Message-State: APjAAAVl0lKg6sFgFwUJPGASQrVLlQsYy/8/Ay3eqYvzgTI+DF79zgqh
 EWtN5KSyc4vPVAet2GlxLHRsmgnmbFItFmNbtvFfDI6m3vtxhfxzLtYoMVVU358HJtycE3/szcR
 BbuxS50pToDN/c4I=
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr19346434wrt.229.1578932090855; 
 Mon, 13 Jan 2020 08:14:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZUWsWJKQldISus9o/x5AXtTEMUnntZG2iZT2erxpCR+T37EUuzTgrTeTYytI3hlycu1ox+g==
X-Received: by 2002:a5d:4e0a:: with SMTP id p10mr19346397wrt.229.1578932090604; 
 Mon, 13 Jan 2020 08:14:50 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:8098:c6b2:68a9:51e5?
 ([2a01:e0a:466:71c0:8098:c6b2:68a9:51e5])
 by smtp.gmail.com with ESMTPSA id h17sm16080838wrs.18.2020.01.13.08.14.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2020 08:14:50 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Priority of -accel
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <871rs3zaih.fsf@dusky.pond.sub.org>
Date: Mon, 13 Jan 2020 17:14:49 +0100
Message-Id: <752BE521-649F-418F-BD09-DDC7708F4FF2@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com>
 <2ae2dee3-cd16-a247-971b-4b3482e596a5@redhat.com>
 <20200107142735.GC3368802@redhat.com>
 <fb83df0a-da82-f981-fbda-d5c74e87cf5c@redhat.com>
 <871rs3zaih.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: 6COnVfXbP8CcESpH7J0pIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 13 Jan 2020, at 15:39, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>>>>=20
>>>> 'any' is a russian roulette, you don't want it to return 'qtest' ;)
>>>=20
>>> We could make it return "qtest" only on April 1st ;-P
>>=20
>> ... or we finally dare to let QEMU chose the "best" accelerator by
>> default if no "-accel" option has been specified...
>=20
> Changing a default that has ceased to make sense a decade ago?  Are you
> out of your mind?
>=20
> ;-P

Well, it makes perfect sense, since we select kvm first on macOS and, I gue=
ss,
all non-Linux platforms ;-)

% ./x86_64-softmmu/qemu-system-x86_64  =20
qemu-system-x86_64: invalid accelerator kvm
qemu-system-x86_64: falling back to tcg

(Fixing that knowing that CONFIG_KVM is poisoned in vl.c is left as an
exercise for the reader)

Christophe


