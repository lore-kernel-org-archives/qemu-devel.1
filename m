Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC3C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F162021743
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F162021743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0nou-0006NY-2w
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i0nkV-0001h5-9S
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i0nkT-0007jy-8H
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:07:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1i0nkP-0007iE-8g; Thu, 22 Aug 2019 10:07:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90DA980F79;
 Thu, 22 Aug 2019 14:07:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5790600CD;
 Thu, 22 Aug 2019 14:07:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 48BD91162B63; Thu, 22 Aug 2019 16:07:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
 <87sgpukafd.fsf@dusky.pond.sub.org>
 <2ac0407fbbed8558dc22fc0b8a30ef77bddcea6f.camel@redhat.com>
Date: Thu, 22 Aug 2019 16:07:24 +0200
In-Reply-To: <2ac0407fbbed8558dc22fc0b8a30ef77bddcea6f.camel@redhat.com>
 (Maxim Levitsky's message of "Thu, 22 Aug 2019 01:24:09 +0300")
Message-ID: <877e75cmzn.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 22 Aug 2019 14:07:28 +0000 (UTC)
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
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Wed, 2019-08-21 at 13:47 +0200, Markus Armbruster wrote:
>> Maxim Levitsky <mlevitsk@redhat.com> writes:
>> 
>> > This adds:
>> > 
>> > * x-blockdev-update-encryption and x-blockdev-erase-encryption qmp commands
>> >   Both commands take the QCryptoKeyManageOptions
>> >   the x-blockdev-update-encryption is meant for non destructive addition
>> >   of key slots / whatever the encryption driver supports in the future
>> > 
>> >   x-blockdev-erase-encryption is meant for destructive encryption key erase,
>> >   in some cases even without way to recover the data.
>> > 
>> > 
>> > * bdrv_setup_encryption callback in the block driver
>> >   This callback does both the above functions with 'action' parameter
>> > 
>> > * QCryptoKeyManageOptions with set of options that drivers can use for encryption managment
>> >   Currently it has all the options that LUKS needs, and later it can be extended
>> >   (via union) to support more encryption drivers if needed
>> > 
>> > * blk_setup_encryption / bdrv_setup_encryption - the usual block layer wrappers.
>> >   Note that bdrv_setup_encryption takes BlockDriverState and not BdrvChild,
>> >   for the ease of use from the qmp code. It is not expected that this function
>> >   will be used by anything but qmp and qemu-img code
>> > 
>> > 
>> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> 
>> [...]
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 0d43d4f37c..53ed411eed 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -5327,3 +5327,39 @@
>> >    'data' : { 'node-name': 'str',
>> >               'iothread': 'StrOrNull',
>> >               '*force': 'bool' } }
>> > +
>> > +
>> > +##
>> > +# @x-blockdev-update-encryption:
>> > +#
>> > +# Update the encryption keys for an encrypted block device
>> > +#
>> > +# @node-name: 	  Name of the blockdev to operate on
>> > +# @force:         Disable safety checks (use with care)
>> 
>> What checks excactly are disabled?
> Ability to overwrite an used slot with a different password. 
> If overwrite fails, the image won't be recoverable.
>
> The safe way is to add a new slot, then erase the old
> one, but this changes the slot where the password
> is stored, unless this procedure is used twice

Would this be a useful addition to the doc comment?

>> > +# @options:       Driver specific options
>> > +#
>> > +
>> > +# Since: 4.2
>> > +##
>> > +{ 'command': 'x-blockdev-update-encryption',
>> > +  'data': { 'node-name' : 'str',
>> > +            '*force' : 'bool',
>> > +            'options': 'QCryptoEncryptionSetupOptions' } }
>> > +
>> > +##
>> > +# @x-blockdev-erase-encryption:
>> > +#
>> > +# Erase the encryption keys for an encrypted block device
>> > +#
>> > +# @node-name: 	  Name of the blockdev to operate on
>> > +# @force:         Disable safety checks (use with care)
>> 
>> Likewise.
> 1. Erase a slot which is already marked as
> erased. Mostly harmless but pointless as well.
>
> 2. Erase last keyslot. This irreversibly destroys
> any ability to read the data from the device,
> unless a backup of the header and the key material is
> done prior. Still can be useful when it is desired to
> erase the data fast.

Would this be a useful addition to the doc comment?

>> > +# @options:       Driver specific options
>> > +#
>> > +# Returns: @QCryptoKeyManageResult
>> 
>> Doc comment claims the command returns something, even though it
>> doesn't.  Please fix.  Sadly, the doc generator fails to flag that.
> This is leftover, fixed now although most likely this interface will die.
> I was initially planning to return
> information on which slot was allocated when user left that
> decision to the driver.
>
>> 
>> > +#
>> > +# Since: 4.2
>> > +##
>> > +{ 'command': 'x-blockdev-erase-encryption',
>> > +  'data': { 'node-name' : 'str',
>> > +            '*force' : 'bool',
>> > +            'options': 'QCryptoEncryptionSetupOptions' } }

Hmm, all members of @options are optional.  If I don't want to specify
any of them, I still have to say "options": {}.  Should @options be
optional, too?

Question is not relevant for x-blockdev-update-encryption, because
there, options.key-secret isn't actually optional.  Correct?

>> > diff --git a/qapi/crypto.json b/qapi/crypto.json
>> > index b2a4cff683..69e8b086db 100644
>> > --- a/qapi/crypto.json
>> > +++ b/qapi/crypto.json
>> > @@ -309,3 +309,29 @@
>> >    'base': 'QCryptoBlockInfoBase',
>> >    'discriminator': 'format',
>> >    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
>> > +
>> > +
>> > +##
>> > +# @QCryptoEncryptionSetupOptions:
>> > +#
>> > +# Driver specific options for encryption key management.
>> 
>> Specific to which driver?
>
> This is the same issue, of not beeing able to detect an union.
>
> I was planning to have an union here where we could add
> add the driver specific options if we need to have another crypto driver,
> however since I discovered that union needs user to pass the driver name,
> I just placed it in a struct.
>
> So this struct is supposed to represent driver specific options, but
> currently contains only luks options.

Imagine we find driver DRV needs options.  How would we extend your QAPI
schema then?

We can add DRV's options to this struct.  QMP clients then must use only
the LUKS members when the driver is actually LUKS, and only the DRV
members when it's actually DRV.  Works as long as all members are
optional.  Confusing, and ugly as sin.

We can add a second struct for DRV's options.  Call it
QCryptoEncryptionSetupOptionsDRV.  Add an optional parameter 'drv':
'QCryptoEncryptionSetupOptionsDRV' to x-blockdev-*-encryption, make
existing parameter @options optional.  Can't rename it to @luks
(compatibility break).  Probably want to rename
QCryptoEncryptionSetupOptions to QCryptoEncryptionSetupOptionsLUKS.  QMP
clients then must use @options when the driver is actually LUKS, and
@drv when it's actually DRV.  Less confusing, still ugly.

I'm not happy with either idea.  Do you have a better one?

>> > +#
>> > +# @key-secret: the ID of a QCryptoSecret object providing the password
>> > +#              to add or to erase (optional for erase)
>> > +#
>> > +# @old-key-secret: the ID of a QCryptoSecret object providing the password
>> > +#                  that can currently unlock the image
>> > +#
>> > +# @slot: Key slot to update/erase
>> > +#        (optional, for update will select a free slot,
>> > +#        for erase will erase all slots that match the password)
>> > +#
>> > +# @iter-time: number of milliseconds to spend in
>> > +#             PBKDF passphrase processing. Currently defaults to 2000

Let's scratch "currently".

>> > +# Since: 4.2
>> > +##
>> > +{ 'struct': 'QCryptoEncryptionSetupOptions',
>> > +  'data': { '*key-secret': 'str',
>> > +            '*old-key-secret': 'str',
>> > +            '*slot': 'int',
>> > +            '*iter-time': 'int' } }
>> 
>> The two new commands have identical arguments.  Some of them you factor
>> out into their own struct.  Can you explain what makes them special?
>
>
> Uniting these means that I need to add some kind of 'action' to the
> options, which is kind of adding a subcommand to a qmp command, which is also feels
> kind of wrong.
>
> That is why internally this is implemented as one block driver callback,
> with action = {erase,update}, but qmp exposes two commands.

Yes, multiplexed commands are ugly more often than not.

> I would personally prefer to have that erase field,and I would have to have
> it, if I switch to the amend interface.
>
>
>> 
>> The extra nesting on the wire is kind of ugly.  We can talk about how to
>> avoid it once I understand why we want the extra struct.
>> 
> I kind of agree with that but The reason for that is that I designed that interface like that is  to be not specific to luks.
>
> I pass the options structure down the stack till it reaches the luks driver where it can deal with
> it. If a new crypto driver is added, all you would have to do is to define new options in the json,
> and use them in the new crypto driver. The rest of the code doesn't know what is in that struct.
> Kind of the same as done with blockdev-create I guess.

Actually, blockdev-create is quite different in one important way: it
uses a *union* for driver-specific arguments, not a struct.

If we make QCryptoEncryptionSetupOptions ab union, like
BlockdevCreateOptions is, then the way to grow it to more drivers is
obvious.

We can talk about nesting later.

