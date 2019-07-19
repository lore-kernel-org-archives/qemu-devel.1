Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0E3C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 20:54:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E26821849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 20:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E26821849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoZtV-0006ti-7e
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 16:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53178)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hoZtE-0006A9-Di
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hoZtD-0000DM-2m
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:54:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49202)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hoZtC-0000Ch-Qj
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 16:54:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11675308C418;
 Fri, 19 Jul 2019 20:54:01 +0000 (UTC)
Received: from localhost (ovpn-116-109.gru2.redhat.com [10.97.116.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B71915C226;
 Fri, 19 Jul 2019 20:53:59 +0000 (UTC)
Date: Fri, 19 Jul 2019 17:53:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>,
 To: "Denis V. Lunev" <den@openvz.org>
Message-ID: <20190719205358.GB26800@habkost.net>
References: <20190718134537.22356-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190718134537.22356-1-den@openvz.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 19 Jul 2019 20:54:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] x86: add CPU flags supported inside
 libvirt
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 18, 2019 at 04:45:37PM +0300, Denis V. Lunev wrote:
> There are the following flags available in libvirt inside cpu_map.xm
>     <feature name=3D'cvt16'>
>       <cpuid function=3D'0x80000001' ecx=3D'0x00040000'/>

This is bit 18...

>     </feature>
>     <feature name=3D'cmt'> <!-- cqm -->
>       <cpuid eax_in=3D'0x07' ecx_in=3D'0x00' ebx=3D'0x00001000'/>
>     </feature>
> We have faced the problem that QEMU does not start once these flags are
> present in the domain.xml.
>=20
> This patch just adds proper names into the map.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
> CC: Peter Krempa <pkrempa@redhat.com>
> CC: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  target/i386/cpu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 805ce95247..88ba4dad47 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -870,7 +870,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
>              "lahf-lm", "cmp-legacy", "svm", "extapic",
>              "cr8legacy", "abm", "sse4a", "misalignsse",
>              "3dnowprefetch", "osvw", "ibs", "xop",
> -            "skinit", "wdt", NULL, "lwp",
> +            "skinit", "wdt", "cvt16", "lwp",

...this is bit 14.

Anyway, the cvt16 bit was removed on purpose, and was never
supported.  See:
http://mid.mail-archive.com/508091FB.1030705@amd.com

>              "fma4", "tce", NULL, "nodeid-msr",
>              NULL, "tbm", "topoext", "perfctr-core",
>              "perfctr-nb", NULL, NULL, NULL,
> @@ -1044,7 +1044,7 @@ static FeatureWordInfo feature_word_info[FEATURE_=
WORDS] =3D {
>              "fsgsbase", "tsc-adjust", NULL, "bmi1",
>              "hle", "avx2", NULL, "smep",
>              "bmi2", "erms", "invpcid", "rtm",
> -            NULL, NULL, "mpx", NULL,
> +            "cmt", NULL, "mpx", NULL,

This is one is named "cqm" on Linux (X86_FEATURE_CQM).  I prefer
to keep consistency with the name already in use by Linux than
the one in libvirt that was never used.

You can still add a "cmt" alias property if you think it would be
useful.

Also, I see no code implementing migration of MSR_IA32_QM_EVTSEL,
MSR_IA32_QM_CTR, or other RDT-M state.  If the feature is not
safe for migration yet, you need to explicitly add the feature to
.unmigratable_flags.


>              "avx512f", "avx512dq", "rdseed", "adx",
>              "smap", "avx512ifma", "pcommit", "clflushopt",
>              "clwb", "intel-pt", "avx512pf", "avx512er",
> --=20
> 2.17.1
>=20

--=20
Eduardo

