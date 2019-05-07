Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760AAC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484152087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484152087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47562 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0ti-00047o-KY
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 10:16:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO0st-0003GS-HB
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO0sr-0004pF-Lu
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:15:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hO0sr-0004on-GT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:15:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC492308A9BE;
	Tue,  7 May 2019 14:15:52 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D09DA377F;
	Tue,  7 May 2019 14:15:51 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-15-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <3a9663be-7927-fd4a-4a5f-e3cdd31bddf5@redhat.com>
Date: Tue, 7 May 2019 16:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506173353.32206-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 07 May 2019 14:15:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 14/24] linux-user: Use
 qemu_guest_getrandom_nofail for AT_RANDOM
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
> Use a better interface for random numbers than rand * 16.
>=20
> Cc: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index c1a26021f8..e673f7ea55 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -7,6 +7,7 @@
>   #include "qemu.h"
>   #include "disas/disas.h"
>   #include "qemu/path.h"
> +#include "qemu/guest-random.h"
>  =20
>   #ifdef _ARCH_PPC64
>   #undef ARCH_DLINFO
> @@ -1883,12 +1884,9 @@ static abi_ulong create_elf_tables(abi_ulong p, =
int argc, int envc,
>       }
>  =20
>       /*
> -     * Generate 16 random bytes for userspace PRNG seeding (not
> -     * cryptically secure but it's not the aim of QEMU).
> +     * Generate 16 random bytes for userspace PRNG seeding.
>        */
> -    for (i =3D 0; i < 16; i++) {
> -        k_rand_bytes[i] =3D rand();
> -    }
> +    qemu_guest_getrandom_nofail(k_rand_bytes, sizeof(k_rand_bytes));
>       if (STACK_GROWS_DOWN) {
>           sp -=3D 16;
>           u_rand_bytes =3D sp;
>=20

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


