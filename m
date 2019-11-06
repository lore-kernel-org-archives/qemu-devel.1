Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F334C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD0C2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6Ckdmzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD0C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSN5v-0006vm-1F
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSN4w-00067R-2H
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSN4v-0003ib-4x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:18:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSN4u-0003iC-Um
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:18:37 -0500
Received: by mail-wr1-x444.google.com with SMTP id i10so5589060wrs.7
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2EnUdpzQWUpikXvWQEQK88B2YP2cBm8MjYxWVgPcDNU=;
 b=G6CkdmzhVczXocG+q5/91vdyx79aecheACdDe2vYey0HLpAOlyEGGx8gg8M46YCp+V
 +H+Rn6nLKsc14c4WyBTCKxkFAiOwW31tEzuevEnF3QYlin8UPpgpXe42Ge6R7URJbOlj
 XjtyUQOvRH9zxhBOJ8tX9LTsCTRikhpFiXoOLMbu2vR5W2oo3iOSUIGG+t0Pxe2Ko5rU
 bDaKEbHH8PTynRh3li63ndU/4vxh1oWlzs+YaLc/26cehZ1D9YIYmbvg2cmKh110PxYv
 5tj8Xii2hUs7Lb61iBqw8d+BHeTSpVrv105gYjVfmU4dNkGOftEbJIbWG8WX1aVXUPym
 poKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2EnUdpzQWUpikXvWQEQK88B2YP2cBm8MjYxWVgPcDNU=;
 b=aAOcJ9WzmZb8gQuyC+sofhRYSxjIPYdm5aPm15UnfBajB0O3Cg/2v4WQ+pUx1nHsa5
 NaDwb3YZ4mSAjKzjR7jFkOFznm10VMm/Ky8trxtB5KJy9yEnGLFVcYKjj1zWYocRHsP4
 //B9PF1nL1IBFUSE+W08SpRAwowg8rvA5UT7lL+X+bUyUbUdpwsguB6XDKPxP/4yTHXx
 u8Rq//6ZDSu1/sJ67cYDuOBL8cNmkthcQco4b+DzmuKxTkarvwluBSKgsNxIKLIfhWvK
 KDMYLNkJ4viH8je5JwO6jTptexPDpUJeUGRJdwaFXtluDBOHOu7kZHxhb8idjLZHsQV8
 8NEQ==
X-Gm-Message-State: APjAAAVxeAD17uVHGaK028tuoA6kqG3Jit9UJ/jPw4jWVXyRhq8Tptd2
 y89T0vysdExpZjryFgxgE5M=
X-Google-Smtp-Source: APXvYqyc585l6BypXIOrvWGeCZ4NEga2ZTYWbWf5hDDaiVAWFxdACLr0CsbHLtvl+SCuPlMk0i0iEg==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr2878110wrm.179.1573053516049; 
 Wed, 06 Nov 2019 07:18:36 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id l4sm41352573wrf.46.2019.11.06.07.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 07:18:35 -0800 (PST)
Date: Wed, 6 Nov 2019 16:18:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 03/20] fuzz: Add FUZZ_TARGET module type
Message-ID: <20191106151834.GC340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-4-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-4-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:50PM +0000, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  include/qemu/module.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C5EoACgkQnKSrs4Gr
c8jIIgf8CSUElYjDuWqp5NpB7m2rMnvS0P+dPFU/sqeZsyfCD+cXqe+HJMDQFgna
8W98KTOMX3XCcftXFsUJEwF1G+tMemqGbjjRtDDVyFvnrs7JDwnj26pqLhCo8wuH
xvLRrUZLYI0GeExOiKA6XwEzhJb2UU7Gu899RdlSBbMjcCU44XHVpxQpVv78fBvG
F2Ms8es3Y0ynos41Jkz31LIgkgJa8REzGq2YbAdGkzM7gCxHJ9KKpQsI8QvVFcrY
W0gsKvvqd7/vFdbCvuBM+wfNyQj9YYyFSc/EuhiTnhqmiBBkOoyjC/4FZFojass9
+k4ZUNhh2rzVdR5kUaSx4Mkw5H5rzA==
=I9/D
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--

