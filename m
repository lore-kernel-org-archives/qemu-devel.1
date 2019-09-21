Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD80C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:01:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA16208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA16208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40325 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBbGR-0003sT-It
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 05:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBbF6-0002yt-Gz
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBbF4-0002Ng-Kb
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:59:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBbF2-0002MG-P5
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:59:45 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F01B136955
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 08:59:41 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id 4so2033653wmj.6
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wZKZhA7OU6hO/GqMNwjqgHbUfX+io6HsnyOX4ZhAw18=;
 b=t0RhIEtTgGh5GQqLpIxCGFiT6SZBSXjufnzQLc+pIoZ7g4OjyIYfXGn0KtC9tLTiv2
 jWm3umURTfukHDINn9VboAouhMGIps5zSr2nfqVkiUEv88mQJ01/oCSX9t+5ynm0LMSR
 gryFDabQU9cdevzMIs+jTIReIzxs1xRVVEMZej1GiPJgp6olbFQP+QQ90kE/Gxo2mBat
 BtQc2r8rAanWbqUAHRHrJt1JRw0izI0Uc4Ek6aRoTDdOR5j1uPNnHVWol2HzgR8leqO7
 09nz5FPndaCLzy/nZgLdgf8ssfuW6afrZSIBpBt+0xFFfKQYfKpWXjZ8QJhcwUhM6pM6
 ilzQ==
X-Gm-Message-State: APjAAAVnldBmweBRrunOIxFlvc7hhAIU8NmLHGvv/sUrB4NxowMYZ1XV
 nTCYQCzhwmL30ap3fdNTPJeRbFEUA9Qu2iRAwUJazuh9fCKGuNMm5vXCj3reUZHB3WuuunoTAk4
 1si6BiEhfJXNNxg4=
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr15614260wro.147.1569056380735; 
 Sat, 21 Sep 2019 01:59:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaUssjMS1HFMYn6R0kbsdIhlEyshSHzpnmBWJXZw8LHdmWE0BwkmkHnKZ5PpFfeyzO9qrQXg==
X-Received: by 2002:adf:f1c3:: with SMTP id z3mr15614246wro.147.1569056380504; 
 Sat, 21 Sep 2019 01:59:40 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u25sm3605910wml.4.2019.09.21.01.59.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:59:39 -0700 (PDT)
Subject: Re: [PATCH 2/7] exec: Split out variable page size support to
 exec-vary.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190919232952.6382-1-richard.henderson@linaro.org>
 <20190919232952.6382-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c8b2089c-946a-f483-9d4f-e390bc7bfdde@redhat.com>
