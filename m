Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6C7224F3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMjmV/jN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6C7224F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQ1J-0005DQ-O9
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXQ0K-0004j2-At
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXQ0H-0005tk-T9
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:26:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXQ0H-0005tJ-Lb
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 08:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574256399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hlom2oQJD6MiDaZngRuPMOfAXZ1lIdeIyHQMOCOMvKM=;
 b=NMjmV/jNO7ED0bWR3wB3yu5t4dspWBQjEu8qdMrXTIo+zgP5mSMgbT2swVXyFQj+TTsScL
 25J7iGWQTGrWtq5ZXjhFt+YNRXXeFgW9OToBWnNCig6mlP1+eRuJ+0bfaz5i+MNn4CbB3I
 aPAmqet8ikiHs+I7xBW2+pr98ki8m+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-irwsMe5WOcmsgBrP2LdYHA-1; Wed, 20 Nov 2019 08:26:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE211005509;
 Wed, 20 Nov 2019 13:26:34 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20D9A6887F;
 Wed, 20 Nov 2019 13:26:29 +0000 (UTC)
Date: Wed, 20 Nov 2019 14:26:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 00/15] s390x: Protected Virtualization support
Message-ID: <20191120142627.39d041fe.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-1-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: irwsMe5WOcmsgBrP2LdYHA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 06:43:19 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

Do you have a branch with this somewhere?

> Most of the QEMU changes for PV are related to the new IPL type with
> subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
> IPL secure guests. Note that we can only boot into secure mode from
> normal mode, i.e. stfle 161 is not active in secure mode.
>=20
> The other changes related to data gathering for emulation and
> disabling addressing checks in secure mode, as well as CPU resets.
>=20
> While working on this I sprinkled in some cleanups, as we sometimes
> significantly increase line count of some functions and they got
> unreadable.

Any other cleanups than in the first two patches? I.e., anything that
could be picked up independently?

>=20
> Janosch Frank (15):
>   s390x: Cleanup cpu resets
>   s390x: Beautify diag308 handling
>   s390x: protvirt: Add diag308 subcodes 8 - 10
>   Header sync protvirt
>   s390x: protvirt: Sync PV state
>   s390x: protvirt: Support unpack facility
>   s390x: protvirt: Handle diag 308 subcodes 0,1,3,4
>   s390x: protvirt: KVM intercept changes
>   s390x: protvirt: SCLP interpretation
>   s390x: protvirt: Add new VCPU reset functions
>   RFC: s390x: Exit on vcpu reset error
>   s390x: protvirt: Set guest IPL PSW
>   s390x: protvirt: Move diag 308 data over SIDAD
>   s390x: protvirt: Disable address checks for PV guest IO emulation
>   s390x: protvirt: Handle SIGP store status correctly
>=20
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  81 +++++++++++++++++-
>  hw/s390x/ipl.h                      |  35 ++++++++
>  hw/s390x/pv.c                       | 123 +++++++++++++++++++++++++++
>  hw/s390x/pv.h                       |  27 ++++++
>  hw/s390x/s390-virtio-ccw.c          |  79 ++++++++++++++---
>  hw/s390x/sclp.c                     |  16 ++++
>  include/hw/s390x/sclp.h             |   2 +
>  linux-headers/asm-s390/kvm.h        |   4 +-
>  linux-headers/linux/kvm.h           |  43 ++++++++++
>  target/s390x/cpu.c                  | 127 ++++++++++++++--------------
>  target/s390x/cpu.h                  |   1 +
>  target/s390x/cpu_features_def.inc.h |   1 +
>  target/s390x/diag.c                 | 108 +++++++++++++++++------
>  target/s390x/ioinst.c               |  46 ++++++----
>  target/s390x/kvm-stub.c             |  10 ++-
>  target/s390x/kvm.c                  |  58 +++++++++++--
>  target/s390x/kvm_s390x.h            |   4 +-
>  target/s390x/sigp.c                 |   7 +-
>  19 files changed, 640 insertions(+), 133 deletions(-)
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 hw/s390x/pv.h
>=20


