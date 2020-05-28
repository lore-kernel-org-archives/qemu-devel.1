Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC879C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1412088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k4d1/PMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1412088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGXz-00071A-Nh
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeGOi-0004sk-SI
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:08:28 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:35089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeGOg-00026t-KV
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:08:28 -0400
Received: by mail-ot1-x331.google.com with SMTP id 69so2059345otv.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VF55JyiLxFX+mWfo0rSeK//gt3CCDUORiL1ewkjhkBw=;
 b=k4d1/PMVLVQlZi3ByjWbdm/VwMGmABPYR+j8r1dE8ToydBtiWmkqiK4CxMNpNxYbes
 FeP4+Sgy8NY1o67RQXU0pCyXNfz7/NVusDvG/gdJll8qg3BuSvK5u80ar73rfoslw38q
 0B51UDpRDxOpsz+c/X1dArebs3+XpEfVH7Vf4NHbrp9I1Ui56RfZXa26562Z8bGkBucg
 bq0LaZYw/xLxfZtImXxmoHsM2KpmYPRrylyVIfWIALSaHpLbA+cBEX1lgCg/tf7J8h6A
 PvLHTK5w0mx83MutEFzMHMWhx/PL/0llQffz5U5uGQ8gA0o17p9Ld85rGlorEZDGHLn1
 +gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VF55JyiLxFX+mWfo0rSeK//gt3CCDUORiL1ewkjhkBw=;
 b=AnJohG8ytynX+pBUKe+72nvkefQMGNgxY3O+CB6RY7kUN+ouut+5XU7ber6LpnuLnN
 DmkspxbXkPhKBN3+nTqTAknf/FSR92RVU+T/dsPH9qfq93D5PgprHJt1/o3BmsHMvsAV
 QeEANl2FYdkYwH44gp4u/tBAXdOg3xx9C2cOkBHYhjmN3sDgcnbo/z/s0RA7CoD8Igz7
 tRGezoBUx7+bDA8savmsDead19PRqt2dSJPeQEomhzwYbtXYGc6nn2vxthpw/jfxaCHG
 bTD/bVJNpurZazCeSVWessdkm8gJITqYr7JJpHoR3McP7Z70/g6VtwngCS3Bw0rQL97N
 Kpfw==
X-Gm-Message-State: AOAM532Rx1tzF4zImSlXfOXePPg/jUn96jJYCGYo8WgIvvK2RL8MYbtO
 cESuss5N4uiR6Tvvh99qUfQFfLZIXIrHTYWyJJj3tg==
X-Google-Smtp-Source: ABdhPJwMUaPumm/xN1JhI0DAKq405e/BtHGjiUEtbcCupZQ542/yB6ttjhD2huvqlDMkzRSZrlp9nJhnWLGRbdbRyc4=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr1899691otr.135.1590664105149; 
 Thu, 28 May 2020 04:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200527055945.6774-1-armbru@redhat.com>
In-Reply-To: <20200527055945.6774-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 12:08:13 +0100
Message-ID: <CAFEAcA-rPQsrMHRfjt656bu=Gw2-d7E40uwVYFqjmxnG=Bt2Wg@mail.gmail.com>
Subject: Re: [PULL 00/10] Error reporting patches for 2020-05-27
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 at 07:03, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into staging (2020-05-26 14:05:53 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-05-27
>
> for you to fetch changes up to 49e2fa85ff04a9be89ed15f922c7d8dae2be9e74:
>
>   i386: Fix x86_cpu_load_model() error API violation (2020-05-27 07:45:45 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2020-05-27
>
> ----------------------------------------------------------------
> Markus Armbruster (10):
>       nvdimm: Plug memory leak in uuid property setter
>       xen: Fix and improve handling of device_add usb-host errors
>       s390x/cpumodel: Fix harmless misuse of visit_check_struct()
>       tests/migration: Tighten error checking
>       error: Use error_reportf_err() where appropriate
>       mips/malta: Fix create_cps() error handling
>       mips/boston: Fix boston_mach_init() error handling
>       mips/boston: Plug memory leak in boston_mach_init()
>       arm/sabrelite: Consistently use &error_fatal in sabrelite_init()
>       i386: Fix x86_cpu_load_model() error API violation


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

