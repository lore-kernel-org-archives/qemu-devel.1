Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E489C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 16:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD7F2082F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 16:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD7F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1vcD-0000qA-Dt
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 12:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1vbV-0000JP-Vc
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1vbU-0004z5-Qu
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 12:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37630)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1vbR-0004xp-Hh; Sun, 25 Aug 2019 12:42:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 352153082E03;
 Sun, 25 Aug 2019 16:42:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBB61600C4;
 Sun, 25 Aug 2019 16:42:47 +0000 (UTC)
Message-ID: <a09a2f7188892621cc1f4c20f658a8a44a50bd71.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Sun, 25 Aug 2019 19:42:47 +0300
In-Reply-To: <877e75cmzn.fsf@dusky.pond.sub.org>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
 <87sgpukafd.fsf@dusky.pond.sub.org>
 <2ac0407fbbed8558dc22fc0b8a30ef77bddcea6f.camel@redhat.com>
 <877e75cmzn.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sun, 25 Aug 2019 16:42:52 +0000 (UTC)
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

On Thu, 2019-08-22 at 16:07 +0200, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Wed, 2019-08-21 at 13:47 +0200, Markus Armbruster wrote:
> > > Maxim Levitsky <mlevitsk@redhat.com> writes:
> > > 
> > > > This adds:
> > > > 
> > > > * x-blockdev-update-encryption and x-blockdev-erase-encryption qmp commands
> > > >   Both commands take the QCryptoKeyManageOptions
> > > >   the x-blockdev-update-encryption is meant for non destructive addition
> > > >   of key slots / whatever the encryption driver supports in the future
> > > > 
> > > >   x-blockdev-erase-encryption is meant for destructive encryption key erase,
> > > >   in some cases even without way to recover the data.
> > > > 
> > > > 
> > > > * bdrv_setup_encryption callback in the block driver
> > > >   This callback does both the above functions with 'action' parameter
> > > > 
> > > > * QCryptoKeyManageOptions with set of options that drivers can use for encryption managment
> > > >   Currently it has all the options that LUKS needs, and later it can be extended
> > > >   (via union) to support more encryption drivers if needed
> > > > 
> > > > * blk_setup_encryption / bdrv_setup_encryption - the usual block layer wrappers.
> > > >   Note that bdrv_setup_encryption takes BlockDriverState and not BdrvChild,
> > > >   for the ease of use from the qmp code. It is not expected that this function
> > > >   will be used by anything but qmp and qemu-img code
> > > > 
> > > > 
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > 
> > > [...]
> > > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > > index 0d43d4f37c..53ed411eed 100644
> > > > --- a/qapi/block-core.json
> > > > +++ b/qapi/block-core.json
> > > > @@ -5327,3 +5327,39 @@
> > > >    'data' : { 'node-name': 'str',
> > > >               'iothread': 'StrOrNull',
> > > >               '*force': 'bool' } }
> > > > +
> > > > +
> > > > +##
> > > > +# @x-blockdev-update-encryption:
> > > > +#
> > > > +# Update the encryption keys for an encrypted block device
> > > > +#
> > > > +# @node-name: 	  Name of the blockdev to operate on
> > > > +# @force:         Disable safety checks (use with care)
> > > 
> > > What checks excactly are disabled?
> > 
> > Ability to overwrite an used slot with a different password. 
> > If overwrite fails, the image won't be recoverable.
> > 
> > The safe way is to add a new slot, then erase the old
> > one, but this changes the slot where the password
> > is stored, unless this procedure is used twice
> 
> Would this be a useful addition to the doc comment?
> 
> > > > +# @options:       Driver specific options
> > > > +#
> > > > +
> > > > +# Since: 4.2
> > > > +##
> > > > +{ 'command': 'x-blockdev-update-encryption',
> > > > +  'data': { 'node-name' : 'str',
> > > > +            '*force' : 'bool',
> > > > +            'options': 'QCryptoEncryptionSetupOptions' } }
> > > > +
> > > > +##
> > > > +# @x-blockdev-erase-encryption:
> > > > +#
> > > > +# Erase the encryption keys for an encrypted block device
> > > > +#
> > > > +# @node-name: 	  Name of the blockdev to operate on
> > > > +# @force:         Disable safety checks (use with care)
> > > 
> > > Likewise.
> > 
> > 1. Erase a slot which is already marked as
> > erased. Mostly harmless but pointless as well.
> > 
> > 2. Erase last keyslot. This irreversibly destroys
> > any ability to read the data from the device,
> > unless a backup of the header and the key material is
> > done prior. Still can be useful when it is desired to
> > erase the data fast.
> 
> Would this be a useful addition to the doc comment?
Yea, but since I'll will switch to the amend interface,
I'll leave it like that for now.


[...]


Best regards,
	Maxim Levitsky


