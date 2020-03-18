Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BDC10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 18:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E1F20719
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBbZDSAB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E1F20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEd1H-0002ka-Qz
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 14:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEd0S-0002IG-Dq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 14:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEd0R-00010w-CR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 14:01:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEd0Q-0000wH-PE
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 14:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584554486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sDzFhs3KkKd460ctC4viVpm/p8DiyWw+yODRcZg3+iI=;
 b=iBbZDSABC1+5iCvkI0LpPDfC1laLj7kH1wLMA7fYbetbMutrecxeFCIYMZpGGNCirSIMhk
 P6AIWrXGq5UD9KNAiL3ZYVF9NrTjXcA/NP38q44AzXoanaFboNEXtJcauLMv5x8re70d6k
 NEZ6YRzCbdMNNSHPOppmG88w/JAKKk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-DK5mfmh8PaWx1KC_bc5XDw-1; Wed, 18 Mar 2020 14:01:24 -0400
X-MC-Unique: DK5mfmh8PaWx1KC_bc5XDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 802F6100550D;
 Wed, 18 Mar 2020 18:01:23 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F43B19757;
 Wed, 18 Mar 2020 18:01:19 +0000 (UTC)
Date: Wed, 18 Mar 2020 19:00:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 10/16] s390x: protvirt: Set guest IPL PSW
Message-ID: <20200318190043.1ba42bb2.cohuck@redhat.com>
In-Reply-To: <20200318143047.2335-11-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-11-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 10:30:41 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Handling of CPU reset and setting of the IPL psw from guest storage at
> offset 0 is done by a Ultravisor call. Let's only fetch it if
> necessary.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  target/s390x/cpu.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 84029f14814b4980..3ec7d4b2ec1e938f 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -78,16 +78,24 @@ static bool s390_cpu_has_work(CPUState *cs)
>  static void s390_cpu_load_normal(CPUState *s)
>  {
>      S390CPU *cpu = S390_CPU(s);
> -    uint64_t spsw = ldq_phys(s->as, 0);
> -
> -    cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
> -    /*
> -     * Invert short psw indication, so SIE will report a specification
> -     * exception if it was not set.
> -     */
> -    cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
> -    cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
> +    uint64_t spsw;
>  
> +    if (!s390_is_pv()) {
> +        spsw = ldq_phys(s->as, 0);
> +        cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
> +        /*
> +         * Invert short psw indication, so SIE will report a specification
> +         * exception if it was not set.
> +         */
> +        cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
> +        cpu->env.psw.addr = spsw & PSW_MASK_SHORT_ADDR;
> +    } else {
> +        /*
> +         * Firmware requires us to set the load state before we set
> +         * the cpu to operating on protected guests.
> +         */
> +        s390_cpu_set_state(S390_CPU_STATE_LOAD, cpu);

We probably could do that unconditionally, but this is fine.

> +    }
>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
>  }
>  #endif

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


