Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F2FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00A2214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 00:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T5tpqLuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00A2214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvsWD-0000eN-Km
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 20:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUi-0005Qh-8v
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hvsUh-0004o7-Nq
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 20:10:56 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:43839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hvsUe-0004kO-At; Thu, 08 Aug 2019 20:10:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 464Qcl1CVXz9sNk; Fri,  9 Aug 2019 10:10:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565309447;
 bh=Tjc1rsLFxvnigdY6TR4w2cXqyiKtMIv+nlBNFfBtMAQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T5tpqLuR/+h1P0MOQVzgAPJ+1Z+n8ySmnRg2iS956+X/Wc1mresEljR5nzNOIwg13
 U1JY4K8tkO8ob1+XD6R3i2teiL/B8/MF7FtqtJMCARUo8CkZg48sCWfdL4oOmEDjBp
 5rQAPD693ojSOjcJ/+PX65Nuus0457apUsdShvVk=
Date: Thu, 8 Aug 2019 16:49:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190808064957.GF5465@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
 <20190731063044.GG2032@umbus.fritz.box>
 <CAFEAcA-=rMgKuhtq4AT+QohRXf71biNFDRQaxMctrro7mTV4kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-=rMgKuhtq4AT+QohRXf71biNFDRQaxMctrro7mTV4kQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2019 at 11:34:41AM +0100, Peter Maydell wrote:
> On Wed, 31 Jul 2019 at 07:33, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > On Mon, Jul 29, 2019 at 04:56:30PM +0200, Damien Hedde wrote:
> > > +The function *resettable_reset* is used to trigger a reset on a given
> > > +object.
> > > +void resettable_reset(Object *obj, bool cold)
> > > +
> > > +The parameter *obj* must implement the Resettable interface.
> >
> > And what happens if it doesn't?  This function has no way to report an
> > error.
>=20
> Trying to reset an object that isn't actually resettable would
> be a programming error -- I think asserting is a reasonable
> response to that.

Yeah, fair enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1LxhQACgkQbDjKyiDZ
s5LebxAAxnSJ9AE47v34dtt5dflWEB4N5f26kCPmDp7FRA2nj7CaY1IhX0IX3OyR
VnE8QoKB7agSx+MbVBX8c1ByPEEVMYy/qgcQPVBzNMqaJNczltPCbKhQOCMRWxJr
3XTmqeGHv1U1OuN0aX58KmHV7kKa0cyYtkPyIOIowdyzgyK1QQrsWoS5OUVMuqKm
J9sC/wn9I9VT4xbC0JLaLs7qU3Mr8Kl9DPr6viwUHvoWOEq2tVV9u29Zu5mcnvmN
oRhTighFwmis1adpQ3wDDEfQYik/b0SDsoZEjc227bD5l4hoVhXCP9SnTIpv1cXD
0n6JyWIyl8nAshDY0Oc7DStiQ2VO8ozJLBbT+jOtL8cpH6tpgG1u5Qj+sYKyV1W4
39TLyKjXIesOUYKhiblThO0hTmAiA25kGvQ+DcERPTj6+vU2SVpZEcNbGMW37Hpf
DGp5hN3MZ6gHFcEadE2XDX2k94xKE4dmipebGI+SJ4Itv+FZRr4HHbl8GZATTpdj
ZMn46K75A3yxHG8UNUTKJFl82vFqEz+CQnuG99CEAtr3kQWZ4ezeRKk94JwQlZuO
RbxHKt5/i+r9mY3FKb388kxCyxW3SP1g48lYRCFrqPIGK3oLdXe53+QXh0rkBkxy
Z+XX75m38VK1tRxJy52KbSMHh8eF7G61Aobr9/rKbWz+/KE6b6k=
=DAR/
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--

