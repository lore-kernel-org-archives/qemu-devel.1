Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53140C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F58B206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeXXNRzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F58B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5gd-00073E-Ey
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hs5gE-0006ei-4B
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hs5gD-00062d-6A
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:27:10 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hs5gC-00060y-Vs
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:27:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so61835535wrf.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3o/2YoQr0fKPWcdh9lEvGvvQ1rJtAZyO4dm9qUqpV10=;
 b=aeXXNRzGVjX2vZexY21QVKJmcMVA4L2bzGEyVEeOEVAqpc+6cZHoO3ejvkrYK/U8wg
 iVSWm7wuNe9rsS2DiNXGucWGg16ZWBDX7UWmwyD+YAHIrqHc+fD1Kpmja/1RGjLfwpUm
 OdJTentRtO6XYtD89EqmPHmjXq5T1c+Sskh13uoROH5lcy/FsyCo4uhX7iq0k31YlxXt
 r5VNyWbU+cnbb5p6NeVdHNzasFOeIBZEblE1grTCgGNLHK5ljJ1kWyuxLFl2hCoIyMft
 x8ZgNoBkFUBf+df191nePcr4t2qj0XF39+Ek4Y2CiN8WUD9iRt6oMYRErMVzMQoyZTjT
 pBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3o/2YoQr0fKPWcdh9lEvGvvQ1rJtAZyO4dm9qUqpV10=;
 b=UI/DPEZUP6vjekviZhC7lTZ5SEvuuVO3NsYJe3BUqXbi74jyKX6NO1JAh9J6WjHQhO
 gXmFUXJJ42Aa/bXYk6bJnMbn2lmNkSrdvvK1UkYKBgjzYB9yfbAdZQ2h5fyY1n+1CMR+
 Gsi8SM8BtMVyws7BKhVKqdi8+SSpAmwi5xOjqzQ2BPE5f8JS3VhCkEzIW8QLX+91WAhO
 Uefd2GL1RuQ8kwqdY62ecRZ8JZf18rD2bzgepxNBaCXOuU171WR0RTISM/5EDB8gOUhW
 FCYYeFH9XzYx2y/NcA45ujD1ogiPGxsRQ6oPBBTp5HR51HYcPFc3dOoiad5YyP+bQ/UL
 UHGQ==
X-Gm-Message-State: APjAAAU9URdGX8/c4O+cBGty2OTGuszeFhf2L0qjiHtBcV8JR1zI9E+0
 YTzI2YG9bcMoB33LIpi7qLM=
X-Google-Smtp-Source: APXvYqxyX/LlMn3URX62vEhI8ENlSYHW85g9I+A35+HtN7yofAKPJg13wmAPqyLVNBpPbjuKVRDycQ==
X-Received: by 2002:adf:e343:: with SMTP id n3mr81722059wrj.103.1564406827105; 
 Mon, 29 Jul 2019 06:27:07 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x8sm51414943wmc.5.2019.07.29.06.27.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 06:27:06 -0700 (PDT)
Date: Mon, 29 Jul 2019 14:27:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <20190729132705.GC6771@stefanha-x1.localdomain>
References: <c6d83f1f-50e2-60e1-38d7-4e622ac71a8c@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <c6d83f1f-50e2-60e1-38d7-4e622ac71a8c@windriver.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] high-level view of packet processing for virtio
 NIC?
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


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 10:18:01AM -0600, Chris Friesen wrote:
> I'm looking for information on what the qemu architecture looks like for
> processing virtio network packets in a two-vCPU guest.
>=20
> It looks like there's an IO thread doing a decent fraction of the work,
> separate from the vCPU threads--is that correct?  There's no disk involved
> in this case, purely network packet processing.

Most production x86 KVM guests use vhost_net.ko to perform virtio-net
rx/tx virtqueue processing in the host kernel.  That means the QEMU code
isn't used and the code path is totally different.

Before spending too much time on this, check which code path you are
interested in.

If you are using QEMU's virtio-net without vhost then the main loop
thread processes rx/tx virtqueue kicks and packet rx/tx events.  The
vcpu threads are not directly involved because the ioeventfd feature is
used to direct virtqueue kicks to the main loop thread instead of
blocking vcpu threads.

Stefan

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0+9CkACgkQnKSrs4Gr
c8hIzQgAxFjgo6JLLJ37AlTCAbdBz/3mZJqpr+BOtLHAeKD37GXt1f9j9Z7bnWnG
97jdH4mjqEIekE4iRgaaftHetxY/nT/tydHlvk6CsFJWWyePyiOwEuo3QfyxjqwK
yje+l1Ey4Nf222mYYTwy+DUYGJN8INLnF70eb5TRFm8/jxGSLLNxhUIHY+yQCnD3
Shy8agHmfGgBJfXkDBZTDOUMsLqfvZd+fJ8ifiMw3bAVwAZP/kH36ii9zdFN17Fb
MU27PrDOHwyjBJupjuEm6Jgp5oM5aGSWPTLe/wlaJEKkFeXyS7zEN8+tsHP42CE4
+ka882Pjqbn9T9D8O6bw1zpMYHOJtQ==
=mZPD
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--

