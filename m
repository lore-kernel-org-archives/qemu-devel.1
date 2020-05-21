Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6859F2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 12:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il3Zko/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6859F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbkPN-0005Ty-GZ
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 08:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbkNX-0002ZA-Nc; Thu, 21 May 2020 08:32:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jbkNW-0001jQ-RC; Thu, 21 May 2020 08:32:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id m12so5455329wmc.0;
 Thu, 21 May 2020 05:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oRe/eNK2OeSOCoA1q3sY8kJHX2EkxzAtNAGn69DVJLs=;
 b=Il3Zko/naYMbGfBvMiZ6ZO1XmAcKAEksWqpnpU90Vj8ODEuy+K9n38Zp8ELHXFWVhu
 axfSKSDVRczliz7Otv+9uL9292pjtlKYN17Fqb5VyXvqoLuDJCYRbemcCSBMJkLXBLOu
 M5xicUgmxg0nrQhhoG+JRQpC4Xi5SlaGeut7WvWW6Tt+g/Cxb0xJAk0y0RTef1nGw4q8
 YoJNA3Ys4NbPC82gXOVxEcmBcDDzrh7rKZF5ddWeR0PP2S4TalR4vtYW+koVFd020c6f
 Qi5DA4rFzXmjo8yr4uoaTm7h/YHm4AHTvwNA0tIIQl1BCQuf29V+WMcf4GocWkouvyIE
 PVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oRe/eNK2OeSOCoA1q3sY8kJHX2EkxzAtNAGn69DVJLs=;
 b=otuXahKG/C8T52xEvSYwqL7LzvVQ8IJ66DMjea4t23qkQS3GlUIazymwR+Rzjcjq1R
 odJdzghbPfegX+VhikxoU+Wu3J2cmCMcHgd+rfxuak4V5JOX98CySd+jioCeeTtV6M5i
 BhWOqMv7RVXNbalroG9/mY3r1o6kryFz0/GrjmjG854abNeF74XfYkdUQmR+xoAOOaku
 xJju9zKq1CGBkY6Zr/FdT1ywk5HEcQtMlVbnMvVhd0JJHSoq8R6BlZi6jKiLIPjn79QT
 QPtvA8Cd0d9RMhRzf67vWXKrgEowhrM+AC0gjJSzIsHe9IFIkQyTsXmlQjBY/P+ZX6N1
 4PJg==
X-Gm-Message-State: AOAM533S0N0uyKyHwrWRy7N1KPTgs1kQJ7IRIlwSMajJGX5wyL0wnmC1
 SaywrFj2q+5/0/nAua4mAk4=
X-Google-Smtp-Source: ABdhPJxkIooIpLr2LiyKiiEWjR4Kf4rwYxRuv0jLZy3g4LhIGwTq5/BX1vCprQTguFw5EmgU0MDdDw==
X-Received: by 2002:a1c:305:: with SMTP id 5mr8623563wmd.60.1590064368835;
 Thu, 21 May 2020 05:32:48 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x184sm6554504wmg.38.2020.05.21.05.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 05:32:46 -0700 (PDT)
Date: Thu, 21 May 2020 13:32:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/4] memory: Add memory_region_msync() & make NVMe
 emulated device generic
Message-ID: <20200521123245.GG251811@stefanha-x1.localdomain>
References: <20200508062456.23344-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
In-Reply-To: <20200508062456.23344-1-philmd@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 08:24:52AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Let the NVMe emulated device be target-agnostic.
>=20
> It is not clear if dccvap_writefn() really needs
> memory_region_writeback() or could use memory_region_msync().
>=20
> Philippe Mathieu-Daud=E9 (4):
>   memory: Rename memory_region_do_writeback -> memory_region_writeback
>   memory: Extract memory_region_msync() from memory_region_writeback()
>   hw/block: Let the NVMe emulated device be target-agnostic
>   exec: Rename qemu_ram_writeback() as qemu_ram_msync()
>=20
>  include/exec/memory.h   | 15 +++++++++++++--
>  include/exec/ram_addr.h |  4 ++--
>  exec.c                  |  2 +-
>  hw/block/nvme.c         |  6 ++----
>  memory.c                | 12 +++++++++---
>  target/arm/helper.c     |  2 +-
>  hw/block/Makefile.objs  |  2 +-
>  7 files changed, 29 insertions(+), 14 deletions(-)
>=20
> --=20
> 2.21.3
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7GdOwACgkQnKSrs4Gr
c8hL5ggAj7hrXgFBi0o9gIHh93AtEJblCpaPOtTNet0BOV/ko22yyAq9caKYZlsY
KRi1ZTPUeit4KMfEWJkGYqr9FX4Ouw5o+yifLVwiRWY7iybydQrMvzk616CJVPTH
0+XZsv6neVNhJAt5XnS/Sovt1nsI6aOJX2r8hiaM8fPbbbhv58lJIwtk1dAVCZr2
F2QgGk5d6FXZz+xMaGa9vFjXG31yG56BxD64K/ozJ8SqsYuYQ+X5OsPb8NQiPK1+
QqZxnR3SP9v3pKDXJ59KmPJQPNLgoPYbelp8Llietp5cIl/o64bDk/2iRiEDWldH
t4EMn+okcVinPDlBcGRpQLRQHLgYZA==
=jZw7
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--

