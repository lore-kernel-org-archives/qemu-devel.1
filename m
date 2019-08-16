Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB989C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811912086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 14:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811912086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycvK-0004SW-ED
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 10:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1hycsJ-0000Sn-La
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hycsI-00011Q-Jj
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hycsI-00010t-Dv
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 10:06:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A23E746672;
 Fri, 16 Aug 2019 14:06:37 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39B1483BBB;
 Fri, 16 Aug 2019 14:06:26 +0000 (UTC)
Date: Fri, 16 Aug 2019 16:06:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190816160625.4cfd4b06@redhat.com>
In-Reply-To: <20190815183803.13346-3-ehabkost@redhat.com>
References: <20190815183803.13346-1-ehabkost@redhat.com>
 <20190815183803.13346-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 16 Aug 2019 14:06:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] pc: Improve error message when die-id
 is omitted
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
Cc: Peter Krempa <pkrempa@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 15 Aug 2019 15:38:02 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> The error message when die-id is omitted doesn't make sense:
> 
>   $ qemu-system-x86_64 -smp 1,sockets=6,maxcpus=6 \
>     -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0
>   qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0: \
>     Invalid CPU die-id: 4294967295 must be in range 0:0
> 
> Fix it, so it will now read:
> 
>   qemu-system-x86_64: -device qemu64-x86_64-cpu,socket-id=1,core-id=0,thread-id=0: \
>     CPU die-id is not set
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 24b03bb49c..fb4ac5ca90 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2410,6 +2410,10 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>              error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
>                         cpu->socket_id, max_socket);
>              return;
> +        }
> +        if (cpu->die_id < 0) {
> +            error_setg(errp, "CPU die-id is not set");
> +            return;
>          } else if (cpu->die_id > pcms->smp_dies - 1) {
>              error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
>                         cpu->die_id, pcms->smp_dies - 1);


