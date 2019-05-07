Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302BC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9012054F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9012054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44389 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNxgB-00078m-8w
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:50:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hNxf0-0006fv-EJ
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hNxez-0006fU-Au
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hNxez-0006f2-4p
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:49:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B6A988305;
	Tue,  7 May 2019 10:49:20 +0000 (UTC)
Received: from [10.40.204.24] (ovpn-204-24.brq.redhat.com [10.40.204.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A32525B099;
	Tue,  7 May 2019 10:49:19 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190506173353.32206-1-richard.henderson@linaro.org>
	<20190506173353.32206-10-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b2a1544e-bf3d-5d90-c6e5-df7f49664059@redhat.com>
Date: Tue, 7 May 2019 12:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190506173353.32206-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 07 May 2019 10:49:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 09/24] ui/vnc: Use gcrypto_random_bytes
 for start_auth_vnc
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/05/2019 19:33, Richard Henderson wrote:
> Use a better interface for random numbers than rand().
> Fail gracefully if for some reason we cannot use the crypto system.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Use qcrypto_random_bytes, not qemu_getrandom, as there is
>      no need for deterministic results for this interface.
> v3: Fail gracefully in the event qcrypto_random_bytes fails.
> ---
>   ui/vnc.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 785edf3af1..d83f4a6ff9 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -43,6 +43,7 @@
>   #include "crypto/hash.h"
>   #include "crypto/tlscredsanon.h"
>   #include "crypto/tlscredsx509.h"
> +#include "crypto/random.h"
>   #include "qom/object_interfaces.h"
>   #include "qemu/cutils.h"
>   #include "io/dns-resolver.h"
> @@ -2547,16 +2548,6 @@ static void authentication_failed(VncState *vs)
>       vnc_client_error(vs);
>   }
>  =20
> -static void make_challenge(VncState *vs)
> -{
> -    int i;
> -
> -    srand(time(NULL)+getpid()+getpid()*987654+rand());
> -
> -    for (i =3D 0 ; i < sizeof(vs->challenge) ; i++)
> -        vs->challenge[i] =3D (int) (256.0*rand()/(RAND_MAX+1.0));
> -}
> -
>   static int protocol_client_auth_vnc(VncState *vs, uint8_t *data, size=
_t len)
>   {
>       unsigned char response[VNC_AUTH_CHALLENGE_SIZE];
> @@ -2628,7 +2619,16 @@ reject:
>  =20
>   void start_auth_vnc(VncState *vs)
>   {
> -    make_challenge(vs);
> +    Error *err =3D NULL;
> +
> +    if (qcrypto_random_bytes(vs->challenge, sizeof(vs->challenge), &er=
r)) {
> +        trace_vnc_auth_fail(vs, vs->auth, "cannot get random bytes",
> +                            error_get_pretty(err));
> +        error_free(err);
> +        authentication_failed(vs);
> +        return;
> +    }
> +

This part is weird for me: if auth fails we send "vnc_write_u32(vs, 1)"=20
but if it succeeds we send the challenge. There is no success value to=20
send (like "vnc_write_u32(vs, 0)") ?

>       /* Send client a 'random' challenge */
>       vnc_write(vs, vs->challenge, sizeof(vs->challenge));
>       vnc_flush(vs);
>=20


