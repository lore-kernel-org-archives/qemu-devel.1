Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902C6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:33:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084682087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=blade-group.com header.i=@blade-group.com header.b="lGkbGv7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084682087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=blade-group.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIt62-0001G1-22
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIszG-0002Rv-Eb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:26:06 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antoine.damhet@blade-group.com>)
 id 1kIszD-0003qF-WA
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:26:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id d4so1769142wmd.5
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blade-group.com; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hxuORB+uFMLaG5rwi1PH2mmObmRrvK5jQMFiamDZXzE=;
 b=lGkbGv7W8PHsY6SQoxMJoMXdqV4/0QCwpidTssYXPbKCPXmM9H2uumQ6TSXtUhDaoe
 YECrK+Z7uN5mLUOm8WXEJ0ygPKVuSdIVzTc2wQgM56IiM6HqP7IBiIollffTmpGAK2/p
 ad2da2e9exknrD3Pb2d8A4GHkfqL9l1LX4qBZGPeQP0ndYLZ/oAEWrTBwqjBuJzyDgOS
 Qb9soXOSJ9U1ccdd8iFIxfRLAxlcjnH5ecNXE48NekX5+ePudjPGoT42ExpPjQDFyqxc
 qFbO6nkOlih+pOFqlj77AL6O4KlVLsKMmIu4bCWMoZvO1ByDJxjsqgXzM44Cx+z3h2H8
 AV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hxuORB+uFMLaG5rwi1PH2mmObmRrvK5jQMFiamDZXzE=;
 b=RACKtKPjg2MF04awfwgDWBfyzUqlbsFSjx0qFq5YHqnqJ7JxEwjTodthMvXxw943es
 bGlXwLLcuUxC2mQuHRUT2F54kE2S/VIkkLvi5lS+cgptuDNp6tZ+dmcUyfR9MKt7U5T3
 crf5ZYVPQqLKocKlEtncJ9xLbLWaLfQlf68ibVDyTdUN5ddapZZFwQk1ErCe/3w1HbLh
 hnyhk3UqJoGMimgxVozNjeudbXWmM0ccQOqT1TzJ+iNMrG9/3XkeKpDWGFShKNx9bntD
 P4hKXcm06BWCW8izogXzQEaT+X1rzB/L6/ySlOZhy//pJ3F976f4JbfZ9U/63s+5lfoo
 JmIQ==
X-Gm-Message-State: AOAM530mbCpAnqi9/hK4nbP/ae29eKCfC2ekGo0ACscLUN994OCCw9nJ
 utPxnZBgJMY+BIyXXm+RLMyCxA==
X-Google-Smtp-Source: ABdhPJz2yC/mTYzUvINbOg0NNDiAc8aQOaPyb4uEp8wHsiKMAsUoGBgC2Qk5XWVZsCkYWd9/YJGSKA==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr9555726wma.75.1600345561795; 
 Thu, 17 Sep 2020 05:26:01 -0700 (PDT)
Received: from localhost ([2a01:e34:ec16:8a90:4e1d:96ff:fe49:7109])
 by smtp.gmail.com with ESMTPSA id n4sm38207470wrp.61.2020.09.17.05.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 05:26:00 -0700 (PDT)
Date: Thu, 17 Sep 2020 14:25:59 +0200
From: Antoine Damhet <antoine.damhet@blade-group.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] target/i386: always create kvmclock device
Message-ID: <20200917122559.e7i5o64k7rw7urdh@tartarus>
References: <20200917111306.819263-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vikpe6obnxeko6wi"
Content-Disposition: inline
In-Reply-To: <20200917111306.819263-1-vkuznets@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=antoine.damhet@blade-group.com; helo=mail-wm1-x341.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vikpe6obnxeko6wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2020 at 01:13:06PM +0200, Vitaly Kuznetsov wrote:
> QEMU's kvmclock device is only created when KVM PV feature bits for
> kvmclock (KVM_FEATURE_CLOCKSOURCE/KVM_FEATURE_CLOCKSOURCE2) are
> exposed to the guest. With 'kvm=3Doff' cpu flag the device is not
> created and we don't call KVM_GET_CLOCK/KVM_SET_CLOCK upon migration.
> It was reported that without these call at least Hyper-V TSC page
> clocksouce (which can be enabled independently) gets broken after
> migration.
>=20
> Switch to creating kvmclock QEMU device unconditionally, it seems
> to always make sense to call KVM_GET_CLOCK/KVM_SET_CLOCK on migration.
> Use KVM_CAP_ADJUST_CLOCK check instead of CPUID feature bits.
>=20
> Reported-by: Antoine Damhet <antoine.damhet@blade-group.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  hw/i386/kvm/clock.c    | 6 +-----
>  target/i386/kvm.c      | 5 +++++
>  target/i386/kvm_i386.h | 1 +
>  3 files changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> index 64283358f91d..526c9ea5172b 100644
> --- a/hw/i386/kvm/clock.c
> +++ b/hw/i386/kvm/clock.c
> @@ -330,11 +330,7 @@ static const TypeInfo kvmclock_info =3D {
>  /* Note: Must be called after VCPU initialization. */
>  void kvmclock_create(void)
>  {
> -    X86CPU *cpu =3D X86_CPU(first_cpu);
> -
> -    if (kvm_enabled() &&
> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE)=
 |
> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2=
))) {
> +    if (kvm_enabled() && kvm_has_adjust_clock()) {

Shouldn't the old check used when machine type <=3D 5.1 in order to avoid
migration incompatibility ?

>          sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>      }
>  }
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 4a8b3a41c1bc..20b31b65307b 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -143,6 +143,11 @@ bool kvm_has_adjust_clock_stable(void)
>      return (ret =3D=3D KVM_CLOCK_TSC_STABLE);
>  }
> =20
> +bool kvm_has_adjust_clock(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
> +}
> +
>  bool kvm_has_exception_payload(void)
>  {
>      return has_exception_payload;
> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> index 064b8798a26c..0fce4e51d2d6 100644
> --- a/target/i386/kvm_i386.h
> +++ b/target/i386/kvm_i386.h
> @@ -34,6 +34,7 @@
> =20
>  bool kvm_allows_irq0_override(void);
>  bool kvm_has_smm(void);
> +bool kvm_has_adjust_clock(void);
>  bool kvm_has_adjust_clock_stable(void);
>  bool kvm_has_exception_payload(void);
>  void kvm_synchronize_all_tsc(void);
> --=20
> 2.25.4
>=20
>=20

--=20
Antoine 'xdbob' Damhet

--vikpe6obnxeko6wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAl9jVdUACgkQ3AmjLzzl
jz41ZggAgr4IGvlzgt8XS4LjT1qYjt+vr7IFjoceBn6d/Cou21MgV/fBGylABPfy
KJBdJMO4tQ5FCQSlV30sAyFzsoMrKz8B6o4N8i2KVCPPNslH2eQBxaCSutoZWZUO
xGtapD0xAMHwKqd6gjdyTO5YrEq/PdPH79mDiOn38ZDE422WnWiCEts1yMUX51Hk
4bCC89fV3w7oDj/lzrJs+kfQpybP/qH67OMv0FqJE5guhkiE27zxbMz+O0n47D0n
E8UfXTEzXS/9ev1lP8vcuv+IJhm7tT44lEP2TMfl+UdBdMMCPpLKqoeummQ4HlB0
siWUMcmlB8Lmb+BYnPPF6gbM0rk4wQ==
=Vqhs
-----END PGP SIGNATURE-----

--vikpe6obnxeko6wi--

