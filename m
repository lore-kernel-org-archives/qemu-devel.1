Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE2FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E5B2178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUwTE+1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E5B2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0aC-0006L5-Dp
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Z7-0005Np-OW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT0Z6-0004vF-Dr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:28:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54547
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT0Z6-0004uw-Ad
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573205304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kI9nm/gRq6E3Bwif70n+mzO9m76rCou1jleENAXlEjw=;
 b=HUwTE+1ZegD5DV3PaghCeI6d7a07SVjLVmcTTNaBCRdeleDmnMCGPAH7NwbIAV+YIY8LRc
 0iGKLVp8EIsGQzh5aSe8SIeUptCCNOBglHrGze3WP6HUynD50d6n3RL9Bhwi8Yfw4338Gi
 G9sy4vhjDTQk7JEe/1l3TDlqkJJHXsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-09HqlnGyMl6_IcGL8aPWHg-1; Fri, 08 Nov 2019 04:28:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87708107ACC3;
 Fri,  8 Nov 2019 09:28:19 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF17860BE2;
 Fri,  8 Nov 2019 09:28:11 +0000 (UTC)
Message-ID: <85a91669bbcd234ee238abb6a5b32d408921bb8a.camel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/11] qcrypto-luks: extend the create
 options for upcoming encryption key management
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Fri, 08 Nov 2019 11:28:10 +0200
In-Reply-To: <87imp1j8qo.fsf@dusky.pond.sub.org>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-3-mlevitsk@redhat.com>
 <87imp1j8qo.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 09HqlnGyMl6_IcGL8aPWHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-10-07 at 09:49 +0200, Markus Armbruster wrote:
> Quick QAPI schema review only.
>=20
> Maxim Levitsky <mlevitsk@redhat.com> writes:
>=20
> > Now you can specify which slot to put the encryption key to
> > Plus add 'active' option which will let  user erase the key secret
> > instead of adding it.
> > Check that active=3Dtrue it when creating.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20
> [...]
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index b2a4cff683..9b83a70634 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -190,6 +190,20 @@
>=20
>    ##
>    # @QCryptoBlockCreateOptionsLUKS:
>    #
>    # The options that apply to LUKS encryption format initialization
>    #
>    # @cipher-alg: the cipher algorithm for data encryption
>    #              Currently defaults to 'aes-256'.
>    # @cipher-mode: the cipher mode for data encryption
>    #               Currently defaults to 'xts'
>    # @ivgen-alg: the initialization vector generator
>    #             Currently defaults to 'plain64'
>    # @ivgen-hash-alg: the initialization vector generator hash
> >  #                  Currently defaults to 'sha256'
> >  # @hash-alg: the master key hash algorithm
> >  #            Currently defaults to 'sha256'
> > +#
> > +# @active: Should the new secret be added (true) or erased (false)
> > +#          (amend only, since 4.2)
>=20
> Is "active" established terminology?  I wouldn't have guessed its
> meaning from its name...

Yea, this is one of the warts of the interface that I wanted to discuss wit=
h everyone
basically the result of using same API for creation and amend.

blockdev-amend, similiar to qemu-img amend will allow the user to change th=
e format driver
settings, and will use the same BlockdevCreateOptions for that, similiar to=
 how qemu-img amend works.

For creation of course the 'active' parameter is redundant, and it is force=
d to true.
For amend it allows to add or erase a new key.
We couldn't really think about any better name, so I kind of decided just t=
o document
this and leave it like that.

>=20
> As far as I can see, QCryptoBlockCreateOptionsLUKS is used just for
> blockdev-create with options.driver \in { luks, qcow, qcow2 }:
>=20
>    { 'command': 'blockdev-create',
>      'data': { ...
>                'options': 'BlockdevCreateOptions' } }
>=20
>    { 'union': 'BlockdevCreateOptions',
>      ...
>      'data': {
>          ...
>          'luks':           'BlockdevCreateOptionsLUKS',
>          ...
>          'qcow':           'BlockdevCreateOptionsQcow',
>          'qcow2':          'BlockdevCreateOptionsQcow2',
>          ... } }
>=20
> With luks:
>=20
>    { 'struct': 'BlockdevCreateOptionsLUKS',
>      'base': 'QCryptoBlockCreateOptionsLUKS',
>      ... }
>=20
> With qcow and qcow2:
>=20
>     { 'struct': 'BlockdevCreateOptionsQcow',
>       'data': { ...
>                 '*encrypt':         'QCryptoBlockCreateOptions' } }
>     { 'struct': 'BlockdevCreateOptionsQcow2',
>       'data': { ...
>                 '*encrypt':         'QCryptoBlockCreateOptions',
>                 ... } }
>=20
>     { 'union': 'QCryptoBlockCreateOptions',
>       'base': 'QCryptoBlockOptionsBase',
>       'discriminator': 'format',
>       'data': { ...
>                 'luks': 'QCryptoBlockCreateOptionsLUKS' } }
>=20
> I think I understand why we want blockdev-create to be able to specify a
> new secret.
>=20
> Why do we want it to be able to delete an existing secret?  How would
> that even work?  Color me confused...

The BlockdevCreateOptions will now be used in
both creation and amend of a block device. Of course the deletion
of an existing secret doesn't make sense on creation time, and a check
is present to disallow the user to do that.

At the same time, the size and 'file' arguments are made optional,
so that during amend you could change the block device without
specifying those.


>=20
> > +#
> > +# @slot: The slot in which to put/erase the secret
> > +#        if not given, will select first free slot for secret addtion
> > +#        and erase all matching keyslots for erase. except last one
> > +#        (optional, since 4.2)
>=20
> Excuse my possibly ignorant question: what exactly is a "matching
> keyslot"?
Not ignorant at all, I dropped a word here.
I meant to say that it will erase all the keyslots which match the given
secret, except last one. The 'active' is what decides if to add to to remov=
e
a secret.


>=20
> > +#
> > +# @unlock-secret: The secret to use to unlock the image
> > +#        If not given, will use the secret that was used
> > +#        when opening the image.
> > +#        (optional, for amend only, since 4.2)
>=20
> More ignorance: what is "amend"?  No mention of it in qapi/*json...
Not ignorant at all again! This interface will be added in the next patch,
and all the changes in this patch (other that specifying the keyslot,
which can be in theory useful anyway) are for it.


>=20
> > +#
> >  # @iter-time: number of milliseconds to spend in
> >  #             PBKDF passphrase processing. Currently defaults
> >  #             to 2000. (since 2.8)
> > @@ -201,7 +215,12 @@
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
> > =20
> > =20
>=20
> [...]


Best regards,
=09Maxim Levitsky


