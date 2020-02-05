Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23361C352A2
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E735920702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXAC5N2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E735920702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLjY-0002tD-VH
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izLiJ-0001LA-Vg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izLiI-0002Z4-Pk
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izLiI-0002Vd-IH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:31:34 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so3012459wru.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ra1gr+2oURpZSjRB7HONE42zZVzjaUu9KOoewszMlgQ=;
 b=LXAC5N2tjZech/U+qskZGmlGiGsg7TJP3qbRMCciUd6Y0ca1SmHRp1+UYLU3QgfxH5
 z5BVzuyAGaDGSnwurhZvaBSkeAfZ/FMTZOSg7SElwh43QetozG/G1mRjFWYdw9jNVLtk
 7wKClmaCDPFroD2E9m6YYXIZmYjIltXDZAyJGfY00DPKu1lk5jO04lsJOTe9zTxo/YkN
 i79Ywk1r85oBFSj1Br0oR1sdy92eYf0PBy6iVzz60WvyvXtsOq5uTBXE9upK8v7uolgd
 KLQd6FC/xNncjWeOWCoDhBoMqzFJT8S/ixqGnExG4VeD70y6kbs68wDTSk7W8XUW2NI4
 tt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ra1gr+2oURpZSjRB7HONE42zZVzjaUu9KOoewszMlgQ=;
 b=im14dplfYK1bMuhO+eyrE1BGxIiapQ+OdMC8zxoniLCixbOZF+NU7Yf2QNreuhkJ1/
 NwC5oBMzweJlpKKbdw/5B1wVXemqSoY92xHWmxHP1MAVTEJFS/qK5CtNpwNG2mwtBIRj
 usLoIjYwDp8p1+9h0fktB2altMGcdDQ+eXzAJgbYM9ATw/5Za3U80V+wWaarC4ve4nqp
 T3Y1n/SYlYpCocfoU6rPRbMsHBBxN65IDr5YKEKpYygYbiRWciRU+W6UnjzyR99mhKVm
 SHkU5DnRWzOELz4pTdrfngXG6YpbwqhaD3YHekWfg2bW6UH2GI86Oas4RRUahRj3jRxV
 0yIg==
X-Gm-Message-State: APjAAAW6LcOllaehf2Hjs48qywrksZPann2AvAKf2hOEr2jis+y5TkST
 u1KvzJS0pkmdnoZ2g9oIX3I=
X-Google-Smtp-Source: APXvYqyrpVcbO+KG3BsiIJ9/Io8XIqh1eN+PC4sx6KVr54oT2W0YblN2tqDiZvgUxcxXxFtaZHudgA==
X-Received: by 2002:adf:df03:: with SMTP id y3mr29043499wrl.260.1580913093220; 
 Wed, 05 Feb 2020 06:31:33 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b21sm8625871wmd.37.2020.02.05.06.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:31:31 -0800 (PST)
Date: Wed, 5 Feb 2020 14:31:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/4] virtiofsd coverity fixes
Message-ID: <20200205143129.GF58062@stefanha-x1.localdomain>
References: <20200204110501.10731-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <20200204110501.10731-1-dgilbert@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 11:04:57AM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Hi,
>   This is a set of fixes that fixes things that coverity pointed out.
> Only the last one (the NULL check in do_read) is probably important.
>=20
> Dave
>=20
> Dr. David Alan Gilbert (4):
>   virtiofsd: Remove fuse_req_getgroups
>   virtiofsd: fv_create_listen_socket error path socket leak
>   virtiofsd: load_capng missing unlock
>   virtiofsd: do_read missing NULL check
>=20
>  tools/virtiofsd/fuse.h           | 20 --------
>  tools/virtiofsd/fuse_lowlevel.c  | 81 ++------------------------------
>  tools/virtiofsd/fuse_lowlevel.h  | 21 ---------
>  tools/virtiofsd/fuse_virtio.c    |  2 +
>  tools/virtiofsd/passthrough_ll.c |  1 +
>  5 files changed, 7 insertions(+), 118 deletions(-)
>=20
> --=20
> 2.24.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl460cEACgkQnKSrs4Gr
c8iTrAgAwcghdnF6Fljyzhs8x0LUX1DHs4OJxW96s9E5N1VaqUJVfdbZdCeV82Y9
Z2Bv3GTL6BDlFd/dNsbjJ6jzDOlBbOKl6Uvx2Y2+AuweczT1rWNKnW/n8z+imgHb
/ZyqVGTFnuxDfEpsvFE5ee2zz1/yD94lUbvWP7pwboiR8SIGatK3/1+S7dzE4EZl
7r87h7kemEQT1cQ7JaSXMkQdtV0c3RBRr0DC6BzBrXCA00gdtj14qmHWyGGkE/73
FxbenwU+UEbUosVsZnxWCiNoIAqfhnywRclt+FrDLV1rfuK6La0Tl2gXMweRethw
NT2fhZxC59utuXETm4/84A4AUUbY6A==
=0pjp
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--

