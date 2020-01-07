Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF55C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EE42080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EE42080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iooV7-0007zv-Og
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iooLY-0006aj-4o
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iooLW-00080p-Tw
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:52:31 -0500
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:48287)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iooLW-00080B-Nn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:52:30 -0500
Received: from player729.ha.ovh.net (unknown [10.108.42.66])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 3A80111D2FF
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 13:52:29 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 95A3AE142458;
 Tue,  7 Jan 2020 12:52:17 +0000 (UTC)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH v2 01/10] ppc: Drop PPC_EMULATE_32BITS_HYPV stub
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 groug@kaod.org, philmd@redhat.com
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-2-david@gibson.dropbear.id.au>
Message-ID: <64259936-5392-6eb4-3c4e-2f4fa901ea57@kaod.org>
Date: Tue, 7 Jan 2020 13:52:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107044827.471355-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9154973617539550091
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhuffvfhfkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedvledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.72.238
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
Cc: lvivier@redhat.com, aik@ozlabs.ru,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, paulus@samba.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 5:48 AM, David Gibson wrote:
> The only effect of the PPC_EMULATE_32BITS_HYPV define is to change how
> MSR_HVB is defined.  This appears to be something to handle hypervisor =
mode
> for 32-bit CPUs, but there's really no other code to handle this.  The
> MSR_THV bit, which it uses is implemented for no cpus we model.
>=20
> It's unlikely anyone is going to implement this any time soon, so just =
drop
> it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  target/ppc/cpu.h | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 103bfe9dc2..2de9e2fa2b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -26,8 +26,6 @@
>  #include "exec/cpu-defs.h"
>  #include "cpu-qom.h"
> =20
> -/* #define PPC_EMULATE_32BITS_HYPV */
> -
>  #define TCG_GUEST_DEFAULT_MO 0
> =20
>  #define TARGET_PAGE_BITS_64K 16

btw, this define ^ is unused.

> @@ -450,14 +448,9 @@ typedef struct ppc_v3_pate_t {
>  #define MSR_HVB (1ULL << MSR_SHV)
>  #define msr_hv  msr_shv
>  #else
> -#if defined(PPC_EMULATE_32BITS_HYPV)
> -#define MSR_HVB (1ULL << MSR_THV)
> -#define msr_hv  msr_thv
> -#else
>  #define MSR_HVB (0ULL)
>  #define msr_hv  (0)
>  #endif
> -#endif
> =20
>  /* DSISR */
>  #define DSISR_NOPTE              0x40000000
>=20


