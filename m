Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D6FC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB2B206C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv/zc/Al"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB2B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGS8-0007KH-B8
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hyGRD-0006LX-Fq
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hyGR9-0006Zd-W3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:09:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hyGR9-0006ZJ-Ow
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:09:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so1371397wmg.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=OLB5A5wHOJlR64f5SBrWhDf8RUtqyHFS9eLIH1A2V7g=;
 b=jv/zc/Al3Tniia2JujYGtyWywnmAm4BsnThrtyyBdSPK6kSZuMUY1zcnKla+6+lN4h
 9riM+AXNekFDyBLExSX2+S6J5p+axXBiO4yyeAPyZj6e0piDhZIazJs2LOBMa4IbSR1B
 527t2y6INPvQMvBf+azniTaJ/Qa0x+bPam3/eL51XKV2dgV7CkhNVWAvp1UlTgDCJC3F
 ot/dDYVtvPYdtr01OOxcQv0MFC9VEPhR/gc25BWtisBLExNTbtMi3Xbf9rWC/1m0J4kX
 SZGCZfPJH0oNhZHrsyGWbkWWsIF/w1+QNA1juk1CDeOA8wV9g81F14Rvw/AAPrMm+BtG
 ptgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OLB5A5wHOJlR64f5SBrWhDf8RUtqyHFS9eLIH1A2V7g=;
 b=eipgO2c+1tlxyN9TZz2Rwur0f9+o9usgZ9tTOaHyOWHWFHsaemeHWOq4Ew6EXYtqCO
 SmH2OpyAOVjn9rQgzGjOlFlhPbUrBSwTG8ZTHKJ9DDktxaMIg30pipTerOhEFiR050iW
 8iQaDte7Otq05qecl+vy6Wfp/LP/2AGzlgz9lptg/iXDzbAcdBtQ3Ysyzgc2TlHRY7WX
 rwwMzImC/l1nQM56N+2Bcz7PF8IekrPh2cEpywqX+qs6nxUZGZ5vcVn81qLiGR8iZ83R
 ug2dKY3o+3F2l4ioyd0sVI2/27VILtdoQLIn/QHeZShwKlwevRdhGDfc+M4l9oJweQU3
 Xl6A==
X-Gm-Message-State: APjAAAVd+qexkNUKvGC0wDzYZPqoQl1fon6mUmnsEpkb/9Nmk/vbze+Z
 ttlRL0NhnlrqnwleXuinM50Ytpu8/zA=
X-Google-Smtp-Source: APXvYqz2wDjNmRwMOTo1sCrAN86VvJjwwbBrR8JUD7WbBTFVAXuWuIWug299M+wNSAtSmtvlDhJ8bw==
X-Received: by 2002:a1c:1d4f:: with SMTP id d76mr3096343wmd.127.1565878146593; 
 Thu, 15 Aug 2019 07:09:06 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v124sm1482239wmf.23.2019.08.15.07.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 07:09:05 -0700 (PDT)
Date: Thu, 15 Aug 2019 15:09:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190815140904.GF10996@stefanha-x1.localdomain>
References: <20190813133042.11683-1-stefanha@redhat.com>
 <39b21ab6-bf1b-69c1-bbea-fb6f1b637132@redhat.com>
 <20190814132306.GF23970@stefanha-x1.localdomain>
 <20190815061340.gryxnfwaaoswqqi7@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <20190815061340.gryxnfwaaoswqqi7@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] usb: reword -usb command-line option and
 mention xHCI
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2019 at 08:13:40AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > > > -Enable the USB driver (if it is not used by default yet).
> > > > +Enable USB emulation on machine types with an on-board USB host co=
ntroller (if
> > > > +not enabled by default).  Note that on-board USB host controllers =
may not
> > > > +support USB 3.0.  In this case -device nec-usb-xhci can be used in=
stead on
> > >=20
> > > Should we maybe rather recommend qemu-xhci instead?
> >=20
> > I think nec-usb-xhci is preferred because there are Windows drivers.
> > IIRC qemu-xhci works under Linux but not under Windows (just because the
> > PCI Vendor/Device ID aren't covered by any driver).
> >=20
> > Gerd: Can you confirm this?
>=20
> That applies to windows 7 only, which is EOL next year.
>=20
> win7 doesn't ship with xhci drivers, but you can download and use
> nec/renesas drivers which require nec-usb-xhci.
>=20
> win8+ ships with generic xhci drivers which works with all xhci
> hardware, including qemu-xhci.
>=20
> So it indeed makes sense to refer to qemu-xhci.

Thanks, will fix in v2!

Stefan

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1VZ4AACgkQnKSrs4Gr
c8jgvQgAwZUSWIOGfWWlLNwOI1IhJhy8MG7bFhJv1FT+szmc40/oEkW3t8MmCvtt
Zyk1I3aI3ckpgcrlkye3fM5A9ZN7n3HNd3OC5W24RJHQnG4bkxR9zl2jyH4qbICw
3dTmA1uC/U42XZNEDXTewVJjZfCy5li6uCRvVcMBXq4h2ge05U8p5aP10UfQI4Q9
H2QzGDXdQl02Mvat0wK68dNGX7LmQubXyCNjgjN8EiT1WRJ2VJhUtZy9Z+QD3kYy
6v9OQYaNgOeV7LoQ+ipWdLYPUSFt5S9RnTIElaKTciMPG0XZet80AQJOLJ1qvTXU
FxBHMo3MC9xedNHmiGCcboYeg5ZiEw==
=GeZZ
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

