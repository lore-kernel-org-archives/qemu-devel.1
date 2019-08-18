Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BAFC3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:57:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC5221855
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC5221855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzTBU-0000Lt-03
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 17:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzTAr-0008NM-VX
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzTAq-00084R-QD
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzTAo-000832-Pg
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:57:16 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AAA285945B
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 21:57:13 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id k10so4203673wru.23
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 14:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OKXy3n+Daaj+8ObJW071b63isMbt3zV9biCpL6iHXpA=;
 b=Hrhdvu2WjLTD5t5m0kbi4YEBuVRLgYTP/3WIqaII+FTEfkgymgCutsYqaCq4pQzm5c
 UppeVUdzrWIIZejpm7n7Bj61iJC8L3n/wbxFfdKHOxe0yuyQYYW2sp3vQtp7y3T6LkAV
 81XSV43O4WNW+W/zlTXvxUBvKsIwrG5CZurmLZIC2clNdSy0J2qIEJvhXwsgTArZkPrV
 Ax9ChFJkSjeM323F/2h2y5Sq00bkhI8DZqulFv43w/QSEJTvpvKnP0AYtlRKurce6Gg+
 aTApk5b6d0XUrCUCW3d93lKT7tH9iodY7iVLHtLSRkcX5f/T7/C9xRBzFrR/M+YricdU
 1eag==
X-Gm-Message-State: APjAAAXVefDzFC13pVgs1Rd6C96gPcIEA2BDOjDNS/apt4mB1uL0hbQz
 Nir3/VEX0OjuQdh1wFcDcGRFVBx+ULFBFJpiWw/NKenncU/T3yS7127J0QBOnhe4qVbtS4Ke3Vf
 sU5Tmh36w80wwXbA=
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr15914679wrv.272.1566165432434; 
 Sun, 18 Aug 2019 14:57:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxcQnzPPe0jo+bwgFL9hMoexL+UhIAcW6yZSN7SSrPSuY1KJxH+KtU7IZcxbCeqL5n2dehqRA==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr15914669wrv.272.1566165432264; 
 Sun, 18 Aug 2019 14:57:12 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id x20sm28612628wrg.10.2019.08.18.14.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2019 14:57:11 -0700 (PDT)
To: Shu-Chun Weng <scw@google.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
References: <20190816211049.57317-1-scw@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cc1ede51-96e2-e759-aed2-6953f9f124c2@redhat.com>
Date: Sun, 18 Aug 2019 23:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190816211049.57317-1-scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] linux-user: add memfd_create
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
Cc: arunkaly@google.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Marc-Andr=C3=A9

On 8/16/19 11:10 PM, Shu-Chun Weng via Qemu-devel wrote:
> Add support for the memfd_create syscall. If the host does not have the
> libc wrapper, translate to a direct syscall with NC-macro.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/1734792
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  include/qemu/memfd.h |  4 ++++
>  linux-user/syscall.c | 11 +++++++++++
>  util/memfd.c         |  2 +-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/qemu/memfd.h b/include/qemu/memfd.h
> index d551c28b68..975b6bdb77 100644
> --- a/include/qemu/memfd.h
> +++ b/include/qemu/memfd.h
> @@ -32,6 +32,10 @@
>  #define MFD_HUGE_SHIFT 26
>  #endif
> =20
> +#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
> +int memfd_create(const char *name, unsigned int flags);
> +#endif
> +
>  int qemu_memfd_create(const char *name, size_t size, bool hugetlb,
>                        uint64_t hugetlbsize, unsigned int seals, Error =
**errp);
>  bool qemu_memfd_alloc_check(void);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8367cb138d..b506c1f40e 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -20,6 +20,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/path.h"
> +#include "qemu/memfd.h"
>  #include <elf.h>
>  #include <endian.h>
>  #include <grp.h>
> @@ -11938,6 +11939,16 @@ static abi_long do_syscall1(void *cpu_env, int=
 num, abi_long arg1,
>          /* PowerPC specific.  */
>          return do_swapcontext(cpu_env, arg1, arg2, arg3);
>  #endif
> +#ifdef TARGET_NR_memfd_create
> +    case TARGET_NR_memfd_create:
> +        p =3D lock_user_string(arg1);
> +        if (!p) {
> +            return -TARGET_EFAULT;
> +        }
> +        ret =3D get_errno(memfd_create(p, arg2));
> +        unlock_user(p, arg1, 0);
> +        return ret;
> +#endif
> =20
>      default:
>          qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
> diff --git a/util/memfd.c b/util/memfd.c
> index 00334e5b21..4a3c07e0be 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -35,7 +35,7 @@
>  #include <sys/syscall.h>
>  #include <asm/unistd.h>
> =20
> -static int memfd_create(const char *name, unsigned int flags)
> +int memfd_create(const char *name, unsigned int flags)
>  {
>  #ifdef __NR_memfd_create
>      return syscall(__NR_memfd_create, name, flags);
>=20

