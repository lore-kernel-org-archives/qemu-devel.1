Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E1C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E986B20644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHxb8TNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E986B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGKd-0001kL-VT
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1hyGJB-00018G-AO
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hyGJ8-0003Lh-2y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:00:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hyGJ7-0003Kr-Qh
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:00:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so2278552wru.13
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NSJQkLWedqZRV6Ny3FHhm1fsMId8b3k4N5nln0Tntrk=;
 b=sHxb8TNhbGDDIe7aEAlZbV1etMdMM595HefCgtAnbWvLt83WjkCyadlQ9fow8p5opz
 7yfopEeSqC0K+2dIuvyuVd/om1au4NxgY+xfdJcbJ+eFAPXooFOvjzgkpdnXfF78Hnw4
 rVdQI0l0j8TEFuRjgcjrXPyD8UV3kb1rPRFxaKmgk82jhffY4IOgf5ntX6gBrOzkGpjA
 R+AtkaKhuPCxAZXq4ospgkrYW/3v3DesVedteoX+gf3aWtHYuZHMczNisk2lcTsPAnwi
 RpPYSoqjzFZ8yoffx4KCSC1ApbT16kE+OgVnulXBqkmVByKHIxeoVqx13UX4WiVjaZXx
 OoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NSJQkLWedqZRV6Ny3FHhm1fsMId8b3k4N5nln0Tntrk=;
 b=guwi9T2QOblZqS1OKrYXDKhhsG6bozPi0QJjSmNc/zvztHpms3T4N3l3rJoJhffXC3
 +hPvsO2aiqmb1cXPqAm7qqRAFqeRoDT1Ka6EvtkrWUq13d/0qNm/UkBM8hWGXCFSaEHy
 0I/Zkgd1kpXMBa89IR0LnskMs2P5AN3HHzDhniMjQvkyYUUTM64KpFIjZrJjQ9TKCGm+
 A0V1D2Y4MSq8A8A0HvBVS0aDasCTjKn8P32vUgqvYWBamZu/hfJ2Ntg6I7kIa468lGmt
 0o3gT9I/5AVxblC1yDfruu73A1FEfjpbJaBiH/X+YTKSP1jKrHhT0lY9BoOnS+13GjVX
 /tcQ==
X-Gm-Message-State: APjAAAWkCJoBCx/736hutRm5N5L8wvnaq6dh/NxXTptGByMS4NWLUfX+
 snopV5HFWYVdB8SqUBdBRas=
X-Google-Smtp-Source: APXvYqyINN9yE0Pb/hnsL5Mzc2yQPeo50f2r6K9wSiwnA7PaeDypsphteTKuZFTgz3PZ1SbKVcQZ5Q==
X-Received: by 2002:a5d:51c7:: with SMTP id n7mr5384068wrv.73.1565877647858;
 Thu, 15 Aug 2019 07:00:47 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a18sm3816952wrt.18.2019.08.15.07.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2019 07:00:47 -0700 (PDT)
Date: Thu, 15 Aug 2019 15:00:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190815140046.GD10996@stefanha-x1.localdomain>
References: <20190813090727.18058-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Content-Disposition: inline
In-Reply-To: <20190813090727.18058-1-kraxel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2] Add git-publish profile for security
 bugs
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 11:07:27AM +0200, Gerd Hoffmann wrote:
> Simplifies sending security patches to all people listed in
> https://wiki.qemu.org/SecurityProcess.  Should also make it
> harder to send a copy to the mailing list by accident.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  .gitpublish | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1VZY4ACgkQnKSrs4Gr
c8hDywf/RccMZwyA/m2RRvJDh8lWIIAn3wn14w63qIMGoHJmHzF7popUPBBNrlp/
0UBeaANS13jBwJcRGgd9qiVBWit1K9k1s57girtEYh2/NBeYuGZPceE+zhHb5nWe
LyCwQ6qcm1ol2vstqyDl/JITz7fanFXQRjmkN3Lo1/XJF4wEFpo373lF0tdsJ8Ov
eJ1xavpbFH8t4TpKqtXW9wY/MoWRaSPswurewQhYyeB7LQ24QCJ66/Bk7p9Q2Jo6
5E/5ZXzi6eytmmkuXjIgPokaFGSewJ3KTq+a3WqY2Q8QRxeXPY4jF+8QaSkIYzGw
gL5wULHHDsi/diI4jTM7iif1aUpKYA==
=CSMa
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--

