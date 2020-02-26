Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF38C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D015421556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSJZFAj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D015421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6z8s-0007nC-0U
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6z2n-00085c-Jj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6z2m-0007Ut-5i
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:56:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6z2m-0007TJ-2B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582732575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1igi9ykotGU2A39oy4h2Af1zX9tVmd6s3/K2j/j0AqY=;
 b=ZSJZFAj7SCMfs/FKs7+tjG085laJooiKib7vCTwLEVMybp0rXViOAYsuOVNKw4R1Ec/jTH
 405PMLoCVex1of1L29Eu7H5bDV3y25+Ae8I0W7A9y5K/62MIC/O7CjKBK/tzvk+p3yYQwv
 Hb5ZYrRs+dOLvoxCSyKR/lD4fnI8oqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-C3qV1A0YN3qBnw-mBoZ_gg-1; Wed, 26 Feb 2020 10:56:14 -0500
X-MC-Unique: C3qV1A0YN3qBnw-mBoZ_gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7D76801E5C;
 Wed, 26 Feb 2020 15:56:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45FBA399;
 Wed, 26 Feb 2020 15:56:11 +0000 (UTC)
Date: Wed, 26 Feb 2020 16:56:09 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] accel/tcg: remove link between guest ram and TCG cache
 size
Message-ID: <20200226165609.48a0b5d8@redhat.com>
In-Reply-To: <20200226152710.31751-1-alex.bennee@linaro.org>
References: <20200226152710.31751-1-alex.bennee@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, f4bug@amsat.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 15:27:10 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Basing the TB cache size on the ram_size was always a little heuristic
> and was broken by a1b18df9a4 which caused ram_size not to be fully
> realised at the time we initialise the TCG translation cache.
>=20
> At the same time the default code generation size seems mainly set to
> deal with the fact we use a static code buffer for CONFIG_USER to
> avoid mmap allocation problems on constrained systems. So we:
>=20
>   - only use a static code buffer on 32 bit systems
>   - up the default buffer size for bigger systems
>   - ignore the ram_size and just go with the default
>   - document the fact tb-size is ignored for 32 bit linux-user
>=20
> The could potentially slow down softmmu emulation on 32 bit systems
> with lots (3gb?) of spare memory. Those users can still manually up
> the tb-size via the command line if they do in fact exist.
>=20
> Fixes: a1b18df9a4
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>  accel/tcg/translate-all.c | 23 ++++++++++-------------
>  qemu-options.hx           |  3 ++-
>  2 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a08ab11f657..cdfa2db7c56 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -891,11 +891,12 @@ static void page_lock_pair(PageDesc **ret_p1, tb_pa=
ge_addr_t phys1,
>      }
>  }
> =20
> -#if defined(CONFIG_USER_ONLY)
> -/* Currently it is not recommended to allocate big chunks of data in
> -   user mode. It will change when a dedicated libc will be used.  */
> -/* ??? 64-bit hosts ought to have no problem mmaping data outside the
> -   region in which the guest needs to run.  Revisit this.  */
> +#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS =3D=3D 32
> +/*
> + * For user mode on smaller 32 bit systems we may run into trouble
> + * allocating big chunks of data in the right place. On these systems
> + * we utilise a static code generation buffer directly in the binary.
> + */
>  #define USE_STATIC_CODE_GEN_BUFFER
>  #endif
> =20
> @@ -927,7 +928,11 @@ static void page_lock_pair(PageDesc **ret_p1, tb_pag=
e_addr_t phys1,
>  # define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
>  #endif
> =20
> +#if TCG_TARGET_REG_BITS =3D=3D 32
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32u * 1024 * 1024)
> +#else
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2ul * 1024 * 1024 * 1024)

I wonder how resource constrained CI VMs going to react to this jump
from current default ram size (128M) buffer size (32M).

> +#endif
> =20
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE \
>    (DEFAULT_CODE_GEN_BUFFER_SIZE_1 < MAX_CODE_GEN_BUFFER_SIZE \
> @@ -937,15 +942,7 @@ static inline size_t size_code_gen_buffer(size_t tb_=
size)
>  {
>      /* Size the buffer.  */
>      if (tb_size =3D=3D 0) {
> -#ifdef USE_STATIC_CODE_GEN_BUFFER
>          tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> -#else
> -        /* ??? Needs adjustments.  */
> -        /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
> -           static buffer, we could size this on RESERVED_VA, on the text
> -           segment size of the executable, or continue to use the defaul=
t.  */
> -        tb_size =3D (unsigned long)(ram_size / 4);
> -#endif
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>          tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ac315c1ac45..0a4bbdb8eb9 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -139,7 +139,8 @@ irqchip completely is not recommended except for debu=
gging purposes.
>  @item kvm-shadow-mem=3Dsize
>  Defines the size of the KVM shadow MMU.
>  @item tb-size=3D@var{n}
> -Controls the size (in MiB) of the TCG translation block cache.
> +Controls the size (in MiB) of the TCG translation block cache. It has no=
 effect on
> +32 bit linux-user binaries.
linux-user doesn't have tb-size option so this hunk could be dropped

>  @item thread=3Dsingle|multi
>  Controls number of TCG threads. When the TCG is multi-threaded there wil=
l be one
>  thread per vCPU therefor taking advantage of additional host cores. The =
default


