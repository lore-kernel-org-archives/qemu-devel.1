Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42ACC432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE06520833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 08:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T62K/5jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE06520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhXF-0005Z9-UL
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 03:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ibhWZ-00050V-AU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:57:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ibhWX-0003gb-SI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:57:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56145
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ibhWX-0003gA-PB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 03:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575277061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngT8rFyrxr9URc+BmHmjBXHpxNko3sg7tBGuivjsohY=;
 b=T62K/5jw1FzCg2QXiT56q/1twGo2lRUDiL7C2cjj1Q+J8OavRQtkafCeDN0+Dyq9Qg2BHo
 woVQJo7dSb+HmO9wkGcFwmLABkmc5pK6czhQSLIZgF68+thQpurKe7SgsTwIb4X+1i732f
 ftO1q6s2V8t/Mqp1fBCNd6DQ/OtKFfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-JhgNXvNdO_OiD6czMIXbIQ-1; Mon, 02 Dec 2019 03:57:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F04191005502;
 Mon,  2 Dec 2019 08:57:36 +0000 (UTC)
Received: from gondolin (ovpn-116-41.ams2.redhat.com [10.36.116.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F02F5C548;
 Mon,  2 Dec 2019 08:57:32 +0000 (UTC)
Date: Mon, 2 Dec 2019 09:57:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 0/3] s390x: Increase architectural compliance
Message-ID: <20191202095729.64cfbcc2.cohuck@redhat.com>
In-Reply-To: <20191129142025.21453-1-frankja@linux.ibm.com>
References: <20191129142025.21453-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JhgNXvNdO_OiD6czMIXbIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 09:20:22 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> On a diag 308 subcode 0 and 1 we need to load the whole reset PSW and
> not just the address.
> 
> On a cpu reset normal, we need to clear local cpus. Unfortunately we
> need a new API for that, since KVM only exposes one of the three
> resets.
> 
> Patches are also in my cleanup branch.
> 
> Janosch Frank (3):
>   s390x: Properly fetch and test the short psw on diag308 subc 0/1
>   Sync reset
>   s390x: protvirt: Add new VCPU reset functions
> 
>  linux-headers/linux/kvm.h |  7 +++++++
>  target/s390x/cpu.c        | 26 ++++++++++++++++++++++----
>  target/s390x/cpu.h        |  1 +
>  target/s390x/kvm-stub.c   | 10 +++++++++-
>  target/s390x/kvm.c        | 38 ++++++++++++++++++++++++++++++++------
>  target/s390x/kvm_s390x.h  |  4 +++-
>  6 files changed, 74 insertions(+), 12 deletions(-)
> 

Ok, it seems I should just go ahead and pick patch 1, and defer the
remainder until after we agree on the interface, right?


