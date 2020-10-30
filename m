Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F79C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:38:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C7020704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LSgoBWyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C7020704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRnt-0004EW-Nu
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYRhw-0006zv-Pi; Fri, 30 Oct 2020 06:32:32 -0400
Received: from mout.web.de ([212.227.15.4]:42257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYRht-0003LS-6B; Fri, 30 Oct 2020 06:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604053941;
 bh=g8q3CIyQfnKFKIwamfX9kEJ1EadIKEfSicCEd7dTTc8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LSgoBWytzzkKly9TbSdxOxV3q7EMhCqnjd45fB8uvnzg06TffqZrm26hRfDfMILzS
 8Iq5mLA7uagzO9U/i+17EgMVxoJq1qSYhTrCEd98gJ7tY1OTe4priOKOJfnel7Ynxy
 YJ2WAKtotCK9LelfvBSd+QQPgr5M26+Kw7MC1OdM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFhe-1juAw30ra6-00eFVT; Fri, 30
 Oct 2020 11:32:21 +0100
Date: Fri, 30 Oct 2020 11:32:12 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v9 1/8] Introduce yank feature
Message-ID: <20201030113212.37ddf1fb@luklap>
In-Reply-To: <87a6w556rl.fsf@dusky.pond.sub.org>
References: <cover.1603909658.git.lukasstraub2@web.de>
 <7b3b182b6ab1a859a1e9fb4ebfa5ce0a7a441e10.1603909658.git.lukasstraub2@web.de>
 <87a6w556rl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TYZin2oQ7bIZL6QbR0Alv3E";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:8pR7MzaovnQg2Tv28ei8/a4tBffAq5xJEqZad96aMNmoU3eoxau
 bsZiV+rznzgzh54hAYaW788iD1kK4nx9GhZuiSleoTh1j6FKa9AClPAng52AOsbR3383uks
 Rs4Q7heDCBKNDiE5dHNH5zIMei4t9JwLzTLH0XcJ37UgKaeXkMaS+qdJFY+ycgNURm1eYi3
 uysQnVYqG2qcI9X/Jl7Ew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7dZ1M99ihiY=:sSzhIMwsKi5/bn3XX0xUPL
 BRJoo9D9EFBrNDMwmbOtwluQG2xCHAxZBIFicFPI16OxvqQDzt+cspkrG+y302GDvlZoYs8Ew
 SIIKQmGGqta6lJ0DmStwmx6gOl68ADQV7tkiV8K6K5ZeBhZUeaO5fzikuhO5Z8G4xecae64Fg
 xbV+DT6MtVTrU7qI0tBRkGxgaIkjOyzQs8VKpP7vNOhSKZvEofqKBOsH2Ccg18crbOxyQLeUB
 EwBQtdXO3Rao4BEg0ro/bLokKOqYqTMRejkO3suJxFU9l3H0FhCMf3QjyUqzmUI72oheNp5fl
 9f2GQvvnJEsNDRU9RktTTmhY3fYQ89cqATSd5WLFABpUgI8czLkAnVXh2fVDdNflvlCTfzYNi
 dcwIeMRk9uOQUfPwRz0xJWXIampRUecBNwTt9M4zoM0ZDbDRfLbbxWaJ4wYQYlWtEzH2a9qLl
 /T3QTSkfxPFGKqPQ317twz0OiuURh5TBvXYYgrjU4a0txRB2gzdRcVo8w7bH9DvTJb3E/drAw
 4KUXcPYrJwugrrHER5gdNB6/st9hQFo2hqVpoJFzfPo8hxPXVqqa06Lahul2lyUNxkD/ULMQM
 ib6+UpwMRgQuz5N44xFVNswELT5SvJdwDf6HbgotP/qvWNYU3WXeJCOpflHrvU3XH90EXVTee
 6/FMYsGQdEXY9nsYbl1BOPWOm6XURGGARyZ4Wn+fgQpm7UC5oWFMGCXXQXG3TY9NJXkSaAy9f
 2NR774WVtw6h7AOfuR04E2yT8uYXnbKTeYuyfOveo3QJIk6c6Dd4jzQUVrbv7IiSP56jTh5sK
 x6GP4u9F1trANACRndNyhruZyEvAQ6TZerdCctvptfgdJlLbZD4Hdm96tWKxY1OqK6jSZ1ANA
 7rfxxZqGdqIpy8E9nj6g==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 06:32:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--Sig_/TYZin2oQ7bIZL6QbR0Alv3E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2020 17:36:14 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Nothing major, looks almost ready to me.
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
> >  include/qemu/yank.h |  95 ++++++++++++++++++++
> >  qapi/misc.json      | 106 ++++++++++++++++++++++
> >  util/meson.build    |   1 +
> >  util/yank.c         | 213 ++++++++++++++++++++++++++++++++++++++++++++=
 =20
