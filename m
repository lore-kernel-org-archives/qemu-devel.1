Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FDEC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1747420801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 10:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY4J0sDG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1747420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ikf-00063n-0C
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 05:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j4ik2-0005cA-5y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:07:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j4ik0-0002ft-Vd
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:07:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j4ik0-0002fM-SW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 05:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582193252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7retPiAYF6ZmW5d0EvUq3S7ujCtqNbot8VYoPo/dc8=;
 b=fY4J0sDGCmkaI+HdjmVvKDanxQCMGpfg9/OXVayvkFXVmLOBRtTelOlQHYXPJsqSKSdQFJ
 8C/kmc1Bt1D5Ix0FrngPlkK27Mpb7e5oCy2EiYY2RYTdjcF1yKGJ2zX+54dbchzUlXxvMC
 XfbfwR8RRUTmoASYxFJq2EMDt6A0Rl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-osY38M3sMG-mgVWpDRT4lA-1; Thu, 20 Feb 2020 05:07:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAADA800EB4;
 Thu, 20 Feb 2020 10:07:27 +0000 (UTC)
Received: from gondolin (ovpn-205-37.brq.redhat.com [10.40.205.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 810B45DA76;
 Thu, 20 Feb 2020 10:07:23 +0000 (UTC)
Date: Thu, 20 Feb 2020 11:07:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 04/17] s390x: protvirt: Add diag308 subcodes 8 - 10
Message-ID: <20200220110720.6142d055.cohuck@redhat.com>
In-Reply-To: <20200214151636.8764-5-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200214151636.8764-5-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: osY38M3sMG-mgVWpDRT4lA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 10:16:23 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
> holds the address and length of the secure execution header, as well
> as a list of guest components.
> 
> Each component is a block of memory, for example kernel or initrd,
> which needs to be decrypted by the Ultravisor in order to run a
> protected VM. The secure execution header instructs the Ultravisor on
> how to handle the protected VM and its components.
> 
> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
> start the protected guest.
> 
> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> 3 and then the 8 and 10 combination for a protected reboot.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/ipl.c      | 48 ++++++++++++++++++++++++++++++++++++++++++---
>  hw/s390x/ipl.h      | 31 +++++++++++++++++++++++++++++
>  target/s390x/diag.c | 27 ++++++++++++++++++++++---
>  3 files changed, 100 insertions(+), 6 deletions(-)

(...)

>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>  {
>      S390IPLState *ipl = get_ipl_device();
>  
> -    ipl->iplb = *iplb;
> -    ipl->iplb_valid = true;
> +    if (iplb->pbt == 5) {

Magic value; maybe introduce a #define or at least a comment?

> +        ipl->iplb_pbt5 = *iplb;
> +        ipl->iplb_valid_pbt5 = true;
> +    } else {
> +        ipl->iplb = *iplb;
> +        ipl->iplb_valid = true;
> +    }
>      ipl->netboot = is_virtio_net_device(iplb);
>  }

> @@ -133,6 +154,7 @@ struct S390IPLState {
>      /*< private >*/
>      DeviceState parent_obj;
>      IplParameterBlock iplb;
> +    IplParameterBlock iplb_pbt5;

Add /* for protected virtualization */ ?

Or, if this is not used for anything else, call it iplb_pv?

>      QemuIplParameters qipl;
>      uint64_t start_addr;
>      uint64_t compat_start_addr;

(...)

> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index b5aec06d6b..4ba6033609 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -52,6 +52,8 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
>  #define DIAG_308_RC_OK              0x0001
>  #define DIAG_308_RC_NO_CONF         0x0102
>  #define DIAG_308_RC_INVALID         0x0402
> +#define DIAG_308_RC_NO_PV_CONF      0x0a02
> +#define DIAG_308_RC_INV_FOR_PV      0x0b02

DIAG_308_RC_INVAL_FOR_PV ?

>  
>  #define DIAG308_RESET_MOD_CLR       0
>  #define DIAG308_RESET_LOAD_NORM     1

(...)

> @@ -128,17 +135,31 @@ out:
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

iplb = (subcode == DIAG308_PV_STORE) ?
       s390_ipl_get_iplb_secure() : s390_ipl_get_iplb();

Matter of taste, I guess.

>          if (iplb) {
>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
>              env->regs[r1 + 1] = DIAG_308_RC_OK;
>          } else {
>              env->regs[r1 + 1] = DIAG_308_RC_NO_CONF;
>          }
> -        return;
> +        break;
> +    case DIAG308_PV_START:
> +        iplb = s390_ipl_get_iplb_secure();
> +        if (!iplb || !iplb_valid_pv(iplb)) {
> +            env->regs[r1 + 1] = DIAG_308_RC_NO_PV_CONF;
> +            return;
> +        }
> +
> +        s390_ipl_reset_request(cs, S390_RESET_PV);
> +        break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          break;


