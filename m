Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5FAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:25:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968FE2087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 16:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWjFH3lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968FE2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZrk-0008Tr-OG
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 11:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1itZqw-0007kU-IO
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1itZqs-0003uW-Mr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:24:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1itZqs-0003uK-JZ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 11:24:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579537474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdmJKveTcUArolR1AEkr8gohRf+HhNqm4hcL3OXbaoQ=;
 b=GWjFH3lxu34A6ui/7+faHZpJL7pC0LjfZQMTiiNvHtmzBNQa7fjmAtkDohRz12vUN99IsG
 UT7J7dPbLzPBb9iRShH/ENm2HlBrNQ6Iir/d84UBmh4J973IC7XX5FK7mj4Y5P7WalOGph
 2ZaYHkoSoUVfqf/JlI0IFB1RnCS1ndw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-UFaeh7n9NWyqGj61d-Vi6g-1; Mon, 20 Jan 2020 11:24:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C24DE8017CC;
 Mon, 20 Jan 2020 16:24:29 +0000 (UTC)
Received: from gondolin (ovpn-205-161.brq.redhat.com [10.40.205.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6556E1CB;
 Mon, 20 Jan 2020 16:24:25 +0000 (UTC)
Date: Mon, 20 Jan 2020 17:24:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3] target/s390x/kvm: Enable adapter interruption
 suppression again
Message-ID: <20200120172422.6528ecee.cohuck@redhat.com>
In-Reply-To: <20200120132441.11884-1-thuth@redhat.com>
References: <20200120132441.11884-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UFaeh7n9NWyqGj61d-Vi6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 14:24:41 +0100
Thomas Huth <thuth@redhat.com> wrote:

> The AIS feature has been disabled late in the v2.10 development cycle since
> there were some issues with migration (see commit 3f2d07b3b01ea61126b -
> "s390x/ais: for 2.10 stable: disable ais facility"). We originally wanted
> to enable it again for newer machine types, but apparently we forgot to do
> this so far. Let's do it for the new s390-ccw-virtio-5.0 machine now.
> 
> While at it, also add a more verbose comment why we need the *_allowed()
> wrappers in s390-virtio-ccw.c.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Moved "s390mc->kvm_ais_allowed = false" to the end of the function

We also might want to move the others in a followup patch, just to
avoid bad examples to copy/paste.

> 
>  hw/s390x/s390-virtio-ccw.c         | 20 +++++++++++++++++---
>  include/hw/s390x/s390-virtio-ccw.h |  3 +++
>  target/s390x/kvm.c                 |  9 ++++++---
>  3 files changed, 26 insertions(+), 6 deletions(-)

Looks good to me, will queue when I get a positive test result.


