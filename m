Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA4ECE595
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308A52089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308A52089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIFj-0005Ft-CN
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iKIEI-0004Fr-M9
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iKIEG-0002a1-2L
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iKIEF-0002Yx-TA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:30:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB852BCFE0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 08:30:49 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B24D5D6B0;
 Tue, 15 Oct 2019 08:30:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 2/2] apic: Use 32bit APIC ID for migration instance ID
In-Reply-To: <20191015075444.10955-3-peterx@redhat.com> (Peter Xu's message of
 "Tue, 15 Oct 2019 15:54:44 +0800")
References: <20191015075444.10955-1-peterx@redhat.com>
 <20191015075444.10955-3-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 15 Oct 2019 10:30:44 +0200
Message-ID: <87v9sqqukr.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 15 Oct 2019 08:30:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: quintela@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> wrote:
> Migration is silently broken now with x2apic config like this:
>
>      -smp 200,maxcpus=288,sockets=2,cores=72,threads=2 \
>      -device intel-iommu,intremap=on,eim=on
>
> After migration, the guest kernel could hang at anything, due to
> x2apic bit not migrated correctly in IA32_APIC_BASE on some vcpus, so
> any operations related to x2apic could be broken then (e.g., RDMSR on
> x2apic MSRs could fail because KVM would think that the vcpu hasn't
> enabled x2apic at all).
>
> The issue is that the x2apic bit was never applied correctly for vcpus
> whose ID > 255 when migrate completes, and that's because when we
> migrate APIC we use the APICCommonState.id as instance ID of the
> migration stream, while that's too short for x2apic.
>
> Let's use the newly introduced initial_apic_id for that.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/intc/apic_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index aafd8e0e33..6024a3e06a 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -315,7 +315,7 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
>      APICCommonState *s = APIC_COMMON(dev);
>      APICCommonClass *info;
>      static DeviceState *vapic;
> -    int instance_id = s->id;
> +    int64_t instance_id = s->initial_apic_id;

int is ok here.

But damn thing, initial_apic_id is uint32_t.  Sniff.

Later, Juan.

