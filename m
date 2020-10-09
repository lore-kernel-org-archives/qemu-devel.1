Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AAAC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:51:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FDE2225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 09:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feL3NE+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FDE2225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQp3y-00082E-VP
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 05:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kQp2z-0007Ey-5x
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kQp2x-0006d7-IH
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 05:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602237041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gs3lWzl1KSrViM+P/tfK4cPR7lXHb836vmE15Zs9uk=;
 b=feL3NE+NQn7PXif9jfWfCLAzLT9bNTsnkPoO9evX3vjroBbDPHJDAwkCpDQ1GLu7xeSJwG
 OZJPNnKGOp06KnaRQMRssQ67De4tGurOKCUgW8LApDW9KsZ1+dzUzI8wyVbx/iVGZIyUUg
 ZhYHd2ZQ1+TanzaLAvSX52IVojFgENE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-6JDRg1R2OWC8-cQyAi8uSw-1; Fri, 09 Oct 2020 05:50:39 -0400
X-MC-Unique: 6JDRg1R2OWC8-cQyAi8uSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5988018A8230;
 Fri,  9 Oct 2020 09:50:38 +0000 (UTC)
Received: from gondolin (ovpn-113-40.ams2.redhat.com [10.36.113.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53EE019936;
 Fri,  9 Oct 2020 09:50:27 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:50:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v3 01/10] s390x/pci: Move header files to include/hw/s390x
Message-ID: <20201009115024.064d2ba0.cohuck@redhat.com>
In-Reply-To: <1602097455-15658-2-git-send-email-mjrosato@linux.ibm.com>
References: <1602097455-15658-1-git-send-email-mjrosato@linux.ibm.com>
 <1602097455-15658-2-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  7 Oct 2020 15:04:06 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Seems a more appropriate location for them.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  MAINTAINERS                              | 1 +
>  hw/s390x/s390-pci-bus.c                  | 4 ++--
>  hw/s390x/s390-pci-inst.c                 | 4 ++--
>  hw/s390x/s390-virtio-ccw.c               | 2 +-
>  {hw => include/hw}/s390x/s390-pci-bus.h  | 0
>  {hw => include/hw}/s390x/s390-pci-inst.h | 0
>  6 files changed, 6 insertions(+), 5 deletions(-)
>  rename {hw => include/hw}/s390x/s390-pci-bus.h (100%)
>  rename {hw => include/hw}/s390x/s390-pci-inst.h (100%)

Much better :)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

(I don't have anything on s390-next atm, or I would have queued it
straight away. Better wait until we can do a proper headers sync and
queue the whole thing.)


