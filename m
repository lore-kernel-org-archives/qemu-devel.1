Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4CF206BB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4CF206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PDU-000169-Nt
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i0P5P-0002CP-7y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i0P5L-0004th-6H
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1i0P59-0004ff-QJ; Wed, 21 Aug 2019 07:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 033188980ED;
 Wed, 21 Aug 2019 11:47:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E98E5E1B9;
 Wed, 21 Aug 2019 11:47:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 904AC11655EE; Wed, 21 Aug 2019 13:47:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-8-mlevitsk@redhat.com>
Date: Wed, 21 Aug 2019 13:47:02 +0200
In-Reply-To: <20190814202219.1870-8-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Wed, 14 Aug 2019 23:22:13 +0300")
Message-ID: <87sgpukafd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 21 Aug 2019 11:47:11 +0000 (UTC)
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Maxim Levitsky <mlevitsk@redhat.com> writes:

> This adds:
>
> * x-blockdev-update-encryption and x-blockdev-erase-encryption qmp commands
>   Both commands take the QCryptoKeyManageOptions
>   the x-blockdev-update-encryption is meant for non destructive addition
>   of key slots / whatever the encryption driver supports in the future
>
>   x-blockdev-erase-encryption is meant for destructive encryption key erase,
>   in some cases even without way to recover the data.
>
>
> * bdrv_setup_encryption callback in the block driver
>   This callback does both the above functions with 'action' parameter
>
> * QCryptoKeyManageOptions with set of options that drivers can use for encryption managment
>   Currently it has all the options that LUKS needs, and later it can be extended
>   (via union) to support more encryption drivers if needed
>
> * blk_setup_encryption / bdrv_setup_encryption - the usual block layer wrappers.
>   Note that bdrv_setup_encryption takes BlockDriverState and not BdrvChild,
>   for the ease of use from the qmp code. It is not expected that this function
>   will be used by anything but qmp and qemu-img code
>
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..53ed411eed 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5327,3 +5327,39 @@
>    'data' : { 'node-name': 'str',
>               'iothread': 'StrOrNull',
>               '*force': 'bool' } }
> +
> +
> +##
> +# @x-blockdev-update-encryption:
> +#
> +# Update the encryption keys for an encrypted block device
> +#
> +# @node-name: 	  Name of the blockdev to operate on
> +# @force:         Disable safety checks (use with care)

What checks excactly are disabled?

> +# @options:       Driver specific options
> +#
> +
> +# Since: 4.2
> +##
> +{ 'command': 'x-blockdev-update-encryption',
> +  'data': { 'node-name' : 'str',
> +            '*force' : 'bool',
> +            'options': 'QCryptoEncryptionSetupOptions' } }
> +
> +##
> +# @x-blockdev-erase-encryption:
> +#
> +# Erase the encryption keys for an encrypted block device
> +#
> +# @node-name: 	  Name of the blockdev to operate on
> +# @force:         Disable safety checks (use with care)

Likewise.

> +# @options:       Driver specific options
> +#
> +# Returns: @QCryptoKeyManageResult

Doc comment claims the command returns something, even though it
doesn't.  Please fix.  Sadly, the doc generator fails to flag that.

> +#
> +# Since: 4.2
> +##
> +{ 'command': 'x-blockdev-erase-encryption',
> +  'data': { 'node-name' : 'str',
> +            '*force' : 'bool',
> +            'options': 'QCryptoEncryptionSetupOptions' } }
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index b2a4cff683..69e8b086db 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -309,3 +309,29 @@
>    'base': 'QCryptoBlockInfoBase',
>    'discriminator': 'format',
>    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> +
> +
> +##
> +# @QCryptoEncryptionSetupOptions:
> +#
> +# Driver specific options for encryption key management.

Specific to which driver?

> +#
> +# @key-secret: the ID of a QCryptoSecret object providing the password
> +#              to add or to erase (optional for erase)
> +#
> +# @old-key-secret: the ID of a QCryptoSecret object providing the password
> +#                  that can currently unlock the image
> +#
> +# @slot: Key slot to update/erase
> +#        (optional, for update will select a free slot,
> +#        for erase will erase all slots that match the password)
> +#
> +# @iter-time: number of milliseconds to spend in
> +#             PBKDF passphrase processing. Currently defaults to 2000
> +# Since: 4.2
> +##
> +{ 'struct': 'QCryptoEncryptionSetupOptions',
> +  'data': { '*key-secret': 'str',
> +            '*old-key-secret': 'str',
> +            '*slot': 'int',
> +            '*iter-time': 'int' } }

The two new commands have identical arguments.  Some of them you factor
out into their own struct.  Can you explain what makes them special?

The extra nesting on the wire is kind of ugly.  We can talk about how to
avoid it once I understand why we want the extra struct.

