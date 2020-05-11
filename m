Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54F2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F763206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPd8FYj1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F763206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY56U-0006kv-PS
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jY55b-0005ks-A1
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:51:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38840
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jY55a-0004eV-DE
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589190668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nn4+ebUEGjP12SLduyrxAK7er7p9DMP21wNjR3eT3M=;
 b=UPd8FYj1/UpDxcaZrZ8+k3QOHoZBrzc122p+mF/Fvatg/qZHmJcoPG5H4c/Jtua5DdLY80
 3tQRCEWPKyoz/6UjKkeYKqejsL3TorxLmOZQJEpmtxPPchH8j+N5Wm4MrFo0NnODPH2ANP
 oh4A2HTdeae79GQZNrFpzWrgBbZElDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362--CLs1YARNcS8YLgkDqlpXQ-1; Mon, 11 May 2020 05:50:34 -0400
X-MC-Unique: -CLs1YARNcS8YLgkDqlpXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A69441054F8F;
 Mon, 11 May 2020 09:50:32 +0000 (UTC)
Received: from localhost (ovpn-114-247.ams2.redhat.com [10.36.114.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2701D9CB9;
 Mon, 11 May 2020 09:50:31 +0000 (UTC)
Date: Mon, 11 May 2020 10:50:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 4/4] exec: Rename qemu_ram_writeback() as
 qemu_ram_msync()
Message-ID: <20200511095030.GA162792@stefanha-x1.localdomain>
References: <20200511081719.31641-1-philmd@redhat.com>
 <20200511081719.31641-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200511081719.31641-5-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 10:17:19AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Rename qemu_ram_writeback() as qemu_ram_msync() to better
> match what it does.

Based on Juan's comment in the other email thread I think this commit
description could be expanded. Let's explain the rationale for this
change:

  qemu_ram_writeback() and memory_region_do_writeback() have similar names
  but perform different functions. qemu_ram_writeback() is concerned with
  syncing changes to the underlying memory device (NVDIMM or file-backed
  RAM). memory_region_do_writeback() is concerned with dirty memory
  logging.

  Rename qemu_ram_writeback() to prevent confusion with
  memory_region_do_writeback().

>=20
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/exec/ram_addr.h | 4 ++--
>  exec.c                  | 2 +-
>  memory.c                | 3 +--
>  3 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index a94809f89b..84817e19fa 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -136,12 +136,12 @@ void qemu_ram_free(RAMBlock *block);
> =20
>  int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
> =20
> -void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t le=
ngth);
> +void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length=
);
> =20
>  /* Clear whole block of mem */
>  static inline void qemu_ram_block_writeback(RAMBlock *block)
>  {
> -    qemu_ram_writeback(block, 0, block->used_length);
> +    qemu_ram_msync(block, 0, block->used_length);
>  }
> =20
>  #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
> diff --git a/exec.c b/exec.c
> index 2874bb5088..f5a8cdf370 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2127,7 +2127,7 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t new=
size, Error **errp)
>   * Otherwise no-op.
>   * @Note: this is supposed to be a synchronous op.
>   */
> -void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t le=
ngth)
> +void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length=
)
>  {
>      /* The requested range should fit in within the block range */
>      g_assert((start + length) <=3D block->used_length);
> diff --git a/memory.c b/memory.c
> index 73534b26f4..5bfa1429df 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2197,7 +2197,6 @@ void memory_region_ram_resize(MemoryRegion *mr, ram=
_addr_t newsize, Error **errp
>      qemu_ram_resize(mr->ram_block, newsize, errp);
>  }
> =20
> -
>  void memory_region_sync(MemoryRegion *mr, hwaddr addr, hwaddr size)
>  {
>      /*
> @@ -2205,7 +2204,7 @@ void memory_region_sync(MemoryRegion *mr, hwaddr ad=
dr, hwaddr size)
>       * different types of memory regions
>       */
>      if (mr->ram_block) {
> -        qemu_ram_writeback(mr->ram_block, addr, size);
> +        qemu_ram_msync(mr->ram_block, addr, size);
>      }
>  }
> =20
> --=20
> 2.21.3
>=20

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl65H+QACgkQnKSrs4Gr
c8jv2Qf9FdFxat/l9/fF9kJ7noztTBcqr4GVwlKgemqW7WpSryJVfQVw0BiZmcx9
OzB6ETcwue2jKQYa61llIrRsb6Fb96IozHAKAfVsjeP2EZlf00thrg8NfDRPtF7h
freqnBSPC7ufszU/sVJ5Vb/AzbiWaajKdJ9UYU8h9s0Pq+8dvx+g0E1K8jmJUKZt
bucl0HVRn2vgn6QZC3UzNMgErx2qaf4opKY7aTdSfQQEr2aRWf38CoDCTK+6k5Lb
2xTTxCmDip+Doav33NcXMa1/3iBaPIEMQ1eGeRn1auweApyaL1ZXaPT4rvfMyH5b
MkgPygxBzdu6fGMFvvBWyYLkn3gYTg==
=aXLF
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


