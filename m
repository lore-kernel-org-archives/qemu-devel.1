Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40404C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4D520650
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4D520650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAdm-0007yG-9Z
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAd9-0007WO-8d
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAd8-00087u-2N
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAd7-00087P-QZ
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:11:54 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A0ADC057EC0
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:11:52 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id k2so5432713wrn.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QlWz80qNZPoknd1RlJjx0VssDjEJu4pqDaCOKRPSvNg=;
 b=e3ZxAyddLkBUKAl8TmmCm0u33GFFVbx74pbPpqUvwmsPTAtdR+g+QvA4XUY8PTBdvc
 s874c4mWkuotv2fcijTSs7hR3Jt7GoLI7D+3clo6NIOZD8FB6QYnUgWbYecX1FGGD7M7
 tHpGuI/vPJSc9fMfLxP110BLIwXOrpkccLR4WUPlK3X0m/ox+pbM+edaBwNrbKVaXnm7
 LPoaFHNUqZ5IxWzvwO7nUpDMs/l2Mxv2Y29bzd3wrDXiz6b1I/pEtry/5h7g6YDV0c1t
 2xiBiuY2qqz5K7MMxehnyHEbCWyby9Y9zMeKTYKRMt53rk1OhnkZU0m07wEXH7ct3GLT
 JR5w==
X-Gm-Message-State: APjAAAXStqgv4CMOncrNONm95eazOwMBehbfXmBIMFf7y81XVuYkpX7O
 HLvlmKzTJ8Gh1w2C50t1XdFll0HkQDdRgibj5uG5jugZevh9lJVyF/Qbebz+Vz1GaIYxKxnG9qa
 Gr+6uZhzyzNfNSP8=
X-Received: by 2002:a1c:2e50:: with SMTP id u77mr6437844wmu.64.1570860711336; 
 Fri, 11 Oct 2019 23:11:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqytsXhw/WveOBbWLDCSUle6LAVJgcwmRiElX9s8qqj8dB+G6LG1Bat3fg65VT/87BXNqoMU3g==
X-Received: by 2002:a1c:2e50:: with SMTP id u77mr6437821wmu.64.1570860711081; 
 Fri, 11 Oct 2019 23:11:51 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id y186sm17875269wmd.26.2019.10.11.23.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:11:50 -0700 (PDT)
Subject: Re: [RFC v5 045/126] pflash: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-46-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <731f1dde-261a-6cd4-4123-e9c5d1b6c7e3@redhat.com>
Date: Sat, 12 Oct 2019 08:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-46-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 armbru@redhat.com, qemu-block@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:04 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp =3D=3D &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>=20
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>     &error_fatel, this means that we don't break error_abort
>     (we'll abort on error_set, not on error_propagate)
>=20
> This commit (together with its neighbors) was generated by
>=20
> for f in $(git grep -l errp \*.[ch]); do \
>      spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>      --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff =
$f; \
> done;
>=20
> then fix a bit of compilation problems: coccinelle for some reason
> leaves several
> f() {
>      ...
>      goto out;
>      ...
>      out:
> }
> patterns, with "out:" at function end.
>=20
> then
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>=20
> (auto-msg was a file with this commit message)
>=20
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   hw/block/pflash_cfi01.c | 7 +++----
>   hw/block/pflash_cfi02.c | 7 +++----
>   2 files changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 566c0acb77..37571b6efb 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -700,12 +700,12 @@ static const MemoryRegionOps pflash_cfi01_ops =3D=
 {
>  =20
>   static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       PFlashCFI01 *pfl =3D PFLASH_CFI01(dev);
>       uint64_t total_len;
>       int ret;
>       uint64_t blocks_per_device, sector_len_per_device, device_len;
>       int num_devices;
> -    Error *local_err =3D NULL;
>  =20
>       if (pfl->sector_len =3D=3D 0) {
>           error_setg(errp, "attribute \"sector-length\" not specified o=
r zero.");
> @@ -739,9 +739,8 @@ static void pflash_cfi01_realize(DeviceState *dev, =
Error **errp)
>           &pfl->mem, OBJECT(dev),
>           &pflash_cfi01_ops,
>           pfl,
> -        pfl->name, total_len, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +        pfl->name, total_len, errp);
> +    if (*errp) {
>           return;
>       }
>  =20
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 4baca701b7..9dcdc13289 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -719,9 +719,9 @@ static const MemoryRegionOps pflash_cfi02_ops =3D {
>  =20
>   static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       PFlashCFI02 *pfl =3D PFLASH_CFI02(dev);
>       int ret;
> -    Error *local_err =3D NULL;
>  =20
>       if (pfl->uniform_sector_len =3D=3D 0 && pfl->sector_len[0] =3D=3D=
 0) {
>           error_setg(errp, "attribute \"sector-length\" not specified o=
r zero.");
> @@ -787,9 +787,8 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
>  =20
>       memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
>                                     &pflash_cfi02_ops, pfl, pfl->name,
> -                                  pfl->chip_len, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +                                  pfl->chip_len, errp);
> +    if (*errp) {
>           return;
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

