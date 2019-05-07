Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4B6C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0394205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0394205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47419 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0lM-0006rq-T0
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 10:08:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO0kL-0006Q6-3d
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO0kH-0004SU-7o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:07:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hO0kF-0004Ol-Ag
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A662B59449;
	Tue,  7 May 2019 14:06:56 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AB971627D8;
	Tue,  7 May 2019 14:06:55 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-13-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <6a5967a8-4835-7f6c-a50b-0154d88a2aed@redhat.com>
Date: Tue, 7 May 2019 16:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506173353.32206-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Tue, 07 May 2019 14:06:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 12/24] linux-user: Initialize
 pseudo-random seeds for all guest cpus
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2019 19:33, Richard Henderson wrote:
> When the -seed option is given, call qemu_guest_random_seed_main,
> putting the subsystem into deterministic mode.  Pass derived seeds
> to each cpu created during clone; which is a no-op unless the
> subsystem is in deterministic mode.
>=20
> Cc: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/main.c    | 21 ++++++++++-----------
>   linux-user/syscall.c |  3 +++
>   2 files changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 3d2230320b..7dfb202e5d 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -34,6 +34,7 @@
>   #include "tcg.h"
>   #include "qemu/timer.h"
>   #include "qemu/envlist.h"
> +#include "qemu/guest-random.h"
>   #include "elf.h"
>   #include "trace/control.h"
>   #include "target_elf.h"
> @@ -48,6 +49,7 @@ static int gdbstub_port;
>   static envlist_t *envlist;
>   static const char *cpu_model;
>   static const char *cpu_type;
> +static const char *seed_optarg;
>   unsigned long mmap_min_addr;
>   unsigned long guest_base;
>   int have_guest_base;
> @@ -290,15 +292,9 @@ static void handle_arg_pagesize(const char *arg)
>       }
>   }
>  =20
> -static void handle_arg_randseed(const char *arg)
> +static void handle_arg_seed(const char *arg)
>   {
> -    unsigned long long seed;
> -
> -    if (parse_uint_full(arg, &seed, 0) !=3D 0 || seed > UINT_MAX) {
> -        fprintf(stderr, "Invalid seed number: %s\n", arg);
> -        exit(EXIT_FAILURE);
> -    }
> -    srand(seed);

It's a detail, but I think you can't remove this srand() in this patch:=20
you initialize qemu_guest_random() sequence but the code continues to=20
use rand() to have a random number, so the seed value is in fact=20
ignored. you can remove it in PATCH 16.

Thanks,
Laurent

