Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888B4C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:01:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEA5214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEA5214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpV8H-0002Ji-2k
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hpV82-0001kX-A4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hpV81-0006Ar-6g
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:01:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37102)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hpV7y-00068J-Mj; Mon, 22 Jul 2019 06:01:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3C2D30224A4;
 Mon, 22 Jul 2019 10:01:05 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F6645F7C0;
 Mon, 22 Jul 2019 10:01:03 +0000 (UTC)
Message-ID: <d7b22bda88c34a14fdd9c89a9456a80c7cb48337.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Mon, 22 Jul 2019 13:01:02 +0300
In-Reply-To: <20190722091528.GD23775@redhat.com>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
 <20190721181508.28608-3-mlevitsk@redhat.com>
 <20190722091528.GD23775@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 22 Jul 2019 10:01:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 2/2] qemu-img: better error
 message when opening a backing file fails
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-07-22 at 10:15 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Sun, Jul 21, 2019 at 09:15:08PM +0300, Maxim Levitsky wrote:
> > Currently we print message like that:
> >=20
> > "
> > new_file.qcow2 : error message
> > "
> >=20
> > However the error could have come from opening the backing file (e.g =
when it missing encryption keys),
> > thus try to clarify this by using this format:
> >=20
> > "
> > qemu-img: error creating new_file.qcow2: base_file.qcow2: error messa=
ge
> > Could not open backing image to determine size.
> > "
> >=20
> >=20
> > Test used:
> >=20
> > qemu-img create -f qcow2 \
> >         --object secret,id=3Dsec0,data=3Dhunter9 \
> >         --object secret,id=3Dsec1,data=3Dmy_new_secret_password \
> >         -b 'json:{ "encrypt.key-secret": "sec1", "driver": "qcow2", "=
file": { "driver": "file", "filename": "base.qcow2" }}' \
> >         -o encrypt.format=3Dluks,encrypt.key-secret=3Dsec1 \
> >         sn.qcow2
> >=20
> >=20
> > Error message before:
> >=20
> > qemu-img: sn.qcow2: Invalid password, cannot unlock any keyslot
> > Could not open backing image to determine size.
> >=20
> >=20
> > Error message after:
> >=20
> > qemu-img: error creating sn.qcow2: \
> > 	json:{ "encrypt.key-secret": "sec1", "driver": "qcow2", "file": { "d=
river": "file", "filename": "base.qcow2" }}: \
> > 	Invalid password, cannot unlock any keyslot
> > Could not open backing image to determine size.
> >=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block.c    | 1 +
> >  qemu-img.c | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/block.c b/block.c
> > index 29e931e217..5eb47b2199 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -5790,6 +5790,7 @@ void bdrv_img_create(const char *filename, cons=
t char *fmt,
> >                              "This may become an error in future vers=
ions.\n");
> >              local_err =3D NULL;
> >          } else if (!bs) {
> > +            error_prepend(&local_err, "%s: ", backing_file);
> >              /* Couldn't open bs, do not have size */
> >              error_append_hint(&local_err,
> >                                "Could not open backing image to deter=
mine size.\n");
>=20
> I think it'd be better todo
>=20
>               error_append_hint(&local_err,
>                                 "Could not open backing image '%s' to d=
etermine size.\n",
>                                  backing_file);
>=20
> At least when backing_file isn't a horrible blob of JSON, the error
> message is easier to read this way IMHO.
I agree, but I guess I need to drop this patch because of possible nestin=
g of the backing files,
as Kevin Wolf pointed out.

Best regards,
	Maxim Levitsky


