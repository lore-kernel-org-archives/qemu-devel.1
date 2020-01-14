Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631DBC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5822075B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrOtDMW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5822075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irQ36-0006K9-7L
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 12:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42175)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1irQ2J-0005sf-GC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1irQ2E-0000aa-FP
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:31:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1irQ2E-0000aJ-2y
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579023080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIAoao9mW1FKueH5qdarwI7u1SNHSIZeBH0xkshYmfw=;
 b=ZrOtDMW8YzwWhA7gQmAaKRxvrbbdSSRqhpYJUD8UPk1YXDC1X33UDoVTWvx6FC9COSq82X
 Ml1i/nJSUxWML86QeXsW8S05wQ9/WtCowI2V2+pNc/TX/u8fRtwsWPWoRbkptthq+Mv6pc
 cwm0DvykBN/gM6bA0Mo9ys+9WvoxS8A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-jm5pJlqeN5m4lyb3jDdPgQ-1; Tue, 14 Jan 2020 12:31:15 -0500
Received: by mail-wm1-f72.google.com with SMTP id t4so3849216wmf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 09:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=NIU5fTXsc1WAAYw+h+UrVvsJkGh1CO0aaNtELhF+hGI=;
 b=DpoCfuPlqSzcSnySbNijLgAJ80UhkwA1Fy9vvPpnD/B680vrB67lY91rqJ63BPb11E
 rJ0rC1Onj4ZSht+wVTmeh0Pid4gPB9T3W2T2sdoR6MlIeL6hCRekBe3lCd8NuC57vdAM
 lVBQ0MQZUmtGl7fKxLD5GHul6WDwE9r/Ef3Qqz86x+pvFux5m6QgPQd5vcdN35ozW+UZ
 7X1ybfTvCCK2ZZ5Itb7jkoFxzNB5vuZD564klNCfa/TEtwzVVxt2ng8JX25gfVVxNxJu
 mzTv3I8ujdihHtapdEN4boqZLroqek6Ti0KYwndFogX3g0yJC4537C5FpfCf4CJOu2wR
 QCzg==
X-Gm-Message-State: APjAAAXQe7ul7LZvUg8iMoQZmgy//pNqVHxm0zZ8tk1vY0rOnd8kcg77
 7B4TJ4WvGeppeJqrTsKwEak1vQeT6Ww2AlMfNDeDSK/YpazMOWfIkwFdNOjCu7N5i2XqyE/7I11
 83qXhHbwVTNnMTkw=
X-Received: by 2002:adf:df8e:: with SMTP id z14mr25963980wrl.190.1579023073952; 
 Tue, 14 Jan 2020 09:31:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzxS3to5WRxCe7pR/oo53twmYGT59pQqY0xoiSQLHarUbvctsd5g8ENzuMvDQtXsqzW1bUptg==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr25963929wrl.190.1579023073424; 
 Tue, 14 Jan 2020 09:31:13 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:7440:4d06:49b0:1f79?
 ([2a01:e0a:466:71c0:7440:4d06:49b0:1f79])
 by smtp.gmail.com with ESMTPSA id f1sm20792407wru.6.2020.01.14.09.31.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jan 2020 09:31:12 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Making QEMU easier for management tools and applications
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <87d0bmchq0.fsf@dusky.pond.sub.org>
Date: Tue, 14 Jan 2020 18:31:11 +0100
Message-Id: <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: jm5pJlqeN5m4lyb3jDdPgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain;
	charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I started cutting some stuff out.

> On 14 Jan 2020, at 14:04, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Prior art:
>=20
>    Presentation
>    KVM Forum 2017: Towards a More Expressive and Introspectable QEMU
>    Command Line
>    https://www.youtube.com/watch?v=3DgtpOLQgnwug
>    https://www.linux-kvm.org/images/f/f2/Armbru-qapi-cmdline_1.pdf
>=20
>    RFC patches
>    https://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg00209.html
>    Message-Id: <20171002152552.27999-1-armbru@redhat.com>
>    https://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/qapi-cmdline

Very useful, thanks.

>=20
>> Compatibility is much harder, which is not the least because the
>> existing command line options are bad (primarily: using inconsistent
>> syntax).
>=20
> Semantics are just as problematic.

Yes, but often you can leverage something (e.g. JSON, XML, etc)

We could decide that the new QAPI language is a custom implementation
of Python ;-) Or more seriously, we could have some part of the JSON
schema that are =E2=80=9Cescapes=E2=80=9D to C code that we put in some gen=
erated file.
I used {{ }} below for this escape, in which case the semantics would be
that of C plus some specific macros we insert in it.