>=20
> checkpatch.pl warns:
>=20
>     WARNING: added, moved or deleted file(s), does MAINTAINERS need updat=
ing?
>=20
> Can we find a maintainer for the two new files?

Yes, I'm maintaining this for now, see patch 7.

> >  4 files changed, 415 insertions(+)
> >  create mode 100644 include/qemu/yank.h
> >  create mode 100644 util/yank.c
> >
> > diff --git a/include/qemu/yank.h b/include/qemu/yank.h
> > new file mode 100644
> > index 0000000000..89755e62af
> > --- /dev/null
> > +++ b/include/qemu/yank.h
> > @@ -0,0 +1,95 @@
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
> > +#include "qapi/qapi-types-misc.h"
> > +
> > +typedef void (YankFn)(void *opaque);
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
> > + * @instance: The instance.
> > + * @errp: Error object.
> > + */
> > +void yank_register_instance(const YankInstance *instance, Error **errp=
);
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
> > + * @instance: The instance.
> > + */
> > +void yank_unregister_instance(const YankInstance *instance);
> > +
> > +/**
> > + * yank_register_function: Register a yank function
> > + *
> > + * This registers a yank function. All limitations of qmp oob commands=
 apply
> > + * to the yank function as well. See docs/devel/qapi-code-gen.txt under
> > + * "An OOB-capable command handler must satisfy the following conditio=
ns".
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance: The instance.
> > + * @func: The yank function.
> > + * @opaque: Will be passed to the yank function.
> > + */
> > +void yank_register_function(const YankInstance *instance,
> > +                            YankFn *func,
> > +                            void *opaque);
> > +
> > +/**
> > + * yank_unregister_function: Unregister a yank function
> > + *
> > + * This unregisters a yank function.
> > + *
> > + * This function is thread-safe.
> > + *
> > + * @instance: The instance.
> > + * @func: func that was passed to yank_register_function.
> > + * @opaque: opaque that was passed to yank_register_function.
> > + */
> > +void yank_unregister_function(const YankInstance *instance,
> > +                              YankFn *func,
> > +                              void *opaque);
> > +
> > +/**
> > + * yank_generic_iochannel: Generic yank function for iochannel
> > + *
> > + * This is a generic yank function which will call qio_channel_shutdow=
n on the
> > + * provided QIOChannel.
> > + *
> > + * @opaque: QIOChannel to shutdown
> > + */
> > +void yank_generic_iochannel(void *opaque);
> > +
> > +#define BLOCKDEV_YANK_INSTANCE(the_node_name) (&(YankInstance) { \
> > +        .type =3D YANK_INSTANCE_TYPE_BLOCKDEV, \
> > +        .u.blockdev.node_name =3D (the_node_name) })
> > +
> > +#define CHARDEV_YANK_INSTANCE(the_id) (&(YankInstance) { \
> > +        .type =3D YANK_INSTANCE_TYPE_CHARDEV, \
> > +        .u.chardev.id =3D (the_id) })
> > +
> > +#define MIGRATION_YANK_INSTANCE (&(YankInstance) { \
> > +        .type =3D YANK_INSTANCE_TYPE_MIGRATION })
> > +
> > +#endif
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 40df513856..3b7de02a4d 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -568,3 +568,109 @@
> >   'data': { '*option': 'str' },
> >   'returns': ['CommandLineOptionInfo'],
> >   'allow-preconfig': true }
> > +
> > +##
> > +# @YankInstanceType:
> > +#
> > +# An enumeration of yank instance types. See "YankInstance" for more =
=20
>=20
> Please write cross-references as @YankInstance.  This gives us a chance
> to turn them into links (seems not to be implemented, yet).  More of the
> same below.

