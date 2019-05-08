Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63E8C004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:42:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7A120C01
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 00:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7A120C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOAfc-0005MR-1W
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 20:42:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hOAes-00052E-AT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hOAer-0007VR-Bv
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:42:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hOAer-0007Sg-6j
	for qemu-devel@nongnu.org; Tue, 07 May 2019 20:42:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so5447687pgp.8
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 17:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=Kr2XqPi1gRvOyb5Xj4YttFQx1exjuEk+xgu3b4WB82c=;
	b=Adv5dN6yOsS6uoWr9uS75upd1h0xOtWV1o7qhB6XIbz3JtAAUpcMV3LHNdZ0ONLv9v
	n4GYQ8LtKCTjo8CI7ZQK+lX9abgnOaA2CYRwKWXDsYsQWBS7iiVKmxDCGic+/JQmNuXW
	udiRkPM5v625khQ82kqmkcnSKevz1sl1+fZdG+PC+OaaSuOVOCuw9g/UmBxKmctZIZ6s
	O/cPx+skj1uy1JwRv7GKNKv4223kAqJJu5KP0wHzEjGOBs+Tm/S7H+zksTU5MkGPBKBj
	x9zLJ4uCAkD1aA8QKZBElukJyib14Gw2yrgL7UFD5Utsp9JSMWLDmghT5dcVEZ6PbLdz
	6KSQ==
X-Gm-Message-State: APjAAAWP4QGd9GkPG+PiglwIsYWGEia2jP0txeUYM/N/2JNhPLofZFyt
	7BaWZae4971hOdy96Z7GoCryC3yDE5jm4A==
X-Google-Smtp-Source: APXvYqwa9X610DR5EdCz9IYCYZJzdNKUoTJzXa7oZgVx3YGbYbowTJvZwi0w/pORz1jnC24CTArjoA==
X-Received: by 2002:aa7:8c1a:: with SMTP id c26mr44809399pfd.25.1557276123606; 
	Tue, 07 May 2019 17:42:03 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	b22sm22298420pgg.88.2019.05.07.17.42.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 07 May 2019 17:42:02 -0700 (PDT)
Date: Tue, 07 May 2019 17:42:02 -0700 (PDT)
X-Google-Original-Date: Tue, 07 May 2019 17:41:21 PDT (-0700)
In-Reply-To: <20190507223646.18981-1-jonathan@fintelia.io>
From: Palmer Dabbelt <palmer@sifive.com>
To: jonathan@fintelia.io
Message-ID: <mhng-b328d27f-e971-49bf-a266-c77ffd2f3051@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.195
Subject: Re: [Qemu-devel] [PATCH] target/riscv: More accurate handling of
 `sip` CSR
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
Cc: jonathan@fintelia.io, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
	sagark@eecs.berkeley.edu, fintelia@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 07 May 2019 15:36:46 PDT (-0700), jonathan@fintelia.io wrote:
> According to the spec, "All bits besides SSIP, USIP, and UEIP in the sip
> register are read-only." Further, if an interrupt is not delegated to mode x,
> then "the corresponding bits in xip [...] should appear to be hardwired to
> zero. This patch implements both of those requirements.
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  target/riscv/csr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 1ec1222da1..fff7d834e8 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -246,6 +246,7 @@ static const target_ulong sstatus_v1_9_mask = SSTATUS_SIE | SSTATUS_SPIE |
>  static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
>      SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
>      SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
> +static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
>
>  #if defined(TARGET_RISCV32)
>  static const char valid_vm_1_09[16] = {
> @@ -694,8 +695,10 @@ static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
>  static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
>                     target_ulong new_value, target_ulong write_mask)
>  {
> -    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> -                   write_mask & env->mideleg);
> +    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
> +                      write_mask & env->mideleg & sip_writable_mask);
> +    *ret_value &= env->mideleg;
> +    return ret;
>  }
>
>  /* Supervisor Protection and Translation */

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!

