Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B2EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F0E206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlOt0sSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F0E206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jom14-0001XP-J7
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jom0D-0000PY-Bm
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:54:37 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jom0B-00041z-HN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:54:37 -0400
Received: by mail-ej1-x641.google.com with SMTP id i14so8912899ejr.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S9tmgHeMzw4Gs9JiDQ2JO+kxLJNINpzRNVs/yrLrGf4=;
 b=RlOt0sSIH4XkbojPtzaLlgbOIvmodJw8QrBjp7OIix7Zb4lle1VdFkK8mgZ3V9s1NW
 saZ1QB1kqc11a+vG5t+/owu3Zqp6W3EesLItzw7qpD1r/XEfI2KA3auH37g6R4/bA3Fa
 c9surUzhNUOZQHsVDg7OUCUVKUpunPrKbhO5nqFoB6DOrdcBAQvtSrJ2KusOZtmmf2Pj
 tfKxwZzjzekCBVjHNvn63lpJTfifnNQ5XYoyucKa3O5euGThR6dx+IBH/34RrB/xq+1I
 jhZ7TvCZ5lGCGQU7t404wryUwR0aqNKo+5hi24AadcLkCF14Wjv7dq88338EsqoAxd71
 rbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S9tmgHeMzw4Gs9JiDQ2JO+kxLJNINpzRNVs/yrLrGf4=;
 b=nXf2ggWxJLCSzLpnG22Z//RQ8uhuGLL4FQjJnDliaCF8w23u7Dub7rLMk+G1B/mprv
 UVvlCzzl+mQqEMI+ID9jQhzhYVStOXz80RV2qPnwEfXvLe/Y2fNCA+en1GAmaNyE4l3d
 I2X+AynMqgNw3NVE0BAVMxAmA/Jyy0jtCVZ99SnPEnFl3JZ3KSQWeigm5Srh2ljg8wY3
 PScFydismXRfn9bwDpyNT/bvFAW6sNiMJTwmeWna+rNca1tDL54zDRegnfH84nbLwt0p
 8W7YD4mx3zrKX/OkBXoxBm95i4HheT0AHXaUXwCyX8TJLcYSaGIrme8nw6wwk+JTOAGI
 TeTg==
X-Gm-Message-State: AOAM531NxLhxiG1kvssCkjo4eQC0e27R4Jua2CAAAS9JPwxyJsAei+fc
 tFeXBSTVqto5Ruock9YWERPmFnxbAdd2rPnJecg=
X-Google-Smtp-Source: ABdhPJzrUyaS+JAiBU4zRZNcm5HXUGwHrRCyPN0i/vIgXw2l0/6RYmRLsLo1SKOm2QKS7y8kWq3v3oiOXr8ikX8oBFs=
X-Received: by 2002:a17:906:2681:: with SMTP id
 t1mr1061924ejc.350.1593168873231; 
 Fri, 26 Jun 2020 03:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
 <CAHiYmc7_ra2qWJ8mkZ-vqL5vN2BKdWxAZeKNnMEkPtien5-fsw@mail.gmail.com>
 <b34bf27c-3189-addc-0c50-b0c0c533876d@redhat.com>
 <d2657f75-26fe-117b-183d-732d88da2653@redhat.com>
 <32aa7cf6-5f4d-eb79-2ebe-ee463f4389b8@redhat.com>
In-Reply-To: <32aa7cf6-5f4d-eb79-2ebe-ee463f4389b8@redhat.com>
From: Jon Doron <arilou@gmail.com>
Date: Fri, 26 Jun 2020 13:54:21 +0300
Message-ID: <CAP7QCoiuc3ZYXowBi6TahYEoxM3fiUQAwfo=pSUZeG5yOGTY9Q@mail.gmail.com>
Subject: Re: [Bug 1885247] [NEW] Build error in Intel 32-bit hosts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bug 1885247 <1885247@bugs.launchpad.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Is there a container I can download which has your build environment?

On Fri, Jun 26, 2020 at 12:27 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 6/26/20 11:20 AM, Thomas Huth wrote:
> > On 26/06/2020 11.13, Philippe Mathieu-Daud=C3=A9 wrote:
> >> On 6/26/20 9:37 AM, Aleksandar Markovic wrote:
> >>> =D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 09:11 Aleksan=
dar Markovic
> >>> <1885247@bugs.launchpad.net> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>>>
> >>>> Public bug reported:
> >>>>
> >>>> The code base is on master, checked out on Thursday June25th 2020,
> >>>> 0250c595c9d. The build procedure:
> >>>>
> >>>> $ mkdir build-gcc
> >>>> $ cd build-gcc
> >>>> $ ../configure
> >>>> $ make
> >>>>
> >>>> The build error message is:
> >>>>
> >>>>    CC      x86_64-softmmu/hw/hyperv/hyperv.o
> >>>>    CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
> >>>>    CC      x86_64-softmmu/hw/hyperv/vmbus.o
> >>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function
> >>>> =E2=80=98gpadl_iter_io=E2=80=99:
> >>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast
> >>>> to pointer from integer of different size [-Werror=3Dint-to-pointer-=
cast]
> >>>>           p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) |
> >>>> off_in_page);
> >>>>               ^
> >>>> cc1: all warnings being treated as errors
> >>>> make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69:
> >>>> hw/hyperv/vmbus.o] Error 1
> >>>> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
> >>
> >> FWIW there is no CI job covering x86 KVM on 32-bit host build.
> >> Should this be covered? I guess the problem is no CI services
> >> provide 32-bit x86...
> >
> > You can certainly provide either a container, or install the 32-bit
> > libraries in a 64-bit environment. Then run
> >
> > PKG_CONFIG_LIBDIR=3D... ./configure --extra-cflags=3D-m32
> >
> > and it should be possible to build 32-bit binaries, too.
> >
> > Alternatively, we could add a cross-compilation job that builds with
> > i686-w64-mingw32 in 32-bit.
>
> Oh, this case is covered:
> https://app.shippable.com/github/qemu/qemu/runs/2437/2/console
>
> But this doesn't use KVM ;)
>

