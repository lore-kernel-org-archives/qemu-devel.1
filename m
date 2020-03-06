Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C70C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF8A2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 13:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPNoeotS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF8A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jACsG-0007pJ-BV
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 08:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jACrS-0007Lp-Ob
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jACrR-0002ft-M4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:17:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jACrR-0002PD-CG
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 08:17:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id j1so2334637wmi.4
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UIOaMGXEFDniHWQZwFuOf8JabOFCrZQFTAvb/KtsETo=;
 b=hPNoeotS4FcszJnHVYLUuWNMU8neqE6DnVyq1AwKiDzowUVy1jtHrJmAXUEg3fG5iI
 tixxaUozOApNJFmaMdfEvKywor6kV5FTm2dHDjDW7fBRE2SWUNq9Bsedpr+YAD7j/Ea5
 JR6yPJUVup8N/jwDOy48GJE5tPpnCVQWynReUrI2UWdf0lvwF02qN5DEC4+5x/FdWK9D
 r0n8bm479/WeKSONhEICMC5io6W8L4k3O3JI7ufFzbN0v6BvI3IEGMnyi33q3xbLCkpA
 5kXnR4oL1340ziChZCvZCJ6YwsNG3dHtXiwWyBPRWHta6LAK/8pppOtUs8gVnINgn3I8
 Ljhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UIOaMGXEFDniHWQZwFuOf8JabOFCrZQFTAvb/KtsETo=;
 b=F6AAPAJfB6vQHuB98rOjugvU+WUaa9e2hW1oKE1P416PFjZYaWUxWatYezhI4EZMma
 rXk1WfTLePJnGRzxHggiirPHnTFRsbvyIMfUaDH65dBXBVYBeVt0DokmHxoOG9vF8JIB
 yYbg9sWHQd0kpAiZL1kNGz4PRcUthfFEkCxWGBFvkRjuHJxgfmsDNy4718vvhIUO7+PH
 DRpLLcuNdzwMjyEz3i68OpKn0tq74PqA6093tzlXkY2RbMwwCa/OsOT34+UJ5hByoKKW
 Scr0V5aj4W6U/0gobAXkU/J0/S47N/JbewVh9/3+k665nLQCpS3aqHunWohkVElRlbOe
 2PPw==
X-Gm-Message-State: ANhLgQ1Jh0UPjGQRKnZq7ElGh2iaySinUxJSOpZ21WxVlSkYQ39mvFP4
 W8WaBKjPEKIM7MdCP/0ysjU=
X-Google-Smtp-Source: ADFU+vtyhbg19orTD2HZTR91WtFl0dH8jMuLqcAcerrDSxARN20LIpGJHdiIPHEj8IVuBqrF9gH42g==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr4184831wmk.121.1583500672022; 
 Fri, 06 Mar 2020 05:17:52 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e22sm14651116wme.45.2020.03.06.05.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 05:17:51 -0800 (PST)
Date: Fri, 6 Mar 2020 13:17:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] tools/virtiofsd: add support for --socket-group
Message-ID: <20200306131749.GN1335569@stefanha-x1.localdomain>
References: <20200304185025.19853-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Content-Disposition: inline
In-Reply-To: <20200304185025.19853-1-alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 06:50:25PM +0000, Alex Benn=E9e wrote:
> diff --git a/docs/tools/virtiofsd.rst b/docs/tools/virtiofsd.rst
> index 378594c422a..6d2342f74d4 100644
> --- a/docs/tools/virtiofsd.rst
> +++ b/docs/tools/virtiofsd.rst
> @@ -85,6 +85,10 @@ Options
> =20
>    Listen on vhost-user UNIX domain socket at PATH.
> =20
> +.. option:: --socket-group=3DGROUP
> +
> +  Also make vhost-user UNIX domain socket accessible to GROUP.

Files only have one gid but the above sentence can be interpreted as
"add GROUP" (instead of "set GROUP").  Please drop "Also" to make the
meaning clearer.

> @@ -924,15 +926,29 @@ static int fv_create_listen_socket(struct fuse_sess=
ion *se)
> =20
>      /*
>       * Unfortunately bind doesn't let you set the mask on the socket,
> -     * so set umask to 077 and restore it later.
> +     * so set umask to appropriately and restore it later.

s/ to //

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iTX0ACgkQnKSrs4Gr
c8jOVQf/Zmeu7hwZRkdAYjN/SK4/2twU82wFH5FkLzO01/wC3E6N6KaUKiVGAzsb
671YHs4DxMfCo/YSLqTZgVxXzTPq+Lqnh/Vr0pJ3HV6ntyEMW1NprHsShcitLGXE
L5Oq+qaZ5skd/dXsYc9Qp/eYmt0P+YKrWqF1zqib2epdIievN4Bhr5Hw+flYDbuD
oeW23iF4rEL+vPNqEycn14Jx+8I9/HDSzZpo2GJNl5MvIOVf1PhCMAEJy8p2A3QQ
QvSCO1wEzG3Zy9ikm9DwmnS4e949P3f08bDVsdBtcDdZ6m+ovRXqxDLTHeb6JbcR
kBDm6KDKbou0wfvt08WIMxOqb6TKow==
=ucHy
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--

