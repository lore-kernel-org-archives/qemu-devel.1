Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E11CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:11:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09ADC222EF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 22:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCOFjK+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ADC222EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWpFM-0003vI-5B
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 17:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iWpEE-0003CJ-Re
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iWpED-0008PX-Ln
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:10:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iWpED-0008ON-Hn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 17:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574115037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Omfivgs4XMi5K8M+7Ng0NhYERfuOgUHEor1cEUSt570=;
 b=gCOFjK+ZA5IgD3D4NuP5d4WDWiITMJ3gmhLPTDDLSpgFu3ea2jJdqeuKbE8vMeIgPDsBzD
 F7Jf0/hdXql+UUYQ45k0s7E9AsppCZCMBvBzhGkh4MVkwoX5XoHM5ms1/xVO3hDtsMNOuG
 NVCIK13TZ7YpSHQe55NssEZcNBxm514=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-KlLlxV70P12N1XGSmEIedQ-1; Mon, 18 Nov 2019 17:10:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 913072F63;
 Mon, 18 Nov 2019 22:10:32 +0000 (UTC)
Received: from localhost (ovpn-116-6.gru2.redhat.com [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A4B78918;
 Mon, 18 Nov 2019 22:10:31 +0000 (UTC)
Date: Mon, 18 Nov 2019 19:10:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH] target/i386: Remove monitor from some CPU model
Message-ID: <20191118221030.GG3812@habkost.net>
References: <20191115083345.22638-1-tao3.xu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191115083345.22638-1-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: KlLlxV70P12N1XGSmEIedQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Fri, Nov 15, 2019 at 04:33:45PM +0800, Tao Xu wrote:
> Add new version of Snowridge, Denverton, Opteron_G3, EPYC, and Dhyana
> CPU model to remove MONITOR/MWAIT feature.
>=20
> After QEMU/KVM use "-overcommit cpu-pm=3Don" to expose MONITOR/MWAIT
> (commit id 6f131f13e68d648a8e4f083c667ab1acd88ce4cd), the MONITOR/MWAIT
> feature in these CPU model is unused.
>=20
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  target/i386/cpu.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a624163ac2..7c5f1e8fe0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2770,6 +2770,19 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>              MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY,
>          .xlevel =3D 0x80000008,
>          .model_id =3D "Intel Atom Processor (Denverton)",
> +        .versions =3D (X86CPUVersionDefinition[]) {
> +            { .version =3D 1 },
> +            {
> +                .version =3D 2,
> +                .props =3D (PropValue[]) {
> +                    { "monitor", "off" },
> +                    { "model-id",
> +                      "Intel Atom Processor (Denverton, no MONITOR)" },

We never changed model-id when adding/removing features in
machine-type code, and I don't see why we should start doing that
now.  This info might be helpful on "-cpu help", but probably
confusing for people looking at /proc/cpuinfo inside the VM.

If you think it is important to add extra info to "-cpu help", I
suggest you send a patch adding a separate field instead of
changing model ID on CPUID.

> [...]

--=20
Eduardo


