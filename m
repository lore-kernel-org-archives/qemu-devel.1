Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83549C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C333206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMpavgzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C333206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYjN-00061h-F2
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1ixY8k-0001ea-90
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:23:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1ixY8i-00030x-Si
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:23:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31456
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ixY8i-0002vO-KP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580484198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TawxEKQ4luwMe/Cf3ho+H6grhw051OxwGtYMWM4eEjo=;
 b=jMpavgzl0JQiTvciKEkiU5EXkOsD5VXtNTE//ls3up8w+QQMnOBv7hNwqJ0lrXnxJryeCA
 R8MSIw6HuSzVdgVqyfGvc/xTbesN5R4SV99Jj0NPSIgS/IfRvCEcLqoXsFDZ9yxwXsaqeD
 ESz3P7S/kCIahkm3ixnJUTjoHuPiyyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-XtiSWXTxOw-G4GUZMY7yVA-1; Fri, 31 Jan 2020 10:22:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA4668010F0;
 Fri, 31 Jan 2020 15:22:54 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-101.ams2.redhat.com
 [10.36.117.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C12EB86C4B;
 Fri, 31 Jan 2020 15:22:44 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 48E953E04B8; Fri, 31 Jan 2020 16:22:43 +0100 (CET)
Date: Fri, 31 Jan 2020 16:22:43 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
Message-ID: <20200131152243.GA24572@paraplu>
References: <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org>
 <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
 <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XtiSWXTxOw-G4GUZMY7yVA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 12:02:05PM +0100, Paolo Bonzini wrote:
> Il ven 31 gen 2020, 11:36 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:

[...]

> The advantage of putting them in the header is that you have them all in
> one place (inline functions and structs must be in the header). In practi=
ce
> that balances for me the disadvantage of having some comments far from th=
e
> code they document, which increases the risk of bitrot especially for
> comments such as "called with lock X held".
>=20
> I definitely agree that the overview/introduction/conventions
> > side of things is where we'd benefit most if somebody wanted
> > to try to tackle that. We could roll
> > https://wiki.qemu.org/Documentation/QOMConventions
> > into that if we had a better place to put that info.
> >
>=20
> I am travelling this weekend so I might try to do some kind of thread
> summary and brain dump in the wiki. I'll leave to Kashyap to do the rST
> conversion and patch submission. ;-)

Thanks!  Happy to be the 'scribe' ;-)  I have a skeltal
qemu-object-model.rst file sitting with some initial content based on
various sources, including one of your presentations[*] from 2014.
I'll wait for your new Wiki link to incorporate that content.

(Minor aside: I'm not sure if this file should be in docs/interop/ dir,
which IIRC, is for things that are 'external' interfaces.  And I learn
that QOM is used both internally in and as an external interface, e.g.
whenever a device is being created, machine types, CPU config, etc.)

            - - -

I've re-skimmed your scarily-titled "QOM exegesis and apocalypse" 2014
KVM Forum talk slides[*], where the "Why QOM?" slide says:

    All device creation, device configuration, backend creation and
    backed configuration done through a single interface
   =20
    Rigorous support for introspection both of runtime objects and type
    capabilities

Me wonders how much of the above "Why" still holds true today.  Although
further slides give more clues on what worked and what didn't.

I'll wait for fresher details from your upcoming Wiki :-)

[*] http://www.linux-kvm.org/images/9/90/Kvmforum14-qom.pdf

--=20
/kashyap


