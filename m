Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFF3C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F878214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F878214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9uYR-0000wD-Kv
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i9uXH-00008j-SM
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i9uXC-0005dm-Ix
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1i9uXC-0005dH-DM; Mon, 16 Sep 2019 13:11:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CCDB9105787C;
 Mon, 16 Sep 2019 17:11:28 +0000 (UTC)
Received: from gondolin (ovpn-116-203.ams2.redhat.com [10.36.116.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C82260600;
 Mon, 16 Sep 2019 17:11:24 +0000 (UTC)
Date: Mon, 16 Sep 2019 19:11:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190916191121.6976ad5c.cohuck@redhat.com>
In-Reply-To: <20190913091443.27565-1-thuth@redhat.com>
References: <20190913091443.27565-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Mon, 16 Sep 2019 17:11:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x/kvm: Officially require at
 least kernel 3.15
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Sep 2019 11:14:43 +0200
Thomas Huth <thuth@redhat.com> wrote:

Modified the subject, as suggested by David.

> Since QEMU v2.10, the KVM acceleration does not work on older kernels
> anymore since the code accidentally requires the KVM_CAP_DEVICE_CTRL
> capability now - it should have been optional instead.
> Instead of fixing the bug, we asked in the ChangeLog of QEMU 2.11 - 3.0
> that people should speak up if they still need support of QEMU running
> with KVM on older kernels, but seems like nobody really complained.
> Thus let's make this official now and turn it into a proper error
> message, telling the users to use at least kernel 3.15 now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Remove also the entry in trace-events
> 
>  hw/intc/s390_flic_kvm.c | 6 ------
>  hw/intc/trace-events    | 1 -
>  target/s390x/kvm.c      | 7 +++++++
>  3 files changed, 7 insertions(+), 7 deletions(-)

(...)

> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 90c9d07c1a..719f46b516 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -75,7 +75,6 @@ xics_ics_simple_eoi(int nr) "ics_eoi: irq 0x%x"
>  
>  # s390_flic_kvm.c
>  flic_create_device(int err) "flic: create device failed %d"
> -flic_no_device_api(int err) "flic: no Device Contral API support %d"

Nice, this also gets rid of a typo :)

>  flic_reset_failed(int err) "flic: reset failed %d"
>  
>  # s390_flic.c

(...)

Thanks, applied.

