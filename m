Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4A4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B74206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsYcnmEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B74206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIf4K-0002Gt-6T
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 17:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIf2A-0000gI-7Y
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:32:10 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIf24-00019x-Bb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:32:09 -0400
Received: by mail-ej1-x644.google.com with SMTP id j11so13467932ejk.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 14:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ET6SumxQReuYkW2J0m63oAGqalomB4mYfmLSHBuKByo=;
 b=MsYcnmENqYqdu3dxObSEGnifwrcX3+OCIwV1Hf0QlMIsLivP5/5dsFmZSfjrDvMQ34
 asM8CeeBHQTFyivoBsEIN27/yI1ifGgb0CkKiGG4rLDINKgBYp+62dyIYEMEHBBMFMKu
 ShYvnyeb+SQ4wdbvtLZjuZqrCsWF/rLGVJbY9d7sr7dS+OAINigyYdSNsGYJLjGrvssy
 tFwUTCb5G/1FyFCW1fGc49ZY6CTk9qIKnM5i/rmpV0ATDwjQEUWUaFy3ID1GUhXOMIMY
 50O5Rxdu9zJFcZ4T1bLWTEcKXVNEqq8FNGxWxIdNIseGMeCD8nICjqszqzjfVw+JKSeH
 WLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ET6SumxQReuYkW2J0m63oAGqalomB4mYfmLSHBuKByo=;
 b=SPJvu/sQjQ2Wnz9MiE7idjRdjCS1D86OaFOaiEE1liFBbo2LxeVk9lIU1ZwSPM+98g
 VJf317uO60AuJzAaqrp7vAQ3YRm/OIJWhu7CAJ36uYCzdnIh9A0PDiu37DFDN0odLWhI
 j0ggrMoc9ngr+f+iuchri0Zo7zIeA/PeYC0Ys4dHm1wP/YPxuht3Y0QqY1wFpzuPwfvl
 fYtRsWaCTX7bkUonhkateQTeZN4Hq5+kLlmLKliJlu4Kwr1WT6EpwqQWH1AmcR1ILDSV
 Yfmi0o9SbiuXYnNW+tdXbCnljjTgVmkizSAENMKXGSI8qLwslzxqXs5WJMGUnZwP9vHB
 GsBQ==
X-Gm-Message-State: AOAM531A62tNYs/TizCFJXXtg/JnTjynZcKQHQaE3wPG+GRsmXkj32sV
 klePWFoBPX+X1x4UGJtAoEf+g/WD7grpUO8j0N4=
X-Google-Smtp-Source: ABdhPJxWcICdlizn2/zik0wG7c23VPXgt4OKl1kPwvVWx8TQ6C6wjVfNIMgpixh9pt0VeiznhQSwCv84RsoWNC7owuA=
X-Received: by 2002:a17:906:52c2:: with SMTP id
 w2mr28077981ejn.389.1600291922336; 
 Wed, 16 Sep 2020 14:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200916193101.511600-1-ehabkost@redhat.com>
In-Reply-To: <20200916193101.511600-1-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Sep 2020 01:31:50 +0400
Message-ID: <CAJ+F1CLo=mz6LhRTx0PTF-NiabiaCNwm-U=7VEhQXUmryQoqvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] qom: Replace INTERFACE_CHECK with OBJECT_CHECK
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000091602405af74fff2"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000091602405af74fff2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Sep 16, 2020 at 11:35 PM Eduardo Habkost <ehabkost@redhat.com>
wrote:

> This series replaces INTERFACE_CHECK with OBJECT_CHECK because
> both macros are exactly the same.
>
> The last patch is a new run of the OBJECT_CHECK ->
> DECLARE*_CHECKER* converter script that will convert the former
> INTERFACE_CHECK-based macros.
>
>
Well, at least having a different macro allows to tweak qom implementation
or replace it with something different more easily.

