Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60954C35243
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3156120704
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcgSiHft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3156120704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv07v-0004M7-EV
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 09:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iv06M-0002Wi-6v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iv06L-0002ri-9B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iv06L-0002qX-55
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 09:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579876704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYetcd5h3Wq+91aAYyWvkdyLOphK0l4o9PE3bHv320Y=;
 b=TcgSiHftZ+cm3S6jLsvjknCHxKZvPSbY+iPoRVLXTwbnstENuA9LgoEUqCicF/rARPXeeM
 krem/P5MuRQxT5BOblRLiUfVEAW+03FbsNjcpvYTumRonOygla77AcWUbLfK4ygzNZC/Gl
 ItW9bN+jBBqkMD0dWhTO2TkdvRc29Vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-5uS8GJERPBKl0Q0qSqacOA-1; Fri, 24 Jan 2020 09:38:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 915EE8B5DE2;
 Fri, 24 Jan 2020 14:38:20 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA5E60BEC;
 Fri, 24 Jan 2020 14:38:16 +0000 (UTC)
Date: Fri, 24 Jan 2020 15:38:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/s390x: Add a more verbose comment about
 get_machine_class() and the wrappers
Message-ID: <20200124153814.2e77bc74.cohuck@redhat.com>
In-Reply-To: <20200123170256.12386-1-thuth@redhat.com>
References: <20200123170256.12386-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5uS8GJERPBKl0Q0qSqacOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

On Thu, 23 Jan 2020 18:02:56 +0100
Thomas Huth <thuth@redhat.com> wrote:

> While working on the "Enable adapter interruption suppression again"
> recently, I had to discover that the meaning of get_machine_class()
> and the related *_allowed() wrappers is not very obvious. Add a more
> verbose comment here to clarify how these should be used.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Thanks, applied.


