Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD35FC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 17:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67F5A20878
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 17:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="LLRmkgxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F5A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbRvw-00070x-KT
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 12:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbRvH-0006Bb-KR
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 12:22:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbRvF-0002Dj-WB
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 12:22:43 -0500
Received: by mail-wm1-x343.google.com with SMTP id a65so4194967wme.1
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 09:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=asFZG2lov717FLRjZhusKCOyFq1RYnqBvCU8Mww6FBU=;
 b=LLRmkgxyyWjYLVqggucYPkqUjLd5qPBr1EVNd1r/3TU+HMYgEHlCTDLIe52ybpAxRT
 4nShH8pemrwCUphJjw8rcHsaAF5nXkPmk8/NwDvC9vVzHzm9aIKpqgUB0iV+aNzis7fA
 iUyF+qQSd/oX6f2QGB8Krh8rVmBswpoQQwFw46wnxn5ZVsbI/1NYQ/vDaQPqGH0Ff/Mj
 y5QSSRetB2GBYe3nMokfiAkY6bDk9WxMn+BgT7tmOZjzCak7jf9Ousz93lLhe+l2aRxc
 8Z8bB84P1G0GUCrJMgbJyUtJpyAO8xIEgBb10yNE4ke44d3o0nWqBjRYB7eFYlJrajrV
 /VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=asFZG2lov717FLRjZhusKCOyFq1RYnqBvCU8Mww6FBU=;
 b=WogXiu5rJ0TJV0wtKqPLyfJ5pM7KrqmAJZyeEzzMFf6TtVIpkqZabmQLY3a6sOVgrp
 MpEHZtLm+zQl0BNX2cPqHSfYDKKf4asbLGB+9sgbZy2lYgSULqxt3qWUuT5eqleehqJ3
 Wx7Rn/itWz0WZXFQzZDy32mN+cg4LSWnzNC4XXVPuUlxa01wiAdmQPtG1Kf3+lRr9JHa
 kP+f2MaRx+9Ete6PoUU7dKnhCOUM1P4v7gWn6J/ZFgJ9dXwf43wr2u/J9e1cqzh514/+
 goTKbeKK0Fi/YDELutgqE3qp7muDmNhooucR7IN4C7RbroSGSAOtkq+dNgG43y26bvP/
 EpWQ==
X-Gm-Message-State: AOAM533tBCNNsTQMhgY8gl9oqCnWi/BfYvZK5zQJI2RqJoyeNAPxrgkA
 /I2JARvI2lo6Fnf0t/EGD8cSb1a8VFJKqoI2o7DhQg==
X-Google-Smtp-Source: ABdhPJztcxDIhHGGJqh3KXLYir0ninPPH/RMsvgWT30tUO4VKRGYX7gIq2GyAMwOJXrprKzKet+mQunNCCf5+54mosc=
X-Received: by 2002:a1c:6456:: with SMTP id y83mr5968370wmb.59.1604769760529; 
 Sat, 07 Nov 2020 09:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20201107150851.87008-1-ani@anisinha.ca>
 <20201107112417-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201107112417-mutt-send-email-mst@kernel.org>
From: Ani Sinha <ani@anisinha.ca>
Date: Sat, 7 Nov 2020 22:52:28 +0530
Message-ID: <CAARzgwzc1qjo1VMECqBa8TTqzv2Oo-ztXM6AE1Fp4gyx7q-9vg@mail.gmail.com>
Subject: Re: [PATCH-for-5.2] acpi-build: Fix maybe-uninitialized warning when
 ACPI hotplug is off
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::343;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 7, 2020 at 9:56 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Nov 07, 2020 at 08:38:51PM +0530, Ani Sinha wrote:
> >  This fixes the following warning (gcc 9.3.0 on Ubuntu):
> >
> >   ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
> >   ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitiali=
zed
> >   in this function [-Werror=3Dmaybe-uninitialized]
> >     496 |         aml_append(parent_scope, method);
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   cc1: all warnings being treated as errors
> >
> > Fixes: df4008c9c59 ("piix4: don't reserve hw resources when hotplug is =
off globally")
> > Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  hw/i386/acpi-build.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 4f66642d88..79b86d4a36 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -349,7 +349,7 @@ static void build_append_pcihp_notify_entry(Aml *me=
thod, int slot)
> >  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bu=
s,
> >                                           bool pcihp_bridge_en)
> >  {
> > -    Aml *dev, *notify_method =3D NULL, *method;
> > +    Aml *dev, *notify_method =3D NULL, *method =3D NULL;
> >      QObject *bsel;
> >      PCIBus *sec;
> >      int i;
> > @@ -492,7 +492,7 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
> >          }
> >      }
> >
> > -    if (bsel || pcihp_bridge_en) {
> > +    if (method) {
> >          aml_append(parent_scope, method);
> >      }
> >      qobject_unref(bsel);
>
> I prefer Philippe's fix I think - gcc does not warn about it but
> using method when it's NULL would lead to a crash.

I could be wrong but I do not see a case where we are using a method
which is uninitialized first.
I did see another bug in my V1 and I fixed it in V2.

>
> > --
> > 2.25.1
>

