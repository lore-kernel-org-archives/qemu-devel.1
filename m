Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33970C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B9F2339F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B9F2339F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0l5U-0004Av-5F
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0l2s-0002e2-Ks
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0l2r-0003Jk-1v
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43978)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0l2n-0003Hg-HG; Thu, 22 Aug 2019 07:14:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D471110F23E1;
 Thu, 22 Aug 2019 11:14:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 29A6C6D0A4;
 Thu, 22 Aug 2019 11:14:11 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:14:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190822111409.GM3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
 <12c342c8-6ac8-3533-7a7b-e61826e9abb0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12c342c8-6ac8-3533-7a7b-e61826e9abb0@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 22 Aug 2019 11:14:16 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 08:27:48PM +0200, Max Reitz wrote:
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

For key mgmt we definitely need to have an online capability.

If layering it into a general purpose format "amend' option
is too complex, then we should keep it separate rather than
making our lives uncecessarily difficult IMHO.

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
>=20
> > +# @force:         Disable safety checks (use with care)
>=20
> I think being a bit more verbose wouldn=E2=80=99t hurt.
>=20
> (Same above.)
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

I agree, we can get a more understandable schema if each
command has its own struct wit the right options.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