{ 'option': '--add-fd',
 'data': { 'fd': 'int', 'set': 'int', '*opaque': 'str' },
 'help': [
"-add-fd fd=3Dfd,set=3Dset[,opaque=3Dopaque]",
"                Add 'fd' to fd 'set'=E2=80=9D]=20
 =E2=80=98validate=E2=80=99 : {{
    error_if(QOPT.fd < 0, =E2=80=9Cfd option cannot be negative=E2=80=9D);
    error_if(QOPT.fd <=3D STDERR_FILENO, =E2=80=9Cfd cannot be a standard I=
/O stream=E2=80=9D);
 }},
 =E2=80=98exec=E2=80=99 : {{
    if (do_add_fd(QOPT.fd, QOPT.fset, QOPT.opaque) < 0) {
        exit(1);
    }
 }},

I=E2=80=99m not necessarily saying this is a good idea, mind you.

>=20
> You mean the qemu-options.hx.  qemu-options.def is generated from it.

Oh, I had missed that, thanks.

>>> or build configuration (there is a hint of the connection between
>>> the two in the option =E2=80=98if=E2=80=99 member in the .json files).
>=20
> I'm not sure what exactly you have in mind for build configuration.

I meant what you pointed out wrt. options, that this =E2=80=9Clanguage=E2=
=80=9D needs to
know about the qemu configuration. There is =E2=80=98if=E2=80=99 today, you=
 pointed
out arch-specific for options. But the configuration itself is yet
another =E2=80=9Clanguage=E2=80=9D with its own semantics=E2=80=A6 which JS=
ON knows
nothing about.

>=20
>>> In other words, the language I have in mind would be something
>>> that I could auto-generate from, say, the current qapi-schema.json
>>> and the qemu-options.def. Maybe in the end, that would be simply
>>> by having qemu-options.def being used to build qemu-options.json,
>>> and then add the relevant entries in qemu-options.json. Maybe
>>> there is a better way.
>>=20
>> I would rather say that .def should go away and its content should
>> be converted to a JSON schema that becomes the new source format rather
>> than an intermediate generated file. There is nothing in .def files that
>> couldn't be represented in the schema.
>=20
> Yes.

Agreed too. The meta-schema would need to be extended.

>>=20
>> To a certain degree, QAPI does just that, by supporting different data
>> types for options. If necessary, I'm sure the type system could be
>> extended, but it's not clear to me to which degree we actually need
>> this.
>=20
> QAPI is much more expressive than qemu-options.hx.  All the latter can
> do is "has option argument" and "option is arch-specific".  QAPI lets
> you specify an option argument's structure, and supports compile-time
> conditionals.  It can't do things like "must specify either argument A
> or B", or "numeric argument C must not exceed argument D", or "multiple
> options combine vs. last one wins".  Mostly because "it=E2=80=99s already
> complicated enough as is".

Understood.


>>=20
>> We could. But is it actually worth inventing a new programming language?
>> I think this is something that should be done in C code even in the
>> future. I think what we're looking for is a way to describe interfaces,
>> not implementations.
>=20
> Sane sugar can be described declaratively as macro expansion.
>=20
> Less than sane sugar takes code.
>=20
> Desugaring in code promotes (accidental) abandonment of sanity.
>=20
> That said, we have to keep things simple to succeed.  Declarative
> desugaring seems beyond our reach.

Well, =E2=80=9Ckeeping things simple=E2=80=9D is a complicated thing.

>=20
>> Even just for adding more sophisticated constraints, like in the example
>> above that maxmem >=3D size, it's questionable whether doing this in the
>> schema provides enough value for actually implementing it there.
>=20
> Yes.

If we do it, yes. If we delegate to an existing language (I showed C above)=
,
maybe it adds clarity without too much of an additional cost.

>=20
>>>> I think the only thing in this list that can't obviously be covered
>>>> easily by QAPI is QOM. Or rather, it's covered by passing through
>>>> key=3Dvalue lists without describing their structure
>>>=20
>>> That=E2=80=99s close enough to me. (In my mind, that part was already =
=E2=80=9Cdone=E2=80=9D
>>> by QAPI, even if in the convoluted way you describe)
>>=20
>> That's not really close enough. If you are happy with this level of
>> abstraction, you can define any command line option to be either a flag
>> or take a string as its argument and be done. This is obviously not very
>> helpful because it says nothing about the structure of that string.
>=20
> Similar to all QMP commands taking a single 'any' argument.

Hmmm, I guess I have not understood what you meant by
"QOM could not be covered easily by QAPI" then.

We don=E2=80=99t want the QAPI to let arbitrary fields of a QOM object
be modified, do we?

As for the =E2=80=9Cpublic=E2=80=9D aspects of a QOM object, that is static=
 if it
comes from QAPI, so why couldn=E2=80=99t we define it there?


>=20
>>                                                                    In
>> the same way, QAPI can't say anything about the structure of a QOM
>> object, and I think that's a problem.
>>=20
>>>> - which, as far as I
>>>> understand, is mainly because QOM properties aren't necessarily static=
,
>>>> so we can't provide a statically defined interface for them. Probably
>>>> solvable in QEMU, but not without a major effort.
>>>=20
>>> Or maybe extend the language so that it=E2=80=99s internal semantics
>>> knows about this aspect of QOM?
>>=20
>> My point is that for example you can't generate a C struct (which is
>> statically defined) from something that has a dynamic structure. The
>> best you could do is fall back to key=3Dvalue even in the C source, both
>> key and value being strings. But then you still have to parse these
>> strings manually, so it doesn't actually help much compared to a state
>> without C bindings.

I really don=E2=80=99t understand that point. To me, all these operations
seem relatively simple to generate.

I think that what confuses me is when you write =E2=80=9Csomething that has=
 a
dynamic structure=E2=80=9D. I understand that as referring to the structure
defined in the schema. But the schema itself is static. So you can
generate static code from it, and it=E2=80=99s already done today.

Another hypothesis on my side is that we don=E2=80=99t want, ever, to
have the API provide for example the option to create its own
arbitrary QOM classes, or to tag arbitrary properties to an object,
where by =E2=80=9Carbitrary=E2=80=9D I mean not explicitly mentioned somewh=
ere in
something like the schema.

So I suspect you are talking about something else.


>=20
> QOM and QAPI sabotage each other.  Ironic, considering they were dreamed
> up by the same guy :)
>=20
> QAPI is compile-time static by design.
>=20
> QOM is run-time dynamic by design.  Some support for static definitions
> has been grafted on since.
>=20
> We use QAPI type system escapes for QOM.  Defeats QAPI introspection and
> doc generation.  We provide separate QOM introspection instead, which is
> clumsier and less expressive.  QOM documentation doesn't exist.

