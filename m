Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11169C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 14:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF06420850
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 14:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF06420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1tDy-0002p4-Qp
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 10:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1tD5-0002Ky-M1
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 10:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1tD4-0002HR-IQ
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 10:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44096)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1tD1-0002FW-QN; Sun, 25 Aug 2019 10:09:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5EF24307D915;
 Sun, 25 Aug 2019 14:09:30 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEFE15C3FD;
 Sun, 25 Aug 2019 14:09:25 +0000 (UTC)
Message-ID: <f5d156655abe4954da6784dea01512c06f58ed13.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Sun, 25 Aug 2019 17:09:24 +0300
In-Reply-To: <20190822103810.GH3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-4-mlevitsk@redhat.com>
 <20190822103810.GH3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Sun, 25 Aug 2019 14:09:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] qcrypto-luks: refactoring: extract
 load/store/check/parse header functions
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 11:38 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Aug 14, 2019 at 11:22:09PM +0300, Maxim Levitsky wrote:
> > With upcoming key management, the header will
> > need to be stored after the image is created.
> >=20
> > Extracting load header isn't strictly needed, but
> > do this anyway for the symmetry.
> >=20
> > Also I extracted a function that does basic sanity
> > checks on the just read header, and a function
> > which parses all the crypto format to make the
> > code a bit more readable, plus now the code
> > doesn't destruct the in-header cipher-mode string,
> > so that the header now can be stored many times,
> > which is needed for the key management.
> >=20
> > Also this allows to contain the endianess conversions
> > in these functions alone
> >=20
> > The header is no longer endian swapped in place,
> > to prevent (mostly theoretical races I think)
> > races where someone could see the header in the
> > process of beeing byteswapped.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 756 ++++++++++++++++++++++++++----------------=
--
> >  1 file changed, 440 insertions(+), 316 deletions(-)
> >      if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
> >          /* Try to find which key slot our password is valid for
> >           * and unlock the master key from that slot.
> >           */
> > -
> >          masterkey =3D g_new0(uint8_t, masterkeylen(luks));
> > =20
> >          if (qcrypto_block_luks_find_key(block,
> > @@ -845,12 +1132,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
> >      }
> > =20
> >      block->sector_size =3D QCRYPTO_BLOCK_LUKS_SECTOR_SIZE;
> > -    block->payload_offset =3D luks->header.payload_offset *
> > -        block->sector_size;
> > +    block->payload_offset =3D luks->header.payload_offset * block->s=
ector_size;
> > =20
> >      g_free(masterkey);
> >      g_free(password);
> > -
> >      return 0;
>=20
> Smoe unrelated whitespace changes here.
>=20
>=20
> > +    /* populate the slot 0 with the password encrypted master key*/
> > +    /* This will also store the header */
> > +    if (qcrypto_block_luks_store_key(block,
> > +                                     0,
> > +                                     password,
> > +                                     masterkey,
> > +                                     luks_opts.iter_time,
> > +                                     writefunc,
> > +                                     opaque,
> > +                                     errp)) {
> >          goto error;
> > -    }
> > +     }
>=20
> Indent is off by 1
>=20
>=20
> Regards,
> Daniel


Fixed,


Best regards,
	Maxim Levitsky


