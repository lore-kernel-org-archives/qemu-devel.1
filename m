Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77523C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63CF206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExyPyCi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63CF206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPp6f-0002GA-0b
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kPp4R-0000mS-U2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kPp4Q-0007kh-7d
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601998805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iVKzhPnNWnTR0T+C26GTxek83BgSeJCF9XBuHyTo+SM=;
 b=ExyPyCi5I54ShSFWy0D0A2/6oHjE7qjEETRHsUkUtzOd55V6MLqj63fMm57FiSVd2zNL2c
 oAslmBW24faTT/HTf0zJjygdNgD++zyN17jyEBJcqNEUUyfidbB69i/F96q7XNt2mCzZQE
 x1IooYlGSms3xHUQ6YFpWRvj8pV3WQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-ud2z3xMLP46eJ3pD_4YUxQ-1; Tue, 06 Oct 2020 11:40:01 -0400
X-MC-Unique: ud2z3xMLP46eJ3pD_4YUxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10D2D1868412;
 Tue,  6 Oct 2020 15:40:00 +0000 (UTC)
Received: from gondolin (ovpn-112-156.ams2.redhat.com [10.36.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 503EA55767;
 Tue,  6 Oct 2020 15:39:47 +0000 (UTC)
Date: Tue, 6 Oct 2020 17:39:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v2 4/9] linux-headers: update against 5.9-rc7
Message-ID: <20201006173944.611048c5.cohuck@redhat.com>
In-Reply-To: <1601669191-6731-5-git-send-email-mjrosato@linux.ibm.com>
References: <1601669191-6731-1-git-send-email-mjrosato@linux.ibm.com>
 <1601669191-6731-5-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, kvm@vger.kernel.org, pmorel@linux.ibm.com,
 david@redhat.com, schnelle@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 alex.williamson@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  2 Oct 2020 16:06:26 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> PLACEHOLDER as the kernel patch driving the need for this ("vfio-pci/zdev:
> define the vfio_zdev header") isn't merged yet.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  .../drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h         | 14 +++++++-------
>  linux-headers/linux/kvm.h                                  |  6 ++++--
>  linux-headers/linux/vfio.h                                 |  5 +++++
>  3 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> index 7b4062a..acd4c83 100644
> --- a/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> +++ b/include/standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_ring.h
> @@ -68,7 +68,7 @@ static inline int pvrdma_idx_valid(uint32_t idx, uint32_t max_elems)
>  
>  static inline int32_t pvrdma_idx(int *var, uint32_t max_elems)
>  {
> -	const unsigned int idx = qatomic_read(var);
> +	const unsigned int idx = atomic_read(var);

Hm... either this shouldn't have been renamed to qatomic_read() in the
first place, or we need to add some post-processing to the update
script.

>  
>  	if (pvrdma_idx_valid(idx, max_elems))
>  		return idx & (max_elems - 1);