Changed for the next version.

> > +# information.
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'enum': 'YankInstanceType',
> > +  'data': [ 'blockdev', 'chardev', 'migration' ] }
> > +
> > +##
> > +# @YankInstanceBlockdev:
> > +#
> > +# Specifies which blockdev to yank. See "YankInstance" for more inform=
ation.
> > +#
> > +# @node-name: the blockdev's node-name =20
>=20
> Is this really about block devices?  A node-name identifies a block
> graph node, which may or may not be associated with a block device.
>=20
> If I understand PATCH 2 correctly, it makes *any* block node with driver
> 'nbd' yankable while it has a network connection.  If that's true, then
> this is definitely about block graph nodes, not about block devices.

Indeed, changed for the next version.

> If it is about devices, let's say "block device", not "blockdev".
>=20
> If it is about nodes, let's say "block graph node".  Also rename
> YankInstanceType member 'blockdev' by 'block-node', YankInstanceBlockdev
> to YankInstanceBlockNode.
>=20
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'struct': 'YankInstanceBlockdev',
> > +  'data': { 'node-name': 'str' } }
> > +
> > +##
> > +# @YankInstanceChardev:
> > +#
> > +# Specifies which chardev to yank. See "YankInstance" for more informa=
tion. =20
>=20
> "character device", not "chardev".

Changed for the next version.

> > +#
> > +# @id: the chardev's ID
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'struct': 'YankInstanceChardev',
> > +  'data': { 'id': 'str' } } =20
>=20
> This is called 'label' in @ChardevInfo.  It's also called 'id' in
> @chardev-add.  Oh well, 'id' it is.
>=20
> > +
> > +##
> > +# @YankInstance:
> > +#
> > +# A yank instance can be yanked with the "yank" qmp command to recover=
 from a
> > +# hanging qemu. =20
>=20
> QEMU
>=20
> > +#
> > +# Currently implemented yank instances:
> > +#  -nbd block device:
> > +#   Yanking it will shutdown the connection to the nbd server without
> > +#   attempting to reconnect.
> > +#  -socket chardev:
> > +#   Yanking it will shutdown the connected socket.
> > +#  -migration:
> > +#   Yanking it will shutdown all migration connections. =20
>=20
> To my surprise, this is recognized as bullet list markup.  But please
> put a space between the bullet and the text anyway.
>=20
> Also: "shutdown" is a noun, the verb is spelled "shut down".

Both changed for the next version.

> In my review of v8, I asked how yanking migration is related to command
> migrate_cancel.  Daniel explained:
>=20
>     migrate_cancel will do a shutdown() on the primary migration socket o=
nly.
>     In addition it will toggle the migration state.
>=20
>     Yanking will do a shutdown on all migration sockets (important for
>     multifd), but won't touch migration state or any other aspect of QEMU
>     code.
>=20
>     Overall yanking has less potential for things to go wrong than the
>     migrate_cancel method, as it doesn't try to do any kind of cleanup
>     or migration.
>=20
> Would it make sense to work this into the documentation?

How about this?

  - migration:
    Yanking it will shut down all migration connections. Unlike
    @migrate_cancel, it will not notify the migration process,
    so migration will go into @failed state, instead of @cancelled
    state.

> > +#
> > +# Since: 5.2
> > +##
> > +{ 'union': 'YankInstance',
> > +  'base': { 'type': 'YankInstanceType' },
> > +  'discriminator': 'type',
> > +  'data': {
> > +      'blockdev': 'YankInstanceBlockdev',
> > +      'chardev': 'YankInstanceChardev' } }
> > +
> > +##
> > +# @yank:
> > +#
> > +# Recover from hanging qemu by yanking the specified instances. See =20
>=20
> QEMU
>=20
> "Try to recover" would be more precise, I think.

Changed for the next version.

