Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAEFC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A8D222FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 16:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A8D222FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvOab-0004rs-La
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 12:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39626)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvOaE-0004Rt-V9
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvOaE-0004My-0D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvOaD-0004MG-RD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 12:14:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D28837BDB1;
 Wed,  7 Aug 2019 16:14:36 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A81F5D70D;
 Wed,  7 Aug 2019 16:14:35 +0000 (UTC)
Date: Wed, 7 Aug 2019 17:14:32 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190807161432.GJ2867@work-vm>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
 <20190806165429.19327-6-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806165429.19327-6-brijesh.singh@amd.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 07 Aug 2019 16:14:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 05/14] hw/machine: add helper to query
 the memory encryption state
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Singh, Brijesh (brijesh.singh@amd.com) wrote:
> To enable a memory encryption inside a VM, user must pass the object
> name used for the encryption in command line parameter as shown below.
> 
> # $(QEMU) \
>   -machine memory-encryption=<object_name>
> 
> Add a helper machine_memory_encryption_enabled() which will return a bool
> indicating whether the encryption object has been specified in the command
> line parameter.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

There's a check in accel/kvm/kvm-all.c:kvm_init which has:
       if (ms->memory_encryption) {

which you might want to replace by this.

Dave

> ---
>  hw/core/machine.c   | 5 +++++
>  include/hw/boards.h | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c58a8e594e..f1e1b3661f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1031,6 +1031,11 @@ bool machine_mem_merge(MachineState *machine)
>      return machine->mem_merge;
>  }
>  
> +bool machine_memory_encryption_enabled(MachineState *machine)
> +{
> +    return machine->memory_encryption ? true : false;
> +}
> +
>  static char *cpu_slot_to_string(const CPUArchId *cpu)
>  {
>      GString *s = g_string_new(NULL);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a71d1a53a5..c5446a39cf 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -76,6 +76,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
>                                 Error **errp);
>  
>  void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type);
> +bool machine_memory_encryption_enabled(MachineState *machine);
>  
>  
>  /**
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

