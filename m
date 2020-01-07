Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E9DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:12:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44212073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Faaz+Q07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44212073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosPM-00041d-HS
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iosOC-0002oW-Kc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iosOA-0001Tl-HV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:11:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iosOA-0001TL-C0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578417089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqM5k9cplZrMLejuxnH1rK9KynvzjsaeVnM8UO0lLuA=;
 b=Faaz+Q07Ob3xzlA41fVkMrdtt3Edjq9zg9eBjBk7RIKz/rHmJ2/zcIgucizXQb+aMSGHdz
 0A25XzLFTqT7fG3bvQO32LzA5xq+eJoEY+uv8J2IuQXZKsZCtOajLkTPO7VuiC62qE9yXv
 O2DoxUBay2cPXadTCotMm0Aa+9Cs3Ws=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-JpUw6X_iMU2F8bMgfPoOEQ-1; Tue, 07 Jan 2020 12:11:23 -0500
Received: by mail-wr1-f69.google.com with SMTP id i9so222626wru.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 09:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=cL/4ApnQs4mKcBEyQOL51IbfhdOQoqnSP6bk2On4vlE=;
 b=IbgCAonyuPFl0GxfGnbd4Twqk+li6EnkJEKSDrcMbrO97JjDWpod7uli+4KI+V8tGn
 Udg0IMwajOei2lpijO8mlFIqShQ186Wr3l/wjr7THQE+EyMylHM9D1wBrnEQZ+4wjJxN
 6zhLBJrrHdcI0i0rK86sJNeYPXetGmmPwqpuY3prINKzzC/84isV2WyUvkzqU6bYdGJl
 XLW7aZgaJBfneGp/U/nOj9/yb/L31fVj4/bou8h9IvAkWelwcvDIE8A4trrmDe+oPWl1
 YhAR3ppmG5wUJX53oxVwsS9c45KGzL3EY90w3NUk98mp+d01meRnDkUTEBhNLXOPbdNF
 UTqw==
X-Gm-Message-State: APjAAAU8+pNmdui5KMDR1tifCcn8kBft7eAy8HKdXFPpxlQcK4+wNVd+
 OCeaoDj3YV5Fyx6lvwK+kAclJIhZI7XxauMW64D8O+k5qgZymY2zWVMvffsw9TyNz5a0FGa1yyn
 crVk0JHZDP+jvXM0=
X-Received: by 2002:adf:8297:: with SMTP id 23mr29699wrc.379.1578417081073;
 Tue, 07 Jan 2020 09:11:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpwvmvtm0gKMVLdmz9FjFghyQ2AzMrxuJHmF9BiZBMnyZ7islEqcpQh31GWbbaLycjslJI9A==
X-Received: by 2002:adf:8297:: with SMTP id 23mr29663wrc.379.1578417080632;
 Tue, 07 Jan 2020 09:11:20 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:8d4b:4003:dcb:4c70?
 ([2a01:e0a:466:71c0:8d4b:4003:dcb:4c70])
 by smtp.gmail.com with ESMTPSA id r5sm563387wrt.43.2020.01.07.09.11.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 09:11:20 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Making QEMU easier for management tools and applications
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
Date: Tue, 7 Jan 2020 18:11:13 +0100
Message-Id: <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-MC-Unique: JpUw6X_iMU2F8bMgfPoOEQ-1
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
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,



> On 20 Dec 2019, at 17:13, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>=20
> Hi,
> QEMU presents a command-line interface and QMP monitor for
> applications to interact with.  Applications actually need API
> bindings in their programming language.  Bindings avoid reimplementing
> code to spawn a QEMU process and interact with QMP.  QEMU is kind of
> lazy and de facto relies on libvirt for API bindings.
>=20
> Is it time for better QEMU APIs?

I hear that often ;-)

After catching up with this thread, I think that there is a common,
intuitive sense that a number of topics are interconnected and
relate to the QEMU API, from command-line to language bindings
to sandboxing to configuration files, and even to rewriting in Rust=E2=80=
=A6

