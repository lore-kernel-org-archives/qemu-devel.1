Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636F3C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3893A2133F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3893A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHNmY-0003wz-E3
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 03:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHNls-0003Se-Va
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHNlr-000225-J0
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHNln-00020T-JO; Mon, 07 Oct 2019 03:49:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E17B518C8911;
 Mon,  7 Oct 2019 07:49:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35EB260127;
 Mon,  7 Oct 2019 07:49:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E4A21138648; Mon,  7 Oct 2019 09:49:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/11] qcrypto-luks: extend the create
 options for upcoming encryption key management
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-3-mlevitsk@redhat.com>
Date: Mon, 07 Oct 2019 09:49:19 +0200
In-Reply-To: <20190912223028.18496-3-mlevitsk@redhat.com> (Maxim Levitsky's
 message of "Fri, 13 Sep 2019 01:30:19 +0300")
Message-ID: <87imp1j8qo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Mon, 07 Oct 2019 07:49:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quick QAPI schema review only.

Maxim Levitsky <mlevitsk@redhat.com> writes:

> Now you can specify which slot to put the encryption key to
> Plus add 'active' option which will let  user erase the key secret
> instead of adding it.
> Check that active=true it when creating.
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[...]
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index b2a4cff683..9b83a70634 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -190,6 +190,20 @@
   ##
   # @QCryptoBlockCreateOptionsLUKS:
   #
   # The options that apply to LUKS encryption format initialization
   #
   # @cipher-alg: the cipher algorithm for data encryption
   #              Currently defaults to 'aes-256'.
   # @cipher-mode: the cipher mode for data encryption
   #               Currently defaults to 'xts'
   # @ivgen-alg: the initialization vector generator
   #             Currently defaults to 'plain64'
   # @ivgen-hash-alg: the initialization vector generator hash
>  #                  Currently defaults to 'sha256'
>  # @hash-alg: the master key hash algorithm
>  #            Currently defaults to 'sha256'
> +#
> +# @active: Should the new secret be added (true) or erased (false)
> +#          (amend only, since 4.2)

Is "active" established terminology?  I wouldn't have guessed its
meaning from its name...

As far as I can see, QCryptoBlockCreateOptionsLUKS is used just for
blockdev-create with options.driver \in { luks, qcow, qcow2 }:

   { 'command': 'blockdev-create',
     'data': { ...
               'options': 'BlockdevCreateOptions' } }

   { 'union': 'BlockdevCreateOptions',
     ...
     'data': {
         ...
         'luks':           'BlockdevCreateOptionsLUKS',
         ...
         'qcow':           'BlockdevCreateOptionsQcow',
         'qcow2':          'BlockdevCreateOptionsQcow2',
         ... } }

With luks:

   { 'struct': 'BlockdevCreateOptionsLUKS',
     'base': 'QCryptoBlockCreateOptionsLUKS',
     ... }

With qcow and qcow2:

    { 'struct': 'BlockdevCreateOptionsQcow',
      'data': { ...
                '*encrypt':         'QCryptoBlockCreateOptions' } }
    { 'struct': 'BlockdevCreateOptionsQcow2',
      'data': { ...
                '*encrypt':         'QCryptoBlockCreateOptions',
                ... } }

    { 'union': 'QCryptoBlockCreateOptions',
      'base': 'QCryptoBlockOptionsBase',
      'discriminator': 'format',
      'data': { ...
                'luks': 'QCryptoBlockCreateOptionsLUKS' } }

I think I understand why we want blockdev-create to be able to specify a
new secret.

Why do we want it to be able to delete an existing secret?  How would
that even work?  Color me confused...

> +#
> +# @slot: The slot in which to put/erase the secret
> +#        if not given, will select first free slot for secret addtion
> +#        and erase all matching keyslots for erase. except last one
> +#        (optional, since 4.2)

Excuse my possibly ignorant question: what exactly is a "matching
keyslot"?

> +#
> +# @unlock-secret: The secret to use to unlock the image
> +#        If not given, will use the secret that was used
> +#        when opening the image.
> +#        (optional, for amend only, since 4.2)

More ignorance: what is "amend"?  No mention of it in qapi/*json...

> +#
>  # @iter-time: number of milliseconds to spend in
>  #             PBKDF passphrase processing. Currently defaults
>  #             to 2000. (since 2.8)
> @@ -201,7 +215,12 @@
>              '*cipher-mode': 'QCryptoCipherMode',
>              '*ivgen-alg': 'QCryptoIVGenAlgorithm',
>              '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
> +
>              '*hash-alg': 'QCryptoHashAlgorithm',
> +            '*active' : 'bool',
> +            '*slot': 'int',
> +            '*unlock-secret': 'str',
> +
>              '*iter-time': 'int'}}
>  
>  
[...]

