Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19094C606AC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 11:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33F120861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 11:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33F120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkS12-0000z7-T1
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 07:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hkRz8-0000Ls-3U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hkRz6-00043A-2p
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 07:39:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hkRz5-0003oY-SD; Mon, 08 Jul 2019 07:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12A55C055676;
 Mon,  8 Jul 2019 11:38:35 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE375C22B;
 Mon,  8 Jul 2019 11:38:28 +0000 (UTC)
Date: Mon, 8 Jul 2019 13:38:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190708133826.737cdd23.cohuck@redhat.com>
In-Reply-To: <20190705153249.12525-1-borntraeger@de.ibm.com>
References: <20190705153249.12525-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 08 Jul 2019 11:38:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] s390x/cpumodel: Set up CPU model for AQIC
 interception
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  5 Jul 2019 17:32:49 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Let's add support for the AP-Queue interruption facility to the CPU
> model.
> 
> The S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, CPU facility indicates
> whether the PQAP instruction with the AQIC command is available
> to the guest.
> This feature will be enabled only if the AP instructions are
> available on the linux host and AQIC facility is installed on
> the host.
> 
> This feature must be turned on from userspace to intercept AP
> instructions on the KVM guest. The QEMU command line to turn
> this feature on looks something like this:
> 
>     qemu-system-s390x ... -cpu xxx,apqi=on ...
> or
>     ... -cpu host
> 
> Right now AP pass-through devices do not support migration,
> which means that we do not have to take care of migrating
> the interrupt data:
> virsh migrate apguest --live qemu+ssh://root@target.lan/system
> error: Requested operation is not valid: domain has assigned non-USB host devices
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> [rebase to newest qemu and fixup description]
> ---
>  target/s390x/cpu_features_def.inc.h | 1 +
>  target/s390x/cpu_models.c           | 1 +
>  target/s390x/gen-features.c         | 1 +
>  3 files changed, 3 insertions(+)

While technically a tad late for 4.1, this is a small and
straightforward patch (that already had been on the list earlier), so I
went ahead and applied it.

