Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E24C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E32B2078C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ3gNfFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E32B2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVbGP-0003hJ-CO
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 09:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVbFc-0002a4-2T; Mon, 04 May 2020 09:35:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:51844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jVbFa-0002fi-5C; Mon, 04 May 2020 09:35:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id x4so8489320wmj.1;
 Mon, 04 May 2020 06:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/LXWw1yFvQo2XzE1xEnrfGvQ/MfGI1uwGSadxtVUsMM=;
 b=iJ3gNfFbMMn25FRf1jWuv1MmsZ6N3Az5di6aNDRdQjqiKg6J1fK62yjIspF8rxUkmu
 JxWHZqbUg8Djrbob0vCwuV24zcKIjMFzk7OtNJ+vLHINDLo4pJr3CYbi6xVCGear1iub
 W22Oxn21zLWb5Ld4TExq+ncp3Zu6pVgepW0d3dJYb3WLoHqtyy+Vs0Aid0px/bBlm2f8
 T0DYl8ISuRNZlCeRyOSq65363XTPKqAmnjMqG83UflpjOXW0LIrFtqPtXpbYf0hEp2Vh
 FgscoZkioNTsY4r8brZXubPhyOM/Hlh9l3Rk597F2DRl3sfechs3lvRExi0dfYDBakIF
 clhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/LXWw1yFvQo2XzE1xEnrfGvQ/MfGI1uwGSadxtVUsMM=;
 b=jVTzKzxbEyrPk/vrVX308I08oywr+wf5m7Wkm0TxE7Jy7EJNkgS7L0ORQdYD8DoejB
 dLsabecIgjbdjnuSdhAf45PGEJi0WiVqh6njDSzcB74kQ8Df/3DMimUdSGVAGMgmO2gY
 D3NCE/4r9YsVxA2rZiw5SKwCJzIhGWh8YjnHTRPkhhbVhWFgVBBlNtNN2i173UUkv5Dz
 MmOF31VqLicDdpaqC6tczUkPUi4+izp5sR0SfD1shZrUoukmWzShaO40GRKe/d+l3N8h
 ONbzWVtrSNVjlWqziSrY5kn747hmMxNIOtvos+3Brr72drolqpJpRc0DNHkXCBBi1jlM
 9cJQ==
X-Gm-Message-State: AGi0PuY41UEZMy0Gu8xR8LlyzUggLVI+c4lozsPp3xb8uFb1TuCWVqgA
 LP8KM5PYHWFC8zHuLl3CSXU=
X-Google-Smtp-Source: APiQypJmc6R9Lg8zpgqkoLrfWQ2Df9G1N7GQdKalao8ECQDTZbfxPO78jL+k867GvV2aLiSsS6KcCA==
X-Received: by 2002:a1c:f609:: with SMTP id w9mr14476578wmc.123.1588599312058; 
 Mon, 04 May 2020 06:35:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d143sm13577381wmd.16.2020.05.04.06.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 06:35:11 -0700 (PDT)
Date: Mon, 4 May 2020 14:35:02 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1875762 <1875762@bugs.launchpad.net>
Subject: Re: [Bug 1875762] [NEW] Poor disk performance on sparse VMDKs
Message-ID: <20200504133502.GG354891@stefanha-x1.localdomain>
References: <158811390770.10067.14727390581808721252.malonedeb@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <158811390770.10067.14727390581808721252.malonedeb@soybean.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x333.google.com
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 28, 2020 at 10:45:07PM -0000, Alan Murtagh wrote:
> QEMU appears to suffer from remarkably poor disk performance when
> writing to sparse-extent VMDKs. Of course it's to be expected that
> allocation takes time and sparse VMDKs peform worse than allocated
> VMDKs, but surely not on the orders of magnitude I'm observing.

Hi Alan,
This is expected behavior. The VMDK block driver is not intended for
running VMs. It is primarily there for qemu-img convert support.

You can get good performance by converting the image file to qcow2 or
raw instead.

The effort required to develop a high-performance image format driver
for non-trivial file formats like VMDK is quite high. Therefore only
qcow2 goes through the lengths required to deliver good performance
(request parallelism, metadata caching, optimizing metadata update
dependencies, etc).

The non-native image format drivers are simple and basically only work
well for sequential I/O with no parallel requests. That's all qemu-img
convert needs!

If someone volunteers to optimize VMDK then I'm sure the patches could
be merged. In the meantime I suggest using QEMU's native image formats:
qcow2 or raw.

Stefan

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6wGgYACgkQnKSrs4Gr
c8gbhwf+IzSQavaUeT6INrnroUEZOFG5CMBV+PnNW5tQhfqzABMGWeSn4C1WCeKP
KprcTlaU7Ye4dL+QiNrh8gQbq2gKOv4fMYi/Hqz6v3PHy94Xn4GlC2JMLtrWn6Gl
jRBkDjLu9g+YzT0EwPcTrrSb1h0EaTAmihLffUqOelttX13QYlKHJ4oNQXfxp9mb
2hwgGrgxir9PE2por3+DbIZq2GQAT3+/g/dsZ90pyv6Ixlk6LA3Wy5dacS8vqpmF
bIqqNodUALk5MtW21KD/fu7n0u0PIdOdultZ7HkkWMyzA4twWFRWS/aYsGwi54Uf
DpLk51QxpdFbjNcYt+2TgyRN+bfgaA==
=gs4n
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--

