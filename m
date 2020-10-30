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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9618CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:21:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E561E20756
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AG+o3Axm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E561E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWDC-0007tT-So
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYWBm-0006YL-3M; Fri, 30 Oct 2020 11:19:38 -0400
Received: from mout.web.de ([212.227.17.11]:35903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kYWBg-0007fS-JF; Fri, 30 Oct 2020 11:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1604071166;
 bh=pIAb7zFcaYBsQrSxsp6cC671uxZ19WDF4l1aX9GrVQM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=AG+o3AxmxSAIyo2dedDxxFWpDzFaiMQg6bdn1e8lcMdkImAR3YhzWCizQsRc8W81v
 Eml4DBwtcrtbIWqdx1tPMgSX4SpXtI6v31gqsUW69vYfyk09lCR4PtJkYIZwScuYlS
 4c5uLlly4Hi7DDfk7/u7NJg+sKAj5p3uvyyjCuws=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.100]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL0Q-1kbnQY0mA8-00EJW5; Fri, 30
 Oct 2020 16:19:26 +0100
Date: Fri, 30 Oct 2020 16:19:08 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v9 1/8] Introduce yank feature
Message-ID: <20201030161908.2f71ecd5@luklap>
In-Reply-To: <87lffnstge.fsf@dusky.pond.sub.org>
References: <cover.1603909658.git.lukasstraub2@web.de>
 <7b3b182b6ab1a859a1e9fb4ebfa5ce0a7a441e10.1603909658.git.lukasstraub2@web.de>
 <87a6w556rl.fsf@dusky.pond.sub.org>
 <20201030113212.37ddf1fb@luklap>
 <87lffnstge.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w5WnJ9IVm/XsHhmyw_A7l_l";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Li0H6BpJP8kB5jefRq4YVa5ZDd1P6rrdIEaZA4Cg77MYk8d/pV5
 RonRyfuq08MLrkoSDSrXsgVL3aqUl9Tbkays5pyXlp2lPbYU4pxHU6PAYqWOZgbZjorinqv
 Mvv9rmtp57A6BKi41VQONTn6JJhTI8r7kh7LwzAfIhtPUG5Bht2NUUbwXS7+IRuzGTYNzmh
 1lZisCaFEVCNtM20VYhJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQ2IZdLWZwQ=:S72kKEbd+H0wEDK9i5FoK0
 8t5Cl7nobrdiDxj9tLmNDj5ppiwmNy2NgQ8ADNvAIuRt8ExVnZas0tFExBxurviUhPFHAthII
 R5d7mCHCCyZeRGy7qKJR08bMirk/ZCk/7PIElogtnJjudm0fbavIvcYP2wocZooaCRpPIPf3S
 2tK9y0cVBfWD2QKqZaDJnwIxlZMetErPC8Yom/dXLP9Rgg7J6x33FhVRnm425oYtC8yMl34f0
 UGSYK2kR7ZqoUOWxLPut8voPOwEe/O0IgByHt5PJVvUoCP2uLqHjHAahKIWuCIp/4NQW9Y1yr
 ZkT/aibrIHa1idpOYWSmTEdT+UhipPxGfICn+bK3gFSz4pxFOWK1EyM/DFlPk85na7TNQM5+m
 3+yb0TaPC+mJEvOS98bSuTE/a0bnxALeya5ntzvziqQ4ADBLDrbimVPCjr1xTEOWlmKPohK0h
 FGwbpTe2YgxgQIL0ZCDRlYi1zaanj6po/6qb/g8T72wf/ThCnI+A2Hk/0eTrzj51A+1ze/tWp
 5RqUTR1SMEg+BLOs3WUY+JIfRQChA+wd6Vn0uLwcGr2TUm8fpM8v9HCBfXrayLhUpt9UKe5oC
 +n0Ozeweta4YQhDuPHlg/dSDO/ZS3W0Aw8thxzjiGnu7hQ6rH95JR8J8lNXlqxVTUV8vMMD5+
 pShrdc9aWjDPqr8/P6UWX55Z08R8YfSs5S0+EI1JnF/QxtZ5mVXBPDL0Q5I483cI+pp/W67rJ
 c1LjaT9LE/gTf3ekzaQLytR0HNynWmQYWGZDcjuUGFY9kj5MZVIr+TC6Qi/cEbZdlhNkSfGan
 es7f3eXbNS0F6ZxG1dqY1DG6Z9Drqd8nGJ5mtMf+vc8Fhhw1FP56dzzZiVCUtL2ryR84Adl5Y
 IuFf674IYW+wna+K/L0Q==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 11:19:30
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
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/w5WnJ9IVm/XsHhmyw_A7l_l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Oct 2020 15:02:09 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Lukas Straub <lukasstraub2@web.de> writes:
>=20
> > On Thu, 29 Oct 2020 17:36:14 +0100
> > Markus Armbruster <armbru@redhat.com> wrote:
> > =20
> >> Nothing major, looks almost ready to me.
> >>=20
> >> Lukas Straub <lukasstraub2@web.de> writes:
> >>  =20
> >> > The yank feature allows to recover from hanging qemu by "yanking"
> >> > at various parts. Other qemu systems can register themselves and
> >> > multiple yank functions. Then all yank functions for selected
> >> > instances can be called by the 'yank' out-of-band qmp command.
> >> > Available instances can be queried by a 'query-yank' oob command.
> >> >
> >> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> >> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> > ---
> >> >  include/qemu/yank.h |  95 ++++++++++++++++++++
> >> >  qapi/misc.json      | 106 ++++++++++++++++++++++
> >> >  util/meson.build    |   1 +
> >> >  util/yank.c         | 213 +++++++++++++++++++++++++++++++++++++++++=
+++   =20
> >>=20
> >> checkpatch.pl warns:
> >>=20
> >>     WARNING: added, moved or deleted file(s), does MAINTAINERS need up=
dating?
> >>=20
> >> Can we find a maintainer for the two new files? =20
> >
> > Yes, I'm maintaining this for now, see patch 7. =20
>=20
> Thanks!  Would it make sense to add the yank stuff to a new QAPI module
> yank.json instead of misc.jaon, so the new MAINTAINERS stanza can cover
> it?

