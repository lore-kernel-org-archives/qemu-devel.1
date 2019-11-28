Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E07C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:50:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A098A216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnXgDAGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A098A216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaEZJ-000782-Kx
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 02:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaEXE-0006d2-Ov
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaEX9-0003bd-U9
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:48:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42260
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaEX8-0003Up-Je
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574927293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/bLg+p3M3zE0srE5Nrw81CsE3Hr/Xx5JuXdtlyC1oQ=;
 b=QnXgDAGmKn3ryL0UXLSVPbexucaqFRWV586SUxpq+meJAG5cJysmB/uj5ex2PkkbVtjWBY
 +z11LQGw9/flVOp+bcUzzeMqIRISSI7/N2KV0BGwKG+TcErL3Ldq9KbSG4xwG3eDgyYbUK
 IZpt9IRk6AooGWXzY625ARnh4kK3RAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-eBGhMt65Npiwldq0GD9Tug-1; Thu, 28 Nov 2019 02:48:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC1F218AAFA1;
 Thu, 28 Nov 2019 07:48:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7CE4600C8;
 Thu, 28 Nov 2019 07:48:02 +0000 (UTC)
Subject: Re: [PATCH v4 6/6] s390x: kvm: Make kvm_sclp_service_call void
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191127175046.4911-1-frankja@linux.ibm.com>
 <20191127175046.4911-7-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9f66d9d3-e212-dbb5-bf40-eabddf075344@redhat.com>
Date: Thu, 28 Nov 2019 08:48:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127175046.4911-7-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: eBGhMt65Npiwldq0GD9Tug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/11/2019 18.50, Janosch Frank wrote:
> It defaults to returning 0 anyway and that return value is not
> necessary, as 0 is also the default rc that the caller would return.
> 
> While doing that we can simplify the logic a bit and return early if
> we inject a PGM exception. Also we always set a 0 cc, so let's not
> base it on the rc of the sclp emulation functions.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   target/s390x/kvm.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 0c9d14b4b1..08bb1edca0 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1159,13 +1159,13 @@ void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t te_code)
>       kvm_s390_vcpu_interrupt(cpu, &irq);
>   }
>   
> -static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
> +static void kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>                                    uint16_t ipbh0)
>   {
>       CPUS390XState *env = &cpu->env;
>       uint64_t sccb;
>       uint32_t code;
> -    int r = 0;
> +    int r;
>   
>       sccb = env->regs[ipbh0 & 0xf];
>       code = env->regs[(ipbh0 & 0xf0) >> 4];
> @@ -1173,11 +1173,9 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>       r = sclp_service_call(env, sccb, code);
>       if (r < 0) {
>           kvm_s390_program_interrupt(cpu, -r);
> -    } else {
> -        setcc(cpu, r);
> +        return;
>       }
> -
> -    return 0;
> +    setcc(cpu, 0);

I think I'd also slightly prefer setcc(cpu, r) here ... but anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>


