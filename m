Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8CC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17AF20645
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3rFxKLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17AF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42876 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTr9-0006Gl-Eq
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hbSLR-00068o-D9
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hbSLI-0000Id-Ub
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:12:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hbSLC-0007fw-7E; Thu, 13 Jun 2019 12:12:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id n4so21371146wrw.13;
 Thu, 13 Jun 2019 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pozcxlOsEh8tedQlvKwH/BycRWDv3x1eho7USa5oCWA=;
 b=i3rFxKLg1jCMfIh3+9yiVGyZYpLTYAbPhj/Kz1Oem7b8oj+eKjxx9pAwIyLfqQuB0l
 2GHfF3wDMqyhj7/ilf5A14wEoKR27H5N1GpJ/lXD2NHqYrhkCi+TSa9sssX/0lbxnX9q
 yVZtBwfTQYouZeCqgMMGqlBfhtVvt4BTCQeMIGgdj8AmqJ7neZXGScfwgI57zlqI1FYD
 Is+YwdoxS7ZEN1Zq/jOU8eaTXK7iFu4kJRfHZ0cTNl2Gdn3giZ+0o5qwMYALaV9da5uN
 arElDwwVUPnby496JviIi+ficodUxWoyo/BdBbDTCJKGrgADkN5oRQkQZcpOFGSykhwx
 BcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pozcxlOsEh8tedQlvKwH/BycRWDv3x1eho7USa5oCWA=;
 b=BbOcmMwlUq5HmK1ffuFw9JdmAOyoDUWqoY40rOkxYAM7SCuX4M122kNa1cNWqSzBbq
 cL+k6LCVlHvwo7091q0NiH7vBLfmrT7lx/9Y5HcpArvsQ1gY5MtjwWAlXJeqMSRPlgl4
 3+JiWA3QYWExQBiDfFA57iXe1T76XIw2YXtJceRK3J1DTsV78zasObcxx9XTRz/fEpTn
 F6anbWKfKqWJE3ocHKV0Z8yGrkZXcPxVRzFiLdFi/OGwUzbjQLisW1rsmFX9SHnTqmNj
 Z++rorBSf8fgL/1fQ7dUMuHGbyw7r0h5QMnd0J/4MXZkbnJcidpIFe9VIjtyGkWhPcd4
 VFHw==
X-Gm-Message-State: APjAAAVj+RlXMBJSygzvD7auLg4n/hxATxjS+6BKFInMmtVdu5MmZb9V
 vnbdgD8RfLhKDtGvQSmec0Y=
X-Google-Smtp-Source: APXvYqxNPvk+eeuoXo/JJrLgUaxhTyTQyAirYjBdL6yoAZvArw/msebbDvXSZzzuySVsttP43JAMfw==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr13471957wrn.168.1560442351223; 
 Thu, 13 Jun 2019 09:12:31 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w67sm462702wma.24.2019.06.13.09.12.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 09:12:30 -0700 (PDT)
Date: Thu, 13 Jun 2019 17:12:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190613161225.GB12986@stefanha-x1.localdomain>
References: <20190524172812.27308-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20190524172812.27308-1-mreitz@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: Re: [Qemu-devel] =?utf-8?q?=5BRFC_0/3=5D_block=3A_Inquire_images?=
 =?utf-8?q?=E2=80=99_rotational_info?=
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2019 at 07:28:09PM +0200, Max Reitz wrote:
> Hi,
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2019-05/msg00569.html
> shows that optimizations affect HDDs and SSDs differently.  It would be
> nice if we could differentiate between the two and then choose to adjust
> our behavior depending on whether a given image is stored on an HDD or
> not.
>=20
> Or maybe it isn=E2=80=99t so nice.  That=E2=80=99s one reason this is an =
RFC.

Seems useful.

As long as this isn't exposed to the guest automatically (e.g. via SCSI)
then it's fine since guest-visible values are not allowed to change
across live migration or storage migration.

Stefan

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0CdekACgkQnKSrs4Gr
c8grOwgApST2nTn5eGLNFKeozkGF0u3cXti2r3wvp2s7rHP825TPSPShbYYXvbd5
yS0Uk7DHJgvU3+N6M3YYqNhhmgy4Cirfw8qOR8hiP9AoJJJKqJfWnjsuQ+wlzUb6
l5ACAFUwtMytKZKA5nnCgQRB2hfh3VaBTCPWupauiXp/MkKLBmpNQCAzFyYyp92N
J4SIOxtYj03RWNzw3V1XrheLfbqVievrKtLDyibggjhMU70n+NoK+lYhuvrAMxnO
wOSsZzCQPhizPdf4s1JMlLz/1i2LiTrvxhOQxoPcvlzVGGMTRjrg/qIZNkH1jXUd
89iYtP+VcVh5UcqUgq39yJbgmVtRJA==
=cMJd
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

