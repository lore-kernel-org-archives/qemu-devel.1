Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F4AC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 708B12133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i85RF81Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708B12133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhir-0007aN-NO
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56270)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hbhh2-00065q-SZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hbhgx-00068S-IS
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:36:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hbhgx-00067I-Bs; Fri, 14 Jun 2019 04:36:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so1392224wma.4;
 Fri, 14 Jun 2019 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FtsMw6gULlhnWEqNSilawymZFzcFoOlY8Y32pKxwRro=;
 b=i85RF81QHE0GLgYy//g5gRXjpbcTD0qQHt9rVls97pztNR4g2g81hVLfZt6pLa3mTX
 iUm7EfLzUP9/kghT0GmsEYXzr8/D+NqNaAkB2jAmf+zZbXz8A2kYEIrrGBKhx8W73nli
 5ORYR/dWo+NpwerfQZDsjfqhWtgpYfhK8n3BXtU1TeZT3WeytSd/SoHa715I5N6PreQj
 ojNlDHhyisJOI1AEIyyXgxphWkDrODmeUty/FuKjIrVUrswnnm+c+pC1wq0jhiGnanSa
 qDOVnkAo4AqJ88grdsytXscIczZBFDwCYJIT31BtdzNY0/IgYfPLthlUycOFVTKemXpA
 6kUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FtsMw6gULlhnWEqNSilawymZFzcFoOlY8Y32pKxwRro=;
 b=jDthlsd8bp57pxhiHofyeGhcO2Auo5lL+k94mCtZi9V2HooyCSSQXep+my40OWY9LH
 sjnC8uQpvh5OKgm6Kx+LAo5/Fm98OzQV76gXt25zk34E7VedRtdM9g+XZgT1Er0tr5Qz
 nm5U4thJoEN1ONqpByf2GsY4G0DiH+PS4vWjKs3h5sJZnWwo5Cgml/Z2Fa6dzu93yBZG
 v8JxgsdJiIhQa/qvJ5EOeXkRpN1qT8zHDj9QBoqdO/3GJipjA9qi3Gae9bskOardIctL
 6DSIKszbvYg7AziDCkwJ2+FIg0hnagzBbhxg4GJpaqtElRngt/vqQNcO8DvDbiHeNq6d
 A8jg==
X-Gm-Message-State: APjAAAWpzoJ4obDButI7z/L0jz9BlqXI+VQSF7neDh46DdBY7lKIxSOV
 s1gm3+cmGC83KSxeQuHLXdY=
X-Google-Smtp-Source: APXvYqzZf565wq8+K0aO9G+2CRzEA8z7+x5B5wYcqX2kQxWuv5l3cwmGrmRCeLtSDEr6SY/RbUX9EQ==
X-Received: by 2002:a05:600c:20c3:: with SMTP id
 y3mr7155410wmm.3.1560501369141; 
 Fri, 14 Jun 2019 01:36:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y12sm2193773wrr.3.2019.06.14.01.36.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 01:36:08 -0700 (PDT)
Date: Fri, 14 Jun 2019 09:36:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190614083603.GB10957@stefanha-x1.localdomain>
References: <20190605131221.29432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20190605131221.29432-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] docs/vhost-user.json: some firmware.json
 copy leftovers
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2019 at 03:12:21PM +0200, Marc-Andr=E9 Lureau wrote:
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/interop/vhost-user.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0DXHMACgkQnKSrs4Gr
c8i7xQf8CeyTI3u/TyRWKEcVGbn3cU0rOP8oOnVkScpoRe0bkmZevTpkmuy9kd44
2k9AHgX1DDpla55m9AQk/ZQsZ95M3aY5WnUQlV1/D8wFrjEunv3okCl0Fd4bkQ5J
72Qi6DrB/ZJ+OcnWJHJ4cW2zdDLmYhR/BmCN0EIPjivZIXcx0E1+JiZpg9VRJu5W
v0vAnO4I4+Gqki/z06KWwdLtymlF3jgNoObbU04gI1h+qs4Se7cmh7sqcUSXegs+
R7m0e0uouMGZypxwLinLOj8nUsijdW7vj9mwCOEzgIiJd0/EkXBDgTIAmUQ4APyC
BlTi6FphKKZ2DjI/cxpkfW4rQ/eluQ==
=oUDS
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--

