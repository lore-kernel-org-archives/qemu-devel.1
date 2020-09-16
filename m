Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ADFC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:16:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1F82222A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="jCTf6WPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1F82222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWMr-0001Aj-55
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIW6O-0000jM-3P
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:59:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIW6L-0001DJ-Rv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:59:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id k18so2707369wmj.5
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QI8CHkdLFKbabYboce+LlxNHsg+oVRiDEvBQJwSrNCM=;
 b=jCTf6WPLKeGXUWZQU6MzY7erBulIkf+22dw1bTDHiX/oNPveJoUMMWleXbJrMtpZmo
 j5bxlL+UxnYGYcDrF+2IFGf65qZPT0AFagNd2nfZjtAn0bdB/HLtRfDwLE1eauqGR5PZ
 HqeepjfvvKc8kBQg8+aEYA9y+scE9Vc++qmw+jlHp+gVNE6U3eXxBuCVbQ30wncbN6se
 CQmWGJsf7YAth0pgF+kVaqrR9zY+lzY8kl8o0k58EtHcOh8I4Pe//mMzmHLXzooINSVS
 G8WQ6T5IsIrnMeO4UxItL0g97VZuv9LBrP0HbDcKon3mgMaopz63AZubGnJj43/KEPCT
 qrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QI8CHkdLFKbabYboce+LlxNHsg+oVRiDEvBQJwSrNCM=;
 b=HH6HhVZudc84xatHADhM5NtjKW6vQrSt4XGhpBO4ojtDcKcC6hgyfqvMjyXBIeLIm7
 lLMZCiLl7oEhhe8mVRovUFvagYv+WWZ89iwLLGYJxsjl18KcWPWw9pJx6Dzwsxmh1lEk
 q9YKOEG6OV6ffsiOI3J9hyVNEnm1neK4lu3sMgmT4igsJBiELN20BGCPvJOHhLJge4HZ
 PGGHINgGuJwKo9tII8CfFcwqx/H+iymyPC/6VFAEbtexMDW4Pia917AsSAPZgKGkm3s3
 nr53WdvQ/bjTP95SlM73Nosesc1fU5D4LFcllbTN6TA36BDYXymAda1VAQvSaWCvwGCr
 mGJA==
X-Gm-Message-State: AOAM531zY/XccWqoqM3zlRI7X8a4ZQlkli/vGuDZQqBaGlvw29kWbJax
 xoR0SliAX6gVqk+rCUkGihYbtw==
X-Google-Smtp-Source: ABdhPJxQ+5R7c3vXSDHCprkdV8DH9LMzbuSc7Jn5tCSiJWR8ym9yp7a5l61RwkCLrX386AMmrDgnOQ==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr4385766wmb.70.1600257592331; 
 Wed, 16 Sep 2020 04:59:52 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id q15sm30810594wrr.8.2020.09.16.04.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:59:51 -0700 (PDT)
Date: Wed, 16 Sep 2020 13:59:50 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [BUG] Migration hv_time rollback
Message-ID: <20200916115950.tsarwvk2dwgiceoe@tartarus>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="h6abctsp65t6bzip"
Content-Disposition: inline
In-Reply-To: <20200916112956.GE2833@work-vm>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--h6abctsp65t6bzip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 12:29:56PM +0100, Dr. David Alan Gilbert wrote:
> cc'ing in Vitaly who knows about the hv stuff.

Thanks

>=20
> * Antoine Damhet (antoine.damhet@blade-group.com) wrote:
> > Hi,
> >=20
> > We are experiencing timestamp rollbacks during live-migration of
> > Windows 10 guests with the following qemu configuration (linux 5.4.46
> > and qemu master):
> > ```
> > $ qemu-system-x86_64 -enable-kvm -cpu host,kvm=3Doff,hv_time [...]
> > ```
>=20
> How big a jump are you seeing, and how did you notice it in the guest?

I'm seeing jumps of about the guest uptime (indicating a reset of the
counter). It's expected because we won't call `KVM_SET_CLOCK` to
restore any value.

We first noticed it because after some migrations `dwm.exe` crashes with
the "(NTSTATUS) 0x8898009b - QueryPerformanceCounter returned a time in
the past." error code.

I can also confirm the following hack makes the behavior disappear:

```
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 64283358f9..f334bdf35f 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -332,11 +332,7 @@ void kvmclock_create(void)
 {
     X86CPU *cpu =3D X86_CPU(first_cpu);

-    if (kvm_enabled() &&
-        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
-                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))=
) {
-        sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
-    }
+    sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
 }

 static void kvmclock_register_types(void)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 32b1453e6a..11d980ba85 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -158,9 +158,7 @@ static void pc_init1(MachineState *machine,

     x86_cpus_init(x86ms, pcmc->default_cpu_version);

-    if (kvm_enabled() && pcmc->kvmclock_enabled) {
-        kvmclock_create();
-    }
+    kvmclock_create();

     if (pcmc->pci_enabled) {
         pci_memory =3D g_new(MemoryRegion, 1);
```

>=20
> Dave
>=20
> > I have tracked the bug to the fact that `kvmclock` is not exposed and
> > disabled from qemu PoV but is in fact used by `hv-time` (in KVM).
> >=20
> > I think we should enable the `kvmclock` (qemu device) if `hv-time` is
> > present and add Hyper-V support for the `kvmclock_current_nsec`
> > function.
> >=20
> > I'm asking for advice because I am unsure this is the _right_ approach
> > and how to keep migration compatibility between qemu versions.
> >=20
> > Thank you all,
> >=20
> > --=20
> > Antoine 'xdbob' Damhet
>=20
>=20
> --=20
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20

--=20
Antoine 'xdbob' Damhet

--h6abctsp65t6bzip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9h/jEACgkQ3AmjLzzl
jz6jiQf/fiNRX4JVTmByAlW305o0Mzih4RdUbZGFRm1ytGOv+ZhJVfynCGlXBZMQ
P++lYJIzlt1gt6Uj4NNEgsbLP22hUiyRefjhTkNs9G7X6MpptIBcUJwihmSW1pnX
DzpGcxkmLD2FhG2yu9yZBeFxQo2rIv/6UYDFjpFmGBWxl9yKKnvrNKs17bU5FhTb
wEJ7Z0iQZRhl89uhuUgR/CQhcdaAWwK81j2X2yCNz/Xse6siVSOBHiNCOW8Bo+M7
SilsZdFhKE65jAN41UelkUOGlKud/PUt/jQDO2SJ3mxVfD2+JA8ot+qfNsxesRwu
V1wAgZDq+NpxR5Zf0NvU1F92ze1aVA==
=zIp1
-----END PGP SIGNATURE-----

--h6abctsp65t6bzip--

