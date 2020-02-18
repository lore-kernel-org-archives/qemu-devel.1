Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F7C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A30922527
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnxaMZo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A30922527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42p7-0008Bl-LW
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j42gf-00047h-KW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j42gc-0006cK-T4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:13:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j42gc-0006bl-I6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582031593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5nthzg/7QkIe/ahXszg3m//7XvjE80yHgw6heGrV44=;
 b=RnxaMZo8L30HDkw4Mie1rCaXZOw56tydXnQhYjCHUvD9IIjdIzTh3tr8d8KT2iLXKBOYha
 n2gco/vL06M2vvEkHUz+7bAFqBJUOGJ6gH6JbjI6Q6i/L2NtQgg7yg9NFJU+JfK+iOkuBj
 MKdB5YkQVbtFGXftlz6Bx1O5wuZVHUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-XOF-Vk5pOKq93faeYZiwig-1; Tue, 18 Feb 2020 08:13:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F151C800D48;
 Tue, 18 Feb 2020 13:13:09 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A7F117DC8;
 Tue, 18 Feb 2020 13:13:06 +0000 (UTC)
Date: Tue, 18 Feb 2020 14:13:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 00/17] s390x: Protected Virtualization support
Message-ID: <20200218141304.1c6f82b0.cohuck@redhat.com>
In-Reply-To: <20200214151636.8764-1-frankja@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XOF-Vk5pOKq93faeYZiwig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Feb 2020 10:16:19 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> Most of the QEMU changes for PV are related to the new IPL type with
> subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
> IPL secure guests. Note that we can only boot into secure mode from
> normal mode, i.e. stfle 161 is not active in secure mode.
> 
> The other changes related to data gathering for emulation and
> disabling addressing checks in secure mode, as well as CPU resets.

Does it make sense to start looking at this series now, or I should I
wait until review on the kernel side has settled? (I've lost track of
the state of the interfaces...)

> 
> V3:
> 	* Use dedicated functions to access SIDA
> 	* Smaller cleanups and segfault fixes
> 	* Error reporting for Ultravisor calls
> 	* Inject of RC of diag308 subcode 10 fails
> 
> V2:
> 	* Split out cleanups
> 	* Internal PV state tracking
> 	* Review feedback
> 
> Janosch Frank (17):
>   Header sync
>   s390x: Add missing vcpu reset functions
>   Sync pv
>   s390x: protvirt: Add diag308 subcodes 8 - 10
>   s390x: protvirt: Support unpack facility
>   s390x: protvirt: Add migration blocker
>   s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
>   s390x: protvirt: KVM intercept changes
>   s390: protvirt: Move STSI data over SIDAD
>   s390x: Add SIDA memory ops
>   s390x: protvirt: SCLP interpretation
>   s390x: protvirt: Set guest IPL PSW
>   s390x: protvirt: Move diag 308 data over SIDAD
>   s390x: protvirt: Disable address checks for PV guest IO emulation
>   s390x: protvirt: Move IO control structures over SIDA
>   s390x: protvirt: Handle SIGP store status correctly
>   s390x: For now add unpack feature to GA1
> 
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  80 +++++++++++++-
>  hw/s390x/ipl.h                      |  33 ++++++
>  hw/s390x/pv.c                       | 160 ++++++++++++++++++++++++++++
>  hw/s390x/pv.h                       |  40 +++++++
>  hw/s390x/s390-virtio-ccw.c          | 136 ++++++++++++++++++++++-
>  hw/s390x/sclp.c                     |  17 +++
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  include/hw/s390x/sclp.h             |   2 +
>  linux-headers/linux/kvm.h           |  48 ++++++++-
>  target/s390x/cpu.c                  |  41 +++++--
>  target/s390x/cpu.h                  |   8 +-
>  target/s390x/cpu_features_def.inc.h |   1 +
>  target/s390x/diag.c                 |  63 +++++++++--
>  target/s390x/gen-features.c         |   1 +
>  target/s390x/helper.c               |   4 +
>  target/s390x/ioinst.c               | 113 ++++++++++++++------
>  target/s390x/kvm-stub.c             |  10 +-
>  target/s390x/kvm.c                  |  89 ++++++++++++++--
>  target/s390x/kvm_s390x.h            |   6 +-
>  target/s390x/mmu_helper.c           |   9 ++
>  target/s390x/sigp.c                 |   1 +
>  22 files changed, 789 insertions(+), 75 deletions(-)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 hw/s390x/pv.h
> 

-ENODOC; can you add something under docs/ that describes how you
configure a pv guest and what the initialization/teardown flow is?