> > +# "YankInstance" for more information.
> > +#
> > +# Takes a list of @YankInstance as argument.
> > +#
> > +# Returns: nothing.
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "yank",
> > +#      "arguments": {
> > +#          "instances": [
> > +#               { "type": "block-node",
> > +#                 "node-name": "nbd0" }
> > +#          ] } }
> > +# <- { "return": {} }
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'yank',
> > +  'data': { 'instances': ['YankInstance'] },
> > +  'allow-oob': true }
> > +
> > +##
> > +# @query-yank:
> > +#
> > +# Query yank instances. See "YankInstance" for more information.
> > +#
> > +# Returns: list of @YankInstance
> > +#
> > +# Example:
> > +#
> > +# -> { "execute": "query-yank" }
> > +# <- { "return": [
> > +#          { "type": "block-node",
> > +#            "node-name": "nbd0" }
> > +#      ] }
> > +#
> > +# Since: 5.2
> > +##
> > +{ 'command': 'query-yank',
> > +  'returns': ['YankInstance'],
> > +  'allow-oob': true }
> > diff --git a/util/meson.build b/util/meson.build
> > index c5159ad79d..dbda9d9123 100644
> > --- a/util/meson.build
> > +++ b/util/meson.build
> > @@ -50,6 +50,7 @@ endif
> >
> >  if have_system
> >    util_ss.add(when: 'CONFIG_GIO', if_true: [files('dbus.c'), gio])
> > +  util_ss.add(files('yank.c'))
> >  endif
> >
> >  if have_block
> > diff --git a/util/yank.c b/util/yank.c
> > new file mode 100644
> > index 0000000000..0b3a816706
> > --- /dev/null
> > +++ b/util/yank.c
> > @@ -0,0 +1,213 @@
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
> > +#include "qapi/qapi-visit-misc.h"
> > +#include "qapi/clone-visitor.h"
> > +#include "io/channel.h"
> > +#include "qemu/yank.h"
> > +
> > +struct YankFuncAndParam {
> > +    YankFn *func;
> > +    void *opaque;
> > +    QLIST_ENTRY(YankFuncAndParam) next;
> > +};
> > +
> > +struct YankInstanceEntry {
> > +    YankInstance *instance;
> > +    QLIST_HEAD(, YankFuncAndParam) yankfns;
> > +    QLIST_ENTRY(YankInstanceEntry) next;
> > +};
> > +
> > +typedef struct YankFuncAndParam YankFuncAndParam;
> > +typedef struct YankInstanceEntry YankInstanceEntry;
> > +
> > +/*
> > + * This lock protects the yank_instance_list below. =20
>=20
> Please add something like
>=20
>     * Because it's taken by OOB-capable commands, it must be "fast",
>     * i.e. it may only be held for a bounded, short time.  See
>     * docs/devel/qapi-code-gen.txt for additional information.

Changed for the next version.

> > + */
> > +static QemuMutex yank_lock;
> > +
> > +static QLIST_HEAD(, YankInstanceEntry) yank_instance_list
> > +    =3D QLIST_HEAD_INITIALIZER(yank_instance_list);
> > +
> > +static int yank_compare_instances(const YankInstance *a, const YankIns=
tance *b)
> > +{
> > +    if (a->type !=3D b->type) {
> > +        return 0;
> > +    }
> > +
> > +    switch (a->type) {
> > +    case YANK_INSTANCE_TYPE_BLOCKDEV:
> > +        return !strcmp(a->u.blockdev.node_name, b->u.blockdev.node_nam=
e);
> > +    break;
> > +
> > +    case YANK_INSTANCE_TYPE_CHARDEV:
> > +        return !strcmp(a->u.chardev.id, b->u.chardev.id);
> > +    break;
> > +
> > +    case YANK_INSTANCE_TYPE_MIGRATION:
> > +        return 1;
> > +    break;
> > +
> > +    default:
> > +        abort();
> > +    }
> > +} =20
>=20
> Please make this function return bool.  When a comparison function
> returns int, I expect it to return negative value when less, zero when
> equal, and positive value when greater.

Changed for the next version.

