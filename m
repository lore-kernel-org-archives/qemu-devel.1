Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8C7C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DCD205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKHcIUbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DCD205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDoGg-00007O-NN
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jDnbM-0001uo-8S
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jDnbK-0000yw-VU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:08:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jDnbK-0000cO-Nc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584356885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLnbFyB1eV6nEdIYefNiKAvHZQY1co2NQx+tEzEcItA=;
 b=TKHcIUbSIbzCFISA66pxmH8LxqUtl7Y6M0F78ONV8/z4FIaA/k+c2yYRjvJQ8CRGcDtjIp
 ELomm6dHOwmy9eUr3+el6cnT1LLLvmRX/PPQMuMfZWPqNzSSHIzbGoyIixvo/ZWyIFQ9sT
 yEvfQeF3n/XyUEGR0LUZPwr887A4o1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-nUx1xulgPcSEsQGuTikr8g-1; Mon, 16 Mar 2020 07:08:01 -0400
X-MC-Unique: nUx1xulgPcSEsQGuTikr8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6171F801E70;
 Mon, 16 Mar 2020 11:08:00 +0000 (UTC)
Received: from gondolin (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBAA85C1B2;
 Mon, 16 Mar 2020 11:07:52 +0000 (UTC)
Date: Mon, 16 Mar 2020 12:07:50 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jay Zhou <jianjay.zhou@huawei.com>
Subject: Re: [PATCH] kvm: support to get/set dirty log initial-all-set
 capability
Message-ID: <20200316120750.509149ab.cohuck@redhat.com>
In-Reply-To: <20200304025554.2159-1-jianjay.zhou@huawei.com>
References: <20200304025554.2159-1-jianjay.zhou@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: liu.jinsong@huawei.com, weidong.huang@huawei.com, kvm@vger.kernel.org,
 mst@redhat.com, wangxinxin.wang@huawei.com, qemu-devel@nongnu.org,
 peterx@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Mar 2020 10:55:54 +0800
Jay Zhou <jianjay.zhou@huawei.com> wrote:

> Since the new capability KVM_DIRTY_LOG_INITIALLY_SET of
> KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 has been introduced in the
> kernel, tweak the userspace side to detect and enable this
> capability.
> 
> Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> ---
>  accel/kvm/kvm-all.c       | 21 ++++++++++++++-------
>  linux-headers/linux/kvm.h |  3 +++
>  2 files changed, 17 insertions(+), 7 deletions(-)

<standard message>
Please do any linux-headers updates in a separate patch; that makes it
easy to replace the manual update with a complete headers update.
</standard message>

:)


