Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896F3C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:40:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FBB021A4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xl3C9iHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBB021A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6Z9-0002dK-S8
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iS68X-0001M0-Ut
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iS68U-0004yt-Tp
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:13:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iS68U-0004yj-Ho
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572988389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Tp2ixndWMu1cBasr+uzvmjG092c9uFyiYoX6rgzM1s=;
 b=Xl3C9iHt4bgRB6HSE0iAZDhbFnPKI5DQvo8uV7JsZH61QDHTbwLFn4elkF8MmC2i0E88Q0
 hpIZSY22x1Vn7pqREX/PtSJCGtBpiYhReWxDSdOJDBuggl4pKZ1s4msDmrFXEUpE6Of6TY
 eXha17mccQ/TRCD4fpQMXgCzVtio+yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-P8GUKxmSOBmlWYb-QX7hOg-1; Tue, 05 Nov 2019 16:13:06 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BE9F107ACC3;
 Tue,  5 Nov 2019 21:13:05 +0000 (UTC)
Received: from localhost (ovpn-116-57.gru2.redhat.com [10.97.116.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09624600C4;
 Tue,  5 Nov 2019 21:13:04 +0000 (UTC)
Date: Tue, 5 Nov 2019 18:13:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v1 Resend] target/i386: set the CPUID level to 0x14 on
 old machine-type
Message-ID: <20191105211303.GK3812@habkost.net>
References: <1572416882-41378-1-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
In-Reply-To: <1572416882-41378-1-git-send-email-luwei.kang@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: P8GUKxmSOBmlWYb-QX7hOg-1
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 30, 2019 at 02:28:02PM +0800, Luwei Kang wrote:
> The CPUID level need to be set to 0x14 manually on old
> machine-type if Intel PT is enabled in guest. e.g. in Qemu 3.1
> -machine pc-i440fx-3.1 -cpu qemu64,+intel-pt
> will be CPUID[0].EAX(level)=3D7 and CPUID[7].EBX[25](intel-pt)=3D1.
>=20
> Some Intel PT capabilities are exposed by leaf 0x14 and the
> missing capabilities will cause some MSRs access failed.
> This patch add a warning message to inform the user to extend
> the CPUID level.

Note that a warning is not an acceptable fix for a QEMU crash.
We still need to fix the QEMU crash reported at:
https://lore.kernel.org/qemu-devel/20191024141536.GU6744@habkost.net/


>=20
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>

The subject line says "v1", but this patch is different from the
v1 you sent earlier.

If you are sending a different patch, please indicate it is a new
version.  Please also indicate what changed between different
patch versions, to help review.

> ---
>  target/i386/cpu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a624163..f67c479 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5440,8 +5440,12 @@ static void x86_cpu_expand_features(X86CPU *cpu, E=
rror **errp)
> =20
>          /* Intel Processor Trace requires CPUID[0x14] */
>          if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
> -             kvm_enabled() && cpu->intel_pt_auto_level) {

Not directly related to the warning: do you know why we have a
kvm_enabled() check here?  It seems unnecessary.  We want CPUID
level to be correct for all accelerators.

> -            x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
> +             kvm_enabled()) {
> +            if (cpu->intel_pt_auto_level)
> +                x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x1=
4);
> +            else
> +                warn_report("Intel PT need CPUID leaf 0x14, please set "
> +                            "by \"-cpu ...,+intel-pt,level=3D0x14\"");

The warning shouldn't be triggered if level is already >=3D 0x14.

It is probably a good idea to mention that this happens only on
pc-*-3.1 and older, as updating the machine-type is a better
solution to the problem than manually setting the "level"
property.

This will print the warning multiple times if there are multiple
VCPUs.  You can use warn_report_once() to avoid that.

>          }
> =20
>          /* CPU topology with multi-dies support requires CPUID[0x1F] */
> --=20
> 1.8.3.1
>=20

--=20
Eduardo


