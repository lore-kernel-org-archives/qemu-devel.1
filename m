Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16335C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C419A206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVHKNmWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C419A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCVs-0000no-V6
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iVCVD-0000Gs-3S
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iVCVA-0007Mo-E6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:37:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iVCV8-0007KH-LY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573727841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9Oo/x3/yKlMwnyFCoQn/oiS0prFH8OUjrDY49pQHuo=;
 b=ZVHKNmWeepwwyiQPQIJb/YrF5bkgDrEDWzuSLfF24X07EPRcxVmDO6KCwogncIK1scBg0F
 KDqQOelpPWyBXIF+pToffz+5Xdd4H3ngAU06KpGIeS8gltrFT1HiSLNYc91xeBUZwjiSOn
 LNB5hjxAzBCWkyWnGoTfyCt9mZ3NSAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-PQJV4H-TPM6paGy1KyQcmg-1; Thu, 14 Nov 2019 05:37:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03D1B106B786;
 Thu, 14 Nov 2019 10:37:17 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10C95691B4;
 Thu, 14 Nov 2019 10:37:11 +0000 (UTC)
Message-ID: <89b580b2da26da8995a90ffd70e8325ba277a20a.camel@redhat.com>
Subject: Re: API definition for LUKS key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 14 Nov 2019 12:37:11 +0200
In-Reply-To: <20191111183424.GR814211@redhat.com>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191111183424.GR814211@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PQJV4H-TPM6paGy1KyQcmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 John Ferlan <jferlan@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-11-11 at 18:34 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Nov 11, 2019 at 05:58:20PM +0200, Maxim Levitsky wrote:
> > Hi!
> >=20
> > I would like to discuss the API for LUKS key management.
> >=20
> > First of all very brief overview of LUKS v1 format:
> >=20
> > Each sector of the image is encrypted with same master key, which
> > is not stored directly on the disk.
> >=20
> > Instead in the LUKS header we have 8 slots. Each slot optionally stores
> > an encrypted version of the master key, encrypted by the user password.
> > Knowing the password, you can retrieve the master key from the keyslot.
> > Slot can be marked as active or inactive, inactive slots are not consid=
ered
> > when opening the image.
> >=20
> > In addition to that LUKS header has a hash of the master key, so that
> > you can check if the password 'opens' a keyslot by decrypting it
> > with given the password, and then checking if=20
> > the hash of the decrypted master key candidate obtained matches the sto=
red hash.
> >=20
> > That basically means that you can have up to 8 different passwords that=
 will
> > open a luks volume and you can change them as you wish without re-encry=
pting
> > everything.
> >=20
> > Now for raw luks volumes you have cryptsetup which allows to manage the=
se
> > keyslots, but we also have so called encrypted qcow2 format which
> > basically has the luks header, together with keyslots embedded, plus ea=
ch
> > cluster is encrypted with the master key as in raw luks.
> > Cryptsetup doesn't support this, thus I implemented this in qemu block =
layer.
>=20
> Even for raw luks volumes, the traditional "cryptsetup" tool is
> undesirable. eg consider LUKS on an RBD or ISCSI volume where
> you are using the in-QEMU RBD/ISCSI client. You don't want to
> have to configure the host kernel client just to change the
> keyslot info. You don't want to use the in-QEMU clients for
> qemu-img.

I didn't thought about it. This is a very good point!

>=20
> >=20
> > Link to bugzilla here: https://bugzilla.redhat.com/show_bug.cgi?id=3D16=
62412
> >=20
> >=20
> > Relevant to the API,
> > first of all qemu has the notion of amend (qemu-img amend), which allow=
s
> > currently to change format specific extensions of qcow2.
> >=20
> > Since luks, especially luks inside qcow2 is a format on its own, it fit=
s to=20
> > use that interface to change the 'format' options, in this case,
> > the encryption key slots.
> >=20
> >=20
> > There are the following requirements (they are 100% hardcoded, we might=
 discuss
> > to drop some of these):
> >=20
> >=20
> > 1. ability to add a new password to a free keyslot=20
> > (best is to let api to pick a free keyslot)
> > Also user should not need to know all the passwords in existing keyslot=
s.
> >=20
> >=20
> > 2. ability to erase a keyslot, usually by giving the password that shou=
ld be erased, and erasing all
> > the keyslots that match the password, or by giving a keyslot index.
> > This will usually be done after adding a new password.
> >=20
> >=20
> > 3. Allow to do so online, that is while qemu is running, but also suppo=
rt offline management.
> > Note that online management is even useful for raw luks volumes, since =
its not safe
> > to run cryptsetup on them while qemu is using the images.
> >=20
> >=20
> > I implemented those requirements using the following interface.
> > (I have sent the patches already)
> >=20
> > I will try to explain the interface with bunch of examples:
> >=20
> >=20
> > # adds a new password, defined by qemu secret 'sec0' to first unused sl=
ot
> > # give user a error if all keyslots are occupied
> > qemu-img amend --secret ... -o key-secret=3Dsec1 image.luks
>=20
> I think you meant "--object secret,...." instead of "--secret ..."
>=20
True, sorry about that!

