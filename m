Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6767ECE59D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7EE2086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7EE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKZHO-0007gI-PA
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 22:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKZGk-00079Y-F1
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKZGi-0002Kr-Qg
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:42:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKZGi-0002KS-LG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:42:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 884C410CC1F8
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:42:31 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0801E5C1D6;
 Wed, 16 Oct 2019 02:42:28 +0000 (UTC)
Date: Tue, 15 Oct 2019 23:42:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 3/4] apic: Use 32bit APIC ID for migration instance ID
Message-ID: <20191016024227.GC4084@habkost.net>
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016022933.7276-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016022933.7276-4-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 16 Oct 2019 02:42:31 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 10:29:32AM +0800, Peter Xu wrote:
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

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo

