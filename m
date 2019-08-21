Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51C3C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 989E7233A1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989E7233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Z2f-0004mm-MM
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 18:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0Z1h-00041o-54
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0Z1e-00043X-Ph
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0Z1b-00040p-Pn; Wed, 21 Aug 2019 18:24:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED68A4E4E6;
 Wed, 21 Aug 2019 22:24:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 962725DC1E;
 Wed, 21 Aug 2019 22:24:10 +0000 (UTC)
Message-ID: <2ac0407fbbed8558dc22fc0b8a30ef77bddcea6f.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Thu, 22 Aug 2019 01:24:09 +0300
In-Reply-To: <87sgpukafd.fsf@dusky.pond.sub.org>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
 <87sgpukafd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 21 Aug 2019 22:24:15 +0000 (UTC)
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-21 at 13:47 +0200, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > This adds:
> > 
> > * x-blockdev-update-encryption and x-blockdev-erase-encryption qmp commands
> >   Both commands take the QCryptoKeyManageOptions
> >   the x-blockdev-update-encryption is meant for non destructive addition
> >   of key slots / whatever the encryption driver supports in the future
> > 
> >   x-blockdev-erase-encryption is meant for destructive encryption key erase,
> >   in some cases even without way to recover the data.
> > 
> > 
> > * bdrv_setup_encryption callback in the block driver
> >   This callback does both the above functions with 'action' parameter
> > 
> > * QCryptoKeyManageOptions with set of options that drivers can use for encryption managment
> >   Currently it has all the options that LUKS needs, and later it can be extended
> >   (via union) to support more encryption drivers if needed
> > 
> > * blk_setup_encryption / bdrv_setup_encryption - the usual block layer wrappers.
> >   Note that bdrv_setup_encryption takes BlockDriverState and not BdrvChild,
> >   for the ease of use from the qmp code. It is not expected that this function
> >   will be used by anything but qmp and qemu-img code
> > 
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [...]
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
> 
> What checks excactly are disabled?
Ability to overwrite an used slot with a different password. 
If overwrite fails, the image won't be recoverable.

The safe way is to add a new slot, then erase the old
one, but this changes the slot where the password
is stored, unless this procedure is used twice

> 
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
> > +# @force:         Disable safety checks (use with care)
> 
> Likewise.
1. Erase a slot which is already marked as
erased. Mostly harmless but pointless as well.

2. Erase last keyslot. This irreversibly destroys
any ability to read the data from the device,
unless a backup of the header and the key material is
done prior. Still can be useful when it is desired to
erase the data fast.


> 
> > +# @options:       Driver specific options
> > +#
> > +# Returns: @QCryptoKeyManageResult
> 
> Doc comment claims the command returns something, even though it
> doesn't.  Please fix.  Sadly, the doc generator fails to flag that.
This is leftover, fixed now although most likely this interface will die.
I was initially planning to return
information on which slot was allocated when user left that
decision to the driver.

> 
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
> 
> Specific to which driver?

This is the same issue, of not beeing able to detect an union.

I was planning to have an union here where we could add
add the driver specific options if we need to have another crypto driver,
however since I discovered that union needs user to pass the driver name,
I just placed it in a struct.

So this struct is supposed to represent driver specific options, but
currently contains only luks options.

> 
> > +#
> > +# @key-secret: the ID of a QCryptoSecret object providing the password
> > +#              to add or to erase (optional for erase)
> > +#
> > +# @old-key-secret: the ID of a QCryptoSecret object providing the password
> > +#                  that can currently unlock the image
> > +#
> > +# @slot: Key slot to update/erase
> > +#        (optional, for update will select a free slot,
> > +#        for erase will erase all slots that match the password)
> > +#
> > +# @iter-time: number of milliseconds to spend in
> > +#             PBKDF passphrase processing. Currently defaults to 2000
> > +# Since: 4.2
> > +##
> > +{ 'struct': 'QCryptoEncryptionSetupOptions',
> > +  'data': { '*key-secret': 'str',
> > +            '*old-key-secret': 'str',
> > +            '*slot': 'int',
> > +            '*iter-time': 'int' } }
> 
> The two new commands have identical arguments.  Some of them you factor
> out into their own struct.  Can you explain what makes them special?


Uniting these means that I need to add some kind of 'action' to the
options, which is kind of adding a subcommand to a qmp command, which is also feels
kind of wrong.

That is why internally this is implemented as one block driver callback,
with action = {erase,update}, but qmp exposes two commands.

I would personally prefer to have that erase field,and I would have to have
it, if I switch to the amend interface.


> 
> The extra nesting on the wire is kind of ugly.  We can talk about how to
> avoid it once I understand why we want the extra struct.
> 
I kind of agree with that but The reason for that is that I designed that interface like that is  to be not specific to luks.

I pass the options structure down the stack till it reaches the luks driver where it can deal with
it. If a new crypto driver is added, all you would have to do is to define new options in the json,
and use them in the new crypto driver. The rest of the code doesn't know what is in that struct.
Kind of the same as done with blockdev-create I guess.

Thanks for the review,
Best regards,
	Maxim Levitsky





