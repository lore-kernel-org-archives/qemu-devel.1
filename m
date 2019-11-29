Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E57C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E98020869
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4+zkO4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E98020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iafim-0002l3-Gj
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iafZp-0005Bo-Qd
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iafZj-0001HB-HK
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:40:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iafZi-0001Cy-Uq
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 07:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575031240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=hUQkvXzyTkBGb+nvxolHSFWIGiF/haKM9Encaeizypc=;
 b=S4+zkO4Cy7MM05vYWNxY7KbSnOercU41twWMUhReg905FHsZbe5LvFINSL4B+npNSBD7T8
 NIMk/qWSGm+WdWBqlhaMB8jOqLO7nGEHQYQOJ0D/SKFNsCQAiPJC5HOtkczAppHxtPAPNs
 BKsY6aKnTYXrrFtxltLsYDWx1TiCLBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-z4z6Eek4M6e6UbXoB2b82A-1; Fri, 29 Nov 2019 07:40:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7A32DB20;
 Fri, 29 Nov 2019 12:40:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AABAD60BE2;
 Fri, 29 Nov 2019 12:40:29 +0000 (UTC)
Subject: Re: [PATCH v2 01/13] s390x: protvirt: Add diag308 subcodes 8 - 10
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-2-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <97db1c4b-bc9e-9db0-424d-6cd3ba348e78@redhat.com>
Date: Fri, 29 Nov 2019 13:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129094809.26684-2-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: z4z6Eek4M6e6UbXoB2b82A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 10.47, Janosch Frank wrote:
[...]
> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> 3 and then the 8 and 10 combination for a protected reboot.

So if 8-10 are not valid in protected mode...

> @@ -59,6 +61,9 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  #define DIAG308_LOAD_NORMAL_DUMP    4
>  #define DIAG308_SET                 5
>  #define DIAG308_STORE               6
> +#define DIAG308_PV_SET              8
> +#define DIAG308_PV_STORE            9
> +#define DIAG308_PV_START            10
>  
>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>                                uintptr_t ra, bool write)
> @@ -105,6 +110,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>          break;
>      case DIAG308_SET:
> +    case DIAG308_PV_SET:

... should you maybe add a check here (and the other cases) to make sure
that the guest is currently not running in PV mode? Or is this taken
care of by the Ultravisor already?

>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>              return;
>          }
> @@ -117,7 +123,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>  
>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
>  
> -        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
> +        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
> +            !(iplb_valid_se(iplb) && s390_ipl_pv_check_comp(iplb) >= 0)) {
>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
>              goto out;
>          }
> @@ -128,10 +135,15 @@ out:
>          g_free(iplb);
>          return;
>      case DIAG308_STORE:
> +    case DIAG308_PV_STORE:
>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>              return;
>          }
> -        iplb = s390_ipl_get_iplb();
> +        if (subcode == DIAG308_PV_STORE) {
> +            iplb = s390_ipl_get_iplb_secure();
> +        } else {
> +            iplb = s390_ipl_get_iplb();
> +        }
>          if (iplb) {
>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
>              env->regs[r1 + 1] = DIAG_308_RC_OK;
> @@ -139,6 +151,16 @@ out:
>              env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
>          }
>          return;
> +        break;

Please remove the break. Or the return. But let's not do both.

> +    case DIAG308_PV_START:
> +        iplb = s390_ipl_get_iplb_secure();
> +        if (!iplb_valid_se(iplb)) {
> +            env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
> +            return;
> +        }
> +
> +        s390_ipl_reset_request(cs, S390_RESET_PV);
> +        break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          break;
> 

 Thomas


