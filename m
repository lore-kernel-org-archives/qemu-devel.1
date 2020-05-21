Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF0CD206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzXJiUpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0CD206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkZy-00035s-0W
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbkZA-00028Z-4K; Thu, 21 May 2020 08:44:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbkZ8-0004kq-Ut; Thu, 21 May 2020 08:44:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id h17so6508796wrc.8;
 Thu, 21 May 2020 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=twRmwHsXTaUvuSoa0FMOY+ZMOl9koaBC0q6GGRMooM4=;
 b=RzXJiUprOa3lUqaOSAKaXW0pujTe+3k/aN+6YcNMcacLVV3S6qWUILFMnEj0+MlSB5
 kj8ydUonLrTiLubj6siv5B3fU3jTESYMFxikoByRmkAWvL65B5UWjsJPKwfkahYOaFpW
 PHg/xQDRb1xZcggaD3lfdoQ2E06mxG9yRQ/DbOFbIOykMh1sr4UH2P4YgylG59PgiUc6
 3tnMONDza/GjWVgmWWejycs1MOCW36On5iAGffctXhqfreWYHLHJv3A2rFGyN2T2MhPr
 gVRyMmwaY4kIAK2tu3bW5fIUWgxQw9lu5fNO3knUt/h8JVKj7Stfu8tQiEiVcfecBLtG
 3oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=twRmwHsXTaUvuSoa0FMOY+ZMOl9koaBC0q6GGRMooM4=;
 b=DkrMOkOVFTwANK2wLLiM3zT/NJaNNHO8K29MQmy6n+iNJ7/Z+W7jn5ml1oyaldDn16
 u1LSjNCGs3l370OzRSwuy21P91590q6d6c7/JwosLW9ewDxHf40sAC37zoWngtJkJxJ/
 LwVPEticSKs9iyNlp4waa3wrHUD7TfrFou9cRrK8gqclonvY3g+JNtHaxV1RVPmz9KNf
 JLJ1xxw1HSbo6GNKzvEEKyjiWF7W7VI+e0EPXWIvaSFC5VBmd71oQrzezqcmLaX+4lBT
 Ccdu1M9fHbVHWf+zAZcqrZFtCO9DgVZOt0WftTZaRKRytQQv+PWKLUeKgK8Bz8E+y6h8
 Ao3Q==
X-Gm-Message-State: AOAM533/aPmgbrwB8i6BxHh6+CUm/fgSSJFfgoaJ/RhHbZKxG21fAY8P
 8+wJNCczTfQthmD348Oujro=
X-Google-Smtp-Source: ABdhPJykfWt0N9NnCYclgYtJIl+ryprlxwglpSFfeW8ofrP0FMwT+YBG4Vi9K7x8L61UmD6aWA/CSQ==
X-Received: by 2002:a5d:61c3:: with SMTP id q3mr8322408wrv.405.1590065089038; 
 Thu, 21 May 2020 05:44:49 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e29sm141147wra.7.2020.05.21.05.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 05:44:47 -0700 (PDT)
Date: Thu, 21 May 2020 13:44:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] scripts/tracetool: Update maintainer email address
Message-ID: <20200521124445.GI251811@stefanha-x1.localdomain>
References: <20200511082816.696-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Content-Disposition: inline
In-Reply-To: <20200511082816.696-1-philmd@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 10:28:16AM +0200, Philippe Mathieu-Daud=E9 wrote:
> There is an effort in progress to generate a QEMU Python
> package. As I'm not sure this old email is still valid,
> update it to not produce package with broken maintainer
> email.
>=20
> Patch created mechanically by running:
>=20
>  $ sed -i 's,\(__email__ *=3D "\)stefanha@linux.vnet.ibm.com",\1stefanha@=
redhat.com",' \
>          $(git grep -l 'email.*stefanha@linux.vnet.ibm.com')
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  scripts/tracetool.py                             | 2 +-
>  scripts/tracetool/__init__.py                    | 2 +-
>  scripts/tracetool/backend/__init__.py            | 2 +-
>  scripts/tracetool/backend/dtrace.py              | 2 +-
>  scripts/tracetool/backend/log.py                 | 2 +-
>  scripts/tracetool/backend/simple.py              | 2 +-
>  scripts/tracetool/backend/ust.py                 | 2 +-
>  scripts/tracetool/format/__init__.py             | 2 +-
>  scripts/tracetool/format/c.py                    | 2 +-
>  scripts/tracetool/format/d.py                    | 2 +-
>  scripts/tracetool/format/h.py                    | 2 +-
>  scripts/tracetool/format/stap.py                 | 2 +-
>  scripts/tracetool/format/tcg_h.py                | 2 +-
>  scripts/tracetool/format/tcg_helper_c.py         | 2 +-
>  scripts/tracetool/format/tcg_helper_h.py         | 2 +-
>  scripts/tracetool/format/tcg_helper_wrapper_h.py | 2 +-
>  scripts/tracetool/transform.py                   | 2 +-
>  scripts/tracetool/vcpu.py                        | 2 +-
>  18 files changed, 18 insertions(+), 18 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7Gd70ACgkQnKSrs4Gr
c8iJEwf/cwdiWqyO1yCf/46RzmdeW22C50aY8xZRRwY4Jt65k245onJv50WWkRzK
KWMCBaPAXG9xf/Z8doD0+PVpEbysIGfU6nt8Y8+4abWb8KP/gJky8Ehs6scfvKJv
9IFHACM6ON37lfBMLvZMYS4MsIv+E5zC/JrI+y7mwkjsn9icUHjx5ZHlK5Sp/DsO
CtB/0axPy8Fz5J76ipk37SMHcsiGOb8yKV4VBIih8nz5JmPLKvJsZ8MWHc3feCds
fTbgcjoa1MQFixBzLfBJCt0wj6TrW5dwilowhJ+d+ywA+fCDyZYUQgFwqEkIVBtr
VGju1PLrme1lilq9WjYO7r//bljBXg==
=XWv6
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--