Yes, makes sense. Changed for the next version.

> [...]
> >> > diff --git a/qapi/misc.json b/qapi/misc.json
> >> > index 40df513856..3b7de02a4d 100644
> >> > --- a/qapi/misc.json
> >> > +++ b/qapi/misc.json =20
> [...]
> >> > +##
> >> > +# @YankInstance:
> >> > +#
> >> > +# A yank instance can be yanked with the "yank" qmp command to reco=
ver from a
> >> > +# hanging qemu.   =20
> >>=20
> >> QEMU
> >>  =20
> >> > +#
> >> > +# Currently implemented yank instances:
> >> > +#  -nbd block device:
> >> > +#   Yanking it will shutdown the connection to the nbd server witho=
ut
> >> > +#   attempting to reconnect.
> >> > +#  -socket chardev:
> >> > +#   Yanking it will shutdown the connected socket.
> >> > +#  -migration:
> >> > +#   Yanking it will shutdown all migration connections.   =20
> >>=20
> >> To my surprise, this is recognized as bullet list markup.  But please
> >> put a space between the bullet and the text anyway.
> >>=20
> >> Also: "shutdown" is a noun, the verb is spelled "shut down". =20
> >
> > Both changed for the next version.
> > =20
> >> In my review of v8, I asked how yanking migration is related to command
> >> migrate_cancel.  Daniel explained:
> >>=20
> >>     migrate_cancel will do a shutdown() on the primary migration socke=
t only.
> >>     In addition it will toggle the migration state.
> >>=20
> >>     Yanking will do a shutdown on all migration sockets (important for
> >>     multifd), but won't touch migration state or any other aspect of Q=
EMU
> >>     code.
> >>=20
> >>     Overall yanking has less potential for things to go wrong than the
> >>     migrate_cancel method, as it doesn't try to do any kind of cleanup
> >>     or migration.
> >>=20
> >> Would it make sense to work this into the documentation? =20
> >
> > How about this?
> >
> >   - migration:
> >     Yanking it will shut down all migration connections. Unlike
> >     @migrate_cancel, it will not notify the migration process,
> >     so migration will go into @failed state, instead of @cancelled
> >     state. =20
>=20
> Works for me.  Advice on when to use it rather than migrate_cancel would
> be nice, though.

Ok, Changed for the next version.

> >> > +#
> >> > +# Since: 5.2
> >> > +##
> >> > +{ 'union': 'YankInstance',
> >> > +  'base': { 'type': 'YankInstanceType' },
> >> > +  'discriminator': 'type',
> >> > +  'data': {
> >> > +      'blockdev': 'YankInstanceBlockdev',
> >> > +      'chardev': 'YankInstanceChardev' } }
> >> > +
> >> > +##
> >> > +# @yank:
> >> > +#
> >> > +# Recover from hanging qemu by yanking the specified instances. See=
   =20
