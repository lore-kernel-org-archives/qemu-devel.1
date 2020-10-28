Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E5EC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD0E2220B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJKC4hEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD0E2220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXgiN-0000Q8-6B
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 04:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kXggw-0007uL-7p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kXggu-0002Mk-Lh
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603873219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arnxCOyMeskaT3QbJhB6l4HlxQ9o/QM2oZKbCmekm8s=;
 b=aJKC4hErFcQngZLMjaRqQe1rWIHMD0u6U7JNMbX+9NJH97ZB1jhm93/76pn6SpXfzFOVcU
 RVwIUYKpzJWXfD5LoXKIxqjkTwqD/GHLDLsG67gRy4nNWKVki7tTPcgacPZ1VIzXzagvDf
 KPU1xX7Pe1ZOOR7XC5Yd5Bw3RiMZpyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-NBVW9pcoMfWX4BAZPd5UuA-1; Wed, 28 Oct 2020 04:20:15 -0400
X-MC-Unique: NBVW9pcoMfWX4BAZPd5UuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE99410199AB;
 Wed, 28 Oct 2020 08:20:13 +0000 (UTC)
Received: from gondolin (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CA816EF5E;
 Wed, 28 Oct 2020 08:20:10 +0000 (UTC)
Date: Wed, 28 Oct 2020 09:20:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] kvm: Add a --enable-debug-kvm option to configure
Message-ID: <20201028092008.5a5397fc.cohuck@redhat.com>
In-Reply-To: <404f58a5-180d-f3d7-dbcc-b533a29e6a94@redhat.com>
References: <5F97FD61.4060804@huawei.com> <5F991998.2020108@huawei.com>
 <404f58a5-180d-f3d7-dbcc-b533a29e6a94@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pasic@linux.ibm.com, zhang.zhanghailiang@huawei.com, kvm@vger.kernel.org,
 mtosatti@redhat.com, qemu-devel@nongnu.org, AlexChen <alex.chen@huawei.com>,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, chenhc@lemote.com,
 zhengchuan@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 08:44:59 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 28/10/20 08:11, AlexChen wrote:
> > The current 'DEBUG_KVM' macro is defined in many files, and turning on
> > the debug switch requires code modification, which is very inconvenient,
> > so this series add an option to configure to support the definition of
> > the 'DEBUG_KVM' macro.
> > In addition, patches 3 and 4 also make printf always compile in debug output
> > which will prevent bitrot of the format strings by referring to the
> > commit(08564ecd: s390x/kvm: make printf always compile in debug output).  
> 
> Mostly we should use tracepoints, but the usefulness of these printf
> statements is often limited (except for s390 that maybe could make them
> unconditional error_reports).  I would leave this as is, maintainers can
> decide which tracepoints they like to have.

Looking at the s390 statements, they look more like something to put
into trace events (the "unimplemented instruction" cases are handled
gracefully, but the information might be interesting when developing.)


