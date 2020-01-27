Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD8A24679
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mu405pqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD8A24679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9iP-0005m0-RX
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iw9hN-0004u3-Ah
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iw9hK-0004qd-4Y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23683
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iw9hJ-0004pU-8p
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580151920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sPoA2ydAQoLizKedPf2KzFJv1XJIB0Kou7QTXHKikc=;
 b=Mu405pqfqI8o5rbIyfl6EYjGusWtNqp6fY9tbYJqL2xDHhQC2VvjV39YOmXFeJpt1ERWIK
 BRro3gIwVHDuZzBtLAYw64RNrKZXsr7p1hXoHCIRrgvVJWp4/oX1LRC9zVllPukUlAyFhT
 pWN+pcZVaijhrd/Q5IBfFaVIKo3inW4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-RYiLkGxfMDarXMun7P8AGA-1; Mon, 27 Jan 2020 14:05:18 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so6663451wrw.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=RhACkVO/W7XiLN8LGh5WECTBKRKMmkgfpG5ujrP+dwE=;
 b=ODzJF1OaEjAjn2REzsZJIQF/6Yqk/do/ktsoceR6OCn7PLhzJhpIJkiEE2N74KjiCh
 vx46qIiRSpz1KaYHbcuEpqObuVtvn7hwaDQ66PIab3Vkc/szCcafVLjnAYB2/852xZM6
 vIUvKhhN3vtpUOnQbqTPRhZDGuL5dc/9qCsa2RTrrw7O39bALdE7yGMuc6Z79i8+fdnR
 jxdQZWwx2QJb3fG+qDqFS8wLpP5BYIcR2OKhYuwY7WWinYhM6ms21qXrrLN8luuZade1
 WEp11CtoxvA6uWuG1zvmKk/b1a0Ajd6z5kJxKeByeQInVyqpwiueR4xiPcfCaMsOCf/C
 kuaA==
X-Gm-Message-State: APjAAAVj6+2BVOS4gz+6myqH0MgziM1ZgD6Q0EoswgzrnfeWhsMSFc5T
 MjJu3kl2FkROOMaorx0QBSPM8GH8Z+74pOGsKP2K9R94zRTZQhIqEQwmnp6n0Cykgze2kaKLzSE
 A3tud8J1tTQQbhj8=
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr24531686wrn.351.1580151916522; 
 Mon, 27 Jan 2020 11:05:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDYiJFyYYefPTYsBVKwYiAoJr8KWNKcZX9/U2gEY8TgCZk2eAzMGpiCpg5rxwgJPLxrX7aEQ==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr24531652wrn.351.1580151916086; 
 Mon, 27 Jan 2020 11:05:16 -0800 (PST)
Received: from [10.200.153.205] ([213.175.37.12])
 by smtp.gmail.com with ESMTPSA id b67sm20388348wmc.38.2020.01.27.11.05.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jan 2020 11:05:14 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Integrating QOM into QAPI
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <0e08d426-dc2a-d373-86f3-f2cc22694b74@redhat.com>
Date: Mon, 27 Jan 2020 20:05:13 +0100
Message-Id: <82B69BF4-B34B-4B76-81AD-2DE789C9F9EA@redhat.com>
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
 <0e08d426-dc2a-d373-86f3-f2cc22694b74@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: RYiLkGxfMDarXMun7P8AGA-1
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
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 26 Jan 2020, at 17:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 26/01/20 10:11, Marc-Andr=C3=A9 Lureau wrote:
>>> I=E2=80=99m still puzzled as to why anybody would switch to something l=
ike
>>> GObject when there is C++.
>> C++ is another level of complexity.
>>=20
>> Replacing QOM with GObject would mainly bring us a more solid type
>> system with better tooling/features, gobject-introspection support,
>> and remove the burden of having our own OO from QEMU code base.
>=20
> In fact, C++ doesn't solve any of the problems that either QOM or
> GObject try to solve.  (Neither does Rust for that matter).

It does not solve all of them _easily_. I do believe that any solution
to these problems can be engineered in C++, if only because C++
is essentially a superset of C. The question is whether the result can
be made easier / safer to use and generally more elegant. I believe
that the answer is yes, see proof at end of mail.

However, before going further, glib offers way more than gobject.
So there=E2=80=99s that too=E2=80=A6 And I=E2=80=99m not saying migrating t=
o C++ is a good
idea, I=E2=80=99m just trying to evaluate the various options fairly.