I have some wip branch somewhere where I actually made Interface a
different beast than Object (it was saving some fields, and avoiding some
potentially wrong casts iirc - I didn't bother to upstream that yet). Also
I have a different branch where I played with GObject to replace qom. In
both cases, your proposal would have, or would make, the work more
complicated.


Eduardo Habkost (3):
>   qom: Correct object_class_dynamic_cast_assert() documentation
>   qom: Replace INTERFACE_CHECK with OBJECT_CHECK
>   [automated] Use DECLARE_*CHECKER* macros
>
>  include/hw/acpi/acpi_dev_interface.h |  7 +++----
>  include/hw/arm/linux-boot-if.h       |  6 +++---
>  include/hw/fw-path-provider.h        |  6 +++---
>  include/hw/hotplug.h                 |  6 +++---
>  include/hw/intc/intc.h               |  7 +++----
>  include/hw/ipmi/ipmi.h               |  6 +++---
>  include/hw/isa/isa.h                 |  2 +-
>  include/hw/mem/memory-device.h       |  6 +++---
>  include/hw/nmi.h                     |  6 +++---
>  include/hw/ppc/pnv_xscom.h           |  4 ++--
>  include/hw/ppc/spapr_irq.h           |  4 ++--
>  include/hw/ppc/xics.h                |  4 ++--
>  include/hw/ppc/xive.h                | 12 ++++++------
>  include/hw/rdma/rdma.h               |  7 +++----
>  include/hw/rtc/m48t59.h              |  6 +++---
>  include/hw/stream.h                  |  6 +++---
>  include/hw/vmstate-if.h              |  6 +++---
>  include/qom/object.h                 | 14 +-------------
>  include/qom/object_interfaces.h      |  7 +++----
>  include/sysemu/tpm.h                 |  6 +++---
>  target/arm/idau.h                    |  6 +++---
>  tests/check-qom-interface.c          |  6 +++---
>  22 files changed, 62 insertions(+), 78 deletions(-)
>
> --
> 2.26.2
>
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000091602405af74fff2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 16, 2020 at 11:35 PM Ed=
uardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>This series replaces INTERFACE_CHECK with OBJECT_CHECK because<br>
both macros are exactly the same.<br>
<br>
The last patch is a new run of the OBJECT_CHECK -&gt;<br>
DECLARE*_CHECKER* converter script that will convert the former<br>
INTERFACE_CHECK-based macros.<br>
<br></blockquote><div><br></div><div>Well, at least having a different macr=
o allows to tweak qom implementation or replace it with something different=
 more easily.</div><div><br></div><div>I have some wip branch somewhere whe=
re I actually made Interface a different beast than Object (it was saving s=
ome fields, and avoiding some potentially wrong casts iirc - I didn&#39;t b=
other to upstream that yet). Also I have a different branch where I played =
with GObject to replace qom. In both cases, your proposal would have, or wo=
uld make, the work more complicated. <br></div><div><br></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
Eduardo Habkost (3):<br>
=C2=A0 qom: Correct object_class_dynamic_cast_assert() documentation<br>
=C2=A0 qom: Replace INTERFACE_CHECK with OBJECT_CHECK<br>
=C2=A0 [automated] Use DECLARE_*CHECKER* macros<br>
<br>
=C2=A0include/hw/acpi/acpi_dev_interface.h |=C2=A0 7 +++----<br>
=C2=A0include/hw/arm/linux-boot-if.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++=
+---<br>
=C2=A0include/hw/fw-path-provider.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++=
+---<br>
=C2=A0include/hw/hotplug.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0include/hw/intc/intc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 7 +++----<br>
=C2=A0include/hw/ipmi/ipmi.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0include/hw/isa/isa.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0include/hw/mem/memory-device.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 ++=
+---<br>
=C2=A0include/hw/nmi.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0include/hw/ppc/pnv_xscom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++--<br>
=C2=A0include/hw/ppc/spapr_irq.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 4 ++--<br>
=C2=A0include/hw/ppc/xics.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0include/hw/ppc/xive.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 12 ++++++------<br>
=C2=A0include/hw/rdma/rdma.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 7 +++----<br>
=C2=A0include/hw/rtc/m48t59.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 6 +++---<br>
=C2=A0include/hw/stream.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 6 +++---<br>
=C2=A0include/hw/vmstate-if.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 6 +++---<br>
=C2=A0include/qom/object.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 14 +-------------<br>
=C2=A0include/qom/object_interfaces.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +++----=
<br>
=C2=A0include/sysemu/tpm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0target/arm/idau.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++---<br>
=C2=A0tests/check-qom-interface.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 6 +++---<br>
=C2=A022 files changed, 62 insertions(+), 78 deletions(-)<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000091602405af74fff2--