A good question is: why do we believe that? Thinking about it, it=E2=80=99s
not entirely obvious, is it, that a C API has anything to do with a
configuration file, is it?

(I _believe_ that it is true, but I=E2=80=99m trying to explore why our int=
uition
tells us so)

My gut feeling at this point is that we are not talking about an API,
we are first talking about a _language_, with relatively complicated
and loosely defined semantics. There are signs of this language
everywhere, from some custom object-model to several distinct
syntaxen (from ever-more-complex command-line options to JSON).
In order to see what I mean with =E2=80=9Crelatively complicated semantics=
=E2=80=9D,
see the recent discussions about -hda vs. -drive vs. -device vs. -blockdev=
=E2=80=A6

It does not help that a large fraction of this language is used to describe
graphs, e.g. network or bus topology. Textual languages make it
notoriously difficult to describe graphs, forcing us to add intermediate
user-provided names e.g. to interconnect a guest device and the
associated host resource, or to precisely define how guest NICs
connect to various virtual networks or host interface cards.

We then have several dialects of what should be, at least conceptually,
the same language, including, but not limited, to an XML dialect, a virsh
dialect, a command-line dialect, a qmp dialect, a JSON dialect that is
partially incorporated in several of the above, etc=E2=80=A6

Of note, several tools, including virsh, git, OpenShift or dnf, have starte=
d
moving away from the simple =E2=80=9Clist of switches=E2=80=9D towards havi=
ng sub-commands.
Some, like virsh, even switch to =E2=80=9Cshell mode=E2=80=9D if called wit=
hout arguments.
So maybe qemu should enter =E2=80=9Cshell mode=E2=80=9D if given no argumen=
t, and
accept a command file as input=E2=80=A6 If only there was no backward
compatibility issue=E2=80=A6

So I think that it might help, in the long run, to start defining the
language in question in some abstract way, and then to have rules
for how to transform that abstract language into concrete bindings.
This definition itself is not obvious (at least not to me). For
example, do we have, anywhere but in the C code, the specification
of how one can add a disk to qemu, and what it means?
Say, looking at qemu-options.def, how do I tell that -hda has
anything to do with -device or -blockdev or -help?

I think that the following piece of code from vl.c is revealing:

            case QEMU_OPTION_hda:
            case QEMU_OPTION_hdb:
            case QEMU_OPTION_hdc:
            case QEMU_OPTION_hdd:
                drive_add(IF_DEFAULT, popt->index - QEMU_OPTION_hda, optarg=
,
                          HD_OPTS);
                break;
            case QEMU_OPTION_blockdev:
                {
                    Visitor *v;
                    BlockdevOptionsQueueEntry *bdo;

                    v =3D qobject_input_visitor_new_str(optarg, "driver",
                                                      &error_fatal);

                    bdo =3D g_new(BlockdevOptionsQueueEntry, 1);
                    visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
                                               &error_fatal);
                    visit_free(v);
                    loc_save(&bdo->loc);
                    QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
                    break;
                }
            case QEMU_OPTION_drive:
                if (drive_def(optarg) =3D=3D NULL) {
                    exit(1);
                }
                break;

Here, we have three cases related to disks in a way or another,
and three entirely different ways of doing things.

AFAICT, qemu already created several meta-languages to define
several aspects of the API, from qemu-options.def to qapi-schema.json.
But maybe at some point we need to go meta once more, and define
a language defining the API from which we could automatically
derive the various bindings, including FFI-style bindings for Rust and Go,
as well as some internal data structures. Ideally, that meta-definition
is something that could be shared between libvirt and qemu so that they
literally speak the same language. Or that could be used to automatically
build a REST interface.

A big issue, though, is that of compatibility. Doing the above starting
from scratch does not seem that complicated. Doing it in a way that
preserves a minimum of interoperability with earlier-generation
software is another ordeal.

