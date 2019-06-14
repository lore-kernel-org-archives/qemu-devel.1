Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C596C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8B32082C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOQGb5Z7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8B32082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49608 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbigN-0006ZK-5y
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40698)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hbieF-0004hV-Qx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hbiaH-0001GC-Vn
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:33:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hbiaG-0001EV-Gq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:33:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id c6so1601052wml.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vaSlLJX1Ny9kajYJJoPkvGITLkH9ZFJaRT9dA2EwCc8=;
 b=WOQGb5Z7oSotlEoJdVFlQF5hkARFwMo+cd9V699AB62C5nK/vXcj/CNO23jsS6W3zD
 RJ9ng1zHnVIVO8cxec7zX8nBRR2BpDr3c51q29cVAEBA3uINBGTkJmLUP84Rw68tYJUr
 y22Y2sdgUZ+w+Y+BZV+R+zVo/hnJXFVklPJtpFVbQR8f5hdOMl/25pmOcFjaxI6tpbMF
 VpSL0Ry5BB+PU4CZV+KXaO8bHJGmAlSnSSoLs74Jebuu6Gq5uEUFPCTm60TaVCne8s0Q
 CTx1O26ys898y2KqXRRk9iaBwHicNHcIYnkWqTZbX1xLttCiy5Vu79HExQy2pY7YCfi3
 Ya1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vaSlLJX1Ny9kajYJJoPkvGITLkH9ZFJaRT9dA2EwCc8=;
 b=LA8YVoCAnADKHyFK3QClhtK39LoVPmV2hmPaKjFnGRQ0ZwGF1+M4iKiMtT63uVctRD
 2oQ+Twk0oq/G6oXwXh1ERQPanEOFtRonR8/VArTUZ6Tm8lCwkhAina7olqc2SrVGO2/D
 K94fRVF6CWJN1UGzs1whMqdVq1XM1wG5rcsuufMc16EMDI5QZj6jMNe1J6RojQMRtyfJ
 Kk+Zv3o4p4mgBJ8iaK3vv0FHKyA5AlPzUq8nXpp5PWxHrmLtz3KOkCPg3pJIGitPBFvT
 Srg13gNL0ZW6xR60WinTUn8/FD/tlzJzhfaxajuWEofiTCpk19P51Fd2Ma/93+kV+yJH
 dlOw==
X-Gm-Message-State: APjAAAW/3zhEQycSuJJkc241316x2lZyeXUD2kDaGiK9aUuiWBct+mwT
 jqUWWNcjg8vtoQBKgpJogEM=
X-Google-Smtp-Source: APXvYqxB0yRGw+jrJAYzgfobVQKm57uiAm8/3dOjgapk/QZPMd69qlQo4EYbIXVHOU2ToX2Q0agsEA==
X-Received: by 2002:a1c:1d8d:: with SMTP id d135mr6809566wmd.54.1560504792346; 
 Fri, 14 Jun 2019 02:33:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o6sm2788617wmc.15.2019.06.14.02.33.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 02:33:11 -0700 (PDT)
Date: Fri, 14 Jun 2019 10:33:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <20190614093306.GG10957@stefanha-x1.localdomain>
References: <20190613050937.124903-1-aik@ozlabs.ru>
 <35361394-42ba-dcf0-6fe2-5a0a538d1440@redhat.com>
 <d20e26db-7157-d9bd-c707-d7f4443396c0@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="doKZ0ri6bHmN2Q5y"
Content-Disposition: inline
In-Reply-To: <d20e26db-7157-d9bd-c707-d7f4443396c0@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2019 at 10:13:04AM +1000, Alexey Kardashevskiy wrote:
>=20
>=20
> On 13/06/2019 23:08, Philippe Mathieu-Daud=E9 wrote:
> > Hi Alexey,
> >=20
> > On 6/13/19 7:09 AM, Alexey Kardashevskiy wrote:
> >> This adds a trace point which prints every loaded image. This includes
> >> bios/firmware/kernel/initradmdisk/pcirom.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>
> >> The example for a pseries guest:
> >>
> >> loader_write_rom slof.bin: @0x0 size=3D0xe22e0 ROM=3D0
> >> loader_write_rom phdr #0: /home/aik/t/vml4120le: @0x400000 size=3D0x13=
df000 ROM=3D0
> >> loader_write_rom /home/aik/t/le.cpio: @0x1ad0000 size=3D0x9463a00 ROM=
=3D0
> >=20
> > I find the "ROM=3D0" part confuse, maybe you can change to "ROM:false".
>=20
> How? I mean I can do that in the code as rom->isrom?"true":"false" and
> make trace point accept "%s" but it is quite ugly and others seem to
> just use %d for bool.

Yes, %d is the convention for bool.  Perhaps you can name it "is_rom"
instead of "ROM".  That way the name communicates that this is a boolean
value.

Stefan

--doKZ0ri6bHmN2Q5y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0DadIACgkQnKSrs4Gr
c8hXQwf/SPMRQRJgwRpus8v1yrZ+Myy4oUWTGLzOjia1Cii8fi+bqv03Ui9yVh5j
cIRKQXid126qEbQIOQvXAYWpRHS6d/tzIwBQ2quGHZ2VERA4WZ3yIw0D4H5HBIf2
cfco5q3y9Do2x2pewbrfPqMj4yL5SpZWueEb7QzAAdH7ZVbXocK2nrL8FWt1sNTe
nnp7UHXZNBYksfEnHOJvx5bXP21mSiBaZavlhAvIf/OHoYZEXlUsFK45sH96BaXI
lVCaOeMW/56BsFEkor6dvpCb++rqZmTA9QoCfvf9wSRjnAfIdUx2ks5PpGBu3imh
cjWVGmZGg11fqsl4wABNcZlGSoz8rw==
=EwUy
-----END PGP SIGNATURE-----

--doKZ0ri6bHmN2Q5y--

