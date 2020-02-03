Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061A4C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F992070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3c2eu1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F992070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYS2-000813-Uz
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iyYRF-0007KP-PV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iyYRC-0007Qo-GD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:54:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iyYRC-0007Ph-CV
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580723677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAH/RTgSgPdmG2oXN/9sILCeGVRdYkGqY9YTw9lo8g8=;
 b=R3c2eu1CGc04ojPiO2DxGyPGSx+WJrsb9gdnepypiHAuNwpiXRFR05BWkKgpsHPpZTgFGf
 ywKdyXf1YJWm8enq+V8sUF9KVA54j+vBD/ntmEyYksotr3yAczz03nMff5/mvyTooQ41HR
 1FxImvPH9YnRpP7WH7GfOrJw0C7H0vk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-DhwemwaDPC-3fO3i1zw9Ew-1; Mon, 03 Feb 2020 04:54:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A88028010CC;
 Mon,  3 Feb 2020 09:54:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4931090F51;
 Mon,  3 Feb 2020 09:54:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5E711138404; Mon,  3 Feb 2020 10:54:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
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
 <20200131152243.GA24572@paraplu> <87sgjvbkvj.fsf@dusky.pond.sub.org>
 <b2a329bf-4795-14f0-473c-2a7cdfa4d262@redhat.com>
Date: Mon, 03 Feb 2020 10:54:24 +0100
In-Reply-To: <b2a329bf-4795-14f0-473c-2a7cdfa4d262@redhat.com> (Paolo
 Bonzini's message of "Mon, 3 Feb 2020 09:56:24 +0100")
Message-ID: <87mua02dyn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: DhwemwaDPC-3fO3i1zw9Ew-1
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
 "Denis V. Lunev" <den@virtuozzo.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/01/20 18:23, Markus Armbruster wrote:
>> Kashyap Chamarthy <kchamart@redhat.com> writes:
>> docs/devel/qapi-code-gen.txt has the same problem: it's mostly internal
>> stuff, but there's also introspection, which is an external interface.
>
> We should move introspection to docs/interop.  Any takers?
>
>>>     Rigorous support for introspection both of runtime objects and type
>>>     capabilities
>>=20
>> For a value of "rigorous".
>>=20
>> Let me propose QAPI's query-qmp-schema as the tin standard[*] of
>> introspection:
>>=20
>> * It's documented
>>=20
>> * It comes with something that can pass as a type system
>>=20
>> * It actually tells you the full truth.
>
> Well, not all statements age equally well.  But compared to netdev_add=20
> and device_add, it was still an improvement. :)

I think "rigorous" is to be read as ambition, not description.  Sadly,
QOM stagnated before getting close to realizing its ambitions.

> It's certainly worse than QAPI *now*, but it's not nonexistent:
>
>> * Documentation
>>=20
>>   QAPI: docs/devel/qapi-code-gen.txt section "Client JSON Protocol
>>   introspection"
>>=20
>>   QOM: Nada
>
> Well, there is qom.json.  So slightly more than nothing, though I have=20
> already found an off-by-one error and it could definitely be improved:
>
>  @type: the type of the property.  This will typically come in one of fou=
r
>         forms:
>
>         1) A primitive type such as 'u8', 'u16', 'bool', 'str', or 'doubl=
e'.
>            These types are mapped to the appropriate JSON type.
>
>         2) A child type in the form 'child<subtype>' where subtype is a q=
dev
>            device type name.  Child properties create the composition tre=
e.
>
>         3) A link type in the form 'link<subtype>' where subtype is a qde=
v
>            device type name.  Link properties form the device model graph=
.

If the off-by-one you found is "four forms" followed by a list of three,
then the error isn't "four", it's the omitted fourth list item.

Anyway, I grant you "nada" was an exaggeration for effect.

Note that the doc comments are reference documentation.  QAPI got that,
too.  Reference documentation is useful, but no replacement for an
explainer like qapi-code-gen.txt.

>> * Type system
>>=20
>>   QAPI: A few built-in types specified in the documentation, type
>>   constructors for complex types.
>>=20
>>   QOM: Types are strings, and you just need to know what they mean.
>>   Some string patterns are special: link<STR>, child<STR>, STR[INT], and
>>   you just need to know what that means, too.
>
> str[int] is not a type as far as I understood it, it's a property name. =
=20

You're right.

> Types are documented as above; however types other than link<> and=20
> child<>, which are QAPI types, can be user-defined types (structs,=20
> enums) and this is not included in (1).

Specifically, three of four kinds of type names are documented:
primitive, child, scalar.  The fourth kind is not, and it can be
anything.  It need not be a QAPI type name.  In any case, you just have
to know what the type name means.

In contrast, QAPI introspection defines all types in terms of type
constructors and primitive types.  It completely hides user-defined QAPI
type names, so they don't become ABI.

Do you think we could somehow appropriate QAPI's type system for QOM
introspection?

>> * Full truth
>>=20
>>   QAPI: If you can access it at the interface, you can also see it in
>>   introspection.
>>=20
>>   QOM: Type introspection can show you only the properties of a freshly
>>   created object.  Properties that get created only later are invisible.
>>   Properties that depend on global state are unreliable.  Object
>>   introspection is reliable, but only for that object in its current
>>   state.
>
> Right, that's array properties and at least theoretically child=20
> properties (I don't know if there are examples).
>
> Paolo


