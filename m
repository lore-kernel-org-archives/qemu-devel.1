Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B7C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D6120989
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D6120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOIC9-0003Lo-7O
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 04:44:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hOIBN-00031Z-2q
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hOIBL-0004i5-VK
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hOIBL-0004hY-ND; Wed, 08 May 2019 04:44:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41C61307D962;
	Wed,  8 May 2019 08:44:06 +0000 (UTC)
Received: from gondolin (ovpn-204-161.brq.redhat.com [10.40.204.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 496F95D9D6;
	Wed,  8 May 2019 08:44:04 +0000 (UTC)
Date: Wed, 8 May 2019 10:44:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190508104400.68e62de0.cohuck@redhat.com>
In-Reply-To: <42ffdd81-7bbd-1a46-c4f9-3771ea26a84b@linux.ibm.com>
References: <20190507081251.24307-1-cohuck@redhat.com>
	<ee335c4c-468a-3e70-fe7e-02d0d77ef9d1@linux.ibm.com>
	<42ffdd81-7bbd-1a46-c4f9-3771ea26a84b@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 08 May 2019 08:44:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC v2] s390/css: handle CCW_FLAG_SKIP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pmorel@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 May 2019 11:31:16 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/7/19 5:08 AM, Pierre Morel wrote:
> > On 07/05/2019 10:12, Cornelia Huck wrote: =20
> >> If a ccw has CCW_FLAG_SKIP set, and the command is of type
> >> read, read backwards, or sense, no data should be written
> >> to the guest for that command.
> >>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>
> >> v1 -> v2: fixed checks for command type [Eric]
> >>
> >> Still only lightly tested (it boots); I don't think I have a tool
> >> generating channel programs with the skip flag handy. =20
>=20
> FWIW, my test program hits this code once (read of a single page, with=20
> SLI and SKIP flags set) before getting into the passthrough codepath.

Ah, good.

>=20
> >>
> >> ---
> >> =C2=A0 hw/s390x/css.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 22 ++++++++++++++++++----
> >> =C2=A0 include/hw/s390x/css.h |=C2=A0 1 +
> >> =C2=A0 2 files changed, 19 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index 8fc9e35ba5d3..080ac7e5bc0b 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -830,8 +830,12 @@ static int ccw_dstream_rw_noflags(CcwDataStream=20
> >> *cds, void *buff, int len,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (op =3D=3D CDS_OP_A) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto incr;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> -=C2=A0=C2=A0=C2=A0 ret =3D address_space_rw(&address_space_memory, cd=
s->cda,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 MEMTXATTRS_UNSPECIFIED, buff, len, op);
> >> +=C2=A0=C2=A0=C2=A0 if (!cds->do_skip) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D address_space_rw(&=
address_space_memory, cds->cda,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEMTXATTRS_UNSPECIFIED, buff, len, op);
> >> +=C2=A0=C2=A0=C2=A0 } else {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret !=3D MEMTX_OK) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cds->flags |=3D=
 CDS_F_STREAM_BROKEN;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> @@ -928,8 +932,13 @@ static int ccw_dstream_rw_ida(CcwDataStream *cds,=
=20
> >> void *buff, int len,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iter_len =3D MI=
N(len, cont_left);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (op !=3D CDS=
_OP_A) {
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
t =3D address_space_rw(&address_space_memory, cds->cda,
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MEMTXATTRS_UNS=
PECIFIED, buff,=20
> >> iter_len, op);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!cds->do_skip) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D address_space_rw(&address_space_memory, cds->=
cda,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 MEMTXATTRS_UNSPECIFIED, buff,=20
> >> iter_len,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 op);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if (ret !=3D MEMTX_OK) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* assume inaccessible address */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL; /* channel program check=
 */
> >> @@ -968,6 +977,11 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1=20
> >> const *ccw, ORB const *orb)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cds->count =3D ccw->count;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cds->cda_orig =3D ccw->cda;
> >> +=C2=A0=C2=A0=C2=A0 /* skip is only effective for read, read backwards=
, or sense=20
> >> commands */
> >> +=C2=A0=C2=A0=C2=A0 cds->do_skip =3D (ccw->flags & CCW_FLAG_SKIP) &&
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((ccw->cmd_code & CCW_CMD_=
BASIC_SENSE) =3D=3D CCW_CMD_BASIC_SENSE ||
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ccw->cmd_code & 0x0=
2) =3D=3D 0x02 /* read */ ||
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ccw->cmd_code & 0x0=
c) =3D=3D 0x0c /* read backwards */); =20
> >=20
> > I think you should use masks like
> > ((code & 0x3) =3D=3D 2) =3D> READ
> > ((code & 0xf) =3D=3D 0xc) =3D> READ BACKWARD
> > ((code & 0xf) =3D=3D 0x4) =3D> SENSE =20
>=20
> I think Pierre is right.  In the v2 code, a control CCW (like NOP) would=
=20
> still be flagged as a READ.

Sigh. I hope third time's the charm.

