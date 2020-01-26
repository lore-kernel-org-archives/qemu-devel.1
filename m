Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EBDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 16:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3965D206A2
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqDobmiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3965D206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivl59-00037S-DP
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 11:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ivl4A-0002cc-7x
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 11:47:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ivl47-0002zc-Rr
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 11:47:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ivl47-0002yp-Nw
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 11:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580057234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VosXAJSOWRv+RjYNiRK3nHDNw6+1ZwiDWsU+8E+dS8A=;
 b=RqDobmiPqrSWPjaZUvIL/BGf+v+rtqd+9AwYH/zhEaCVOpn3vDrmtDK7aHXG1CMvK9mxwg
 6+G1KbLs1d/M5EbYgeSOfbwMvAIwoUHmhKkOPeKr8/JUo+BWqxYyD0Yzxd5g1kCciORxFc
 FbVzpZgOIAUng9JFk2P7QX89uTCvRAM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-AXqMqo7mNbWa1AuApBiQsg-1; Sun, 26 Jan 2020 11:47:10 -0500
Received: by mail-wr1-f70.google.com with SMTP id o6so4647927wrp.8
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2020 08:47:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r8xdpEbui/mJTQseJTsbh0+qV0y+2P/d2fNkJKOIoXs=;
 b=QnmVutgxi6j4OYOJiKCOMu2rOHQQQIp9ln0KU83RugkL2aDAtzDx7yBBkL0oekyhVS
 zM1mBQFusEv4bvWSqR5b5aw5gnZK2wluRUzjCtL286ruloNug6GYPRtmxOa3j8d40riF
 Fsrsg9HJpxHIs7oPY28ypl0/d0a3C0SZR06q+9U7KAuWrNFXpjfsk8JkFSNnpyiRnizR
 N1vcH4SAkrJUIbqYaRR07VorURDHxSd4DovxksnC2PkVLNiU0WENxvAo091YS8BkgLZw
 KsuZmyabFycO/5830P5dA/teLoBrQGvPKswvSPutI67E2/j0p0REtVzC+R6ZCGskY5kT
 8qaw==
X-Gm-Message-State: APjAAAU9Kh5pUzFpVPBW6i6xUc+VKMJ3Ta2e0w0EkQh3lQl8CbgPhBnN
 dN0srwCSsOq/30p4hSwYmArRzdj7UGk2SHxfVPvpb5m7ZK6MR8pESsakPKQLezm52UP2dEbnHCK
 eW940NkoLVpre+Ho=
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr9329437wmk.172.1580057229681; 
 Sun, 26 Jan 2020 08:47:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyIJTLqIkluPW8HIaaKxDokWTfrbMrDCnIUz0zR3ZXrv4xZihvyGK1coQE51yUsMYaKBCw1Yg==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr9329399wmk.172.1580057229339; 
 Sun, 26 Jan 2020 08:47:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:784d:f09c:63f4:b9cb?
 ([2001:b07:6468:f312:784d:f09c:63f4:b9cb])
 by smtp.gmail.com with ESMTPSA id t12sm16118333wrs.96.2020.01.26.08.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2020 08:47:08 -0800 (PST)
Subject: Re: Integrating QOM into QAPI
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Christophe de Dinechin <dinechin@redhat.com>
References: <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200120100849.GB345995@stefanha-x1.localdomain>
 <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org> <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
 <CAJ+F1CL_nREHOyh4YffWwbES+wgq8tZTkd4n8Vf568b+hbzgDQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0e08d426-dc2a-d373-86f3-f2cc22694b74@redhat.com>
Date: Sun, 26 Jan 2020 17:47:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL_nREHOyh4YffWwbES+wgq8tZTkd4n8Vf568b+hbzgDQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: AXqMqo7mNbWa1AuApBiQsg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/01/20 10:11, Marc-Andr=C3=A9 Lureau wrote:
>> I=E2=80=99m still puzzled as to why anybody would switch to something li=
ke
>> GObject when there is C++.
> C++ is another level of complexity.
>=20
> Replacing QOM with GObject would mainly bring us a more solid type
> system with better tooling/features, gobject-introspection support,
> and remove the burden of having our own OO from QEMU code base.

In fact, C++ doesn't solve any of the problems that either QOM or
GObject try to solve.  (Neither does Rust for that matter).
Nevertheless, there is no stupid question, only stupid answers, and I
think Christophe's remark is an example of a common misconception.  In
the hope of not making this a stupid answer, let my try to formulate
succinctly what I think the differences are between QOM, GObject and the
C++ object model:

- the C++ object model (at least "old-style" C++ with virtual functions
and the like) provides you with _the intersection_ of what QOM and
GObject try to solve.  This is what Marc-Andr=C3=A9 calls "OO", and it's
essentially virtual functions and dynamic casts.  It's a relatively
small part of both QOM and GObject, and unfortunately a wheel that
almost every large C program ends up reinventing.

- Marc-Andr=C3=A9 also described above what GObject provides: a fully
introspectable type system and the tools so that _libraries_ can define
_types that will be used from multiple programming languages_.

- QOM also provides a fully introspectable type system, but with a
different focus: it's so that _objects_ can expose _properties that will
be accessed from multiple channels_.


Everything else in both GObject and QOM follows from this core purpose,
and the differences between the two follow from the differences.  For
example:

- GObject's focus on multiple programming languages:
gobject-introspection, GClosure, support for non-object types (scalar
and GBoxed)

- QOM's focus on objects: dynamic properties, object tree, all types are
classes

- QOM's focus on properties: no introspection of methods

- QOM's support for multiple channels: visitors

Paolo


