Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBACC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FED8206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 10:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FED8206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs2bx-0002eS-S9
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 06:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36546)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hs2bO-00026v-5x
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hs2bM-0007Qg-6R
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 06:09:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hs2bI-0007M0-BR; Mon, 29 Jul 2019 06:09:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C93713083363;
 Mon, 29 Jul 2019 10:09:50 +0000 (UTC)
Received: from localhost (ovpn-117-148.ams2.redhat.com [10.36.117.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DB6C60623;
 Mon, 29 Jul 2019 10:09:47 +0000 (UTC)
Date: Mon, 29 Jul 2019 11:09:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190729100946.GC3369@stefanha-x1.localdomain>
References: <1562554503-177179-1-git-send-email-shaju.abraham@nutanix.com>
 <087e6cb5-b24d-b144-744c-d74defeadb86@redhat.com>
 <34a8030e-a173-162d-6786-3dafa5a1d4ed@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <34a8030e-a173-162d-6786-3dafa5a1d4ed@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 29 Jul 2019 10:09:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Fix Guest VM crash due to iSCSI Sense Key
 error
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 shaju.abraham@nutanix.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2019 at 04:18:46PM -0400, John Snow wrote:
> Paolo, Stefan and Kevin: can I loop you in here? I'm quite uncertain
> about this and I'd like to clear this up quickly if it's possible:
>=20
> On 7/25/19 8:58 PM, John Snow wrote:
> >=20
> >=20
> > On 7/7/19 10:55 PM, shaju.abraham@nutanix.com wrote:
> >> From: Shaju Abraham <shaju.abraham@nutanix.com>
> >>
> >> During the  IDE DMA transfer for a ISCSI target,when libiscsi encounte=
rs
> >> a SENSE KEY error, it sets the task->sense to  the value "COMMAND ABOR=
TED".
> >> The function iscsi_translate_sense() later translaters this error to -=
ECANCELED
> >> and this value is passed to the callback function. In the case of  IDE=
 DMA read
> >> or write, the callback function returns immediately if the value of th=
e ret
> >> argument is -ECANCELED.
> >> Later when ide_cancel_dma_sync() function is invoked  the assertion
> >> "s->bus->dma->aiocb =3D=3D ((void *)0)" fails and the qemu process get=
s terminated.
> >> Fix the issue by making the value of s->bus->dma->aiocb =3D NULL when
> >> -ECANCELED is passed to the callback.
> >>
> >> Signed-off-by: Shaju Abraham <shaju.abraham@nutanix.com>
> >> ---
> >>  hw/ide/core.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/ide/core.c b/hw/ide/core.c
> >> index 6afadf8..78ea357 100644
> >> --- a/hw/ide/core.c
> >> +++ b/hw/ide/core.c
> >> @@ -841,6 +841,7 @@ static void ide_dma_cb(void *opaque, int ret)
> >>      bool stay_active =3D false;
> >> =20
> >>      if (ret =3D=3D -ECANCELED) {
> >> +        s->bus->dma->aiocb =3D NULL;
> >>          return;
> >>      }
> >> =20
> >>
> >=20
> > The part that makes me nervous here is that I can't remember why we do
> > NO cleanup whatsoever for the ECANCELED case.
> >=20
> > commit 0d910cfeaf2076b116b4517166d5deb0fea76394
> > Author: Fam Zheng <famz@redhat.com>
> > Date:   Thu Sep 11 13:41:07 2014 +0800
> >=20
> >     ide/ahci: Check for -ECANCELED in aio callbacks
> >=20
> >=20
> > ... This looks like we never expected the aio callbacks to ever get
> > called with ECANCELED, so we treat this as a QEMU-internal signal.
> >=20
> > It looks like we expect these callbacks to do NOTHING in this case; but
> > I'm not sure where the IDE state machine does its cleanup otherwise.
> > (The DMA might have been canceled, but the DMA and IDE state machines
> > still need to exit their loop.)
> >=20
> > If you take a look at this patch from 2014 though, there are many other
> > spots where we have littered ECANCELED checks that might also cause
> > problems if we're receiving error codes we thought we couldn't get norm=
ally.
> >=20
> > I am worried this patch papers over something worse.
> >=20
> I'm not clear why Fam's patch adds a do-nothing return to the ide_dma_cb
> if it's invoked with ECANCELED: shouldn't it be the case that the IDE
> state machine needs to know that a transfer it was relying on to service
> an ATA command was canceled and treat it like an error?
>=20
> Why was it ever correct to ignore these? Is it because we only ever
> canceled DMA during reset/shutdown/etc?
>=20
> It appears as if iscsi requests can actually genuinely return an
> ECANCELED errno, so there are likely several places in the IDE code that
> need to accommodate this from happening.
>=20
> The easiest fix LOOKS like just deleting the special-casing of ECANCELED
> altogether and letting the error pathways handle things as normal.
>=20
> Am I mistaken?

I think your instincts are right that there are deeper issues.  The
first step would be test cases, then you can be sure various scenarios
have been handled correctly.

I noticed that ide_sector_read_cb(), ide_sector_write_cb(), and
ide_flush_cb() all differ in whether they reset s->pio_aiocb and
s->status before returning early due to -ECANCELED.  That must be a bug.

I didn't look at the ide_dma_cb() code path.

Stefan

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0+xeoACgkQnKSrs4Gr
c8g7bggAoYCw4MKxbmvw+9g5lkvoHUIvMKTgk2hWxGZs8ADlTCLLI0yYDfN2SE9d
mnbvgk75+pSk20tOskDIpoZ9xj0PqZs8gJdFM9bYitaYALJt03cz4X/rLJC3QeeI
56KnLqpqb84A740kiAuc+SUaCppXQo74qi3qjwti+EGZFmgRs/UsuhzxUvcwTeBl
LRkfk1DKX48LEubYCDhE1FLCioL+Bjs0xiUjhr6jdrUPcjKVWwmZxgaWMsaH/wYv
DRpGnoeOusNt0S90xTZ9gx+s+jkQg+8aYTJ+J4/xDFEYcfVTf9rSJJoFYfSn2lcQ
XSCaj8FsNCwt2GMm6+UuvGoCFdxofQ==
=Ct3n
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

