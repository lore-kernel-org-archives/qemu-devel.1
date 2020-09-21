Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0324EC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC602078E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1fVUUuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC602078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBYD-0004ql-Kh
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKBWP-000371-PP
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:42 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKBWJ-0000ak-UV
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 22:25:41 -0400
Received: by mail-lj1-x244.google.com with SMTP id k25so9754832ljg.9
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 19:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=stZ/MScYI4lX4D5+/Vjv6s6etq74BRHgj3z7ErPvgP4=;
 b=S1fVUUuE6f4Lj4sADK/V3/5QPosCKusawJakKiyr7HcFSmjMleZXHnPw8eGOiub1Iv
 PvNGv0dBvqogvxZvRMOyn08kQ3JxlH/zq+dwsCmOc9aaLTJ+axxVQVnRTWWwit+3zhK2
 w3eamp0LgaC+XteLlGo8Y13VLMJUf/z/aV9Io/V0PWf+X6ZX2WKepEjOiNw5+Eu60Hos
 IqI+pytj2i7wmBgauoy0SJiHnWPJZSgMjzcsxiky5jEY7KXfGeQYR6CGyPZ63vrueImV
 ED8zoAeqbQtShioII5yfQ6A0Ls3uZ4BVRsXSiOt8/HhhgXbcbpxTDTvf9ivB2GXSs3O1
 ePcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=stZ/MScYI4lX4D5+/Vjv6s6etq74BRHgj3z7ErPvgP4=;
 b=AQHWJOfkFNs4kNAJncJZ37vv7H9SrSSAlxLqnN6uGCJpZhX2hGQx1AkWGDe3odbuVS
 ZzjsEqj5QCiIjfqXns3GjOMadHMyd807wJzmK9TTuHmROO/BHuOCgAy0aGvFucJ/ECZH
 bmgPXdQK3sB+ppaiN5kcVQiB3GjDAtNH+MPoKE90QaMhyKJFL/vM97JhU5Ffl9JcG0yW
 Ieom1aRJIaGHMr5aDceymDm2UM+lufXd6PZDokYwYgBoPuNb784znq6+rskhpfpxMNH3
 hNjiEjaSjSL0TQxSOAOxgBbFD+V1zi2xhiRWn7GM5U+sLGZc+DT4+uimwyh0C3VB+SYS
 Khpg==
X-Gm-Message-State: AOAM531aZ6LXbp7d8FjgOtI1LEuB5+sa6VWwy1nlyEVw5G4mnSbW0lUt
 SqFrAeUfLTyEC9zrcOtZbOipfOdo20EeCDbK6g0=
X-Google-Smtp-Source: ABdhPJy3aUyYagk8oYBb1NGOPKt94ISuaIku5QKeC2k95LCtx8uF+b00vcMfUbh95/2MFxLDikf2qmeROHGNwzrqvY8=
X-Received: by 2002:a05:651c:110:: with SMTP id
 a16mr15838588ljb.110.1600655134084; 
 Sun, 20 Sep 2020 19:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <7c38105a-831f-b306-9250-8d0c43fc4108@amsat.org>
In-Reply-To: <7c38105a-831f-b306-9250-8d0c43fc4108@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Mon, 21 Sep 2020 10:25:21 +0800
Message-ID: <CABDp7Vqz=x=WhvcU=aZKpO2oRPjJsjNgrutODUqdRjMYj=8uEg@mail.gmail.com>
Subject: Re: [PATCH V9 0/6] mips: Add Loongson-3 machine support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Thu, Sep 17, 2020 at 3:56 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Huacai,
>
> On 9/16/20 4:12 AM, Huacai Chen wrote:
> > Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> > R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> > Loongson-3A R4 is the newest and its ISA is almost the superset of all
> > others. To reduce complexity, in QEMU we just define two CPU types:
> >
> > 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It i=
s
> >    suitable for TCG because Loongson-3A R1 has fewest ASE.
> > 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It i=
s
> >    suitable for KVM because Loongson-3A R4 has the VZ ASE.
> >
> [...]
>
> > Of course the upstream kernel is also usable (though it is "unstable"
> > now):
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >
> > How to use QEMU/Loongson-3?
> > 1, Download kernel source from the above URL;
> > 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> > 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> > 4, Build QEMU-master with this patchset;
> > 5, modprobe kvm (only necessary for KVM mode);
> > 6, Use QEMU with TCG:
> >        qemu-system-mips64el -M loongson3-virt,accel=3Dtcg -cpu Loongson=
-3A1000 -kernel <path_to_kernel> -append ...
> >    Use QEMU with KVM:
> >        qemu-system-mips64el -M loongson3-virt,accel=3Dkvm -cpu Loongson=
-3A4000 -kernel <path_to_kernel> -append ...
>
> Can you add a KVM-only build CI job?
> Simply building, not running test, as there is no MIPS CI.
>
> See for example commit 41e1f0e2256 (".travis.yml: Add a KVM-only
> s390x job"), but add it to GitLab instead.
I have some difficulties in CI testing (I think I should setup a CI
environment first), can this work be done by others, or in future
after this series?

Huacai
>
> Thanks!
>
> Phil.



--=20
Huacai Chen