> > +
> > +static YankInstanceEntry *yank_find_entry(const YankInstance *instance)
> > +{
> > +    YankInstanceEntry *entry;
> > +
> > +    QLIST_FOREACH(entry, &yank_instance_list, next) {
> > +        if (yank_compare_instances(entry->instance, instance)) {
> > +            return entry;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +void yank_register_instance(const YankInstance *instance, Error **errp)
> > +{
> > +    YankInstanceEntry *entry;
> > +
> > +    qemu_mutex_lock(&yank_lock);
> > +
> > +    if (yank_find_entry(instance)) {
> > +        error_setg(errp, "duplicate yank instance"); =20
>=20
> How could this ever be anything but a programming error?
>=20
> If it is a programming error, use assert(), just like you do in
> yank_unregister_instance() below.

The chardev code initializes the chardev-socket which in turn initiates the
connection, before checking for duplicate id. So we'll have to catch it her=
e.

>=20
> > +        qemu_mutex_unlock(&yank_lock);
> > +        return;
> > +    }
> > +
> > +    entry =3D g_slice_new(YankInstanceEntry); =20
>=20
> Why not g_new()?  Hmm, GLib documentation says
>=20
>     For newly written code it is recommended to use the new g_slice API
>     instead of g_malloc() and friends, as long as objects are not
>     resized during their lifetime and the object size used at allocation
>     time is still available when freeing.
>=20
> I see.
>=20
> > +    entry->instance =3D QAPI_CLONE(YankInstance, instance); =20
>=20
> You clone so the callers can build the argument on the stack.  Another
> way to skin this cat: caller builds on the heap, this function takes
> ownership.  But we're at v9, and your code should work just fine :)

This makes the code simpler in the later patches.

> > +    QLIST_INIT(&entry->yankfns);
> > +    QLIST_INSERT_HEAD(&yank_instance_list, entry, next);
> > +
> > +    qemu_mutex_unlock(&yank_lock);
> > +}
> > +
> > +void yank_unregister_instance(const YankInstance *instance)
> > +{
> > +    YankInstanceEntry *entry;
> > +
> > +    qemu_mutex_lock(&yank_lock);
> > +    entry =3D yank_find_entry(instance);
> > +    assert(entry);
> > +
> > +    assert(QLIST_EMPTY(&entry->yankfns));
> > +    QLIST_REMOVE(entry, next);
> > +    qapi_free_YankInstance(entry->instance);
> > +    g_slice_free(YankInstanceEntry, entry);
> > +
> > +    qemu_mutex_unlock(&yank_lock);
> > +}
> > +
> > +void yank_register_function(const YankInstance *instance,
> > +                            YankFn *func,
> > +                            void *opaque)
> > +{
> > +    YankInstanceEntry *entry;
> > +    YankFuncAndParam *func_entry;
> > +
> > +    qemu_mutex_lock(&yank_lock);
> > +    entry =3D yank_find_entry(instance);
> > +    assert(entry);
> > +
> > +    func_entry =3D g_slice_new(YankFuncAndParam);
> > +    func_entry->func =3D func;
> > +    func_entry->opaque =3D opaque;
> > +
> > +    QLIST_INSERT_HEAD(&entry->yankfns, func_entry, next);
> > +    qemu_mutex_unlock(&yank_lock);
> > +}
> > +
> > +void yank_unregister_function(const YankInstance *instance,
> > +                              YankFn *func,
> > +                              void *opaque)
> > +{
> > +    YankInstanceEntry *entry;
> > +    YankFuncAndParam *func_entry;
> > +
> > +    qemu_mutex_lock(&yank_lock);
> > +    entry =3D yank_find_entry(instance);
> > +    assert(entry);
> > +
> > +    QLIST_FOREACH(func_entry, &entry->yankfns, next) {
> > +        if (func_entry->func =3D=3D func && func_entry->opaque =3D=3D =
opaque) {
> > +            QLIST_REMOVE(func_entry, next);
> > +            g_slice_free(YankFuncAndParam, func_entry);
> > +            qemu_mutex_unlock(&yank_lock);
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
> > +void qmp_yank(YankInstanceList *instances,
> > +              Error **errp)
> > +{
> > +    YankInstanceList *tail;
> > +    YankInstanceEntry *entry;
> > +    YankFuncAndParam *func_entry;
> > +
> > +    qemu_mutex_lock(&yank_lock);
> > +    for (tail =3D instances; tail; tail =3D tail->next) {
> > +        entry =3D yank_find_entry(tail->value);
> > +        if (!entry) {
> > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Instance no=
t found"); =20
>=20
> Quote error.h:
>=20
>  * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
>  * strongly discouraged.
>=20
> Any particular reason for ERROR_CLASS_DEVICE_NOT_FOUND?  If not, then
> error_setg(), please.

There may be a time-to-check to time-to-use race condition here. Suppose
the management application (via QMP) calls 'blockev-del nbd0', then QEMU
hangs, so after a timeout it calls 'yank nbd0' while shortly before that
QEMU unhangs for some reason and removes the blockdev. Then yank returns
this error.

QMP errors should not be parsed except for the error class, so the the
management application can only differentiate between this (ignorable)
error and other (possibly fatal) ones by parsing the error class.

>=20
> > +            qemu_mutex_unlock(&yank_lock);
> > +            return;
> > +        }
> > +    }
> > +    for (tail =3D instances; tail; tail =3D tail->next) {
> > +        entry =3D yank_find_entry(tail->value);
> > +        assert(entry);
> > +        QLIST_FOREACH(func_entry, &entry->yankfns, next) {
> > +            func_entry->func(func_entry->opaque);
> > +        }
> > +    }
> > +    qemu_mutex_unlock(&yank_lock);
> > +}
> > +
> > +YankInstanceList *qmp_query_yank(Error **errp)
> > +{
> > +    YankInstanceEntry *entry;
> > +    YankInstanceList *ret;
> > +
> > +    ret =3D NULL;
> > +
> > +    qemu_mutex_lock(&yank_lock);
> > +    QLIST_FOREACH(entry, &yank_instance_list, next) {
> > +        YankInstanceList *new_entry;
> > +        new_entry =3D g_new0(YankInstanceList, 1);
> > +        new_entry->value =3D QAPI_CLONE(YankInstance, entry->instance);
> > +        new_entry->next =3D ret;
> > +        ret =3D new_entry; =20
>=20
> There is a pull request pending that adds QAPI_LIST_PREPEND().  If it
> gets pulled before you respin, using it would be nice.
>=20
> > +    }
> > +    qemu_mutex_unlock(&yank_lock); =20
>=20
> Your critical sections all look "fast" to me.  Good.
>=20
> > +
> > +    return ret;
> > +}
> > +
> > +static void __attribute__((__constructor__)) yank_init(void)
> > +{
> > +    qemu_mutex_init(&yank_lock);
> > +}
> > --
> > 2.20.1 =20
>=20

--Sig_/TYZin2oQ7bIZL6QbR0Alv3E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+b66wACgkQNasLKJxd
sljjqw/+LHoOQ7W6DZ4nZWpCbe7c2CMHIEyl6lh2JHY4iD7n9qOBms3MnhKXdHhb
Tf+iYXk3lUo9TYo9rnqUaNnyew67GZdJcgQ7ZQVQut6Ju8UwU3uZyu/IlkVXutoi
kJy9+gFe8y466y07Kjk8OWmRz8vOlQeHodMXWrh/jLC3aNzu0uwq0Db2xK1C6bZE
lAtISsg+dx3JmlTmKg0Yv6ilnAimPHWA1FCJQVTw4vRy9DOVTJ2wolFJK0jwFgf0
T0VbJs3cqcFNaQSdHiSkMRb5U3wfnAoM+N3R4fya/I0TC0yFKBJO4S7U5kg9NT2u
uWP1vqBIgDnKlf+HeCQpl016HUvKuQrfDDkUfRNlwX+hM+a6RxNMOloAWdRDzohE
MhORJl3T40ELFX4bMo8wVsE8LzoArGgGKcr1fOhqSS0KQBvrXza5aGO4xCWXOadR
KymLEWnbF0LUsl3xmflYHqxXbBPH8BRIBIm7ANSHAoJaMye7spPkztwQ4OKnZpZN
MbFAoIanrvbTnx+ZkcHTZUk0Zh13ACLyoBHH9DUvQYrO8dIhnmDFCns6OOSjDh3Z
tSQWeyHrgFUPbhyDGzzAgNx/3M7vD4W66ypUG4n9WB3kFAdX2w+BUBdAEHoTGfxx
S/IMSzdZS7vuOSUbpiAwMVzUC09KTQpASjN6AUHqREs7mn0Lx+c=
=8kvp
-----END PGP SIGNATURE-----

--Sig_/TYZin2oQ7bIZL6QbR0Alv3E--

