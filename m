Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B840C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 20:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364CF20663
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 20:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cLQDBw94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364CF20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhez9-0002x3-7d
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 16:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jhewD-0001Qm-QB
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:57:05 -0400
Received: from mout.web.de ([212.227.15.3]:34621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jhewC-0004gJ-T3
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591473408;
 bh=JVc1tme83sX0FYh8gyZ3B3TxVVq04w5MKP9jW8z7b00=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cLQDBw94tvV8aFyNb9bq6MIDvefH7yLLiV1OMXth0O8YJVABLncrzswBfYxIWyvFH
 Zagm0jpvKg/bDzG0FGr7Xr24v2HwEEscFuJokbxRcgy0lcFoeIpUbKh7Xmii6mHY9I
 wg5ypgo/SYnpKc1e60SF18vOKLwCbxkK5u64FdlA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6pf-1ikJxP2nfz-00zTU1; Sat, 06
 Jun 2020 21:56:48 +0200
Date: Sat, 6 Jun 2020 21:56:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Zhang Chen <chen.zhang@intel.com >
Subject: Re: [PATCH V2 1/2] migration/colo: Optimize COLO boot code path
Message-ID: <20200606215646.6679f8b6@luklap>
In-Reply-To: <20200604085533.7769-2-chen.zhang@intel.com>
References: <20200604085533.7769-1-chen.zhang@intel.com>
 <20200604085533.7769-2-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/00CXRRNtcWQQePKMzMqGIF4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:sLxfJQ1l2YDGt7C14Do3oFJzk9yYhcy1ztSXA8801rGcvPiZ8iD
 gB92VFGJGco1Ki5bA3yg/9v4svyov60dXCpt124xOVs8S5KveP6THP7TeUPhZs6HmyBrARu
 i6RdSDrXebBkvj7wwKA6bPZA/cqeDjBMguZY9lT/Q300SKzNLGuzwp5nIgB9Ox8mZ/zaelr
 R4imTpEpUjPAsg8qQQksQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qzxRsb5Bmeg=:w/kFycfp9X/kLavNh3qTRz
 IaVUt1VAqTI/JmYgI1eRC50hd50P7vkjUdtMRf8SXuL7V3ux1dUWj4/TYHeVzwfzD9aJQ6/fO
 QHWtIh9LlyIzGMfeUr0tMSVFlXRlv0E9zrkS4Q6Jk1gZZKSBa0nbkb5Wg3jG0LxNT1ykssEIv
 XqeJudeg84qoa7WSIBS6I6Wop5MiKvxRZNK3MeoZHEtears2OSmaQCT5Y40yu8qPNAaRH9tk4
 t9qkhIOeh8k04Y6hYgGp+QrQw6Fnc6NGTQ31FLos4ANNxqGDG1XtnUJP8VS8TJytwbl12xHp8
 HMk3rOk/Kigg+q+8HvKMZEcSwsg2drVXdWITtTI2gC2BIwgsuQJ8vLa5bgUcNfPzB0tKQr6E1
 LrtvAtCsL243kq7AJ7550YYGAxHxDg2bIeOVt/iaj1QuomFIALaAVFwXOlnJG7nmewdE88BML
 fIkFGVKisrygJKZbj4iFBEDhBX00FK/hlDadoUwwzzbVPR7G7blXCCA6OojodNAnuMb6iPSgu
 ihh1wEqfnBh/yVv2gZWSTDlKVwqoMyVm4kTFYVAuo7t4CoWVubLeKHvrOZGYxddfJqCgF57qW
 o6OLj7oAfgmracbFqXngPDGTl6aQEwn5Vscs9aNcTjxqUGlTKgP3fVVzcR9Q5gJiH30sJUadQ
 OKHO5W6UNRlitCSDhN7BWZYpoAsIzaDL4EZHAuULClo/THEb63GlxWoTLfytzJoLHihushpZq
 JVHM8YCvcTTdaZ+LDxSx104pQrmEjdNxMbwR+ChqWbFfNt9hHIb2DwCXchJRH5tQ96TXVIIQQ
 DYLmT3qoqbm8mKn02T/imdETA8Dozq54mUe2BDF54fIMmHT7l/SLpUFJ0Ux0Kf9D+v6XRc4vR
 Pqt2Svl8pnsNa/0CtDshed+1AJKU89vHuIQOPyyLkoqBeEfqEPLLpk/zVcazxS3GFPlBNz6Pa
 AunXdNhjE0JUO8FSczg3ch//mVLrOiBlV/Nv3sx7Y2ITxG6A+bT1Eck4xRKvutrUv/hqA34iI
 HfZHBRMgGB5YLjjDQ8N+WN1EJ/QcNPRArbIAex6IkEECbHQwkv+ZaWiyuyrm0+RbRTVImLZBP
 Z10bx7gXr093ZPLKE2cnPOsf/u4eOx9m1AmD5QL8l7GffTQhh4bCnTs+KiRLelrORjsgz9eGs
 eIr9eDZIwEb03G8vOOz4niAq9u8/gWaFg4NslC58EhoXeAwiru2vXSU7Q9ml/vUTG6XUew4X9
 jQLIfELQSS7aKORCL
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:17:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/00CXRRNtcWQQePKMzMqGIF4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Jun 2020 16:55:32 +0800
Zhang Chen <chen.zhang@intel.com > wrote:

> From: Zhang Chen <chen.zhang@intel.com>
>=20
> No need to reuse MIGRATION_STATUS_ACTIVE boot COLO.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  migration/colo.c      |  2 --
>  migration/migration.c | 17 ++++++++++-------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index ea7d1e9d4e..91c76789fa 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -670,8 +670,6 @@ void migrate_start_colo_process(MigrationState *s)
>                                  colo_checkpoint_notify, s);
> =20
>      qemu_sem_init(&s->colo_exit_sem, 0);
> -    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                      MIGRATION_STATUS_COLO);
>      colo_process_checkpoint(s);
>      qemu_mutex_lock_iothread();
>  }
> diff --git a/migration/migration.c b/migration/migration.c
> index b63ad91d34..7f3f82a715 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2972,7 +2972,10 @@ static void migration_completion(MigrationState *s)
>          goto fail_invalidate;
>      }
> =20
> -    if (!migrate_colo_enabled()) {
> +    if (migrate_colo_enabled()) {
> +        migrate_set_state(&s->state, current_active_state,
> +                          MIGRATION_STATUS_COLO);
> +    } else {
>          migrate_set_state(&s->state, current_active_state,
>                            MIGRATION_STATUS_COMPLETED);
>      }
> @@ -3304,12 +3307,7 @@ static void migration_iteration_finish(MigrationSt=
ate *s)
>          migration_calculate_complete(s);
>          runstate_set(RUN_STATE_POSTMIGRATE);
>          break;
> -
> -    case MIGRATION_STATUS_ACTIVE:
> -        /*
> -         * We should really assert here, but since it's during
> -         * migration, let's try to reduce the usage of assertions.
> -         */
> +    case MIGRATION_STATUS_COLO:
>          if (!migrate_colo_enabled()) {
>              error_report("%s: critical error: calling COLO code without "
>                           "COLO enabled", __func__);
> @@ -3319,6 +3317,11 @@ static void migration_iteration_finish(MigrationSt=
ate *s)
>           * Fixme: we will run VM in COLO no matter its old running state.
>           * After exited COLO, we will keep running.
>           */
> +    case MIGRATION_STATUS_ACTIVE:
> +        /*
> +         * We should really assert here, but since it's during
> +         * migration, let's try to reduce the usage of assertions.
> +         */

I think this case should be removed, because arriving here with MIGRATION_S=
TATUS_ACTIVE is invalid. It should be handled by the default case.

Regards,
Lukas Straub

>          s->vm_was_running =3D true;
>          /* Fallthrough */
>      case MIGRATION_STATUS_FAILED:


--Sig_/00CXRRNtcWQQePKMzMqGIF4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b9P4ACgkQNasLKJxd
sljoLg//SAtOMpctNQ0FvFw9paeVOLKaqeSp4U9NPcfX3Zw3BDfK+oTU7IF1RMx8
IzBFvC7ACN/xQdYqiGg5VSTZ2t6eui7//s2jCakxeg3purerAVV4f9TQRoV2BBwI
+d516uxIa26KKJSwazjR/4uGpiuJ8bG9zLRHh6dmSp4ZeMvi9SygQDVt7wA7AghF
zFMQ3/jA9dwl7Vjl2zsQ3RKSNPraNtlHbmBwJqL6SyHwEgJtZ6v/dp7wXWgyZhZ9
o3xN4Q8tOq2V2QxcsK5hgxan0kfl1UE/Ax37YP5CcxcgaAlUoKwCaOpH2pYBRA4p
Yf+agM3ryps1bjR6fD00rKyjoxLmoaAERyNZpSeqOXpQJMh+1b4L9Tv/LNcZ7OPQ
CJqqgpNkoWP/42UyhsxQhpy/3vM58zS0EBp5t+Oo6Z/6HLcKC+0MmQL/RvqwWII+
7rB8FW7sXLG6+lJcy7V++oOYqCRJtRx3/KtcyQLZp4LLC8HahtLBkzhRZE8Gvsnp
wnvukTM7w8kxMW91htQJzaE9s6nuNt9P/w4Ru1cloM9TFXNg8cq6qVlzCSMh3j67
6J2nncqwzC9GAePKRmZWuoR/J+HVlKqI2D9w9arA08lDOLB+gmzT2hMrMq/f9n4C
c3b2WPIsYERa4BYIExpM4qzcR0n1ZJULtX6BHNBdQ8C6vjx0Twk=
=z9i0
-----END PGP SIGNATURE-----

--Sig_/00CXRRNtcWQQePKMzMqGIF4--