So I think that Daniel is right. We may need at some point to start
a NEMU-style offshoot that does not attempt to be compatible,
but explores describing an increasing surface of the API using a
new meta-language from which we can generate, in a consistent
way, at least:

- C bindings
- Command-line options
- Shell bindings (or =E2=80=9CHMP=E2=80=9D)
- JSON schema or qom description
- Bindings in other languages (Rust, Go, Python)
- Networked versions of the API (socket, REST)
- Client-side code e.g. for libvirt.
- Serialization / deserialization, e.g. for configuration files
- Documentation, including man page and API docs
- Command-line help

At the most fundamental level, I think we need to describe:

- Values, e.g. how we represent names, sizes, paths, etc, possibly
with some user-friendly aspects, e.g. path shortcuts, memory units,
spelling shortcuts (e.g. being able to consistently say -blo for -blockdev
if that=E2=80=99s the shortest option that matches)
- Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=80=9Cder=
ives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,
=E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=9Cattach=
es to=E2=80=9D=E2=80=A6
- States, e.g. how do we represent the machine configuration,
or the desired new disk setting
- Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Cconnect=E2=
=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
=E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we describe=
 the kind of input they need.
- Possibly more subtle things like support for transactions, commit/rollbac=
k,
i.e. =E2=80=9CI want to add connect a virtual nic to some host vf, but if a=
nything
along the way fails, I=E2=80=99d like all the cleanup to happen automatical=
ly)


>=20
> 1. We have qapi-schema.json.  Let's render to HTML and publish
> versioned documentation online.

Added =E2=80=9CDocumentation=E2=80=9D above to make sure this is preserved.
I agree with the assessment that the existing commenting state
is not good enough to make this that valuable at this point.
Notably missing are all the relation aspects.


>=20
> 2. scripts/qmp/ contains command-line tools for QMP communication.
> They could use some polish and then be shipped.

Shouldn=E2=80=99t we first identify what they do and how to use them? ;-)

>=20
> 3. python/qemu/ contains Python modules for managing a QEMU process
> and QMP communication.  This should be packaged in distros and
> available on PyPI.

That is probably somewhat independent from the rest, although
in my =E2=80=9Cmeta=E2=80=9D model, we should certainly be able to also gen=
erate
some python bindings.

>=20
> 4. Go and Rust bindings would also be useful.  There is
> https://github.com/intel/govmm but I think it makes sense to keep it
> in qemu.git and provide an interface similar to our Python modules.

Same comment as above.

>=20
> 5. A jailer is needed to isolate the QEMU process and vhost-user
> device backends using seccomp, Linux namespaces, and maybe
> SELinux/AppArmor.  We used to be able to rely on libvirt for QEMU
> security, but it's becoming a common task for any device backend and
> IMO should be its own launcher tool.

I believe that this =E2=80=9Cjailer=E2=80=9D comment is interesting. It=E2=
=80=99s not really
related to a refactoring of APIs, it looks more like an API that we
forgot because libvirt did it, and we now realize that this may not
be the right place for some use cases.

>=20
> 6. A configuration file format is sorely needed so that guest
> configuration can be persisted and easily launched.  Today you have to
> create a shell script that executes a QEMU command-line, but this is
> suboptimal because sharing executable scripts is dangerous from a
> security perspective and is hard to parse or modify programmatically.

Agreed. That=E2=80=99s one reason why I started talking about a =E2=80=9Cla=
nguage=E2=80=9D above.


> In many of these areas we already have a partial solution.  It just
> needs more work.  I think it would be worth the effort and the mental
> shift to really providing APIs that are easy to use by applications.
>=20
> What do you think?

Overall, I think this is not a simple problem.

>=20
> Have I missed things that are needed?

The main one for me is the meta-language I talked about above.

>=20
> Have I included things that are unnecessary?

No, but some of the things that you included surprised me in an =E2=80=9CAP=
I=E2=80=9D
discussion, and that=E2=80=99s what launched me in this =E2=80=9Cmeta-langu=
age=E2=80=9D direction.


>=20
> Stefan
>=20


