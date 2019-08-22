Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9141AC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C5A22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 12:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C5A22CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ltF-0000We-KV
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 08:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0lbD-0003CH-Km
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0lbC-0000lf-5O
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53696)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0lb8-0000gN-CY; Thu, 22 Aug 2019 07:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3348308427C;
 Thu, 22 Aug 2019 11:49:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9951D60FA2;
 Thu, 22 Aug 2019 11:49:41 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:49:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822114939.GT3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-9-mlevitsk@redhat.com>
 <20190822111608.GN3267@redhat.com>
 <1cedbbf007f4447f9424d09848c6486b0341b43d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cedbbf007f4447f9424d09848c6486b0341b43d.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 22 Aug 2019 11:49:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 08/13] qcrypto: add the plumbing for
 encryption management
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 02:47:03PM +0300, Maxim Levitsky wrote:
> On Thu, 2019-08-22 at 12:16 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Aug 14, 2019 at 11:22:14PM +0300, Maxim Levitsky wrote:
> > > This adds qcrypto_block_manage_encryption, which
> > >  is thin wrapper around manage_encryption of the crypto driver
> > >  which is also added
> > >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  crypto/block.c         | 29 +++++++++++++++++++++++++++++
> > >  crypto/blockpriv.h     |  9 +++++++++
> > >  include/crypto/block.h | 27 +++++++++++++++++++++++++++
> > >  3 files changed, 65 insertions(+)
> > >=20
> > > diff --git a/crypto/block.c b/crypto/block.c
> > > index ee96759f7d..5916e49aba 100644
> > > --- a/crypto/block.c
> > > +++ b/crypto/block.c
> > > @@ -20,6 +20,7 @@
> > > =20
> > >  #include "qemu/osdep.h"
> > >  #include "qapi/error.h"
> > > +
> > >  #include "blockpriv.h"
> > >  #include "block-qcow.h"
> > >  #include "block-luks.h"
> > > @@ -282,6 +283,34 @@ void qcrypto_block_free(QCryptoBlock *block)
> > >  }
> > > =20
> > > =20
> > > +int qcrypto_block_setup_encryption(QCryptoBlock *block,
> > > +                                   QCryptoBlockReadFunc readfunc,
> > > +                                   QCryptoBlockWriteFunc writefunc=
,
> > > +                                   void *opaque,
> > > +                                   enum BlkSetupEncryptionAction a=
ction,
> > > +                                   QCryptoEncryptionSetupOptions *=
options,
> > > +                                   bool force,
> > > +                                   Error **errp)
> > > +{
> > > +    if (!block->driver->setup_encryption) {
> > > +        error_setg(errp,
> > > +                "Crypto format %s doesn't support management of en=
cryption keys",
> > > +                QCryptoBlockFormat_str(block->format));
> > > +        return -1;
> > > +    }
> > > +
> > > +    return block->driver->setup_encryption(block,
> > > +                                           readfunc,
> > > +                                           writefunc,
> > > +                                           opaque,
> > > +                                           action,
> > > +                                           options,
> > > +                                           force,
> > > +                                           errp);
> > > +}
> > > +
> > > +
> > > +
> > >  typedef int (*QCryptoCipherEncDecFunc)(QCryptoCipher *cipher,
> > >                                          const void *in,
> > >                                          void *out,
> > > diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
> > > index 71c59cb542..804965dca3 100644
> > > --- a/crypto/blockpriv.h
> > > +++ b/crypto/blockpriv.h
> > > @@ -81,6 +81,15 @@ struct QCryptoBlockDriver {
> > > =20
> > >      bool (*has_format)(const uint8_t *buf,
> > >                         size_t buflen);
> > > +
> > > +    int (*setup_encryption)(QCryptoBlock *block,
> > > +                            QCryptoBlockReadFunc readfunc,
> > > +                            QCryptoBlockWriteFunc writefunc,
> > > +                            void *opaque,
> > > +                            enum BlkSetupEncryptionAction action,
> > > +                            QCryptoEncryptionSetupOptions *options=
,
> > > +                            bool force,
> > > +                            Error **errp);
> > >  };
> > > =20
> > > =20
> > > diff --git a/include/crypto/block.h b/include/crypto/block.h
> > > index fe12899831..60d46e3efc 100644
> > > --- a/include/crypto/block.h
> > > +++ b/include/crypto/block.h
> > > @@ -23,6 +23,7 @@
> > > =20
> > >  #include "crypto/cipher.h"
> > >  #include "crypto/ivgen.h"
> > > +#include "block/block.h"
> > > =20
> > >  typedef struct QCryptoBlock QCryptoBlock;
> > > =20
> > > @@ -268,4 +269,30 @@ uint64_t qcrypto_block_get_sector_size(QCrypto=
Block *block);
> > >   */
> > >  void qcrypto_block_free(QCryptoBlock *block);
> > > =20
> > > +
> > > +/**
> > > + * qcrypto_block_setup_encryption:
> > > + * @block: the block encryption object
> > > + *
> > > + * @readfunc: callback for reading data from the volume header
> > > + * @writefunc: callback for writing data to the volume header
> > > + * @opaque: data to pass to @readfunc and @writefunc
> > > + * @action: tell the driver the setup action (add/erase currently)
> > > + * @options: driver specific options, that specify
> > > + *           what encryption settings to manage
> > > + * @force: hint for the driver to allow unsafe operation
> > > + * @errp: error pointer
> > > + *
> > > + * Adds/Erases a new encryption key using @options
> >=20
> > I'd prefer to see separate APIs for add + erase instead
> > of overloading. It'll lead to a clearer API from callers
> > POV to see exactly which parameters are for each action.
>=20
>=20
> The downside of this is some duplication of code in the middle layers.
> I don't mind doing that if you are OK with that.
>=20
> Also note that if we go with amend options, we will have to use the sin=
gle
> API.

That should not be the case. The interface used at the qemu-img/QMP
layer is something for the block layer to be concerned with. THis
code is in the crypto layer and shouldn't depend on stuff defined
in the block layer QAPI schema. The block layer ammend options impl
should translate to the relevant API calls needed at the crypto layer.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

