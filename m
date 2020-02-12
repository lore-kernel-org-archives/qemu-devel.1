Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728CDC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEBF20724
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kr1OW2vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEBF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sZV-0001eL-FH
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j1sYI-00010D-Dy
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:59:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j1sYH-0001lE-HO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:59:42 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j1sYH-0001kR-BC
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:59:41 -0500
Received: by mail-wm1-x342.google.com with SMTP id c84so2574594wme.4
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 05:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=S238rRIKrPq1FuMvvJ7UzP3jw+n3ulk1FUkqh2+jDWE=;
 b=kr1OW2vue+ZPiluyhp3fHh0A7hfhvL06noEuYDHBYPzfbGheZh7D6N+88g3L74jw8P
 +ZcVHDDPfrWiPTW1fd5/JMsjZ/KWsxkL6z5kAB2ibTjHwOQXeIKt9T6COT7x7kHWVYeQ
 qMwUY81Lvt+fFKY5ccgwPeNqoqtdcD13Po7BKzp4J0Lke72kzV8LhX5Fyo52iylRbGmi
 Jw9DJ9NG6a7h2TyN5OTXlVLPygFng9+ZxiqlidoiKW8nmWOnT+QeuEt3GEMEWsNwz35y
 q7QUmLnyCBXRDNaFUJ5wXA2RPhTSea0sLsiSkIf2/Uhb/eDjnko+szn292ALujw6im5X
 qBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S238rRIKrPq1FuMvvJ7UzP3jw+n3ulk1FUkqh2+jDWE=;
 b=lQqT+2UPeWgPv6gkoQAKQoHCKlTKcjeTJIHwtNpDzoJEAHnYUjdRFPxGxDvkyzoAUc
 KKaTErhRg/A9L81d9v3dkTlOmNDnW2A6P02rl26o13ooCCKJ3CaSRkd8Padd3s88mQs3
 Y7N8Fkq5Kj+ZpRSbw+NVlh8fBCA501hsJjQIvOI+RHWjFUMXFcbSnH0ECMPLdiAeaKe+
 2meu5PifezqRB651VhxFUIz81CesqWVnoc5QW53rZf0IPE20lp70SeTv9r7EVbHK+Pag
 W0d0OSnntg1+ftDXt74vy6mkdXI9PTz8ZGsomrooFz1ZD0eOcTtVQjkySEbMeOpZNYc9
 ae+A==
X-Gm-Message-State: APjAAAUnlVu09DtcHiH8dKCj7mcbinUJP90NGZkdpsDtKM92VkQFU+zT
 zuKC6DrQh1tEL39StYf+8hiDd/JONHg=
X-Google-Smtp-Source: APXvYqzlHB6cFD/zCNjHymWewfyUpAbXpr0mrYrNUbEm58JPHA1/k3/bHjrTogd2zdVydqJFR6RTRg==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr13065839wmj.150.1581515980335; 
 Wed, 12 Feb 2020 05:59:40 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y20sm793462wmi.25.2020.02.12.05.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 05:59:38 -0800 (PST)
Date: Wed, 12 Feb 2020 13:59:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] tests: Fix a bug with count variables
Message-ID: <20200212135937.GD432724@stefanha-x1.localdomain>
References: <20200207115433.118254-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20200207115433.118254-1-tianjia.zhang@linux.alibaba.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, thuth@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 07:54:33PM +0800, Tianjia Zhang wrote:
> The counting code here should use the local variable n_nodes_local.
> Otherwise, the variable n_nodes is counting incorrectly, causing the
> counting logic of the code to be wrong.
>=20
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  tests/test-rcu-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5EBMkACgkQnKSrs4Gr
c8hp4gf/dwONW57TvdV0pTC9+Ay+PtugPakXkeWfFRTZwSlpqRFXHOSyjJbpAX/k
6+Ouvv+cGZF3Y9kK1lbn55QIMSXDpDkfEYQ2XWyTe9ywONWuSsnh96Z4/d2cjWWp
onGr0gasodEyL71GJUFywURuvuA2Wa2Ns8ij1JuJ4+dYvvNAJpDl+A65FuzsIBvj
eBOg9+B2gv3ePzZdm7daSpnBcHNBWBfIEH2T8VQQ+wcR91ifH10Mh2cpIoJGiiVb
OODcvp2W+Yl8JgdMdS4XpsWaXJ8q68cHifUVHvzmzj8sBbFUy8CSCQtiY0ATKpsn
bR1WogNR/4XJ45gK23diXFkIi3TejQ==
=u6Ho
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--