> Nevertheless, there is no stupid question, only stupid answers, and I
> think Christophe's remark is an example of a common misconception.  In
> the hope of not making this a stupid answer, let my try to formulate
> succinctly what I think the differences are between QOM, GObject and the
> C++ object model:

Thank you for this remarkably non-stupid answer ;-) You have really
isolated, in very clear terms, the essence of the discussion.

>=20
> - the C++ object model (at least "old-style" C++ with virtual functions
> and the like) provides you with _the intersection_ of what QOM and
> GObject try to solve.  This is what Marc-Andr=C3=A9 calls "OO", and it's
> essentially virtual functions and dynamic casts.  It's a relatively
> small part of both QOM and GObject, and unfortunately a wheel that
> almost every large C program ends up reinventing.

This was the part I was pointing to in my initial comment.

C++ solves that basic =E2=80=9COO=E2=80=9D stuff well, and goes a little be=
yond QOM
or GObject in offering IMO many other benefits, e.g. wrt type safety.

>=20
> - Marc-Andr=C3=A9 also described above what GObject provides: a fully
> introspectable type system and the tools so that _libraries_ can define
> _types that will be used from multiple programming languages_.

This kind of things has existed for a very long time. CORBA dates back
to 1991. Also, I=E2=80=99m not sure how important multiple programming lang=
uages
are for the qemu use-case. I believe that what matters more is remotely
accessible objects (e.g. over a socket), which in turn makes it almost
trivial to call from another language as long as you accept some kind
of serialization / deserialization process along the way.

GObject only seems marginally better for the =E2=80=9Cin same process=E2=80=
=9D use case,
in the sense that it makes =E2=80=9Cobjects=E2=80=9D that can be used from =
any language,
indeed, but at the cost of being somewhat foreign and weird in all language=
s,
including C.

Look at the GClosure marshalling, for example, and compare it with the
example I give you at end of this email, and you tell me which one looks
easier and safer to use.

>=20
> - QOM also provides a fully introspectable type system, but with a
> different focus: it's so that _objects_ can expose _properties that will
> be accessed from multiple channels_.

Exposing the properties and making them introspectable are the
fundamental feature we need to discuss. So agreement here.

What you have not explained to my satisfaction
yet is how GObject is a better starting point for re-creating a new
externally-accessible API than some kind of wrapper built in C++
and taking advantage of modern C++ features.


> Everything else in both GObject and QOM follows from this core purpose,
> and the differences between the two follow from the differences.  For
> example:
>=20
> - GObject's focus on multiple programming languages:
> gobject-introspection, GClosure, support for non-object types (scalar
> and GBoxed)

How much of that is actually useful to create a new usable qemu API?

>=20
> - QOM's focus on objects: dynamic properties, object tree, all types are
> classes

That, to me, looks fundamental, since not having it would require
a total re-architecture of the rest of qemu.

But it looks also somewhat trivial to implement in C++.
For example, obj[=E2=80=9Cid=E2=80=9D] could return a PropertyAccessor<T>
that lets you read or write the object knowing that it is of type
T, so you could write:

=09if (my_object[=E2=80=9Cid=E2=80=9D] < 3) // Automatically checks the typ=
e

or=20

=09my_object[=E2=80=9Cid=E2=80=9D] =3D 42;

The latter would call PropertyAccessor<int>::operator=3D(int), which
in turn would check if property =E2=80=9Cid=E2=80=9D exists in my_object, i=
f it has type
=E2=80=9Cint=E2=80=9D, and so on.

Implementation-wise, a simple std::map of BaseProperty pointers,
where each would be an instance of some

=09template<class T>
=09class Property : public BaseProperty
=09{
=09=09operator T(); // get
=09=09T& operator=3D(const T&); // set
=09};

=09template<class T, class Index>
=09class PropertyAccessor
=09{
=09=09PropertyAccessor(PropertyOwner<T> &owner, Index &index) : owner(owner=
), index(index) {}
=09=09operator T() { return owner[index]; }
=09=09T& operator =3D(const T&val) { return owner[index] =3D val; }
=09};

> - QOM's focus on properties: no introspection of methods

OK. So I=E2=80=99m giving a bad example below, because I=E2=80=99m introspe=
cting
a method, but=E2=80=A6 ;-)

