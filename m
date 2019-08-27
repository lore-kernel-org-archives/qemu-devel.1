Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913F6C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 635022070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635022070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XIo-0001NP-L4
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i2XH0-0007S8-UR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i2XGz-0000MS-Fi
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:56:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i2XGv-0000Kt-K1; Tue, 27 Aug 2019 04:56:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3286811A9;
 Tue, 27 Aug 2019 08:56:12 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B1CE194B2;
 Tue, 27 Aug 2019 08:56:07 +0000 (UTC)
Date: Tue, 27 Aug 2019 09:56:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190827085604.GD16500@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-7-mlevitsk@redhat.com>
 <20190822110448.GK3267@redhat.com>
 <ba3ddc4c3c6dd18b7a7c913e55e52ddc8c9efeb0.camel@redhat.com>
 <cd92c8fe167d241255b3f61aca39b693364bf225.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd92c8fe167d241255b3f61aca39b693364bf225.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 27 Aug 2019 08:56:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 06/13] qcrypto-luks: implement more
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 25, 2019 at 07:08:00PM +0300, Maxim Levitsky wrote:
> On Sun, 2019-08-25 at 18:40 +0300, Maxim Levitsky wrote:
> > On Thu, 2019-08-22 at 12:04 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Aug 14, 2019 at 11:22:12PM +0300, Maxim Levitsky wrote:
> > > > Check that keyslots don't overlap with the data,
> > > > and check that keyslots don't overlap with each other.
> > > > (this is done using naive O(n^2) nested loops,
> > > > but since there are just 8 keyslots, this doens't really matter.
> > > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  crypto/block-luks.c | 42 +++++++++++++++++++++++++++++++++++++++=
+++
> > > >  1 file changed, 42 insertions(+)
> > > >=20
> > > > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > > > index 336e633df4..1997e92fe1 100644
> > > > --- a/crypto/block-luks.c
> > > > +++ b/crypto/block-luks.c
> > > > @@ -551,6 +551,8 @@ static int
> > > >  qcrypto_block_luks_check_header(QCryptoBlockLUKS *luks, Error **=
errp)
> > > >  {
> > > >      int ret;
> > > > +    int i, j;
> > > > +
> > > > =20
> > > >      if (memcmp(luks->header.magic, qcrypto_block_luks_magic,
> > > >                 QCRYPTO_BLOCK_LUKS_MAGIC_LEN) !=3D 0) {
> > > > @@ -566,6 +568,46 @@ qcrypto_block_luks_check_header(QCryptoBlock=
LUKS *luks, Error **errp)
> > > >          goto fail;
> > > >      }
> > > > =20
> > > > +    /* Check all keyslots for corruption  */
> > > > +    for (i =3D 0 ; i < QCRYPTO_BLOCK_LUKS_NUM_KEY_SLOTS ; i++) {
> > > > +
> > > > +        QCryptoBlockLUKSKeySlot *slot1 =3D &luks->header.key_slo=
ts[i];
> > > > +        uint start1 =3D slot1->key_offset;
> > > > +        uint len1 =3D splitkeylen_sectors(luks, slot1->stripes);
> > >=20
> > > Using 'uint' is not normal QEMU style.
> > >=20
> > > Either use 'unsigned int'  or if a specific size is needed
> > > then one of the 'guintNN' types from glib.
> > >=20
> > > This applies elsewhere in this patch series too, but
> > > I'll only comment here & let you find the other cases.
> >=20
> > Fixed. Sorry for the noise.
> >=20
> > >=20
> > > > +
> > > > +        if (slot1->stripes =3D=3D 0 ||
> > > > +                (slot1->active !=3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_=
DISABLED &&
> > > > +                slot1->active !=3D QCRYPTO_BLOCK_LUKS_KEY_SLOT_E=
NABLED)) {
> > > > +
> > >=20
> > > Redundant blank line
> >=20
> > Fixed
> > >=20
> > > > +            error_setg(errp, "Keyslot %i is corrupted", i);
> > >=20
> > > I'd do a separate check for stripes and active fields, and then giv=
e a
> > > specific error message for each. That way if this does ever trigger
> > > in practice will immediately understand which check failed.
> > >=20
> > > Also using '%d' rather than '%i' is more common convention
> >=20
> > Done.
>=20
> Note that I switched i,j to be size_t since you said that you prefer th=
is,
> and to print this I apparently need %lu.

For size_t, you need %zu to be 32/64-bit agnostic  (ssize_t is %zd)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

