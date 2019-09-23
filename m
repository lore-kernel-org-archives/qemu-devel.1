Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A67C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7865120665
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7865120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOMb-0004UR-Jl
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iCOKe-0002d8-HX
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iCOKd-0007vQ-H9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:24:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:61055)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iCOKb-0007tr-EI; Mon, 23 Sep 2019 09:24:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED2DE51EF3;
 Mon, 23 Sep 2019 13:24:43 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D3AF5D784;
 Mon, 23 Sep 2019 13:24:39 +0000 (UTC)
Message-ID: <4392e976d685934283633fba3ac516c25d71f4ea.camel@redhat.com>
Subject: Re: [PATCH v2 01/11] qcrypto: add suport for amend options
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Mon, 23 Sep 2019 16:24:38 +0300
In-Reply-To: <29336f49-c364-1263-664b-61a4a02be0be@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <20190912223028.18496-2-mlevitsk@redhat.com>
 <29336f49-c364-1263-664b-61a4a02be0be@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 23 Sep 2019 13:24:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-09-23 at 08:08 -0500, Eric Blake wrote:
> On 9/12/19 5:30 PM, Maxim Levitsky wrote:
> > This adds the qcrypto_amend_options and corresponding
> > crypto driver callbacks for the  for encrypted
>=20
> grammar is off, did you miss a word where that double space is?
>=20
> > key managedment
>=20
> management


Thank you!
I'll try my best in the future to have less spelling and
grammar errors like that. I need to double check every
message prior to sending the patches.

>=20
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  crypto/block.c         | 31 +++++++++++++++++++++++++++++++
> >  crypto/blockpriv.h     |  8 ++++++++
> >  include/crypto/block.h | 22 ++++++++++++++++++++++
> >  3 files changed, 61 insertions(+)
> >=20
> > diff --git a/crypto/block.c b/crypto/block.c
> > index 325752871c..14b684de7f 100644
> > --- a/crypto/block.c
> > +++ b/crypto/block.c
> > @@ -115,6 +115,37 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockC=
reateOptions *options,
> >  }
> > =20
> > =20
> > +int qcrypto_block_amend_options(QCryptoBlock *block,
> > +                                QCryptoBlockReadFunc readfunc,
> > +                                QCryptoBlockWriteFunc writefunc,
> > +                                void *opaque,
> > +                                QCryptoBlockCreateOptions *options,
> > +                                bool force,
> > +                                Error **errp)
> > +{
> > +    if (options->format !=3D block->format) {
> > +        error_setg(errp,
> > +                   "Its not possible to change encryption format wit=
h amend interface");
> > +        return -1;
>=20
> "It's" (here, you want the form meaning "It is")
>=20
> Or reword the entire error to something shorter:
>=20
> error_setg(errp, "cannot amend encryption format")


Same here.
>=20


Thanks for the review,
Best regards,
	Maxim Levitsky