> - QOM's support for multiple channels: visitors

How different are visitors from iterators in C++? Sorry, showing my
ignorance here=E2=80=A6=20


I do not fully understand all the subtleties of QOM, nor all its use cases.
However, my own experience with =E2=80=9Cmodern=E2=80=9D C++ shows that it=
=E2=80=99s pretty
straightforward to get it to do extremely interesting introspective work.

As an illustration, which happens to be directly related to the problem
of interconnecting with another language, I would like to share the followi=
ng
tidbit of code (https://github.com/c3d/xl/blob/master/src/runtime.cpp#L73).

Tree *  xl_evaluate(Scope *scope, Tree *tree)
// ------------------------------------------------------------------------=
----
//   Dispatch evaluation to the main entry point
// ------------------------------------------------------------------------=
----
{
    return MAIN->Evaluate(scope, tree);
}
XL_NATIVE(evaluate);

With this little XL_NATIVE macro, the compiler automatically makes the
function xl_evaluate available to the XL language as =E2=80=9Cevaluate=E2=
=80=9D, with
the correct parameter sets. In particular:

- It inserts an object representing xl_evaluate in a list of all native fun=
ctions
- It generates a function that generates the source-code interface,
  which in XL would look like `evaluate A:scope, B:tree as tree`,
  see record #28601 in the output below. Note that this includes=20
  all the required type conversions (e.g. from `Tree *` to `tree`).
- It generates a function that generates a machine-level prototype
  using LLVM, i.e. it automatically all the LLVM calls required to declare
    Tree *xl_evaluate(Scope *scope, Tree *tree);
- It generates a function that acts as a wrapper around it and calls
  the prototype above, doing the necessary type conversions.

Here is an example of output at run-time:
> xl -tnative -O3
[=E2=80=A6]
[26809 0.007432] native: Entering prototype for same_text shape 0x111a3f540=
 [same_text A:tree, B:text as boolean]
[27021 0.007512] native: Shape 1 infix 0x111615d28 [tree] : 0x111ac8838 [A]=
 =3D 0x111a94af0 [A:tree]
[27213 0.007630] native: Return shape (one) 0x111615d28 [tree]
[27274 0.007651] native: Native shape 1 0x111a94aa8 [A:tree as tree] return=
 0x111615d28 [tree]
[27447 0.007708] native: Entering prototype for stack_overflow shape 0x111a=
3f510 [stack_overflow A:tree as tree]
[27595 0.007784] native: Shape 1 infix 0x111615c10 [scope] : 0x111ac87c8 [A=
] =3D 0x111a94a60 [A:scope]
[27795 0.007844] native: Shape 2 infix 0x111615d28 [tree] : 0x111ac8790 [B]=
 =3D 0x111a94a18 [B:tree]
[27991 0.007897] native: Shape 2 (...) 0x111a94a60 [A:scope],0x111a94a18 [B=
:tree] =3D 0x111a949d0 [A:scope, B:tree]
[28303 0.007985] native: Return shape (...) 0x111615d28 [tree]
[28364 0.008014] native: Native shape 2 0x111a94988 [A:scope, B:tree as tre=
e] return 0x111615d28 [tree]
[28601 0.008077] native: Entering prototype for evaluate shape 0x111a3f4e0 =
[evaluate A:scope, B:tree as tree]
[=E2=80=A6]

What I believe makes my point is that this is achieved with 476 lines of C+=
+
(admittedly not the simplest C++ on earth, but still not super-complex eith=
er)
If you are curious, this is done by https://github.com/c3d/xl/blob/master/i=
nclude/native.h.

So in 500 lines of C++ code, we have something that automatically turns any=
 C function into
a wrapper object that:
- Gives you introspected type information about the parameters and return t=
ype of the function
- Gives you directly-accessible methods that operate on that function in a =
type-safe way

The same approach could of course offer serialization, construction of obje=
cts, etc.

So to me, this proves that introspecting an API in C++ is not just =E2=80=
=9Ceasy=E2=80=9D, it is highly usable.


Cheers,
Christophe

PS: Again, I=E2=80=99m not necessarily advocating we start writing any C++ =
code.
I=E2=80=99m just trying to understand the value proposition of GObject, QOM=
, etc,
in order to make a more informed decision before doing anything.

>=20
> Paolo
>=20