But back to the original discussion about management tools,
do we let upper layers tag their own arbitrary stuff in QOM objects?


>=20
>> Maybe what could be done is covering at least the static properties and
>> then having key=3Dvalue for the dynamic part (which should be the
>> exception).
>=20
> To make this worthwhile, we'd have to replace dynamic QOM properties by
> static ones when possible.  Monumental task.

I=E2=80=99m sure you are right, but it=E2=80=99s hard for me to evaluate, g=
iven how
many ways there are to access an object. Naively, grepping for
set_prop and for new_with_prop does not give me that many hits.


>=20
>>>>> - Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=80=
=9Cderives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,
>>>>> =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=9C=
attaches to=E2=80=9D=E2=80=A6
>>>>> - States, e.g. how do we represent the machine configuration,
>>>>> or the desired new disk setting
>>>>> - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Cconnec=
t=E2=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
>>>>> =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we de=
scribe the kind of input they need.
>>>>> - Possibly more subtle things like support for transactions, commit/r=
ollback,
>>>>> i.e. =E2=80=9CI want to add connect a virtual nic to some host vf, bu=
t if anything
>>>>> along the way fails, I=E2=80=99d like all the cleanup to happen autom=
atically)
>>>>=20
>>>> This sounds like a different approach from our current QAPI command se=
t
>>>=20
>>> Well, except for purposefully trying to use a different wording to avoi=
d
>>> the risk of getting your mind stuck in one of the particular existing
>>> meta-languages in QEMU, the approach is not very different.
>>=20
>> I didn't necessarily mean relations/state/verbs, which obviously exist,
>> but the examples that seemed to express things in a deliberately
>> different way from what we have today.
>>=20
>>> - Transactions do not exist today that I know of, although we see
>>> signs of them in discussions about the fact that this options destroys
>>> that back end but that option does not.
>>=20
>> We have a 'transaction' QMP command, but they are not an integral part
>> of the language. Considering the trouble to implement transactional
>> commands, I suppose we don't even want it to be a fundamental part of
>> the language.
>>=20
>>>> Does it actually provide more functionality, though?
>>>=20
>>> It=E2=80=99s not intended to provide more, but to require less to do th=
e same thing.
>>=20
>> Though we always need to keep in mind that if requiring less for future
>> additions requires a huge effort now, the investment may pay off only in
>> a very distant future (if the abstraction we build even survives until
>> then).
>=20
> Worse is better.
>=20
> http://dreamsongs.com/RiseOfWorseIsBetter.html

You know that I positively hate this ;-)

Well, I guess we can expand the schema. #ILoveJSON.


Thanks
Christophe



