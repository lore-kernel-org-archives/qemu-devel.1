Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A9EC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 11:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6B7245BB
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 11:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6B7245BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY7qe-0005ue-E8
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 07:43:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hY7pj-0005M1-QP
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hY7pi-0005Xr-Tm
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 07:42:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hY7pe-0004no-TL; Tue, 04 Jun 2019 07:42:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0023F316290F;
	Tue,  4 Jun 2019 11:42:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 71CC05D9CD;
	Tue,  4 Jun 2019 11:42:06 +0000 (UTC)
Date: Tue, 4 Jun 2019 13:42:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Message-ID: <20190604134205.757b217a@redhat.com>
In-Reply-To: <20190603150120.29255-1-alex.bennee@linaro.org>
References: <20190603150120.29255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 04 Jun 2019 11:42:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH] cputlb: use uint64_t for interim
 values for unaligned load
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, 1830872@bugs.launchpad.net, qemu-arm@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>, randrianasulu@gmail.com,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  3 Jun 2019 16:01:20 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> When running on 32 bit TCG backends a wide unaligned load ends up
> truncating data before returning to the guest. We specifically have
> the return type as uint64_t to avoid any premature truncation so we
> should use the same for the interim types.
>=20
> Hopefully fixes #1830872
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Fixes arm/virt bios-tables-test for me, so

Tested-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  accel/tcg/cputlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index cdcc3771020..b796ab1cbea 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1303,7 +1303,7 @@ load_helper(CPUArchState *env, target_ulong addr, T=
CGMemOpIdx oi,
>          && unlikely((addr & ~TARGET_PAGE_MASK) + size - 1
>                      >=3D TARGET_PAGE_SIZE)) { =20
>          target_ulong addr1, addr2;
> -        tcg_target_ulong r1, r2;
> +        uint64_t r1, r2;
>          unsigned shift;
>      do_unaligned_access:
>          addr1 =3D addr & ~(size - 1);


