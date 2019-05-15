Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C33C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E361120881
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvZUowFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E361120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34930 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQrJz-0001Lw-8a
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:39:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQrIr-0000lS-Ck
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hQrIq-00071g-Ih
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:38:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hQrIq-000719-9f
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:38:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id w8so2087403wrl.6
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=fGQomAmfYsv3QFUEiAS69lY4nkrxcZdpENt6ktQXgJg=;
	b=EvZUowFzLmzLaPiFsb7SzRRTDd+ytbML8Bwz3fajKFp6WS5+iVh2GPngPEwvp5WBe0
	WZFmdp8prTUjVjI9uy7ybG4/fZkS0QUAtzlT9IX1NF+U5DS+3AN5wqlQYMCe0hvf4UP8
	5kRKO6SMqaHaXj7lMt2wigM37KZ0xqyiT0k9398R+bfKXMzV+NmUIGgjDCy3R59TXaz+
	i+s4uZRUvhm4hqVqJ/9TGA1wGjHZ2s2ORq7dMeuOWz/loqEwfLVf/peUyfOr0/DNI3pQ
	Xx6rXUA4AJ3m1BniG9VV2X4KmOGVXF4VCIgeNgJtw0n34LZAmADq6/nZ6Ci0La6wkWbl
	CBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=fGQomAmfYsv3QFUEiAS69lY4nkrxcZdpENt6ktQXgJg=;
	b=saoMmxh2clxZq87rc1sR5tozlrXuPTjNmDti+cyFHz7eQqXPz3cG2p8d9jROUEZUrd
	iyZqAi5pxTXNI9WiJkFqVtylqqnsiCTc5V/DYU8njEkinPiSJC8QmL4oL0rYPo4t3vgL
	7weJEJm+gZTHbIh7LPOWqkiyhA33hk1CgDcjLMcIaMQb0W03JKa/0IAdVmXqybnjATrr
	6akwhZMLva+lieqhwTxld+plUFXbcNVDWHYja784ZBgNUKIIj82yvrizKe/6c8Ubq4gz
	PiSd9E61NfXnMKhqIqOAE0juw6zDMT/vBX9BkM1NGrvZ2lScZeyxeVLKgGq+9JaK2/x1
	Z6NA==
X-Gm-Message-State: APjAAAXtTcl1Oufsd6eRpdr3FZuGPC7ywJwy+CKy+33nFLv+G2Pe3fP1
	ATzfEFHNmzumluEbeilEkxg=
X-Google-Smtp-Source: APXvYqzziJVp5kAUOFWZexfdl26AUlqeX6Q5E3Thd4PVBUC2SBjd9D/w/vp3BxnDarxN1xFxuOzwYA==
X-Received: by 2002:adf:e691:: with SMTP id r17mr6338422wrm.50.1557916707090; 
	Wed, 15 May 2019 03:38:27 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	u125sm3125319wme.15.2019.05.15.03.38.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 03:38:25 -0700 (PDT)
Date: Wed, 15 May 2019 11:38:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190515103825.GE29507@stefanha-x1.localdomain>
References: <20190510190140.17589-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <20190510190140.17589-1-dgilbert@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] monitor: Fix gva2gpa coverityism
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2019 at 08:01:40PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Coverity is complaining that while I'm checking the return
> value of mon_get_cpu(), I'm not actually using the checked value,
> I'm calling it again and thus it's worried I might get null;
> I don't think that's actually possible since i'm under
> lock anyway.
> However, it's a sensible cleanup.
>=20
> CID: 1401346
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzb7CAACgkQnKSrs4Gr
c8iNCQf/T3fCkKhEZQr1u1P0gMG9OOdX90X7+ZzRlXbdf7nKl1XT7i2azL69TJXr
YT4DWoktpbrCdEppVRKCCi/mqOQRENpjjvOif93hJFuaVuLDKVJFz0PB7Vv/h3Vc
Zoifrasjz1jiKCYyIjs8u1B/wZr97nuJadPURK/0K5YHOScFDFPHA/2aTksnc7Z6
uNGtkakR3S9l35bEXjkPQqmPX+BuCVEJ29eM4oLxdR+OqbSHEJ3iIrOcxRGDbOTM
hLFJyayvt8niPyJ5FHY09Gvu9Ps0+KOKU/YY2EMiT8oMlcl83l3NM7SZ/tYTL59W
x0NocyGVqjU06/z6oNNIxB7J05tjuQ==
=0ABn
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--

