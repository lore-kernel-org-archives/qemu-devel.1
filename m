Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D17C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CF820866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CF820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazAL-0008I3-Mh
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:03:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39037)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1haz6Q-000688-V5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1haz5h-00051R-5h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:58:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1haz5d-0004zq-JP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCFE331628E1;
 Wed, 12 Jun 2019 08:58:39 +0000 (UTC)
Received: from work-vm (ovpn-117-119.ams2.redhat.com [10.36.117.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B1426FC1;
 Wed, 12 Jun 2019 08:58:38 +0000 (UTC)
Date: Wed, 12 Jun 2019 09:58:36 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190612085834.GA2691@work-vm>
References: <20190611205420.20286-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611205420.20286-1-ehabkost@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 12 Jun 2019 08:58:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386: Don't print warning if phys-bits was
 set automatically
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, xuelian.guo@intel.com,
 qemu-devel@nongnu.org, Robert Hoo <robert.hu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eduardo Habkost (ehabkost@redhat.com) wrote:
> If cpu->host_phys_bits_limit is set, QEMU will make
> cpu->phys_bits be lower than host_phys_bits on some cases.  This
> triggers a warning that was supposed to be printed only if
> phys-bits was explicitly set in the command-line.
> 
> Reorder the code so the value of cpu->phys_bits is validated
> before the cpu->host_phys_bits handling.  This will avoid
> unexpected warnings when cpu->host_phys_bits_limit is set.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

I think that's OK; note I think that means you can trigger an erroneous
warning in the case where the user does something odd like:

 phys_bits=50,host_phys_bits=true

so you print the warning and *then* set phys_bits = host_phys_bits.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> ---
>  target/i386/cpu.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 7e5b545005..1327e4901a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5269,15 +5269,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>              uint32_t host_phys_bits = x86_host_phys_bits();
>              static bool warned;
>  
> -            if (cpu->host_phys_bits) {
> -                /* The user asked for us to use the host physical bits */
> -                cpu->phys_bits = host_phys_bits;
> -                if (cpu->host_phys_bits_limit &&
> -                    cpu->phys_bits > cpu->host_phys_bits_limit) {
> -                    cpu->phys_bits = cpu->host_phys_bits_limit;
> -                }
> -            }
> -
>              /* Print a warning if the user set it to a value that's not the
>               * host value.
>               */
> @@ -5289,6 +5280,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>                  warned = true;
>              }
>  
> +            if (cpu->host_phys_bits) {
> +                /* The user asked for us to use the host physical bits */
> +                cpu->phys_bits = host_phys_bits;
> +                if (cpu->host_phys_bits_limit &&
> +                    cpu->phys_bits > cpu->host_phys_bits_limit) {
> +                    cpu->phys_bits = cpu->host_phys_bits_limit;
> +                }
> +            }
> +
>              if (cpu->phys_bits &&
>                  (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
>                  cpu->phys_bits < 32)) {
> -- 
> 2.18.0.rc1.1.g3f1ff2140
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

