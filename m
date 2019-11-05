Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439ABC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20292087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 22:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx/xZJxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20292087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS7Bf-0008S5-4S
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 17:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iS6fi-0001jt-NO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iS6ff-00045G-LG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:47:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iS6fb-000434-0A
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572990440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNJYztu9V2q35xzvpCvzlxbCf4MquV3oufWVlEETdrI=;
 b=cx/xZJxmEyn6VZj4GIYxQprkTerInGyMR+E6KZXMr77+7NydduIDuM9/DzvLl6Gm6kuMBu
 iqBzTMrAls5ItpHu9TIwstnI/PmjqBD18oNuqNTlRCeTbNbauiMm197Lne0Djgxpzzoxos
 yoC1dii3joeUAl17n03dWmaUlAm9pzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-lM_n4WMxOi2nFkgOt1Osww-1; Tue, 05 Nov 2019 16:43:32 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53C458017DE;
 Tue,  5 Nov 2019 21:43:30 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F12E5C296;
 Tue,  5 Nov 2019 21:43:27 +0000 (UTC)
Date: Tue, 5 Nov 2019 18:43:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Moger, Babu" <Babu.Moger@amd.com>
Subject: Re: [PATCH 1/2] i386: Add missing cpu feature bits in EPYC model
Message-ID: <20191105214325.GL3812@habkost.net>
References: <157298859935.17394.17194072829278152009.stgit@naples-babu.amd.com>
 <157298864859.17394.12763030347823834590.stgit@naples-babu.amd.com>
MIME-Version: 1.0
In-Reply-To: <157298864859.17394.12763030347823834590.stgit@naples-babu.amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lM_n4WMxOi2nFkgOt1Osww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 09:17:30PM +0000, Moger, Babu wrote:
> Adds the following missing CPUID bits:
> perfctr-core : core performance counter extensions support. Enables the V=
M
>                to use extended performance counter support. It enables si=
x
>                programmable counters instead of 4 counters.
> clzero       : instruction zeroes out the 64 byte cache line specified in=
 RAX.
> xsaveerptr   : XSAVE, XSAVE, FXSAVEOPT, XSAVEC, XSAVES always save error
>                pointers and FXRSTOR, XRSTOR, XRSTORS always restore error
>                pointers.
> ibpb         : Indirect Branch Prediction Barrie.
> xsaves       : XSAVES, XRSTORS and IA32_XSS supported.
>=20
> Depends on:
> 40bc47b08b6e ("kvm: x86: Enumerate support for CLZERO instruction")
> 504ce1954fba ("KVM: x86: Expose XSAVEERPTR to the guest")
> 52297436199d ("kvm: svm: Update svm_xsaves_supported")
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  hw/i386/pc.c      |    8 +++++++-
>  target/i386/cpu.c |   11 +++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 51b72439b4..a72fe1db31 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -105,7 +105,13 @@ struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8=
_MAX};
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
>  static size_t pvh_start_addr;
> =20
> -GlobalProperty pc_compat_4_1[] =3D {};
> +GlobalProperty pc_compat_4_1[] =3D {
> +    { "EPYC" "-" TYPE_X86_CPU, "perfctr-core", "off" },
> +    { "EPYC" "-" TYPE_X86_CPU, "clzero", "off" },
> +    { "EPYC" "-" TYPE_X86_CPU, "xsaveerptr", "off" },
> +    { "EPYC" "-" TYPE_X86_CPU, "ibpb", "off" },
> +    { "EPYC" "-" TYPE_X86_CPU, "xsaves", "off" },
> +};

machine-type-based CPU compatibility was now replaced by
versioned CPU models.  Please use the X86CPUDefinition.versions
field to add a new version of EPYC instead.

>  const size_t pc_compat_4_1_len =3D G_N_ELEMENTS(pc_compat_4_1);
> =20
>  GlobalProperty pc_compat_4_0[] =3D {};
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 07cf562d89..71233e6310 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3110,19 +3110,18 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
>              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
>              CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
> -            CPUID_EXT3_TOPOEXT,
> +            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
> +        .features[FEAT_8000_0008_EBX] =3D
> +            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR =
|
> +            CPUID_8000_0008_EBX_IBPB,
>          .features[FEAT_7_0_EBX] =3D
>              CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_=
AVX2 |
>              CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_RDSE=
ED |
>              CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLFLU=
SHOPT |
>              CPUID_7_0_EBX_SHA_NI,
> -        /* Missing: XSAVES (not supported by some Linux versions,
> -         * including v4.1 to v4.12).
> -         * KVM doesn't yet expose any XSAVES state save component.
> -         */
>          .features[FEAT_XSAVE] =3D
>              CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
> -            CPUID_XSAVE_XGETBV1,
> +            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
>          .features[FEAT_6_EAX] =3D
>              CPUID_6_EAX_ARAT,
>          .features[FEAT_SVM] =3D
>=20

--=20
Eduardo