Date: Sat, 21 Sep 2019 10:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919232952.6382-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/19 1:29 AM, Richard Henderson wrote:
> The next patch will play a trick with "const" that will
> confuse the compiler about the uses of target_page_bits
> within exec.c.  Moving everything to a new file prevents
> this confusion.
>=20
> No functional change so far.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile.target       |  2 +-
>  include/qemu-common.h |  6 +++++
>  exec-vary.c           | 57 +++++++++++++++++++++++++++++++++++++++++++
>  exec.c                | 34 --------------------------
>  4 files changed, 64 insertions(+), 35 deletions(-)
>  create mode 100644 exec-vary.c
>=20
> diff --git a/Makefile.target b/Makefile.target
> index 5e916230c4..ca3d14efe1 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -107,7 +107,7 @@ obj-y +=3D trace/
> =20
>  #########################################################
>  # cpu emulator library
> -obj-y +=3D exec.o
> +obj-y +=3D exec.o exec-vary.o
>  obj-y +=3D accel/
>  obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg=
-op-gvec.o
>  obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
> diff --git a/include/qemu-common.h b/include/qemu-common.h
> index 0235cd3b91..3e800c2224 100644
> --- a/include/qemu-common.h
> +++ b/include/qemu-common.h
> @@ -74,6 +74,12 @@ void cpu_exec_step_atomic(CPUState *cpu);
>   */
>  bool set_preferred_target_page_bits(int bits);
> =20
> +/**
> + * finalize_target_page_bits:
> + * Commit the final value set by set_preferred_target_page_bits.
> + */
> +void finalize_target_page_bits(void);
> +
>  /**
>   * Sends a (part of) iovec down a socket, yielding when the socket is =
full, or
>   * Receives data into a (part of) iovec from a socket,
> diff --git a/exec-vary.c b/exec-vary.c
> new file mode 100644
> index 0000000000..48c0ab306c
> --- /dev/null
> +++ b/exec-vary.c
> @@ -0,0 +1,57 @@
> +/*
> + * Variable page size handling
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "exec/exec-all.h"
> +
> +#ifdef TARGET_PAGE_BITS_VARY
> +int target_page_bits;
> +bool target_page_bits_decided;
> +#endif
> +
> +bool set_preferred_target_page_bits(int bits)
> +{
> +    /*
> +     * The target page size is the lowest common denominator for all
> +     * the CPUs in the system, so we can only make it smaller, never
> +     * larger. And we can't make it smaller once we've committed to
> +     * a particular size.
> +     */
> +#ifdef TARGET_PAGE_BITS_VARY
> +    assert(bits >=3D TARGET_PAGE_BITS_MIN);
> +    if (target_page_bits =3D=3D 0 || target_page_bits > bits) {
> +        if (target_page_bits_decided) {
> +            return false;
> +        }
> +        target_page_bits =3D bits;
> +    }
> +#endif
> +    return true;
> +}
> +
> +void finalize_target_page_bits(void)
> +{
> +#ifdef TARGET_PAGE_BITS_VARY
> +    if (target_page_bits =3D=3D 0) {
> +        target_page_bits =3D TARGET_PAGE_BITS_MIN;
> +    }
> +    target_page_bits_decided =3D true;
> +#endif
> +}
> diff --git a/exec.c b/exec.c
> index 8b998974f8..33bd0e36c1 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -92,11 +92,6 @@ MemoryRegion io_mem_rom, io_mem_notdirty;
>  static MemoryRegion io_mem_unassigned;
>  #endif
> =20
> -#ifdef TARGET_PAGE_BITS_VARY
> -int target_page_bits;
> -bool target_page_bits_decided;
> -#endif
> -
>  CPUTailQ cpus =3D QTAILQ_HEAD_INITIALIZER(cpus);
> =20
>  /* current CPU in the current thread. It is only valid inside
> @@ -110,37 +105,8 @@ int use_icount;
>  uintptr_t qemu_host_page_size;
>  intptr_t qemu_host_page_mask;
> =20
> -bool set_preferred_target_page_bits(int bits)
> -{
> -    /* The target page size is the lowest common denominator for all
> -     * the CPUs in the system, so we can only make it smaller, never
> -     * larger. And we can't make it smaller once we've committed to
> -     * a particular size.
> -     */
> -#ifdef TARGET_PAGE_BITS_VARY
> -    assert(bits >=3D TARGET_PAGE_BITS_MIN);
> -    if (target_page_bits =3D=3D 0 || target_page_bits > bits) {
> -        if (target_page_bits_decided) {
> -            return false;
> -        }
> -        target_page_bits =3D bits;
> -    }
> -#endif
> -    return true;
> -}
> -
>  #if !defined(CONFIG_USER_ONLY)
> =20
> -static void finalize_target_page_bits(void)
> -{
> -#ifdef TARGET_PAGE_BITS_VARY
> -    if (target_page_bits =3D=3D 0) {
> -        target_page_bits =3D TARGET_PAGE_BITS_MIN;
> -    }
> -    target_page_bits_decided =3D true;
> -#endif
> -}
> -
>  typedef struct PhysPageEntry PhysPageEntry;
> =20
>  struct PhysPageEntry {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

