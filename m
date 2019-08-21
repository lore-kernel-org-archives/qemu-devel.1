Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4D02332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4D02332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ZCo-000297-9S
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 18:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0ZA9-0008Bj-IM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0ZA6-0003Q9-7P
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0Z9y-0003It-Sg; Wed, 21 Aug 2019 18:32:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 637E07F756;
 Wed, 21 Aug 2019 22:32:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F0E4194B9;
 Wed, 21 Aug 2019 22:32:48 +0000 (UTC)
Message-ID: <2a997a7396f37a2fdf631f9bffd08573899d37e8.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:32:48 +0300
In-Reply-To: <12c342c8-6ac8-3533-7a7b-e61826e9abb0@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
 <12c342c8-6ac8-3533-7a7b-e61826e9abb0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Wed, 21 Aug 2019 22:32:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/13] block: add manage-encryption command
 (qmp and blockdev)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-20 at 20:27 +0200, Max Reitz wrote:
> On 14.08.19 22:22, Maxim Levitsky wrote:
> > This adds:
> >=20
> > * x-blockdev-update-encryption and x-blockdev-erase-encryption qmp co=
mmands
> >   Both commands take the QCryptoKeyManageOptions
> >   the x-blockdev-update-encryption is meant for non destructive addit=
ion
> >   of key slots / whatever the encryption driver supports in the futur=
e
> >=20
> >   x-blockdev-erase-encryption is meant for destructive encryption key=
 erase,
> >   in some cases even without way to recover the data.
> >=20
> >=20
> > * bdrv_setup_encryption callback in the block driver
> >   This callback does both the above functions with 'action' parameter
> >=20
> > * QCryptoKeyManageOptions with set of options that drivers can use fo=
r encryption managment
> >   Currently it has all the options that LUKS needs, and later it can =
be extended
> >   (via union) to support more encryption drivers if needed
> >=20
> > * blk_setup_encryption / bdrv_setup_encryption - the usual block laye=
r wrappers.
> >   Note that bdrv_setup_encryption takes BlockDriverState and not Bdrv=
Child,
> >   for the ease of use from the qmp code. It is not expected that this=
 function
> >   will be used by anything but qmp and qemu-img code
> >=20
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/block-backend.c          |  9 ++++++++
> >  block/io.c                     | 24 ++++++++++++++++++++
> >  blockdev.c                     | 40 ++++++++++++++++++++++++++++++++=
++
> >  include/block/block.h          | 12 ++++++++++
> >  include/block/block_int.h      | 11 ++++++++++
> >  include/sysemu/block-backend.h |  7 ++++++
> >  qapi/block-core.json           | 36 ++++++++++++++++++++++++++++++
> >  qapi/crypto.json               | 26 ++++++++++++++++++++++
> >  8 files changed, 165 insertions(+)
>=20
> Now I don=E2=80=99t know whether you want to keep this interface at all=
, because
> the cover letter seemed to imply you=E2=80=99d prefer a QMP amend.  But=
 let it
> be said that a QMP amend is no trivial task.  I think the most difficul=
t
> bit is that the qcow2 implementation currently is inherently an offline
> operation.  It isn=E2=80=99t a good idea to use it on a live image.  (M=
aybe it
> works, but it=E2=80=99s definitely not what I had in mind when I wrote =
it.)
>=20
> So I=E2=80=99ll still take a quick glance at the interface here.
>=20
> [...]
>=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 0d43d4f37c..53ed411eed 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5327,3 +5327,39 @@
> >    'data' : { 'node-name': 'str',
> >               'iothread': 'StrOrNull',
> >               '*force': 'bool' } }
> > +
> > +
> > +##
> > +# @x-blockdev-update-encryption:
> > +#
> > +# Update the encryption keys for an encrypted block device
> > +#
> > +# @node-name: 	  Name of the blockdev to operate on
> > +# @force:         Disable safety checks (use with care)
> > +# @options:       Driver specific options
> > +#
> > +
> > +# Since: 4.2
> > +##
> > +{ 'command': 'x-blockdev-update-encryption',
> > +  'data': { 'node-name' : 'str',
> > +            '*force' : 'bool',
> > +            'options': 'QCryptoEncryptionSetupOptions' } }
> > +
> > +##
> > +# @x-blockdev-erase-encryption:
> > +#
> > +# Erase the encryption keys for an encrypted block device
> > +#
> > +# @node-name: 	  Name of the blockdev to operate on
>=20
> Why the tab?
Because checkpatch.pl doesn't warn about this :-)

>=20
> > +# @force:         Disable safety checks (use with care)
>=20
> I think being a bit more verbose wouldn=E2=80=99t hurt.
>=20
> (Same above.)
True about this - this is another reason this is RFC,

I honestly didn't finish the documentation,
since the sudden change to drop all of this interface.


>=20
> > +# @options:       Driver specific options
> > +#
> > +# Returns: @QCryptoKeyManageResult
> > +#
> > +# Since: 4.2
> > +##
> > +{ 'command': 'x-blockdev-erase-encryption',
> > +  'data': { 'node-name' : 'str',
> > +            '*force' : 'bool',
> > +            'options': 'QCryptoEncryptionSetupOptions' } }
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index b2a4cff683..69e8b086db 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -309,3 +309,29 @@
> >    'base': 'QCryptoBlockInfoBase',
> >    'discriminator': 'format',
> >    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> > +
> > +
> > +##
> > +# @QCryptoEncryptionSetupOptions:
> > +#
> > +# Driver specific options for encryption key management.
>=20
> The options do seem LUKS-specific, but the name of this structure does =
not.
This is because to be not luks specific we must use some kind of an union
which means that the user has to specify the driver which I didn't want t=
o do.
Now all of you convinced me ( :-) ) to do this so this will be done when =
I switch
to the amend interface.

>=20
> > +# @key-secret: the ID of a QCryptoSecret object providing the passwo=
rd
> > +#              to add or to erase (optional for erase)
> > +#
> > +# @old-key-secret: the ID of a QCryptoSecret object providing the pa=
ssword
> > +#                  that can currently unlock the image
> > +#
> > +# @slot: Key slot to update/erase
> > +#        (optional, for update will select a free slot,
> > +#        for erase will erase all slots that match the password)
> > +#
> > +# @iter-time: number of milliseconds to spend in
> > +#             PBKDF passphrase processing. Currently defaults to 200=
0
> > +# Since: 4.2
> > +##
>=20
> Does it really make sense to use the same structure for erasing and
> updating?  I think there are ways to represent @key-secret vs. @slot
> being alternatives to each other for erase; @iter-time doesn=E2=80=99t =
seem to
> make sense for erase; and @slot doesn=E2=80=99t seem to make sense for =
update.
> Also, I don=E2=80=99t know whether to use @key-secret or @old-key-secre=
t for erase.
>=20
> All in all, it seems more sensible to me to have separate structs for
> updating and erasing.

The reason for that was to save on code duplication internally.
Internally (as in block device callback, and generic crypto code callback=
),
both options are folded in one, with 'action' field to distinguish betwee=
n them
and that structure.
If I use amend interface, I also would have to have some amend option tha=
t
will tell to erase the key. It one of the things I wanted to ask you
with that RFC, how would you solve this in single amend interface.

>=20
> Max
>=20
> > +{ 'struct': 'QCryptoEncryptionSetupOptions',
> > +  'data': { '*key-secret': 'str',
> > +            '*old-key-secret': 'str',
> > +            '*slot': 'int',
> > +            '*iter-time': 'int' } }
> >=20
>=20
>=20

Best regards,
Thanks for the review,
	Maxim Levitsky



