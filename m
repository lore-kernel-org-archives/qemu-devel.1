Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EC9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5491F20848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RpvpC7zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5491F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfex-0003If-7G
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kBfGf-0005Iw-Uf; Fri, 28 Aug 2020 10:22:14 -0400
Received: from mout.web.de ([212.227.15.14]:39035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kBfGc-0005YY-RE; Fri, 28 Aug 2020 10:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598624523;
 bh=GOP/1i5s4LEm39BzLINUFTGBh+Kzxo61hu8aGXaWR6E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=RpvpC7zBqrERHxmKYm+5uKsuZf96DfZfaHUbXXnozgch4h9dfqDM/WVBvzpx+7yQ8
 qzPYgAd2mE1BtqIchvTRVTr2JnouPZdpcXGJiSX4Vx7JqcPzRPDdYODwXmilcTkv82
 6hS0SP+h4/F6fqDNMx10vIS+p2wkc6f429DqhF9M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.134]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MaJc8-1jrwYN1IKm-00Jrr1; Fri, 28
 Aug 2020 16:22:03 +0200
Date: Fri, 28 Aug 2020 16:21:45 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v7 1/8] Introduce yank feature
Message-ID: <20200828162145.21d082af@luklap>
In-Reply-To: <871rjs9ser.fsf@dusky.pond.sub.org>
References: <cover.1596528468.git.lukasstraub2@web.de>
 <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
 <871rjs9ser.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BrmbCTzCnw0zXIxt0z_i.JT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Fjd+wfXLHL7j0489B3wF4G8T+P3KHmssbJERnuDUK3MboNEmfnx
 PFOdxD+bmSyquXogGCejaWCI0VK8SniYKsLQFcGcO6V+JguvRpqwKeUgG2l+oUO5y+RxhLm
 ZVsbD3ZJllL8Nhg4BlOKa7QbSJYco0BHO4W8TDbxl7rUqla7Cg8mlUII+lWkcljLrP5Q0Kr
 +HhoaUTfwOClif38fV56A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S/9WKTsAA7Y=:dR6KOZ5c7eE9UYlMQkiTWI
 foB1zgPbjzSSLyFlArc38UyElfIxNfRNbA4iPC4VTShZI6efuBjoRsfwLOIXbhay3OcTIEE1L
 ncWyioYr00u1aErq2FxFkBaeVCediiCsG6kFzVql6JntWGk3aIq4Nvp3b+zHUgk5fb8AmlCLX
 lp0qSy7D07aJss3JAI8rt+QC5WDWHyXTHjtz38GK1jIiy34UTCFaahghoWFmSBR6ose8TMjvA
 n7KctIbVVgecIuzo4Olu7uWCwECPyrPxsmemLNZXyyOlKpAFT18LU8xDITtuj0ChFLZB7ubeG
 ZfsQju2sdZb+QV30tidHu+JJnW9fES7s6l/i9Pn5EiTi3E/MoEYSkhtwBI+US4DGfvNP2ewIB
 h61IA9rhfgHNYJRV/3pcDISWOpLb+K8nKvXTB9ESw/I9x92bn8vGcNhN+bZ6IipgX4wxwNKMX
 tiWzMLn1V0U2eWFTbpez68koC1QJQATRvmhsgIHOam7/zI+oRNLcYw7aSk6BHGaLPtm+pzSP1
 JMh4NArXmsW5MXkhJTAeZPzoNGpQRdK/U4AiEUtsu5I1uNO2GX3fkWujDW9iwLaWew16zbvR6
 8htNtFgkNBPstL0FW/6LirxwvjnzdYaiMaUYNwPeJ3FsufMxy30CSrZb5iwu4svNZB3fZQcXG
 IUN2HvFpjHeXRqnwIJtCQRyx0wsBGGYzW/nJeh1Mxs12TdquB2PbpVHly1CmpALGH3/obvFlC
 fFh+7DQUSiqN+xaHHJalViWRvE4EAaKh0kJyose0ssnXQf47g7aXSDHLeotn6JMaSqKtpfrMB
 fOSXRjGC5aP6AHOl/6j9m8ZShtuElzEJDezlNTy4qf4oKhrLtb7i3cpLRSdUZdqudAFxogozj
 HOunAmgpc5au8oco7r9flX2azzy+DReWnJVS3lhbQq/QRXAozKdg3jhSh41QaeSs67wnmiOXa
 FIm9kQeYEtt4yQkCWumd8R8zaFBmW2OVmUIT0GLUa47OKCh4+mHHnNRe4q2L4T250Faf7Twgz
 SWdrHgQJNhrp/RcnjB9ws+YTE/N9Fhf+Ay4FjIJNZU2YZj1qtZ4sbiVUb7mC2r3n5lqJZj6oa
 vCuCdXMx/bUxvatagCVMKGx5rf8S+rXd3DEXQGX5Agr4CuevbI09+drkvohCDjduVs4d4GEnp
 5h4Gh0aNS8IsC/A0fk5OFM36/rkPCDRrnlftDEsiA3UVCFn5lYjqIB/PVE5OXA7NFZVzQfCma
 GQyj1NnDdc1Py1SNcSguX8wUQEnNzXvksLOzrfQ==
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 10:22:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/BrmbCTzCnw0zXIxt0z_i.JT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Aug 2020 14:37:00 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> I apologize for not reviewing this much earlier.
>=20
> Lukas Straub <lukasstraub2@web.de> writes:
>=20
> > The yank feature allows to recover from hanging qemu by "yanking"
> > at various parts. Other qemu systems can register themselves and
> > multiple yank functions. Then all yank functions for selected
> > instances can be called by the 'yank' out-of-band qmp command.
> > Available instances can be queried by a 'query-yank' oob command.
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/qemu/yank.h |  80 +++++++++++++++++++
> >  qapi/misc.json      |  45 +++++++++++
> >  util/Makefile.objs  |   1 +
> >  util/yank.c         | 184 ++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 310 insertions(+)
> >  create mode 100644 include/qemu/yank.h
> >  create mode 100644 util/yank.c
> >
> > diff --git a/include/qemu/yank.h b/include/qemu/yank.h
> > new file mode 100644
> > index 0000000000..cd184fcd05
> > --- /dev/null
> > +++ b/include/qemu/yank.h
> > @@ -0,0 +1,80 @@
> > +/*
> > + * QEMU yank feature
> > + *
> > + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef YANK_H
> > +#define YANK_H
> > +
> > +typedef void (YankFn) (void *opaque); =20
>=20
> No space before parameter lists, please.

Ok, I will fix this in the next version.

> > +
> > +/**
> > + * yank_register_instance: Register a new instance.
> > + *
> > + * This registers a new instance for yanking. Must be called before an=
y yank
> > + * function is registered for this instance.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The globally unique name of the instance.
> > + * @errp: ...
> > + */
> > +void yank_register_instance(const char *instance_name, Error **errp);
> > +
> > +/**
> > + * yank_unregister_instance: Unregister a instance.
> > + *
> > + * This unregisters a instance. Must be called only after every yank f=
unction
> > + * of the instance has been unregistered.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The name of the instance.
> > + */
> > +void yank_unregister_instance(const char *instance_name);
> > +
> > +/**
> > + * yank_register_function: Register a yank function
> > + *
> > + * This registers a yank function. All limitations of qmp oob commands=
 apply
> > + * to the yank function as well. =20
>=20
> The restrictions are documented in docs/devel/qapi-code-gen.txt under
> "An OOB-capable command handler must satisfy the following conditions".
> Let's point there,

I will fix this in the next version.

> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The name of the instance
> > + * @func: The yank function
> > + * @opaque: Will be passed to the yank function
> > + */
> > +void yank_register_function(const char *instance_name,
> > +                            YankFn *func,
> > +                            void *opaque); =20
>=20
> Pardon my ignorance... can you explain to me why a yank instance may
> have multiple functions?
>
> > +
> > +/**
> > + * yank_unregister_function: Unregister a yank function
> > + *
> > + * This unregisters a yank function.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance_name: The name of the instance
> > + * @func: func that was passed to yank_register_function
> > + * @opaque: opaque that was passed to yank_register_function
> > + */
> > +void yank_unregister_function(const char *instance_name,
> > +                              YankFn *func,
> > +                              void *opaque);
> > +
> > +/**
> > + * yank_unregister_function: Generic yank function for iochannel =20
>=20
> Pasto, should be
>=20
>     * yank_generic_iochannel: ...

I will fix this in the next version.

> > + *
> > + * This is a generic yank function which will call qio_channel_shutdow=
n on the
> > + * provided QIOChannel.
> > + *
> > + * @opaque: QIOChannel to shutdown
> > + */
> > +void yank_generic_iochannel(void *opaque);
> > +#endif
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 9d32820dc1..0d6a8f20b7 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1615,3 +1615,48 @@
> >  ##
> >  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
> >
> > +##
> > +# @YankInstances:
> > +#
> > +# @instances: List of yank instances.
> > +#
> > +# Yank instances are named after the following schema:
> > +# "blockdev:<node-name>", "chardev:<chardev-name>" and "migration"
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } } =20
>=20
> I'm afraid this is a problematic QMP interface.
>=20
> By making YankInstances a struct, you keep the door open to adding more
> members, which is good.
>=20
> But by making its 'instances' member a ['str'], you close the door to
> using anything but a single string for the individual instances.  Not so
> good.
>=20
> The single string encodes information which QMP client will need to
> parse from the string.  We frown on that in QMP.  Use QAPI complex types
> capabilities for structured data.
>=20
> Could you use something like this instead?
>=20
> { 'enum': 'YankInstanceType',
>   'data': { 'block-node', 'chardev', 'migration' } }
>=20
> { 'struct': 'YankInstanceBlockNode',
>   'data': { 'node-name': 'str' } }
>=20
> { 'struct': 'YankInstanceChardev',
>   'data' { 'label': 'str' } }
>=20
> { 'union': 'YankInstance',
>   'base': { 'type': 'YankInstanceType' },
>   'discriminator': 'type',
>   'data': {
>       'block-node': 'YankInstanceBlockNode',
>       'chardev': 'YankInstanceChardev' } }
>=20
> { 'command': 'yank',
>   'data': { 'instances': ['YankInstance'] },
>   'allow-oob': true }
>=20
> If you're confident nothing will ever be added to YankInstanceBlockNode
> and YankInstanceChardev, you could use str instead.

