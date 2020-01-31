Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C98C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C39020663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVlfX2jU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C39020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixa2E-0001dQ-A1
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ixa1N-0000iu-5s
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ixa1J-0002mC-OK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:23:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ixa1J-0002le-Kb
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580491432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCnIy5nV5jdiJLAobGpgr6JyF1W9ZElJgutLBa59Isg=;
 b=NVlfX2jU30MNXvKN4Ohc4QuVUIpfHIFeA0JbBMDGumi6PjL8X1IVYLxGo+2BIW4JgiWZ2X
 JKT9+yCN6RPDs9A/5hxO5Gyq44i1Ru3/wMeXhjIlZzeQs6IUSdHjapGuUkHUWemzGWAMXI
 SHlL15eJ6RtRiyTsnZylyOErEFi0XTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-gtVYkZRvODeEKyNfRXC5BQ-1; Fri, 31 Jan 2020 12:23:40 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 960A910CE791;
 Fri, 31 Jan 2020 17:23:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2D67792F;
 Fri, 31 Jan 2020 17:23:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7FFF91138404; Fri, 31 Jan 2020 18:23:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
References: <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org> <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
 <CAFEAcA-545QS9mnM6hwa6TxUpw_pDQ3Pa8tkf4qtzWS1Zi_fxQ@mail.gmail.com>
 <CABgObfaB=wHXyJbQR163bZdFHhWdCc4D8sWRHzte019_hSTuhA@mail.gmail.com>
 <20200131152243.GA24572@paraplu>
Date: Fri, 31 Jan 2020 18:23:28 +0100
In-Reply-To: <20200131152243.GA24572@paraplu> (Kashyap Chamarthy's message of
 "Fri, 31 Jan 2020 16:22:43 +0100")
Message-ID: <87sgjvbkvj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gtVYkZRvODeEKyNfRXC5BQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kashyap Chamarthy <kchamart@redhat.com> writes:

> On Fri, Jan 31, 2020 at 12:02:05PM +0100, Paolo Bonzini wrote:
>> Il ven 31 gen 2020, 11:36 Peter Maydell <peter.maydell@linaro.org> ha
>> scritto:
>
> [...]
>
>> The advantage of putting them in the header is that you have them all in
>> one place (inline functions and structs must be in the header). In pract=
ice
>> that balances for me the disadvantage of having some comments far from t=
he
>> code they document, which increases the risk of bitrot especially for
>> comments such as "called with lock X held".
>>=20
>> I definitely agree that the overview/introduction/conventions
>> > side of things is where we'd benefit most if somebody wanted
>> > to try to tackle that. We could roll
>> > https://wiki.qemu.org/Documentation/QOMConventions
>> > into that if we had a better place to put that info.
>> >
>>=20
>> I am travelling this weekend so I might try to do some kind of thread
>> summary and brain dump in the wiki. I'll leave to Kashyap to do the rST
>> conversion and patch submission. ;-)
>
> Thanks!  Happy to be the 'scribe' ;-)  I have a skeltal
> qemu-object-model.rst file sitting with some initial content based on
> various sources, including one of your presentations[*] from 2014.
> I'll wait for your new Wiki link to incorporate that content.
>
> (Minor aside: I'm not sure if this file should be in docs/interop/ dir,
> which IIRC, is for things that are 'external' interfaces.  And I learn
> that QOM is used both internally in and as an external interface, e.g.
> whenever a device is being created, machine types, CPU config, etc.)

docs/devel/qapi-code-gen.txt has the same problem: it's mostly internal
stuff, but there's also introspection, which is an external interface.

>
>             - - -
>
> I've re-skimmed your scarily-titled "QOM exegesis and apocalypse" 2014
> KVM Forum talk slides[*], where the "Why QOM?" slide says:
>
>     All device creation, device configuration, backend creation and
>     backed configuration done through a single interface
>    =20
>     Rigorous support for introspection both of runtime objects and type
>     capabilities

For a value of "rigorous".

Let me propose QAPI's query-qmp-schema as the tin standard[*] of
introspection:

* It's documented

* It comes with something that can pass as a type system

* It actually tells you the full truth.

Now compare to QOM:

* Documentation

  QAPI: docs/devel/qapi-code-gen.txt section "Client JSON Protocol
  introspection"

  QOM: Nada

* Type system

  QAPI: A few built-in types specified in the documentation, type
  constructors for complex types.

  QOM: Types are strings, and you just need to know what they mean.
  Some string patterns are special: link<STR>, child<STR>, STR[INT], and
  you just need to know what that means, too.

* Full truth

  QAPI: If you can access it at the interface, you can also see it in
  introspection.

  QOM: Type introspection can show you only the properties of a freshly
  created object.  Properties that get created only later are invisible.
  Properties that depend on global state are unreliable.  Object
  introspection is reliable, but only for that object in its current
  state.

> Me wonders how much of the above "Why" still holds true today.  Although
> further slides give more clues on what worked and what didn't.
>
> I'll wait for fresher details from your upcoming Wiki :-)
>
> [*] http://www.linux-kvm.org/images/9/90/Kvmforum14-qom.pdf

[*] Gold was too expensive, but we had some tin on hand, so...


