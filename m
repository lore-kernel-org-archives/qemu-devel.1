Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C12C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 431AD208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUP0DZSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431AD208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58iz-0000gF-GT
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58iG-0008FN-Ho
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58iF-0000eQ-Eo
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:51:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j58iF-0000dk-85
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:51:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id p17so1960946wma.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Wp27tGuH6LiuX37IEvtQEB6wra31P5dXVPBwD1mrzAA=;
 b=oUP0DZSyWu2jEhNEdeWU/vAKqBBgrDNvs/3S0Pg5CtRzGJhNOen7zl5WXYIk12E24T
 SGKhBJrYpyPhzMnlBUuilwYwAkzlXGWgkvrjv/0GwhnWuur1R75T6j/Eg+IKvcELgs6N
 TIGJTYegbJAPnKzWC0FeDiTHEGlVmaQZWzkU0RTU6RaacfSHyyhLXxdinDj4DY0ffcfN
 J+Mbn4sOAjGJjqIMwLBpEtu4vNDErL4SiOFvrOYOv+QbiTmW8oCyShAvklsWFynrTJqy
 a+fB/pYCJ0Ka2i+TEuy5481UcOXnCFoDe3WVuPJ4+kxz6stKW2xgfSuWvRZqOP103pal
 ePIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wp27tGuH6LiuX37IEvtQEB6wra31P5dXVPBwD1mrzAA=;
 b=mR3PK4SYTw2ytwkr8qCCTFmzlkFsH5PMZ0d6fLGx1twXJZl4KDiHj21VKkrq83wGPZ
 zRHdCN5wJiVKa8hohqPVOH95O8dBHvNr1lfKc0W8JQnfOJIO+3jwJt/yUce1CMz0K2Lb
 oy6p5d4/2ta/Uy4zCg2JmG9ctXUGX/X9Ojk5Q3I0Z5DnzCM6LPPXLywILVm5/niE+SdU
 7zNq1m+euvF7E8NG/AwTL9XgoKNMfAGqJFYdu1Wsj+xX9s0X6qEFhmIT+JRiwD6gV8xd
 3+nl9eJZpPL1P1ssrRzElRoSE+BUivI+4DAwJ1Ztn+y0rFijl/H+ufWS2qzlZfIsbm0U
 NaDQ==
X-Gm-Message-State: APjAAAVKvtHI1comZX+uKJyqCvgQBv7xnhnYeVkJEY9k78ObT7vlpSrv
 VaqOkEO+yMldNc9NyYLJrEo=
X-Google-Smtp-Source: APXvYqwFBoOdIS7o2VVd+pu4MVX8ZBOMIKMRw9xT7zoX75v3VgyeSfFpWH286r1+Q9eX5Jy2Sn5sSQ==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr3924228wmj.19.1582293086047;
 Fri, 21 Feb 2020 05:51:26 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m3sm4064283wrs.53.2020.02.21.05.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:51:25 -0800 (PST)
Date: Fri, 21 Feb 2020 13:51:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] rcu_queue: add QSLIST functions
Message-ID: <20200221135124.GM1484511@stefanha-x1.localdomain>
References: <20200220103828.24525-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q8dntDJTu318bll0"
Content-Disposition: inline
In-Reply-To: <20200220103828.24525-1-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


--q8dntDJTu318bll0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2020 at 11:38:28AM +0100, Paolo Bonzini wrote:
> QSLIST is the only family of lists for which we do not have RCU-friendly =
accessors,
> add them.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/queue.h     | 15 +++++++++++--
>  include/qemu/rcu_queue.h | 47 ++++++++++++++++++++++++++++++++++++++++
>  tests/Makefile.include   |  2 ++
>  tests/test-rcu-list.c    | 16 ++++++++++++++
>  tests/test-rcu-slist.c   |  2 ++
>  5 files changed, 80 insertions(+), 2 deletions(-)
>  create mode 100644 tests/test-rcu-slist.c

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--q8dntDJTu318bll0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P4FsACgkQnKSrs4Gr
c8jHLgf9FsIYPAXfY05DCMx6pnEzmxoqNwYCi/IA/ZqGfG/qdW4bp5QIKH7TVEoi
GA9PoCP+pEYs4oLfo/p54KaI8ElbXOB1z5z3lGmSmH/owiA8oSZhOfjASUb6izke
VjwkE47tuxcALDRveeNtmq2vfcx7Ro3ze1JWGPBdhjDaxCKducPwn00SGAc/Wkbs
y8wVHZTFw5IYi0egcZLV3YwA1Z5Kbw/xChNY6vhjv54PVmBA6QekxDQ37/BxNrJC
yPwfLCLZP+2Y5Jz8Degs9YR+vPu1EWM51wcvE2w8Y/JO1cGQ/mf/89UyERNF9H1c
jd49/s3qn8KJJimV1ImpzYbe55BQ5g==
=iH11
-----END PGP SIGNATURE-----

--q8dntDJTu318bll0--

