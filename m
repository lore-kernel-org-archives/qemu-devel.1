Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 07:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DFD2070E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 07:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXalEV+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DFD2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtQv7-0002AV-8l
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 03:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtQuD-0001Kr-Om
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 03:23:41 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:37255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtQuB-0007SL-Q6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 03:23:41 -0400
Received: by mail-ua1-x941.google.com with SMTP id q15so416831uap.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eUvZdEHgBMGrL/+yxMrn6JnFoapfozZri9F2FF+zy78=;
 b=YXalEV+J/kUNOhHmZypE2wOWvLiTb9lsCMKRxeVOs3O9bZ8Bw/yCIUhO8yvEjuyWfQ
 nG28IQl4y89EbfEvopgaJvrzKE1zENx+rlxqdCh9qKeVv1ojm7nDNrx/lemkaCLEFSNq
 +PweWUoZV+GCOAxaXcz85+lbQcENFp6ogZaUH1j92JUyZYbZCuxCEP+UUPbwDCfYZxAJ
 T9a3vjrSGBm9JgYl1IG742rEkCdQEcShJOY/UvSVJ/bwpayOHhRk3nk8lzI7JmuEPPeg
 cedei4eJ1fOF9C21Cl0Cvc+oGMbcA0yjmTXfub7OGx2WYbYNypfxZcWam162uNxn2dtq
 /9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eUvZdEHgBMGrL/+yxMrn6JnFoapfozZri9F2FF+zy78=;
 b=nYVy6DNC5kVMfhOBrLydFePQgbtqXyQlz3lpu6xa50J8OLsfCrYT2EabSk5MtZQJVy
 RytSGioUz1FFpw3GHIaspK5NMfAosWWXXjpcG5WIOVvZ6ymSnE/rJTwIdR8eylTi9PhU
 cd6g4P0Lw/IkXc1MdkFaRzv8J3POk/diwWQXBmQNvUSKLpQhlLCDorGI93cMD5R79u5k
 oc0VMCfIzmRxIvUjX173vWIAvDoxs13eX2K/bckUHPDm9uEhaBcNWXKyGmgvBQ0qzkYn
 iTxt+qD9GX44Dnt4ISupeui8gnsCu/qhPH921vUJ3SG3pHqPktAj0ztDxTMQsGDFIyEC
 iMhA==
X-Gm-Message-State: AOAM5315sU0aEimlsDDfP+KujEhUoiFE3U5zPK+tubmFjGBieH0Go4Iv
 qfY8HTuUVDDYIrCHVhnXzzo5rIL0hUKgUqPMR62W/A==
X-Google-Smtp-Source: ABdhPJwjOdkWu9PaxRfqOM8sVzBoGtTHDXjNoMOjOq/RQl/P3P01UrlHfvNVPuj24/ZnGWb/Ne+nwED/8Zurf2TqSpA=
X-Received: by 2002:ab0:6ec6:: with SMTP id c6mr54499527uav.7.1594279418295;
 Thu, 09 Jul 2020 00:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-6-hskinnemoen@google.com>
 <4b7130f2-032c-3067-b2b6-876a2b17b707@amsat.org>
 <CAFQmdRYi5QFHbcWQH-bWqAsSCidzYMedC8n+mib1DPpJuEy-Rw@mail.gmail.com>
 <CAFQmdRZdUKvmi_eKdtCnR8uP63sRP9X0Z7oxZES56mtSz_=7FA@mail.gmail.com>
 <af879fd1-dea8-a3f2-d3fb-13be24c0b740@amsat.org>
In-Reply-To: <af879fd1-dea8-a3f2-d3fb-13be24c0b740@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Thu, 9 Jul 2020 00:23:26 -0700
Message-ID: <CAFQmdRaqx9+Ftu4_p85q1E0aPUjBZfJ0ARB564WQVHmeSbjwXg@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] hw/arm: Add NPCM730 and NPCM750 SoC models
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::941;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x941.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 8, 2020 at 10:34 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 7/9/20 2:06 AM, Havard Skinnemoen wrote:
> > On Wed, Jul 8, 2020 at 11:13 AM Havard Skinnemoen
> > <hskinnemoen@google.com> wrote:
> >> On Wed, Jul 8, 2020 at 10:31 AM Philippe Mathieu-Daud=C3=A9 <f4bug@ams=
at.org> wrote:
> >>> On 7/7/20 8:47 PM, Havard Skinnemoen wrote:
> >>>> +typedef struct NPCM7xxClass {
> >>>> +    DeviceClass         parent;
> >>>
> >>> Similar comment that elsewhere on this series, if NPCM7xxClass not us=
ed
> >>> outside of npcm7xx.c, keep it local.
> >>
> >> OK, will do.
> >
> > Turns out it is used in npcm7xx_boards.c, so it has to stay where it is=
.
>
> Indeed:
>
> static void npcm7xx_load_kernel(MachineState *machine,
>                                 NPCM7xxState *soc)
> {
>     NPCM7xxClass *sc =3D NPCM7XX_GET_CLASS(soc);
>
>     npcm7xx_binfo.ram_size =3D machine->ram_size;
>     npcm7xx_binfo.nb_cpus =3D sc->num_cpus;
>
>     arm_load_kernel(&soc->cpu[0], machine, &npcm7xx_binfo);
> }
>
> This is fine.

It's also used here:

static void npcm7xx_set_soc_type(NPCM7xxMachineClass *nmc, const char *type=
)
{
    NPCM7xxClass *sc =3D NPCM7XX_CLASS(object_class_by_name(type));
    MachineClass *mc =3D MACHINE_CLASS(nmc);

    nmc->soc_type =3D type;
    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D sc->num_cpus;
}

>
> Just thinking loudly, we traditionally add the load_kernel() code
> in the machine, because it is often specific to Linux guest, and
> the SoC doesn't need to know about the guest OS.
>
> hw/arm/boot.c contains helpers also useful for firmwares.
>
> The SoC has a link to the DRAM so can get its size.
> All the arm_boot_info fields are specific to this SoC.
> So we could move a lot of code to npcm7xx.c, only declaring:
>
>   void npcm7xx_load_kernel(MachineState *machine,
>                            NPCM7xxState *soc);

I can do that, but it doesn't completely get rid of all references to
NPCM7xxClass. I'm afraid there will always be some amount of coupling
between the machines and corresponding SoCs.

Havard

