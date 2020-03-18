Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD415C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A782C20752
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBr4RPd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A782C20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEbnh-00037L-TE
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 12:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEbn7-0002bv-Gq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEbn6-0003z3-Gr
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:43:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEbn6-0003xq-Cj
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584549815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZR0AOLpqPjE0K3iF3bC4S2fZcphvsNyJ+6EpW3pk98=;
 b=hBr4RPd/zj3o+oI8MpQok4sZZVucyrfSSGgOf+yX9bZGW35fkZCKminL+Cff1zSjhK/ETG
 +5xBPtBeAvklF6eFi2EWeYnhJcJ7uGRTTPV2JFGM8HvVYn03x4gGh6Ly7QolmzkvOywBXt
 m7wHYmQTsaH/0/R6FS9RSoKItwMKfto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-7Y0PQm-_N221DM1zAkaiDQ-1; Wed, 18 Mar 2020 12:43:33 -0400
X-MC-Unique: 7Y0PQm-_N221DM1zAkaiDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FE9518A5528;
 Wed, 18 Mar 2020 16:43:32 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10EC460BF1;
 Wed, 18 Mar 2020 16:43:27 +0000 (UTC)
Date: Wed, 18 Mar 2020 17:43:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 16/16] s390x: Add unpack facility feature to GA1
Message-ID: <20200318174323.0001eb7c.cohuck@redhat.com>
In-Reply-To: <20200318143047.2335-17-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-17-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 10:30:47 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> The unpack facility is an indication that diagnose 308 subcodes 8-10
> are available to the guest. That means, that the guest can put itself
> into protected mode.
> 
> Once it is in protected mode, the hardware stops any attempt of VM
> introspection by the hypervisor.
> 
> Some features are currently not supported in protected mode:
>      * vfio devices
>      * Migration
>      * Huge page backings
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/gen-features.c | 1 +
>  target/s390x/kvm.c          | 8 ++++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


