Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7E0C54FD0
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 11:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087652070A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 11:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rHg5lZEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087652070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSfXD-00078Q-HW
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 07:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSfQC-0004e9-7t
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 07:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSfQA-0002EH-Q3
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 07:26:03 -0400
Received: from mout.web.de ([212.227.17.11]:45369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSfQA-0002DN-4e
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 07:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587900334;
 bh=v5dS5fAf/gZXYE0zPj6KcLYHvp8O8i9AacqvOW9q3rc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=rHg5lZEv6Z9whvEluSchTjYjGEEZy0qfOQGVMeEviOexwd2KiXONvAn8f4MBSqG9k
 Xf6ZGz23sMVkf4jYVFL4O/hVhSOCYkN4AP0tLc8//+chGnXFDarThHTna7rCqT2YAo
 IGx622zq4cEcwJr6bBXq4/yyli74lByGfaHIC46o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.95]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ljaei-1ivnV82Sbo-00berU; Sun, 26
 Apr 2020 13:25:34 +0200
Date: Sun, 26 Apr 2020 13:25:23 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Derek Su <dereksu@qnap.com>
Subject: Re: [PATCH v5 1/1] colo-compare: Fix memory leak in packet_enqueue()
Message-ID: <20200426132523.51992c28@luklap>
In-Reply-To: <20200410020056.12104-2-dereksu@qnap.com>
References: <20200410020056.12104-1-dereksu@qnap.com>
 <20200410020056.12104-2-dereksu@qnap.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v4nm272hc.NSkbLbMtr3sGq";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:8ZtJ+DgPhsAByS+ySmirJSK4WOVxhXt32gEFeVCCeAf+2EfCM9f
 QRwFPRcFhyIhd76T1CkvT3Q0fKhhqjHJKcITjKFxnQWKYGZLFSUT/Iv/zK3RTz2DD5Aepqn
 acP80ewk4W9jJzcep0Fqqln8jBemr7xA4DENauSgJWGH1d1KNYHfi4wjRg7CsjkjEGHiYQW
 YNi4XVlKEHue60m49L48Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yn3D+KeTotU=:sbHBvq6y6uVe86/iCcekRU
 RvWLL1DZRqjpRElJ67XsJqq10cXbBDZ4a5uuEaZoxVOMYEj8A2s+aUjYgrLNIIZw7NnNGhvlq
 tnnAarOghV76fSAJTQ92gM7gsi7Gx1TyXHw068wfVpfbNjY5pq2LWk+KzjjKprNNFNRNH4aiA
 F2WAa6ZcNGfn0ZzblnT432+o3YPxFzrYJUQQEcqRL/ZVW9znVSSasuPGvEMw8TIL3wP3E+kvO
 nMQBNrfRmiWhxO6zRJQeNtqYTTGESsqShBEIK1Xa6vKLPq1KNdPG4/dQoENUZ5jqGdyAVLWqx
 pD60FKsv3LDM+yMgKGZqj8YpUWPRJ7KiNfXzn6SWZUNKzcLFmoVwxjrCjh8w6wRW3O+36nZeD
 VKf+50cSfS6S5Yv7Jhygq7BfAjuMNuNeLuMDIJNpAlakqqZupxRJM/Gf0deF+qcgefVgdO092
 ZEkbnqeuBhVl6Op4UOnjRRilE4QNdTABMeN4qSo7hQzSefzBbPc70iHc6ab3qx/oVpFvJwyxd
 npjCPeEsGITUqa0uja1YZ3DAffjYp9ItabZtKptB4DzyP551CPqSFeOhIA6N+xB+NvZhRGzK7
 HhyU5muKFTSpEuuec5T2t1NtozluwPMpakBHnNYzrptPnaptEvIw4i2Xysx1TdR9sLm/jU9Py
 gcMoMXiESA7bDAptyDu+ZAHofW0NnZrBX9pCZDgBdMIw5EWg7NBTuzZ2TQa8nTs8ZjMhlQvGC
 exTuabBRnjf8G5YPngT6h6NlPNy3hIXFuwishrKAN6Au/2GASvG9XZm9Bcxih8eOIsiDgz3ME
 Lilo7pLTL2nI8hUd+ie8pCpPdlELVcYoMLu3Puc4vHdPqumSEBOhLTwdlS9Zr9NM2xMYkqwz8
 Vsfe3koPLkGa6lE478crb9pkBabUIM1S1r9m0NtTP+35lLu+388iUfdTFZ5KVtrtVhsEgMbFL
 Y6D+WJnd+Grjd120R4cP2wpYdB/KoNeAoDlQhwbNQX2CcwgMqzwPElcrfBuhnVaLcxQ1Fij7h
 1/1hnpyy7Q1ikSGexn0OGeiu2vHgbN75j2hvimgcKuk3flpTEqmCG4XOOAMaV9a9TccOEKEGD
 Hpc1OK5v2OThgyFNYKl9A8bkxd8lMSdqPk5UYuujoR0SsfzhPGlm1pglOGGwV50hofp3oC0TY
 CDEDXKHLoU7O8cqltALh0chhpEoOxfcmPVd6/MYyfA4a6Gpba2haN4MbQRU0cAIyf3FO5N3Km
 8NlRevGuwEQOOw6c7
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 07:26:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
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
Cc: lizhijian@cn.fujitsu.com, chyang@qnap.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, ctcheng@qnap.com, chen.zhang@intel.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/v4nm272hc.NSkbLbMtr3sGq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Apr 2020 10:00:56 +0800
Derek Su <dereksu@qnap.com> wrote:

