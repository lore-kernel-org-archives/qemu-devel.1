Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EBAC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF91206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 07:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF91206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJBcT-0005lk-Hj
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 03:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJBbB-0004e5-CN
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJBbA-0007Ir-6x
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJBb9-0007IM-V7
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 03:13:56 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E854383F42
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 07:13:54 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f3so5457888wrr.23
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 00:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NS3FA3koecDNRH9WMDGnMPBnzVD5/MuhKLph+ggovE0=;
 b=NCCiqHjFgAF/ZvIuqP09f+RCL4J2Y2KPHOeSokOUfmADmowFDUGW+58A+oG2cKjG5N
 /6v72sDEcMS0B1PcSRBFaUpACvr2MhWq1sU2Dv18xLblPTZe+7ph1F6A0cEA9FR1Luxq
 AFTyeWgc+5qEw4yqhonER6T+K1itnrP8i9ufEaWYWjCLwepv5c1wS9QNPezN2APXPesy
 LuT/of3ycNirBz+lZ095+Mky8hoTBNqGpHwW5LRAhcklay18PZ9T4WWBartIWtGldsyr
 DPmus0WHzELCFkjLtlRElHkOfuOh40nVkEyD/dasrZBJL3eLN3lwDTXx41Zhl/vO0lVL
 a8eg==
X-Gm-Message-State: APjAAAVYvbblvs58zEBXj1yWJ0Sk3bbyyGu43wQid/LZJYjZMWpAcvtT
 3cE16rjGvyHHDKrniz5vkr7x8ckmmmSISP8qY/7j1uN/089WNiUFQ6WMPpbQJIc0czQVXrq1KkN
 o/29RKp5wJdiTaGc=
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr6425724wml.169.1570864433503; 
 Sat, 12 Oct 2019 00:13:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxa93JGq/SrT/qdHQFrdp5HtWk/9pvBiN8J2i0kO6g5Z99BVZmjznjvP/r2NKgsiVBzOm4JCQ==
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr6425709wml.169.1570864433277; 
 Sat, 12 Oct 2019 00:13:53 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id l20sm1044106wrf.19.2019.10.12.00.13.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Oct 2019 00:13:52 -0700 (PDT)
Subject: Re: [RFC v5 124/126] target/tilegx/cpu.c: introduce
 ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-125-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <86963e53-8d35-a073-c8c0-fcf5546c1fc4@redhat.com>
Date: Sat, 12 Oct 2019 09:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-125-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:05 PM, Vladimir Sementsov-Ogievskiy wrote:
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
>   target/tilegx/cpu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
> index 2b2a7ccc31..79bfe27856 100644
> --- a/target/tilegx/cpu.c
> +++ b/target/tilegx/cpu.c
> @@ -81,13 +81,12 @@ static void tilegx_cpu_reset(CPUState *s)
>  =20
>   static void tilegx_cpu_realizefn(DeviceState *dev, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       CPUState *cs =3D CPU(dev);
>       TileGXCPUClass *tcc =3D TILEGX_CPU_GET_CLASS(dev);
> -    Error *local_err =3D NULL;
>  =20
> -    cpu_exec_realizefn(cs, &local_err);
> -    if (local_err !=3D NULL) {
> -        error_propagate(errp, local_err);
> +    cpu_exec_realizefn(cs, errp);
> +    if (*errp) {
>           return;
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

