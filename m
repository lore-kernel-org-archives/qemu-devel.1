Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9ADC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C401239D4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 01:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Del4qUfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C401239D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKXQq-0001y7-19
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 21:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKXQ4-0001Xj-Ao
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:48:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44764)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kKXQ2-0000UU-Lv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 21:48:36 -0400
Received: by mail-ot1-x341.google.com with SMTP id a2so14184269otr.11
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 18:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IvQoLAPkItcb3V7K1CW6lrPja915WhmZqE4sLOyLhOQ=;
 b=Del4qUfVrBm8zp6Pw/PYWwUHjvrrVI3Gk1KHo2AxXmkQwFi4OFm4koJt6HkB0CqSDL
 DbXg03ln9RxlnuPKPWu0KgXtFSgja//WJU6Ouy/kuVgrBfOyhY6u3CsUGjDJprCwebB9
 jLx7eWLhHjpVCrlNKxtBIS0biT18EaLNI/8ItXVYG1wnfDVfRNT4LWa9wxOta80Rf87t
 rh3fAHF8QfdxP4KVABe0Zz1owfp5vmexoGIBt1u7xfjxKOM1p4hWbyxWO4MbkKEOIRp2
 5hiq53iv5ibyOSNg1F6ZZYzDnIUT+v2Fs/yOaMosXAQimtNc7ddGXuijpkbOKYjBvEt8
 br7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IvQoLAPkItcb3V7K1CW6lrPja915WhmZqE4sLOyLhOQ=;
 b=ube3fY3S7mtW5S1D+vs/jCJZcHyaFifpEphjfDbCfaTNioG/WRdNOkPgaopxJulT00
 dwLl86qR6mdiQejZcgXLjSXjaUc3Ew3DEg/EGz5PgasXLJtS0uLdKZ3VDB3gVq9zQhC4
 WfrhaMyfvbG9wuXaE1IT9hHkVXEDa9XaxZMiSxnqLJ9qkWdDohVI/2CQpEm5gRgJheW/
 zB1i1fogY49fH8WzwNbGBB5txGJJzTuY1c9Av/hsxIokH72wrWdpqJ8L0eHHoCENnlH6
 jAuGrIbLBfA1fenSEvM6ipbHd9KBXdlPsQTdDZHZrGwPsQ2FH6N6SrpGsv+L1S0HJDlZ
 gRdg==
X-Gm-Message-State: AOAM533N2sgGUw6HuitCBAu0EGU8IdDF/CSOO1vXdoYmo1rKYpAx+e77
 I5eWE6YSI5J3urK8S/1YusYabDrtEsF9xQDoeU4=
X-Google-Smtp-Source: ABdhPJxoTy2PX2jL7oozY6vgjfS6lWOXvCA2R37F/24vdJAmxYwO4afIyfHqh0BsyNqSYJ1PinxrkDKhklb40NadQ0o=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr1343207oti.333.1600739313477; 
 Mon, 21 Sep 2020 18:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200921221045.699690-1-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 22 Sep 2020 09:47:57 +0800
Message-ID: <CAKXe6SJVwQ0iz183pnm0jvJnEyAkB_g20Vch2OEeGRZUeNc2Dw@mail.gmail.com>
Subject: Re: [PATCH 00/24] qom: Convert some properties to class properties
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=886:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Class properties make QOM introspection simpler and easier, as it
> doesn't require an object to be instantiated.  This series
> converts a few existing object_property_add*() calls to register
> class properties instead.
>

Hello Eduardo,

IIUC, most of the properties can be dev-spec or class-spec.
Do we have any principle or rule to specify the property to be dev or class=
?

Maybe if the property which is always the same between instances can
be a class-property?

Thanks,
Li Qiang



> Eduardo Habkost (24):
>   cryptodev-vhost-user: Register "chardev" as class property
>   cryptodev-backend: Register "chardev" as class property
>   rng-egd: Register "chardev" as class property
>   rng-random: register "filename" as class property
>   vhost-user: Register "chardev" as class property
>   vexpress: Register "secure" as class property
>   rng: Register "opened" as class property
>   vexpress-a15: Register "virtualization" as class property
>   input-linux: Register properties as class properties
>   input-barrier: Register properties as class properties
>   tmp421: Register properties as class properties
>   s390x: Register all CPU properties as class properties
>   i386: Register most CPU properties as class properties
>   i386: Register feature bit properties as class properties
>   arm/virt: Register most properties as class properties
>   virt: Register "its" as class property
>   cpu/core: Register core-id and nr-threads as class properties
>   arm/cpu64: Register "aarch64" as class property
>   xlnx-zcu102: Register properties as class properties
>   machine: Register "memory-backend" as class property
>   vga-pci: Register "big-endian-framebuffer" as class property
>   i440fx: Register i440FX-pcihost properties as class properties
>   sifive_e: Register "revb" as class property
>   sifive_u: Register "start-in-flash" as class property
>
>  target/s390x/internal.h         |  1 -
>  backends/cryptodev-vhost-user.c | 13 ++---
>  backends/cryptodev.c            |  8 +--
>  backends/rng-egd.c              |  9 +--
>  backends/rng-random.c           |  8 +--
>  backends/rng.c                  |  8 +--
>  backends/vhost-user.c           |  6 +-
>  hw/arm/vexpress.c               | 25 +++++----
>  hw/arm/virt.c                   | 88 ++++++++++++++++-------------
>  hw/arm/xlnx-zcu102.c            | 25 +++++----
>  hw/core/machine.c               | 12 ++--
>  hw/cpu/core.c                   |  8 +--
>  hw/display/vga-pci.c            | 12 ++--
>  hw/misc/tmp421.c                | 30 +++++-----
>  hw/pci-host/i440fx.c            | 32 +++++------
>  hw/riscv/sifive_e.c             | 11 ++--
>  hw/riscv/sifive_u.c             | 16 +++---
>  target/arm/cpu64.c              | 16 ++----
>  target/i386/cpu.c               | 99 +++++++++++++++++----------------
>  target/s390x/cpu.c              |  1 -
>  target/s390x/cpu_models.c       | 35 ++++++------
>  ui/input-barrier.c              | 44 +++++++--------
>  ui/input-linux.c                | 27 ++++-----
>  23 files changed, 262 insertions(+), 272 deletions(-)
>
> --
> 2.26.2
>
>

