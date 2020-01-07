Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B52EC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC7E2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC7E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosKV-0004Vy-1A
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iosIo-0001w4-I6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iosIn-0006qu-6F
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:05:58 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:47045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iosIm-0006q0-Ve
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:05:57 -0500
Received: from player774.ha.ovh.net (unknown [10.109.143.216])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id BA8C68B499
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 18:05:54 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player774.ha.ovh.net (Postfix) with ESMTPSA id DCA60E06B455;
 Tue,  7 Jan 2020 17:05:42 +0000 (UTC)
Date: Tue, 7 Jan 2020 18:05:39 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 01/10] ppc: Drop PPC_EMULATE_32BITS_HYPV stub
Message-ID: <20200107180539.57ba0781@bahia.lan>
In-Reply-To: <20200107044827.471355-2-david@gibson.dropbear.id.au>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13434800640545233382
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehhedgtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.227
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, paulus@samba.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 Jan 2020 15:48:18 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> The only effect of the PPC_EMULATE_32BITS_HYPV define is to change how
> MSR_HVB is defined.  This appears to be something to handle hypervisor mode
> for 32-bit CPUs, but there's really no other code to handle this.  The
> MSR_THV bit, which it uses is implemented for no cpus we model.
> 
> It's unlikely anyone is going to implement this any time soon, so just drop
> it.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/cpu.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 103bfe9dc2..2de9e2fa2b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -26,8 +26,6 @@
>  #include "exec/cpu-defs.h"
>  #include "cpu-qom.h"
>  
> -/* #define PPC_EMULATE_32BITS_HYPV */
> -
>  #define TCG_GUEST_DEFAULT_MO 0
>  
>  #define TARGET_PAGE_BITS_64K 16
> @@ -450,14 +448,9 @@ typedef struct ppc_v3_pate_t {
>  #define MSR_HVB (1ULL << MSR_SHV)
>  #define msr_hv  msr_shv
>  #else
> -#if defined(PPC_EMULATE_32BITS_HYPV)
> -#define MSR_HVB (1ULL << MSR_THV)
> -#define msr_hv  msr_thv
> -#else

These lines come from commit a4f30719a8cd, which also introduced msr_thv
and msr_shv to differentiate the 32 and 64 bits HV mode. Maybe you can go
one step further: drop msr_thv and msr_shv and revert to msr_hv only, like
before a4f30719a8cd ?

>  #define MSR_HVB (0ULL)
>  #define msr_hv  (0)
>  #endif
> -#endif
>  
>  /* DSISR */
>  #define DSISR_NOPTE              0x40000000


