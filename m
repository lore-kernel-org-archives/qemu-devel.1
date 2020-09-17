Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0025C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95CCE206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmDVACJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CCE206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvjQ-00022g-3i
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIvbD-0002WM-E3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:13:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIvbA-0003BF-DB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600355603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+K6q/3zM53tSz0Jg6jCnfeOCrnRzvzq1LJ9iy5Y99Ls=;
 b=LmDVACJnvQuWfKfO/piWXG81upR2lsWeCFNhzpbasaTuMLbIPOP+z37sTrYHyeOSjZN20V
 gIxMI18HqttOkbCcpKhbocdNc660vaFBAxAl43fR1wwCsW6reXppFZR7HfwvCAIu4qLlME
 EYE0Muo6LXhzCjDvQ7lFyoj6y+L9Xrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-04jssOVcNTioJXi6hRZYTQ-1; Thu, 17 Sep 2020 11:13:04 -0400
X-MC-Unique: 04jssOVcNTioJXi6hRZYTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF3B78C2211;
 Thu, 17 Sep 2020 15:13:02 +0000 (UTC)
Received: from localhost (ovpn-112-183.ams2.redhat.com [10.36.112.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 780F65D9CC;
 Thu, 17 Sep 2020 15:13:02 +0000 (UTC)
Date: Thu, 17 Sep 2020 12:07:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/3] block/nvme: Align NVMeRegs structure to 4KiB and
 mark it packed
Message-ID: <20200917110753.GE809514@stefanha-x1.localdomain>
References: <20200916204004.1511985-1-philmd@redhat.com>
 <20200916204004.1511985-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200916204004.1511985-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIMWL_WL_HIGH=-2.997, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:40:04PM +0200, Philippe Mathieu-Daud=E9 wrote:
> In commit e5ff22ba9fc we changed the doorbells register
> declaration but forgot to mark the structure packed (as
> MMIO registers), allowing the compiler to optimize it.

Does this patch actually change anything? NvmeBar is already 4096 bytes
long and struct doorbells has two 32-bit fields, so there is no padding.

I ask because it's not clear whether this patch is a bug fix or a
cleanup.

>  /* Memory mapped registers */
> -typedef struct {
> +typedef struct QEMU_PACKED {
>      NvmeBar ctrl;
>      struct {
>          uint32_t sq_tail;
>          uint32_t cq_head;
>      } doorbells[];
> -} NVMeRegs;
> +} QEMU_ALIGNED(4 * KiB) NVMeRegs;

I can think of two policies for using packed:

1. Packed is used only when needed to avoid padding.

   But this patch uses it even though there is no padding, so it can't
   be this policy.

2. Packed is always used on external binary structs (e.g. file formats,
   network protocols, hardware register layouts, etc).

   But doorbells[] isn't marked packed so it can't be this policy
   either. The documentation says that nested structs need to be marked
   packed too:
   https://gcc.gnu.org/onlinedocs/gcc-10.2.0/gcc/Common-Type-Attributes.htm=
l#Common-Type-Attributes

So I'm confused about the purpose of this patch. What does it achieve?

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9jQ4kACgkQnKSrs4Gr
c8izCAf+JQqePQeGrU2IYgL0uc9zFORaJb9Pmsy/r4hnYM5kRJa166lKrRSzhMWb
K7cn6t64FMFKc9vahK7V3ukqMzoy8OU1Dt94og4/lpOcAz1/7bOP052jyh1hGjVy
yP9FuHCjs082xzmU/LFz+DIY7FDMKXn7ckpfaX8qAushByj4nv9bwSsyaUgoFX02
18zusWmahQpFI2bD5RiTbxcJCzsVYbRXyWKPL8h5d3Tb81iBW0ch8EDkREZd1K6P
Yt60X24pupnLA1+O+5Co0efJQy+LUwgy0j2kMxdLX48Weseoau0qDYzNtCCYLO9H
A/BhSPiOXWccpaR1yPah5excsXi+tg==
=QMKC
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--


