Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89FDC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B8D20735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvvR2VPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B8D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGN8r-0005GN-MM
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jGN85-0004MK-PU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:28:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jGN84-0002lv-GD
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:28:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jGN84-0002lh-95; Mon, 23 Mar 2020 09:28:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id h9so17063364wrc.8;
 Mon, 23 Mar 2020 06:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wu0Pst8qsNF6PrSvx6A5jOL5VHU873nOwjx/pikPcUo=;
 b=jvvR2VPwVXSM3F36lvSU80C+P5HhRxldxm58aZVzeDh3vel7RkFBUy5BCGaB19fXI0
 qFvcBuYBMSkFU6tjg+JUK/MDC82AlMmcsJ6SZZHniuOueuS01eXRV2UCak9+h1durytX
 avaTy8JcTt8wF4fAtsbWzdFnMQpCHgBTm0LO2Ylm//30unJK81+K7h6Iq2rvcWfk6hFR
 w5zsebE3u2c8c40z4t+lNUgdsJWU0TgPrVMCsg8HS5Rcivj/gQXoj8jycCQTbX5li2kd
 JvFctqjQnYJONaKxoNOsbjD5sfLJrjylmqnmgLILk9Kree0Ylxcb7sIGR86V6B4iVpl3
 BR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wu0Pst8qsNF6PrSvx6A5jOL5VHU873nOwjx/pikPcUo=;
 b=nJJDQhmlE8E2XHdSkXbuUotAd9s+Hlf4LI47eiR+rFO2jRuC9ZFw0VmY65a6XInF6N
 ooVYG+u0A1cfl1sJgZOYUJ529C1bb82aTvBACAsr4mQSTfTvSdwPUo4WtA755bH0v3r1
 mmcDdeGTi7NURP3Vus87EKw7zQK7Q4cZBnDcNERCjCAi0pRdK0RtyRe1BReOz7WW6SNy
 ej3aNpeJGD30+0rFMu6iEkdh7/PHUrlrPEQnsTG8Cxbk4qos1uGRUC17ZigjmZNSAGCb
 tFe8Jz4vOwxztlnV2Baj30NsaDVMjoCk/ckMnxdEBjILtS0uNexmvQqHxENessfpcaTu
 vKVw==
X-Gm-Message-State: ANhLgQ26czb9zkolDkdiobc6ADzqeD+KwSrTlY3UNDf7IETli/7aFqsW
 2t/+D8uOF7sMPUX2lW1uiWw=
X-Google-Smtp-Source: ADFU+vvbgEGsIOHgvFKA0K9KKNp5KyEn6ZPMRYnYhNd+jdYHK25SYZ6564xO25cBn6sjr/HWadyK3A==
X-Received: by 2002:a5d:4081:: with SMTP id o1mr27252445wrp.114.1584970111202; 
 Mon, 23 Mar 2020 06:28:31 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b15sm23323763wru.70.2020.03.23.06.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 06:28:30 -0700 (PDT)
Date: Mon, 23 Mar 2020 13:28:29 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH v4] block/nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200323132829.GJ261260@stefanha-x1.localdomain>
References: <20200320215029.32727-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwgQ89ZNnFUwFHTC"
Content-Disposition: inline
In-Reply-To: <20200320215029.32727-1-andrzej.jakowski@linux.intel.com>
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
Cc: kwolf@redhat.com, haozhong.zhang@intel.com, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, dgilbert@redhat.com,
 qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com, junyan.he@intel.com,
 kbusch@kernel.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rwgQ89ZNnFUwFHTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 02:50:29PM -0700, Andrzej Jakowski wrote:
> This patch introduces support for PMR that has been defined as part of NV=
Me 1.4
> spec. User can now specify a pmrdev option that should point to HostMemor=
yBackend.
> pmrdev memory region will subsequently be exposed as PCI BAR 2 in emulate=
d NVMe
> device. Guest OS can perform mmio read and writes to the PMR region that =
will stay
> persistent across system reboot.
>=20
> Signed-off-by: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> v3:
>  - replaced qemu_msync() use with qemu_ram_writeback() to allow pmem_pers=
ist()
>    or qemu_msync() be called depending on configuration [4] (Stefan)
>  - rephrased comments to improve clarity and fixed code style issues [4]
>    (Stefan, Klaus)
>=20
> v2:
>  - reworked PMR to use HostMemoryBackend instead of directly mapping PMR
>    backend file into qemu [1] (Stefan)
>=20
> v1:
>  - provided support for Bit 1 from PMRWBM register instead of Bit 0 to en=
sure
>    improved performance in virtualized environment [2] (Stefan)
>=20
>  - added check if pmr size is power of two in size [3] (David)
>=20
>  - addressed cross compilation build problems reported by CI environment
>=20
> [1]: https://lore.kernel.org/qemu-devel/20200306223853.37958-1-andrzej.ja=
kowski@linux.intel.com/
> [2]: https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10=
-Ratified.pdf
> [3]: https://lore.kernel.org/qemu-devel/20200218224811.30050-1-andrzej.ja=
kowski@linux.intel.com/
> [4]: https://lore.kernel.org/qemu-devel/20200318200303.11322-1-andrzej.ja=
kowski@linux.intel.com/
> ---
> Persistent Memory Region (PMR) is a new optional feature provided in NVMe=
 1.4
> specification. This patch implements initial support for it in NVMe drive=
r.
> ---
>  hw/block/Makefile.objs |   2 +-
>  hw/block/nvme.c        | 109 ++++++++++++++++++++++++++
>  hw/block/nvme.h        |   2 +
>  hw/block/trace-events  |   4 +
>  include/block/nvme.h   | 172 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 288 insertions(+), 1 deletion(-)

Excellent, thank you!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rwgQ89ZNnFUwFHTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54uX0ACgkQnKSrs4Gr
c8iQEAf/cbnhoB/JEBlSPfj2Lx/tCkA3d+vEK4/EAxcnI+E08emGETV4Fq9fuxr8
68ApWlJOWoUFzne8UEzY6rDSwXEgS9cGeIJm2RBBZOcL1yJzZFe3i+bxuSxAdjUT
f6zRzU/yLBEjSd/X4xF0fCYziGRY402DqkMzymGfJSsdEjb/OWRsCwIZlRRT3520
X4/kPLUNGS1QUyh3OyJeV2dtIBdTLi2FvNDe179KF2NjKnHvl22uZ7j8IKV9ya7j
cw76qWwZiSm5VwA9o1t+nuBeEIzazqMLIqG/vr/+H62D4SNtMgCSI/opCmoppC4K
O5A9hYOijPO6EfzQbbRFYhb44oyPvQ==
=mB7y
-----END PGP SIGNATURE-----

--rwgQ89ZNnFUwFHTC--