As Daniel said, this has already been discussed.

> > +
> > +##
> > +# @yank:
> > +#
> > +# Recover from hanging qemu by yanking the specified instances. =20
>=20
> What's an "instance", and what does it mean to "yank" it?
>=20
> The documentation of YankInstances above gives a clue on what an
> "instance" is: presumably a block node, a character device or the
> migration job.
>=20
> I guess a YankInstance is whatever the code chooses to make one, and the
> current code makes these three kinds.
>=20
> Does it make every block node a YankInstance?  If not, which ones?
>=20
> Does it make every character device a YankInstance?  If not, which ones?
>=20
> Does it make migration always a YankInstance?  If not, when?

The yank function is generic so anything more specific than "instance"
doesn't fit. But you are right, I'll improve the documentation here and
list what is currently implemented for yanking and what yanking does in
each case.

> > +#
> > +# Takes @YankInstances as argument.
> > +#
> > +# Returns: nothing.
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "yank", "arguments": { "instances": ["blockdev:nbd0"=
] } }
> > +# <- { "return": {} }
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'command': 'yank', 'data': 'YankInstances', 'allow-oob': true }
> > +
> > +##
> > +# @query-yank:
> > +#
> > +# Query yank instances.
> > +#
> > +# Returns: @YankInstances
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "query-yank" }
> > +# <- { "return": { "instances": ["blockdev:nbd0"] } }
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'command': 'query-yank', 'returns': 'YankInstances', 'allow-oob': tr=
ue }
> > diff --git a/util/Makefile.objs b/util/Makefile.objs
> > index cc5e37177a..13faa98425 100644
> > --- a/util/Makefile.objs
> > +++ b/util/Makefile.objs
> > @@ -45,6 +45,7 @@ util-obj-$(CONFIG_GIO) +=3D dbus.o
> >  dbus.o-cflags =3D $(GIO_CFLAGS)
> >  dbus.o-libs =3D $(GIO_LIBS)
> >  util-obj-$(CONFIG_USER_ONLY) +=3D selfmap.o
> > +util-obj-y +=3D yank.o
> >
> >  #######################################################################
> >  # code used by both qemu system emulation and qemu-img
> > diff --git a/util/yank.c b/util/yank.c
> > new file mode 100644
> > index 0000000000..b0cd27728b
> > --- /dev/null
> > +++ b/util/yank.c
> > @@ -0,0 +1,184 @@
> > +/*
> > + * QEMU yank feature
> > + *
> > + * Copyright (c) Lukas Straub <lukasstraub2@web.de>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/thread.h"
> > +#include "qemu/queue.h"
> > +#include "qapi/qapi-commands-misc.h"
> > +#include "io/channel.h"
> > +#include "qemu/yank.h"
> > +
> > +struct YankFuncAndParam {
> > +    YankFn *func;
> > +    void *opaque;
> > +    QLIST_ENTRY(YankFuncAndParam) next;
> > +};
> > +
> > +struct YankInstance {
> > +    char *name;
> > +    QLIST_HEAD(, YankFuncAndParam) yankfns;
> > +    QLIST_ENTRY(YankInstance) next;
> > +};
> > +
> > +static QemuMutex lock; =20
>=20
> Please give the variable a more telling name, such as @yank_lock, and
> document what exactly the lock protects.  I can guess it's just the list
> that immediately follows, but I prefer to be explicit when it comes to
> locking.

I will fix this in the next version.

> > +static QLIST_HEAD(yankinst_list, YankInstance) head
> > +    =3D QLIST_HEAD_INITIALIZER(head); =20
>=20
> Please give the variable a more telling name, such as
> @yank_instance_list.
>=20
> I doubt there is a need to name the struct.  This should do:
>=20
>    static QLIST_HEAD(, YankInstance) yank_instance_list

I will fix this in the next version.

> > +
> > +static struct YankInstance *yank_find_instance(const char *name)
> > +{
> > +    struct YankInstance *tmp, *instance;
> > +    instance =3D NULL;
> > +    QLIST_FOREACH(tmp, &head, next) {
> > +        if (!strcmp(tmp->name, name)) {
> > +            instance =3D tmp;
> > +        }
> > +    }
> > +    return instance;
> > +} =20
>=20
> Suggest
>=20
>    static struct YankInstance *yank_find_instance(const char *name)
>    {
>        struct YankInstance *instance;
>=20
>        QLIST_FOREACH(instance, &head, next) {
>            if (!strcmp(instance->name, name)) {
>                return instance;
>            }
>        }
>        return NULL;
>    }

I will fix this in the next version.

> > +
> > +void yank_register_instance(const char *instance_name, Error **errp)
> > +{
> > +    struct YankInstance *instance;
> > +
> > +    qemu_mutex_lock(&lock);
> > +
> > +    if (yank_find_instance(instance_name)) {
> > +        error_setg(errp, "duplicate yank instance name: '%s'", instanc=
e_name); =20
>=20
> Rather long line, suggest to wrap before the last argument.

I will fix this in the next version.

> > +        qemu_mutex_unlock(&lock);
> > +        return;
> > +    }
> > +
> > +    instance =3D g_slice_new(struct YankInstance);
> > +    instance->name =3D g_strdup(instance_name);
> > +    QLIST_INIT(&instance->yankfns);
> > +    QLIST_INSERT_HEAD(&head, instance, next);
> > +
> > +    qemu_mutex_unlock(&lock);
> > +}
> > +
> > +void yank_unregister_instance(const char *instance_name)
> > +{
> > +    struct YankInstance *instance;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    instance =3D yank_find_instance(instance_name);
> > +    assert(instance);
> > +
> > +    assert(QLIST_EMPTY(&instance->yankfns));
> > +    QLIST_REMOVE(instance, next);
> > +    g_free(instance->name);
> > +    g_slice_free(struct YankInstance, instance);
> > +
> > +    qemu_mutex_unlock(&lock);
> > +}
> > +
> > +void yank_register_function(const char *instance_name,
> > +                            YankFn *func,
> > +                            void *opaque)
> > +{
> > +    struct YankInstance *instance;
> > +    struct YankFuncAndParam *entry;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    instance =3D yank_find_instance(instance_name);
> > +    assert(instance);
> > +
> > +    entry =3D g_slice_new(struct YankFuncAndParam);
> > +    entry->func =3D func;
> > +    entry->opaque =3D opaque;
> > +
> > +    QLIST_INSERT_HEAD(&instance->yankfns, entry, next);
> > +    qemu_mutex_unlock(&lock);
> > +}
> > +
> > +void yank_unregister_function(const char *instance_name,
> > +                              YankFn *func,
> > +                              void *opaque)
> > +{
> > +    struct YankInstance *instance;
> > +    struct YankFuncAndParam *entry;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    instance =3D yank_find_instance(instance_name);
> > +    assert(instance);
> > +
> > +    QLIST_FOREACH(entry, &instance->yankfns, next) {
> > +        if (entry->func =3D=3D func && entry->opaque =3D=3D opaque) {
> > +            QLIST_REMOVE(entry, next);
> > +            g_slice_free(struct YankFuncAndParam, entry);
> > +            qemu_mutex_unlock(&lock);
> > +            return;
> > +        }
> > +    }
> > +
> > +    abort();
> > +}
> > +
> > +void yank_generic_iochannel(void *opaque)
> > +{
> > +    QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> > +
> > +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> > +}
> > +
> > +void qmp_yank(strList *instances,
> > +              Error **errp)
> > +{
> > +    strList *tmp;
> > +    struct YankInstance *instance;
> > +    struct YankFuncAndParam *entry;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    tmp =3D instances;
> > +    for (; tmp; tmp =3D tmp->next) { =20
>=20
> Make that
>=20
>        for (tail =3D instances; tail; tail =3D tail->next) {

I will fix this in the next version.

> > +        instance =3D yank_find_instance(tmp->value);
> > +        if (!instance) {
> > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > +                      "Instance '%s' not found", tmp->value);
> > +            qemu_mutex_unlock(&lock);
> > +            return;
> > +        }
> > +    }
> > +    tmp =3D instances;
> > +    for (; tmp; tmp =3D tmp->next) { =20
>=20
> Likewise.
>=20
> > +        instance =3D yank_find_instance(tmp->value);
> > +        assert(instance);
> > +        QLIST_FOREACH(entry, &instance->yankfns, next) {
> > +            entry->func(entry->opaque);
> > +        }
> > +    }
> > +    qemu_mutex_unlock(&lock);
> > +}
> > +
> > +YankInstances *qmp_query_yank(Error **errp)
> > +{
> > +    struct YankInstance *instance;
> > +    YankInstances *ret;
> > +
> > +    ret =3D g_new0(YankInstances, 1);
> > +    ret->instances =3D NULL;
> > +
> > +    qemu_mutex_lock(&lock);
> > +    QLIST_FOREACH(instance, &head, next) {
> > +        strList *entry;
> > +        entry =3D g_new0(strList, 1);
> > +        entry->value =3D g_strdup(instance->name);
> > +        entry->next =3D ret->instances;
> > +        ret->instances =3D entry;
> > +    }
> > +    qemu_mutex_unlock(&lock);
> > +
> > +    return ret;
> > +}
> > +
> > +static void __attribute__((__constructor__)) yank_init(void)
> > +{
> > +    qemu_mutex_init(&lock);
> > +}
> > --
> > 2.20.1 =20
>=20
> The two QMP commands permit out-of-band execution ('allow-oob': true).
> OOB is easy to get wrong, but I figure you have a legitimate use case.
> Let's review the restrictions documented in
> docs/devel/qapi-code-gen.txt:
>=20
>     An OOB-capable command handler must satisfy the following conditions:
>=20
>     - It terminates quickly.
>     - It does not invoke system calls that may block.
>     - It does not access guest RAM that may block when userfaultfd is
>       enabled for postcopy live migration.
>     - It takes only "fast" locks, i.e. all critical sections protected by
>       any lock it takes also satisfy the conditions for OOB command
>       handler code.
>=20
> Since the command handlers take &lock, the restrictions apply to the
> other critical sections protected by &lock as well.  I believe these are
> all okay: they do nothing but allocate, initialize and free memory.
>=20
> The restrictions also apply to the YankFn callbacks, but you documented
> that.  Okay.
>=20
> The one such callback included in this patch is
> yank_generic_iochannel(), which is a thin wrapper around
> qio_channel_shutdown(), which in turn runs the io_shutdown method.
> Thus, the restructions also apply to all the io_shutdown methods.
> That's not documented.
>=20
> Daniel, should it be documented?
>=20
This is already done in patch 6.

Thank you for you review.

Regards,
Lukas Straub

--Sig_/BrmbCTzCnw0zXIxt0z_i.JT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9JEvkACgkQNasLKJxd
slgXsQ/+L/kHaLz6AB//ocZ7smVyILj9Ak6qzLkfk8s4j7/Oy/TXqc0FpUKLw+qC
e3+FEOuqG2eRvqP8ndUu2Z1CRZRBCnscJV9DLgQ49CLHvDGxYwmZtfEx1UI5WPWp
q1s5wgznhP+FJ0iXzL3+3TctBJdD3j/SQlpJL+oyOSZ5tT5h2UScXIp/Sdp6Wz1H
TkjRs2wav/wjywHJCZltk+au8YSPFZYeNvwrDbNXx1evvtbRCAUN538SUNbPW5G5
Fx90eA5i2JZOy/Rdbblw3NtHjK2TGaVrT/RAbT2lq68n6/YV9VzW1IM4PohWEa6B
QH8Ba7Zch9VyQKxw7BwzvDHftciWFVhTh12JalkCarh8/8snx4vj30/S7Ufc9XQ+
k8+lrPMoPqcEOl5i/s8vrUfhQc72d1xkZ8CjvPfL0ODX75NB99nNpm49gxUWsOxK
Ps9cr1APE0Szjm8JSMT7XtH4rsBdWfzbrTjhEg2bNdbZDJQX5cTXs2XWiPoRDreD
eMVDmpcOQEgN7kPftYbYPklnwqUWgV0z3NgebtCztQ1oqUsK8xWoRfskCXR29gxX
fluNF3ixlCzhH+GEkmC0g+oRBk34P6pJFb4eNR8angux07OUJm2FVnBJ2KhZGbS9
aA5XGGjVtpSg+Q9MHp9oqCep55a49jqt0DPGDMo/2rpJOl37veI=
=XFhF
-----END PGP SIGNATURE-----

--Sig_/BrmbCTzCnw0zXIxt0z_i.JT--

