Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB90DC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760D420663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNFyG4wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760D420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEu0P-0007WL-Jk
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 08:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEtzo-00077G-Ed
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEtzm-0006O0-CL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:09:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:53566)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEtzm-0006No-8k
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584619793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqUfTg+zftVLqRgn3531E4ny7lnLeY4msKI0/WdDC+g=;
 b=ZNFyG4wr0ml23+bpdgHxSLWhrriQoY/v/GIW1ZlmtSPtxg+gfFTteDQV/a5HJFNhXtTJJl
 s94EI29hb7Th+6t8Iounmp8NylTHKGngcEMqdCJTT0eGn9Od2H7+MzfzEjFyPV8GMujz1o
 HE3f/GmQtPZ8Uox5koufgBonquu5HwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-GDwb0NKDM86Qbnjxeq295A-1; Thu, 19 Mar 2020 08:09:52 -0400
X-MC-Unique: GDwb0NKDM86Qbnjxeq295A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1881A107B271;
 Thu, 19 Mar 2020 12:09:51 +0000 (UTC)
Received: from gondolin (ovpn-113-188.ams2.redhat.com [10.36.113.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39C2091291;
 Thu, 19 Mar 2020 12:09:47 +0000 (UTC)
Date: Thu, 19 Mar 2020 13:09:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 09/16] s390x: protvirt: SCLP interpretation
Message-ID: <20200319130945.4134ed82.cohuck@redhat.com>
In-Reply-To: <20200318143047.2335-10-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-10-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

On Wed, 18 Mar 2020 10:30:40 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> SCLP for a protected guest is done over the SIDAD, so we need to use
> the s390_cpu_pv_mem_* functions to access the SIDAD instead of guest
> memory when reading/writing SCBs.
> 
> To not confuse the sclp emulation, we set 0x4000 as the SCCB address,
> since the function that injects the sclp external interrupt would
> reject a zero sccb address.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  hw/s390x/sclp.c         | 65 ++++++++++++++++++++++++++++++++++-------
>  include/hw/s390x/sclp.h |  2 ++
>  target/s390x/kvm.c      | 25 ++++++++++++----
>  3 files changed, 76 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index af0bfbc2eca74767..6486890fecea4b3c 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -33,6 +33,22 @@ static inline SCLPDevice *get_sclp_device(void)
>      return sclp;
>  }
>  
> +static inline bool sclp_command_code_valid(uint32_t code)
> +{
> +    switch (code & SCLP_CMD_CODE_MASK) {
> +    case SCLP_CMDW_READ_SCP_INFO:
> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
> +    case SCLP_CMDW_READ_CPU_INFO:
> +    case SCLP_CMDW_CONFIGURE_IOA:
> +    case SCLP_CMDW_DECONFIGURE_IOA:
> +    case SCLP_CMD_READ_EVENT_DATA:
> +    case SCLP_CMD_WRITE_EVENT_DATA:
> +    case SCLP_CMD_WRITE_EVENT_MASK:
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static void prepare_cpu_entries(SCLPDevice *sclp, CPUEntry *entry, int *count)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -193,6 +209,43 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>      }
>  }
>  
> +/*
> + * We only need the address to have something valid for the
> + * service_interrupt call.
> + */
> +#define SCLP_PV_DUMMY_ADDR 0x4000
> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
> +                                uint32_t code)
> +{
> +    SCLPDevice *sclp = get_sclp_device();
> +    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> +    SCCB work_sccb;
> +    hwaddr sccb_len = sizeof(SCCB);
> +
> +    /*
> +     * Only a very limited number of calls is permitted by the
> +     * Ultravisor and we support all of them, so we don't check for

This is no longer true, no?

> +     * them. All other specification exceptions are also interpreted
> +     * by the Ultravisor and hence never cause an exit we need to
> +     * handle.
> +     *
> +     * Setting the CC is also done by the Ultravisor.
> +     */
> +    s390_cpu_pv_mem_read(env_archcpu(env), 0, &work_sccb, sccb_len);
> +
> +    if (!sclp_command_code_valid(code)) {
> +        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
> +        goto out_write;
> +    }
> +
> +    sclp_c->execute(sclp, &work_sccb, code);
> +out_write:
> +    s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
> +                          be16_to_cpu(work_sccb.h.length));
> +    sclp_c->service_interrupt(sclp, SCLP_PV_DUMMY_ADDR);
> +    return 0;
> +}
> +
>  int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>  {
>      SCLPDevice *sclp = get_sclp_device();


