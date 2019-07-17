Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD0BC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:41:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FB6206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 03:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vp5UMm2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FB6206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnaoR-0006SP-2z
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 23:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hnao6-0005Pg-2p
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hnao4-0003ia-17
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 23:40:41 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:59465 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hnao0-0003eV-Qd; Tue, 16 Jul 2019 23:40:38 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45pNMJ1qtPz9sMQ; Wed, 17 Jul 2019 13:40:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563334828;
 bh=Mot6s3cntKQklRydT6w8OUE1iO9T4fzZfyzEaYW6BOo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vp5UMm2nGJ2e21/DNFFQEQNEt0q4aUQL5PSvKDrmfo0rHoVBM8jL7vjC8+rgjyCDL
 +J+fy/I1QYAlcLy1lAi1QI3olZb4V7BKSnh+oJJjFUiKmhjgr/oxI7bKRikyv6CkYd
 2927NSnFVWjmF3AtyFNXJDCFcQ7OB4Fqf7eMcVA4=
Date: Wed, 17 Jul 2019 12:08:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190717020809.GE9123@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-9-clg@kaod.org>
 <20190703020748.GD9442@umbus.fritz.box>
 <08faf669-72a7-8f30-d33c-2e285405005c@kaod.org>
 <20190712011527.GB2561@umbus.fritz.box>
 <4f2f24e7-28da-8f32-e1f7-721dc6533e7c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline
In-Reply-To: <4f2f24e7-28da-8f32-e1f7-721dc6533e7c@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xive: Extend XiveTCTX with an
 router object pointer
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 05:45:38PM +0200, C=E9dric Le Goater wrote:
> On 12/07/2019 03:15, David Gibson wrote:
> > On Wed, Jul 03, 2019 at 07:54:57AM +0200, C=E9dric Le Goater wrote:
> >> On 03/07/2019 04:07, David Gibson wrote:
> >>> On Sun, Jun 30, 2019 at 10:45:59PM +0200, C=E9dric Le Goater wrote:
> >>>> This is to perform lookups in the NVT table when a vCPU is dispatched
> >>>> and possibly resend interrupts.
> >>>
> >>> I'm slightly confused by this one.  Aren't there multiple router
> >>> objects, each of which can deliver to any thread?  In which case what
> >>> router object is associated with a specific TCTX?
> >>
> >> when a vCPU is dispatched on a HW thread, the hypervisor does a store=
=20
> >> on the CAM line to store the VP id. At that time, it checks the IPB in=
=20
> >> the associated NVT structure and notifies the thread if an interrupt i=
s=20
> >> pending.=20
> >>
> >> We need to do a NVT lookup, just like the presenter in HW, hence the=
=20
> >> router pointer. You should look at the following patch which clarifies=
=20
> >> the resend sequence.
> >=20
> > Hm, ok.
> >=20
> >>>> Future XIVE chip will use a different class for the model of the
> >>>> interrupt controller. So use an 'Object *' instead of a 'XiveRouter =
*'.
> >>>
> >>> This seems odd to me, shouldn't it be an interface pointer or
> >>> something in that case?
> >>
> >> I have duplicated most of the XIVE models for P10 because the internal=
=20
> >> structures have changed. I managed to keep the XiveSource and XiveTCTX=
=20
> >> but we now have a Xive10Router, this is the reason why.
> >=20
> > Right, but XiveRouter and Xive10Router must have something in common
> > if they can both be used here.  Usually that's expressed as a shared
> > QOM interface - in which case you can use a pointer to the interface,
> > rathe than using Object * which kind of implies *anything* can go
> > here.
>=20
> Yeah. I also think it would be better to have a common base object but
> the class don't have much in common. Here is what I have for now :

Uh.. QOM interfaces don't require there to be a common base object,
only common methods.

>=20
> P9:
>=20
> typedef struct XiveRouterClass {
>     SysBusDeviceClass parent;
>=20
>     /* XIVE table accessors */
>     int (*get_eas)(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>                    XiveEAS *eas);
>     int (*get_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
>                    XiveEND *end);
>     int (*write_end)(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_idx,
>                      XiveEND *end, uint8_t word_number);
>     int (*get_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>                    XiveNVT *nvt);
>     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>                      XiveNVT *nvt, uint8_t word_number);
>     XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
>     uint8_t (*get_block_id)(XiveRouter *xrtr);
> } XiveRouterClass;
>=20
> and P10:
>=20
> typedef struct Xive10RouterClass {
>     SysBusDeviceClass parent;
>=20
>     /* XIVE table accessors */
>     int (*get_eas)(Xive10Router *xrtr, uint8_t eas_blk, uint32_t eas_idx,
>                    Xive10EAS *eas);
>     int (*get_end)(Xive10Router *xrtr, uint8_t end_blk, uint32_t end_idx,
>                    Xive10END *end);
>     int (*write_end)(Xive10Router *xrtr, uint8_t end_blk, uint32_t end_id=
x,
>                      Xive10END *end, uint8_t word_number);
>     int (*get_nvp)(Xive10Router *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
>                    Xive10NVP *nvt);
>     int (*write_nvp)(Xive10Router *xrtr, uint8_t nvt_blk, uint32_t nvt_id=
x,
>                      Xive10NVP *nvt, uint8_t word_number);
>     XiveTCTX *(*get_tctx)(Xive10Router *xrtr, CPUState *cs);
>     uint8_t (*get_block_id)(XiveRouter *xrtr);
>     uint32_t (*get_config)(Xive10Router *xrtr);
> } Xive10RouterClass;
>=20
> Only get_tctx() is common.=20
>=20
> The XIVE structures (END, NV*) used by the routing algo have changed a lo=
t.
> Even the presenter has changed, because all the CAM lines have a slightly=
=20
> different format.  =20
>=20
> C.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0ugwkACgkQbDjKyiDZ
s5Kl7hAAvrrfxXT0sAsAe/fBH3g1q7JOyV8PHdUxp7RLFcGk7eDETzSzyVxWKwAc
s08F4GxSEBheBbyYySfyhmjjyDvHW3ze1E8T5SadeNhhypdXyW0mhbNTZQ558DeN
NGE/u9nIXKpv+/LjkmIsy7vhzvcLMqKj2CY8yRqmajRrb9MeirKyRsYNXSr2aKTq
B1mig0bY4ZsSNSaN7f46t7qan0oTMOjEdjl2S3SCctZssA3ee2euzEmd5qz91Vzh
qrK/K2Ugr3fQj0e6zaPq0t18VvutXT1++nf7Z9/1sn3zgpGCKEavwCfFiBY66l53
yiSXV2Q4Ah7xPdxEGq2l2k7OBiubZY8Ntkl7pEtXJkAeh37swXYvu8OcOtwV8tzC
ib9vZdDw1KJPmTz7orMkIgiIYLYWdy3GY5InT+lp3IasFL/dQOWjuCfa29LHxp3z
iHJY5XX337PRY2u+4HHPj6I7lI5D3wLUSPfWzSb9QsoexdTYvisQoSPjYqiygKtH
5mX9PqHSBl1NOJKUqkxrl1VWE0I+3fHNSv3Ep5hXj409wqQLo1vUjAikJT//BoGl
Wz/Jr9/+jQ+lgmJd25fkqPUL210VWhOuNxAW/O7Wbx+V9uKyqrwDG0dc/iIorzcV
QGysmHOp7XFAc65XZ6KvsbvoYqU8bhZUCgeNMuxL7OV6isGeAkM=
=0MvI
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