> >>=20
> >> QEMU
> >>=20
> >> "Try to recover" would be more precise, I think. =20
> >
> > Changed for the next version.
> > =20
> >> > +# "YankInstance" for more information.
> >> > +#
> >> > +# Takes a list of @YankInstance as argument.
> >> > +#
> >> > +# Returns: nothing.
> >> > +#
> >> > +# Example:
> >> > +#
> >> > +# -> { "execute": "yank",
> >> > +#      "arguments": {
> >> > +#          "instances": [
> >> > +#               { "type": "block-node",
> >> > +#                 "node-name": "nbd0" }
> >> > +#          ] } }
> >> > +# <- { "return": {} }
> >> > +#
> >> > +# Since: 5.2
> >> > +##
> >> > +{ 'command': 'yank',
> >> > +  'data': { 'instances': ['YankInstance'] },
> >> > +  'allow-oob': true }
> >> > + =20
> [...]
> >> > diff --git a/util/yank.c b/util/yank.c
> >> > new file mode 100644
> >> > index 0000000000..0b3a816706
> >> > --- /dev/null
> >> > +++ b/util/yank.c =20
> [...]
> >> > +void qmp_yank(YankInstanceList *instances,
> >> > +              Error **errp)
> >> > +{
> >> > +    YankInstanceList *tail;
> >> > +    YankInstanceEntry *entry;
> >> > +    YankFuncAndParam *func_entry;
> >> > +
> >> > +    qemu_mutex_lock(&yank_lock);
> >> > +    for (tail =3D instances; tail; tail =3D tail->next) {
> >> > +        entry =3D yank_find_entry(tail->value);
> >> > +        if (!entry) {
> >> > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND, "Instance=
 not found");   =20
> >>=20
> >> Quote error.h:
> >>=20
> >>  * Note: use of error classes other than ERROR_CLASS_GENERIC_ERROR is
> >>  * strongly discouraged.
> >>=20
> >> Any particular reason for ERROR_CLASS_DEVICE_NOT_FOUND?  If not, then
> >> error_setg(), please. =20
> >
> > There may be a time-to-check to time-to-use race condition here. Suppose
> > the management application (via QMP) calls 'blockev-del nbd0', then QEMU
> > hangs, so after a timeout it calls 'yank nbd0' while shortly before that
> > QEMU unhangs for some reason and removes the blockdev. Then yank returns
> > this error.
> >
> > QMP errors should not be parsed except for the error class, so the the
> > management application can only differentiate between this (ignorable)
> > error and other (possibly fatal) ones by parsing the error class. =20
>=20
> I see.
>=20
> DeviceNotFound doesn't really fit, but none of the other error classes
> is any better.
>=20
> I think the line
>=20
>       # Returns: nothing.
>=20
> in the QAPI schema (quoted above) should be expanded to something like
>=20
>=20
>       # Returns: - Nothing on success
>                  - If the YankInstance doesn't exist, DeviceNotFound

Changed for the next version.

> >> > +            qemu_mutex_unlock(&yank_lock);
> >> > +            return;
> >> > +        }
> >> > +    }
> >> > +    for (tail =3D instances; tail; tail =3D tail->next) {
> >> > +        entry =3D yank_find_entry(tail->value);
> >> > +        assert(entry);
> >> > +        QLIST_FOREACH(func_entry, &entry->yankfns, next) {
> >> > +            func_entry->func(func_entry->opaque);
> >> > +        }
> >> > +    }
> >> > +    qemu_mutex_unlock(&yank_lock);
> >> > +} =20
> [...]
>=20



--=20


--Sig_/w5WnJ9IVm/XsHhmyw_A7l_l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl+cLuwACgkQNasLKJxd
sligzg//TZa1yyDwyke5UgKunZrdKQeYVwKN7RBZZTbuzDgbVDW60b8hYxlJpvET
uUmPSa5lH6bmL6+WMkPePHW5Qt7WN5RZPT4Iyrl1yUc9iQSgYd35DZ2ml/kOmcXf
Z1hZkNfj2SaQrnAfa4o1F54MM/aJI1IC86DPLsKZdPJX3bp8mMpZjnY4UA0PRisl
BmqqRO7emI3QtMaf1a53bY/cQA2RuV8uVQvsyK5IZ/KknU3mvU5AthT6eV6EaZwX
VACic9P295VPpC+nw89kyC5JQtJpOTjBEW6qgLA9yP0wxpFp8gvasRSd8DsGRMi9
tgcJATAf6HOWnKnEH9TquyG5+xWvfXAYLXqAVsbv81yw+QRl8wyar20KqhXzBCym
ABHds+LsUKsJFaM48Bl8RfytkHWHWJWOwxcg16kNuQno8NHj5gp4wV+XbCtCpWJV
/gn57gwTTn+VjMyuiA27toPD1+xtCC4ulnBkCVO9RUOS6F/5xzibIx4GGe25Zo94
xQblHQoFuk/vYfyvwGWEj0oMTIwit4vJaTcnwzrkfbi6Lnw3q1zjx4miagW/sAQ4
NitHU6s9r3UEo9mm/Q0ofyoy4nml9kljTYXCclcboSkuLtFuz2tqfTcMa0RZwjLe
isUgv7JQ7wHWnMzfKBljWRmgC86MguYuLkcjdBN9AoQpxeL+q1c=
=HjbY
-----END PGP SIGNATURE-----

--Sig_/w5WnJ9IVm/XsHhmyw_A7l_l--

