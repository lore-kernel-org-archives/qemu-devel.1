Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18118C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD14F2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD14F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0rj-00024I-59
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 10:14:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO0qh-0001Vk-13
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hO0qg-0002gv-52
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hO0qg-0002gI-01
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACC1B89C3B;
	Tue,  7 May 2019 14:13:34 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4F3E5B0B5;
	Tue,  7 May 2019 14:13:33 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-14-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c9f9ca4f-d6b5-0225-96d5-ebbb78c10c4b@redhat.com>
Date: Tue, 7 May 2019 16:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506173353.32206-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 07 May 2019 14:13:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 13/24] linux-user: Call qcrypto_init if
 not using -seed
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
> Cc: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/main.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 7dfb202e5d..e05aebe4e1 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -39,6 +39,7 @@
>   #include "trace/control.h"
>   #include "target_elf.h"
>   #include "cpu_loop-common.h"
> +#include "crypto/init.h"
>  =20
>   char *exec_path;
>  =20
> @@ -688,8 +689,18 @@ int main(int argc, char **argv, char **envp)
>       if (seed_optarg =3D=3D NULL) {
>           seed_optarg =3D getenv("QEMU_RAND_SEED");
>       }
> -    if (seed_optarg !=3D NULL) {
> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
> +    {
> +        Error *err =3D NULL;
> +        if (seed_optarg !=3D NULL) {
> +            qemu_guest_random_seed_main(seed_optarg, &err);
> +        } else {
> +            /* ??? Assumes qcrypto is only used by qemu_guest_getrando=
m.  */

perhaps you can add a qemu_guest_random_init() function close to this=20
assumption to call qcrypto_init()? So we will not forget to change this=20
if we use something else in the future.

> +            qcrypto_init(&err);
> +        }
> +        if (err) {
> +            error_reportf_err(err, "cannot initialize crypto: ");
> +            exit(1);
> +        }
>       }
>  =20
>       target_environ =3D envlist_to_environ(envlist, NULL);
>=20

Thanks,
Laurent

