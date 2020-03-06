Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48EFC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09C62072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2+iX9+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09C62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACSx-0001h1-QO
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jACSN-0001Dw-Sb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jACSM-0006hg-OR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:51:59 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:45549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jACSM-0006c2-GE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:51:58 -0500
Received: by mail-wr1-x42d.google.com with SMTP id v2so2195583wrp.12
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AR9boo+HyGf0bthWuBFuPsIoff2oor8etcaKa83eczo=;
 b=f2+iX9+mAOxrGjJHBtQZLN5x+GW4VeE6cC+LQJ7RTWm2Ylmrl+6+RpC/TiNSpM+sCd
 xVsUlqVG2SFYrSUj1GQguDcjnFB+YhprGPOIEfs7j0UWQlONRseY+ilaJeUhj7f/WCJQ
 z9wpzaae9TpZq7toitYjReQEdOEIXqQ/5CphzDmjOZd9rSL4Eqoukc5xPqRJzguklhSY
 cVcYC9RdGh1C9+hC3xqfYnALP157GueJfWAUm6HwCel4UFKd6k5zOKPdlps74q0dD8Sq
 1qqeEl0iIvpkk5sDSOip0YaHolaEIjvZJ3vdQB1qO176RwQ9kWH6/BpRsld7m0/Do23H
 qUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AR9boo+HyGf0bthWuBFuPsIoff2oor8etcaKa83eczo=;
 b=FBq+qodl0Cn+8jJlGiG8s2AribPEfkfoQRHZbN5EpZDZOyU+bWrP3A+qV9IpOtEvy8
 3kAEkOnmiKsBWbq59bYhSlHKz8hm21DtCapjYTLE1Z4LPNH2Ip/rWQ1YvVklb3F9jJGr
 3gp41r3S0fY39wMEqJ8kB+ZMr5oxsPX6gjb6d0XVtkoLlxh4z2SUJ2YnneurS4/hEuj4
 /3QRsxmGBkBXpMYot+Ammyqb6Q2WU4hcTHW0Rzm5BcXxUjWqYoJzs7eDCWW+9+P5wdSv
 JM5EOnwcV6RdBk199gxL1h+WD9XCR33PsTaoiawUHMpJtKvQbw9NFgDzmod4e9SnW9ls
 9ozg==
X-Gm-Message-State: ANhLgQ2yN52mbmUtJop/KFs5VvZ+OGo+sWumHrti2CgXPCB17wVhxG2I
 1ttkjaKz88XRST2UuzxgKtc=
X-Google-Smtp-Source: ADFU+vuGsJ1dlulLFNjfSWFruInFcllZNCDbNbAbn/MN1U0jTIVRJIfNZu8AYqVbDllxE4u9PYVAow==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr3955993wru.100.1583499116995; 
 Fri, 06 Mar 2020 04:51:56 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n3sm13080421wmc.42.2020.03.06.04.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 04:51:56 -0800 (PST)
Date: Fri, 6 Mar 2020 12:51:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: Wiki user request
Message-ID: <20200306125155.GJ1335569@stefanha-x1.localdomain>
References: <b4440411-cc60-cd7e-988e-458baf0c8b6d@xcancerberox.com.ar>
 <CAAdtpL4Fg3rjxOXxGA=sSLpsXrT1E0Ko1kjt1YugvRCtKPi-hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Content-Disposition: inline
In-Reply-To: <CAAdtpL4Fg3rjxOXxGA=sSLpsXrT1E0Ko1kjt1YugvRCtKPi-hw@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 12:57:14PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Ping?

Joaquin's account has been created.

Any QEMU wiki user can create accounts for other people!  Log in and go
to https://wiki.qemu.org/Special:SpecialPages and click the create
account link.

Stefan

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iR2sACgkQnKSrs4Gr
c8g9qwgAvqwRfjtuRcePjdKdlstoQozeB/T1BgS6cUDoJw5RyiIkNpKYzYNSTkWa
suS0SY2WRtWfHaZ/b72wLER0uIibnw+tA2mTFgo/mmuN4Qui62fgKJD8YiqV/o/6
h7U11qnZFMwPY4M/gKoQabDGiWRYuA59nTfUtDoRPUW320iqVt8XwEbw/uFgwm9e
k2UrAngjVV2Pn9dqqqtEWmMuBsfpYSwVWIk2bYdo//ZZ8Hxo/nIr4TWkqFEAJ9Ul
GXZ6Qf+GCBOQAprTnt9iR1bVQ4u6oPpCKhhCbjruUkTamEc4B0zj82rvaYJH/4mM
SM3PfucP8x1ei/njcoU2PpDeBDGW0A==
=p7ro
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--

