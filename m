Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC68C3A59E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD68E216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 00:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD68E216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0acQ-0007WW-2z
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 20:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0abM-0006JH-U8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0abL-0003PV-Vc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 20:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0abJ-0003NN-RB; Wed, 21 Aug 2019 20:05:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0015918C4260;
 Thu, 22 Aug 2019 00:05:12 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A500C60C05;
 Thu, 22 Aug 2019 00:05:08 +0000 (UTC)
Message-ID: <dfad98e6072f37d0a10f4f7c0b5c96aee77aaf18.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 03:05:07 +0300
In-Reply-To: <a55bee89-9f0a-07ee-e411-7f2811449199@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-2-mlevitsk@redhat.com>
 <a55bee89-9f0a-07ee-e411-7f2811449199@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 22 Aug 2019 00:05:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 01/13] block-crypto: misc refactoring
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-20 at 18:38 +0200, Max Reitz wrote:
> On 14.08.19 22:22, Maxim Levitsky wrote:
> > * rename the write_func to create_write_func,
> >   and init_func to create_init_func
> >   this is  preparation for other write_func that will
> >   be used to update the encryption keys.
> >=20
> > No functional changes
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >=20
>=20
> I=E2=80=99m not quite sure why you remove or add blank lines seemingly =
at random...

Basically to have consistent two space separation between all functions.
A bit of OCD I confess :-)

>=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 8237424ae6..42a3f0898b 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
>=20
> [...]
>=20
> > @@ -77,7 +76,7 @@ struct BlockCryptoCreateData {
> >  };
> > =20
> > =20
> > -static ssize_t block_crypto_write_func(QCryptoBlock *block,
> > +static ssize_t block_crypto_create_write_func(QCryptoBlock *block,
> >                                         size_t offset,
> >                                         const uint8_t *buf,
> >                                         size_t buflen,
>=20
> Alignment should be kept at the opening parentheses.
Opps. I am still trying to learn that rule. Fixed.

>=20
> But other than those two things, why not.
>=20
> Max
>=20

Best regards,
	Thanks for the review
		Maxim Levitsky