> The patch is to fix the "pkt" memory leak in packet_enqueue().
> The allocated "pkt" needs to be freed if the colo compare
> primary or secondary queue is too big.
>=20
> Replace the error_report of full queue with a trace event.
>=20
> Signed-off-by: Derek Su <dereksu@qnap.com>

Looks good now and works well in my tests.
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>

Regards,
Lukas Straub

> ---
>  net/colo-compare.c | 23 +++++++++++++++--------
>  net/trace-events   |  1 +
>  2 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 10c0239f9d..035e11d4d3 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -122,6 +122,10 @@ enum {
>      SECONDARY_IN,
>  };
> =20
> +static const char *colo_mode[] =3D {
> +    [PRIMARY_IN] =3D "primary",
> +    [SECONDARY_IN] =3D "secondary",
> +};
> =20
>  static int compare_chr_send(CompareState *s,
>                              const uint8_t *buf,
> @@ -217,6 +221,7 @@ static int packet_enqueue(CompareState *s, int mode, =
Connection **con)
>      ConnectionKey key;
>      Packet *pkt =3D NULL;
>      Connection *conn;
> +    int ret;
> =20
>      if (mode =3D=3D PRIMARY_IN) {
>          pkt =3D packet_new(s->pri_rs.buf,
> @@ -245,16 +250,18 @@ static int packet_enqueue(CompareState *s, int mode=
, Connection **con)
>      }
> =20
>      if (mode =3D=3D PRIMARY_IN) {
> -        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
> -            error_report("colo compare primary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret =3D colo_insert_packet(&conn->primary_list, pkt, &conn->pack=
);
>      } else {
> -        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)=
) {
> -            error_report("colo compare secondary queue size too big,"
> -                         "drop packet");
> -        }
> +        ret =3D colo_insert_packet(&conn->secondary_list, pkt, &conn->sa=
ck);
>      }
> +
> +    if (!ret) {
> +        trace_colo_compare_drop_packet(colo_mode[mode],
> +            "queue size too big, drop packet");
> +        packet_destroy(pkt, NULL);
> +        pkt =3D NULL;
> +    }
> +
>      *con =3D conn;
> =20
>      return 0;
> diff --git a/net/trace-events b/net/trace-events
> index 02c13fd0ba..fa49c71533 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -12,6 +12,7 @@ colo_proxy_main(const char *chr) ": %s"
> =20
>  # colo-compare.c
>  colo_compare_main(const char *chr) ": %s"
> +colo_compare_drop_packet(const char *queue, const char *chr) ": %s: %s"
>  colo_compare_udp_miscompare(const char *sta, int size) ": %s =3D %d"
>  colo_compare_icmp_miscompare(const char *sta, int size) ": %s =3D %d"
>  colo_compare_ip_info(int psize, const char *sta, const char *stb, int ss=
ize, const char *stc, const char *std) "ppkt size =3D %d, ip_src =3D %s, ip=
_dst =3D %s, spkt size =3D %d, ip_src =3D %s, ip_dst =3D %s"


--Sig_/v4nm272hc.NSkbLbMtr3sGq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6lb6MACgkQNasLKJxd
slgiUg//YyClwQCwoWfy2z1Fr6kbaFzrGLr3bcfVyTyGkW9Le/CLZRGe0zytJkvX
kHWK/vP7bQGn22R/5Qr6SNGdfzTLhw3tanoDOy6KpGc/4+jSqn0ema8xzhXo9BBv
r/QK3yAZpHJSR3DuLEnNyaCma8CNB8Sa6CHPB61APyPB6G97HXHS5I9fZQu8tCng
dbMiYfIsPKoLlWolp/vt0tY/QgWUf4t7sHkau+jZ3aSFUzBsLGnY1ssHYEXeSmwH
0rTyU4kpYfy9EWSDfV+u2VVoFsdFRXEStF9NvnOh5KLI6wjql7v2DkDlZHUTsZTs
WPQ8J48Bqqfa2bpbzPacU2V1h71ZzGvzvimdHo/UNKJ/3wnWExr2jOCrC5559AQP
+WluGfi4dHsYavBCpegkBOky39zbzN+AvXzRbQZFeuEvTJjnEAXCAAJ4dvv7/8AM
2iRyQxTJov5KrM0H3euN9M1K0+2mD6RR250O9nnTj2f39qCJrYbxOYnS9vk9kzvV
dmr7BzACnjKq01XiO3uP4y87Ul1CyoaTssyg2XBrxJWOrUv8Wv3xLEHSu+md0XJV
1v1k7ovltzr6pJVh/VGEb5NcLVvrhvQQR5skVt9vqzKTCzjGUDTwuOqWz1B5RX4c
tCfSHh59j2f+uwmoKzkaqqcGIF6V2LpTO6HiBqNaLjZCZ2zYfPk=
=cOqz
-----END PGP SIGNATURE-----

--Sig_/v4nm272hc.NSkbLbMtr3sGq--

