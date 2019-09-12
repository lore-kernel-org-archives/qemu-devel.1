Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF0C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A012A20650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 08:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A012A20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8KDE-0005w4-RW
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 04:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8KCW-0005QB-TI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8KCV-0006xc-RA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 04:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8KCT-0006vp-EV; Thu, 12 Sep 2019 04:11:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DB573064FD2;
 Thu, 12 Sep 2019 08:11:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D70419C77;
 Thu, 12 Sep 2019 08:11:25 +0000 (UTC)
Message-ID: <be99fca21148f2f1626896e9a7bc297e3a93b481.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 11:11:24 +0300
In-Reply-To: <20190906133454.GI5119@redhat.com>
References: <20190826135103.22410-1-mlevitsk@redhat.com>
 <20190826135103.22410-14-mlevitsk@redhat.com>
 <20190906133454.GI5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 12 Sep 2019 08:11:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qcrypto-luks: implement more
 rigorous header checking
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

On Fri, 2019-09-06 at 14:34 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Aug 26, 2019 at 04:51:03PM +0300, Maxim Levitsky wrote:
> > Check that keyslots don't overlap with the data,
> > and check that keyslots don't overlap with each other.
> > (this is done using naive O(n^2) nested loops,
> > but since there are just 8 keyslots, this doesn't really matter.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  crypto/block-luks.c | 46 +++++++++++++++++++++++++++++++++++++++++++=
--
> >  1 file changed, 44 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index db0fb764b4..fdf4c41f8a 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -541,12 +541,12 @@ fail:
> >  static int
> >  qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks, Error =
**errp)
> >  {
> > -    int ret;
> > +    int ret =3D -EINVAL;
>=20
> As before, no need to use errnos, just return -1 immediately.
>=20
> > +    size_t i, j;
> > =20
> >      if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
> >                 QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
> >          error_setg(errp, "Volume is not in LUKS format");
> > -        ret =3D -EINVAL;
> >          goto fail;
> >      }
> > =20
> > @@ -557,6 +557,48 @@ qcrypto_block_luks_check_header(const QCryptoBlo=
ckLUKS *luks, Error **errp)
> >          goto fail;
> >      }
> > =20
> > +    /* Check all keyslots for corruption  */
> > +    for (i =3D 0 ; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; i++) {
> > +
> > +        const QCryptoBlockLUKSKeySlot *slot1 =3D &luks->header.key_s=
lots[i];
> > +        unsigned int start1 =3D slot1->key_offset_sector;
> > +        unsigned int len1 =3D
> > +            qcrypto_block_luks_splitkeylen_sectors(luks, slot1->stri=
pes);
> > +
> > +        if (slot1->stripes =3D=3D 0) {
> > +            error_setg(errp, "Keyslot %zu is corrupted (stripes =3D=3D=
 0)", i);
> > +            goto fail;
> > +        }
>=20
> How about checking stripes !=3D QCRYPTO_BLOCK_LUKS_STRIPES because
> AFAIR, you're required to use 4k stripes in luks v1.
I see that spec does allow for user defined number of stripes.

>=20
> Also how about  checking    iters >=3D MIN_SLOT_KEY_ITERS
Also this is only a suggested minimum

>=20
> > +
> > +        if (slot1->active !=3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_DISABLED =
&&
> > +                slot1->active !=3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_ENABL=
ED) {
>=20
> Align the two lines with (
Done
>=20
> > +            error_setg(errp,
> > +                       "Keyslot %zu state (active/disable) is corrup=
ted", i);
> > +            goto fail;
> > +        }
> > +
> > +        if (start1 + len1 > luks->header.payload_offset_sector) {
> > +            error_setg(errp,
> > +                       "Keyslot %zu is overlapping with the encrypte=
d payload",
> > +                       i);
> > +            goto fail;
> > +        }
> > +
> > +        for (j =3D i + 1 ; j < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; j+=
+) {
> > +            const QCryptoBlockLUKSKeySlot *slot2 =3D &luks->header.k=
ey_slots[j];
> > +            unsigned int start2 =3D slot2->key_offset_sector;
> > +            unsigned int len2 =3D
> > +                qcrypto_block_luks_splitkeylen_sectors(luks, slot2->=
stripes);
> > +
> > +            if (start1 + len1 > start2 && start2 + len2 > start1) {
> > +                error_setg(errp,
> > +                           "Keyslots %zu and %zu are overlapping in =
the header",
> > +                           i, j);
> > +                goto fail;
> > +            }
> > +        }
> > +
> > +    }
> >      return 0;
> >  fail:
> >      return ret;
> > --=20
> > 2.17.2
> >=20
>=20
> Regards,
> Daniel

Best regards,
	Maxim Levitsky