> Also, this example needs to have 2 secrets provided. The first
> secret to unlock the image using the existing password, and the
> second secret is the one being added.
>=20
> > # erases all keyslots that can be opened by password that is contained =
in a qemu secret 'sec0'
> > # active=3Doff means that the given password/keyslot won't be active af=
ter the operation
> > qemu-img amend --secret ... -o key-secret=3Dsec0,active=3Doff image.luk=
s
> >=20
> >=20
> > # erase the slot 5 (this is more low level command, less expected to be=
 used)
> > qemu-img amend --secret ... -o slot=3D5,active=3Doff image.luks
> >=20
> > # add new secret to slot 5 (will fail if the slot is already marked as =
active)
> > qemu-img amend --secret ... -o slot=3D5,key-secret=3Dsec1 image.luks
>=20
> This also needs two secrets provideed.
>=20
> >=20
> >=20
> > This is basically it.
> >=20
> > The full option syntax is as following:
> >=20
> > active=3Don/off (optional, default to on) - toggles if we enabling a ke=
yslot or are erasing it.
> >=20
> > slot=3Dnumber (optional, advanced option) - specifies which exactly slo=
t to erase or which
> > slot to put the new key on
> >=20
> > key-secret =3D id of the secret object - specifies the secret. when slo=
t is enabled,
> > it will be put into the new slot. when disabling (erasing a keyslot), a=
ll keyslots
> > matching that secret will be erased.=20
> > Specifying both key-secret and slot index is treated as error I think
> >=20
> >=20
> > As as very advanced option, --force is added to qemu-img to allow to do=
 unsafe operation,
> > which in this case is removing last keyslot which will render the encry=
pted image useless.
> >=20
> >=20
> > In addition to that, QMP interface was added for online version of the =
above.
> > It is very similiar, but since we don't have blockdev-amend,
> > I added one and it has the following interface:
> >=20
> >=20
> >=20
> > ##
> > # @x-blockdev-amend:
> > #
> > # Starts a job to amend format specific options of an existing open blo=
ck device.
> > # The job is automatically finalized, but a manual job-dismiss is requi=
red.
> > #
> > # @job-id:          Identifier for the newly created job.
> > #
> > # @node-name:       Name of the block node to work on
> > #
> > # @options:         Options (same as for image creation)
> > #
> > # @force:           Allow unsafe operations, format specific
> > #                   For luks that allows erase of the last active keysl=
ot
> > #                   (permanent loss of data),
> > #                   and replacement of an active keyslot
> > #                   (possible loss of data if IO error happens)
> > #
> > # Since: 4.2
> > ##
> > { 'command': 'x-blockdev-amend',
> >   'data': { 'job-id': 'str',
> >             'node-name': 'str',
> >             'options': 'BlockdevCreateOptions',
> >             '*force': 'bool' } }
> >=20
> >=20
> >=20
> > It takes the same BlockdevCreateOptions as blockdev-create (this is ope=
n to debate if to leave this as is)
> >=20
> >=20
> > BlockdevCreateOptionsLUKS (its parent QCryptoBlockCreateOptionsLUKS tec=
hnically is extended in this way):
> >=20
> >=20
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -190,6 +190,21 @@
> >  #                  Currently defaults to 'sha256'
> >  # @hash-alg: the master key hash algorithm
> >  #            Currently defaults to 'sha256'
> > +#
> > +# @active: Should the new secret be added (true) or erased (false)
> > +#          (amend only, since 4.2)
> > +#
> > +# @slot: The slot in which to put/erase the secret
> > +#        if not given, will select first free slot for secret addtion
> > +#        and erase all keyslots that match the given @key-secret for e=
rase.
> > +#        except the last one
> > +#        (optional, since 4.2)
> > +#
> > +# @unlock-secret: The secret to use to unlock the image
> > +#        If not given, will use the secret that was used
> > +#        when opening the image.
> > +#        (optional, for amend only, since 4.2)
> > +#
> >  # @iter-time: number of milliseconds to spend in
> >  #             PBKDF passphrase processing. Currently defaults
> >  #             to 2000. (since 2.8)
> > @@ -201,7 +216,12 @@
> >              '*cipher-mode': 'QCryptoCipherMode',
> >              '*ivgen-alg': 'QCryptoIVGenAlgorithm',
> >              '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
> > +
> >              '*hash-alg': 'QCryptoHashAlgorithm',
> > +            '*active' : 'bool',
> > +            '*slot': 'int',
> > +            '*unlock-secret': 'str',
> > +
> >              '*iter-time': 'int'}}
> >=20
> >=20
> > Here note that key-secret is already present in the in api, and I am ad=
ding the 'slot','active' and 'unlock-secret'
> >=20
> > 'slot' can be also used for new created image to specify where to place=
 the the secret.
