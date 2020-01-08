Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B14C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17BA205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlQUhASn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17BA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip8p6-0007zn-47
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ip8o6-0007LU-6C
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ip8o4-0005v2-Jr
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:43:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25586
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ip8o4-0005uf-Fn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578480200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9OL3CDtYBg3eGfjdHP6WSJMsZsXrHcxAiFDgM7eYdM=;
 b=OlQUhASnpls2sDYfqsVy9MVRxr4IDFC6KVHrFtEgHLRtZmA0Vyb9RUGzL1moNcpqG9QRZJ
 hjU9rg7ihzfx+cd0123mKtM57Sn4bFvmt5Ak4maJIr1VlVODa6IbtAo/+igwG+t/ELssba
 tOl9rUN45aDF+cl86WH3cCD2VTkaz9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-W59PJjEONb-M9UIYWgeKaw-1; Wed, 08 Jan 2020 05:43:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FA878C8B40;
 Wed,  8 Jan 2020 10:43:17 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 753AD9A84;
 Wed,  8 Jan 2020 10:43:07 +0000 (UTC)
Date: Wed, 8 Jan 2020 11:43:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: W59PJjEONb-M9UIYWgeKaw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.01.2020 um 18:11 hat Christophe de Dinechin geschrieben:
> So I think that it might help, in the long run, to start defining the
> language in question in some abstract way, and then to have rules
> for how to transform that abstract language into concrete bindings.

I think this abstract language is QAPI. The problem is that we're not
even close to using QAPI for everything. Adding a new language on top of
QAPI instead isn't going to make the conversion process any faster.

> This definition itself is not obvious (at least not to me). For
> example, do we have, anywhere but in the C code, the specification
> of how one can add a disk to qemu, and what it means?
> Say, looking at qemu-options.def, how do I tell that -hda has
> anything to do with -device or -blockdev or -help?

BlockdevOptions in the QAPI schema is what tells you how it _really_
works. The connection to the various command line syntaxes isn't defined
in a declarative way because we don't have a QAPIfied command line yet.
I know that Markus wants to work on this, but I don't know how much time
he actually has to invest in it.

> I think that the following piece of code from vl.c is revealing:
>=20
>             case QEMU_OPTION_hda:
>             case QEMU_OPTION_hdb:
>             case QEMU_OPTION_hdc:
>             case QEMU_OPTION_hdd:
>                 drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, opta=
rg,
>                           HD_OPTS);
>                 break;
>             case QEMU_OPTION_blockdev:
>                 {
>                     Visitor *v;
>                     BlockdevOptionsQueueEntry *bdo;
>=20
>                     v =3D qobject_input_visitor_new_str(optarg, "driver",
>                                                       &error_fatal);
>=20
>                     bdo =3D g_new(BlockdevOptionsQueueEntry, 1);
>                     visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
>                                                &error_fatal);
>                     visit_free(v);
>                     loc_save(&bdo->loc);
>                     QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
>                     break;
>                 }
>             case QEMU_OPTION_drive:
>                 if (drive_def(optarg) =3D=3D NULL) {
>                     exit(1);
>                 }
>                 break;
>=20
> Here, we have three cases related to disks in a way or another,
> and three entirely different ways of doing things.

I would say two different ways because drive_add() is just a small
wrapper around drive_def() that overrides a few options.

Describing the semantics of the -drive way is hard. This is one of the
reasons why I would love to get rid of it and replace it with a new
user-friendly option that has a more direct mapping to the -blockdev
way, which in turn just is BlockdevOptions mapped 1:1 to the command
line.

> AFAICT, qemu already created several meta-languages to define
> several aspects of the API, from qemu-options.def to qapi-schema.json.
> But maybe at some point we need to go meta once more, and define
> a language defining the API from which we could automatically
> derive the various bindings, including FFI-style bindings for Rust and Go=
,
> as well as some internal data structures. Ideally, that meta-definition
> is something that could be shared between libvirt and qemu so that they
> literally speak the same language. Or that could be used to automatically
> build a REST interface.

I think adding an output for additional languages to the QAPI generator
shouldn't be too hard. It already creates multiple things from a single
schema (C data structures and command wrappers, schema introspection
data, documentation, and probably other things that I forgot).

libvirt already speaks QAPI, however without reusing the schema and the
generator from QEMU.

> A big issue, though, is that of compatibility. Doing the above starting
> from scratch does not seem that complicated. Doing it in a way that
> preserves a minimum of interoperability with earlier-generation
> software is another ordeal.

Indeed, this is the major reason why QAPI isn't as pervasive as it
should be.

> So I think that Daniel is right. We may need at some point to start
> a NEMU-style offshoot that does not attempt to be compatible,
> but explores describing an increasing surface of the API using a
> new meta-language from which we can generate, in a consistent
> way, at least:
>=20
> - C bindings
> - Command-line options
> - Shell bindings (or =E2=80=9CHMP=E2=80=9D)
> - JSON schema or qom description
> - Bindings in other languages (Rust, Go, Python)
> - Networked versions of the API (socket, REST)
> - Client-side code e.g. for libvirt.
> - Serialization / deserialization, e.g. for configuration files
> - Documentation, including man page and API docs
> - Command-line help

I think the only thing in this list that can't obviously be covered
easily by QAPI is QOM. Or rather, it's covered by passing through
key=3Dvalue lists without describing their structure - which, as far as I
understand, is mainly because QOM properties aren't necessarily static,
so we can't provide a statically defined interface for them. Probably
solvable in QEMU, but not without a major effort. In a fork that doesn't
care about compatibility, it should be easier.

> At the most fundamental level, I think we need to describe:
>=20
> - Values, e.g. how we represent names, sizes, paths, etc, possibly
> with some user-friendly aspects, e.g. path shortcuts, memory units,
> spelling shortcuts (e.g. being able to consistently say -blo for -blockde=
v
> if that=E2=80=99s the shortest option that matches)

I don't think user-friendly shortcuts on the command line are "most
fundamental". Whether to accept -blo is an implementation detail of the
command line parser which translates a bunch of strings into QAPI
objects.

> - Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=80=9Cd=
erives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,
> =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=9Catta=
ches to=E2=80=9D=E2=80=A6
> - States, e.g. how do we represent the machine configuration,
> or the desired new disk setting
> - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Cconnect=E2=
=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
> =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we descri=
be the kind of input they need.
> - Possibly more subtle things like support for transactions, commit/rollb=
ack,
> i.e. =E2=80=9CI want to add connect a virtual nic to some host vf, but if=
 anything
> along the way fails, I=E2=80=99d like all the cleanup to happen automatic=
ally)

This sounds like a different approach from our current QAPI command set
(use a smaller set of operations that can work with a greater variety of
objects).

Does it actually provide more functionality, though?

Kevin


