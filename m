Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29171C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABE121D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cw/NpE7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABE121D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJx5-0002wL-5i
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBJw8-00022l-7n
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBJw2-0003gu-P1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:03:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29397
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBJw2-0003gD-LF
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583766194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onvmzExfSXPMPC/nCf1sm4xy6zPMEccejSPAL5cCZUg=;
 b=Cw/NpE7teRs4XXFsliOiibwanZ211YIEwdgU6uLijkhdz5K4wnlFMMVVc4G/hkS8ExYspa
 OYZ28r8VO+5vp+XF2i5KWY4I+de7Jaah68TzWW54yIa9vdpC8J85JPVtNr+FnrbLKkIlsX
 XKHlSd87u4QjJkR6mHlm5Ffw89zt3vU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-mnLq_bN3MWOidwZbYhEWDA-1; Mon, 09 Mar 2020 11:03:09 -0400
X-MC-Unique: mnLq_bN3MWOidwZbYhEWDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CFCF800D55;
 Mon,  9 Mar 2020 15:03:08 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD89F7389B;
 Mon,  9 Mar 2020 15:03:03 +0000 (UTC)
Date: Mon, 9 Mar 2020 16:03:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 13/16] target/i386: Add EPYC model specific handlers
Message-ID: <20200309160301.00243403@Igors-MacBook-Pro>
In-Reply-To: <158326549681.40452.14219781294371149597.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326549681.40452.14219781294371149597.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Mar 2020 13:58:16 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Add the new EPYC model specific handlers to fix the apicid decoding.
>=20
> The APIC ID is decoded based on the sequence sockets->dies->cores->thread=
s.
> This works fine for most standard AMD and other vendors' configurations,
> but this decoding sequence does not follow that of AMD's APIC ID enumerat=
ion
> strictly. In some cases this can cause CPU topology inconsistency.
>=20
> When booting a guest VM, the kernel tries to validate the topology, and f=
inds
> it inconsistent with the enumeration of EPYC cpu models. The more details=
 are
> in the bug https://bugzilla.redhat.com/show_bug.cgi?id=3D1728166.
>=20
> To fix the problem we need to build the topology as per the Processor
> Programming Reference (PPR) for AMD Family 17h Model 01h, Revision B1
> Processors.
> It is available at https://www.amd.com/system/files/TechDocs/55570-B1_PUB=
.zip
>=20
> Here is the text from the PPR.
> Operating systems are expected to use Core::X86::Cpuid::SizeId[ApicIdSize=
], the
> number of least significant bits in the Initial APIC ID that indicate cor=
e ID
> within a processor, in constructing per-core CPUID masks.
> Core::X86::Cpuid::SizeId[ApicIdSize] determines the maximum number of cor=
es
> (MNC) that the processor could theoretically support, not the actual numb=
er of
> cores that are actually implemented or enabled on the processor, as indic=
ated
> by Core::X86::Cpuid::SizeId[NC].
> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> =E2=80=A2 ApicId[6] =3D Socket ID.
> =E2=80=A2 ApicId[5:4] =3D Node ID.
> =E2=80=A2 ApicId[3] =3D Logical CCX L3 complex ID
> =E2=80=A2 ApicId[2:0]=3D (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,Lo=
gicalCoreID[1:0]}
>=20
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f33d8b77f5..f870f7c55b 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3884,6 +3884,10 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>          .xlevel =3D 0x8000001E,
>          .model_id =3D "AMD EPYC Processor",
>          .cache_info =3D &epyc_cache_info,
> +        .apicid_from_cpu_idx =3D x86_apicid_from_cpu_idx_epyc,
> +        .topo_ids_from_apicid =3D x86_topo_ids_from_apicid_epyc,
> +        .apicid_from_topo_ids =3D x86_apicid_from_topo_ids_epyc,
> +        .apicid_pkg_offset =3D apicid_pkg_offset_epyc,
>          .versions =3D (X86CPUVersionDefinition[]) {
>              { .version =3D 1 },
>              {
>=20
>=20