> > 'active' not allowed to be false for blockdev-create of an image and ca=
n be true/false for 'blockdev-amend'
> >=20
> > 'unlock-secret' (might be removed later) covers an corner case that is =
specific for online key management.
> > The case is that if the keyslot used to open the image in first place i=
s removed, it can be used to specify
> > the password to retrieve the master key from one of existing keyslots, =
since the driver doesn't officially
> > keep the master key all the time (it can be in theory only loaded in ha=
rdware crypto device)
> >=20
> > That is why for adding a new keyslot, the secret that was used to open =
the image is tried first, and if it
> > doesn't open a keyslot, the 'unlock-secret' can be used instead. This c=
an be thought of as the 'current password'
> > that is need to update the password on many web forums.
> >=20
> >=20
> > One of the concerns that was raised during the review was that amend in=
terface for luks that I propose is
> > different from the amend inteface used currently for qcow2.
> >=20
> > qcow2 amend interface specifies all the format options, thus overwrites=
 the existing options.
> > Thus it seems natural to make the luks amend interface work the same wa=
y, that it receive an array
> > of 8 slots, and for each slot specify if it is active, and if true what=
 password to put in it.
> > This does allow to add and erase the keyslots, but it doesn't allow:
> >=20
> >    * add a password without knowing all other passwords that exist in e=
xisting keyslots
> >      this can be mitigated by specifying which keyslots to modify for e=
xample by omitting the
> >      keyslots that shouldn't be touched from the array (passing null pl=
aceholder instead)
> >      but then it already doesn't follow the 'specify all the options ea=
ch time' principle.
>=20
> I think this is highly undesirable, as we must not assume that the
> mgmt app has access to all the passwords currently set.
>=20
> The two key use cases for having multiple key slots are
>=20
>   - To enable a two-phase change of passwords to ensure new password
>     is safely written out before erasing the old password
>    =20
>   - To allow for multiple access passwords with different controls
>     or access to when each password is made available.
>=20
>     eg each VM may have a separate "backup password" securely
>     stored off host that is only made available for use when
>     doing disaster recovery.
>=20
> the second use case is doomed if you need to always provide all
> current passwords when changing any key slots.
Fully agree, and thanks for these examples!


>=20
>=20
> >    * erase all keyslots matching a password - this is really hard to do=
 using this approach,
> >      unless we give user some kind of api to try each keyslot with give=
n password,
> >      which is kind of ugly and might be racy as well.
> > So what do you think?
>=20
> The point of using "amend" is that we already have some of the boilerplat=
e
> supporting framework around that, so it saves effort for both QEMU and
> our users. If the semantics of "amend" don't fit nicely though, then the
> benefit of re-using "amend" is cancelled out and we should go back to
> considering a separate "key-manage" command.

I guess we should anyway use amend interface, while updating its definition
a bit to suit the broader requirements of the drivers, e.g luks.

I see the amend interface being like generic 'edit the device options' thin=
g,
which is maybe better that adding device specific commands like add-key,rem=
ove-key,
etc. No strong opinion on this though.


Best regards,
=09Maxim Levitsky


