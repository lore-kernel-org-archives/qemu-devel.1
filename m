Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E365C2D0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFABB20736
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtZHo6Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFABB20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXUg-0007rp-0r
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYXSJ-0003me-Jk
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:08:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20124
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYXSI-00058d-PM
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589299709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQJ+iAINYbHqjTWZbDc58EG2xewC4S/2gG8v76Mrr3I=;
 b=GtZHo6YjUicnnYeKhehQfOJ/GRUlsgKXAy9nJ3ZAXjGPlfJiGKgqbqhyBrsBkivmbBJrnf
 AmaOKiRRJNMigmKHwrgKD6lFPGDuTayxk9RHchU/PB/QDIhqKm5QdEG/ycQvITPUS3rdO0
 IdzRLM/JJVehg0tMqqxcnh/epufq+vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-6hBt1yhEMFSLyBzqF4h72w-1; Tue, 12 May 2020 12:08:28 -0400
X-MC-Unique: 6hBt1yhEMFSLyBzqF4h72w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C03107ACCD;
 Tue, 12 May 2020 16:08:26 +0000 (UTC)
Received: from gondolin (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EF3D60C80;
 Tue, 12 May 2020 16:08:18 +0000 (UTC)
Date: Tue, 12 May 2020 18:08:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v1 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Message-ID: <20200512180816.1237e990.cohuck@redhat.com>
In-Reply-To: <20200508230823.22956-1-walling@linux.ibm.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  8 May 2020 19:08:15 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> Collin L. Walling (8):
>   s390/sclp: remove SCLPDevice param from prepare_cpu_entries

This looks like a simple cleanup...

>   s390/sclp: check sccb len before filling in data

...and that like a simple fix (for a problem that currently does not
trigger.) Would it help or hinder you if I went ahead and queued these
two patches already?

>   s390/sclp: rework sclp boundary and length checks
>   s390/sclp: read sccb from mem based on sccb length
>   s390/sclp: use cpu offset to locate cpu entries
>   s390/sclp: add extended-length sccb support for kvm guest
>   s390/kvm: header sync for diag318
>   s390: diagnose 318 info reset and migration support
> 
>  hw/s390x/s390-virtio-ccw.c          |  45 +++++++++++++
>  hw/s390x/sclp.c                     | 101 +++++++++++++++++++++-------
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  include/hw/s390x/sclp.h             |   4 ++
>  linux-headers/asm-s390/kvm.h        |   5 ++
>  smp.max_cpus                        |   0

Probably a stray file? (Should be stripped from patch 2.)

>  target/s390x/cpu.c                  |  19 ++++++
>  target/s390x/cpu.h                  |   4 ++
>  target/s390x/cpu_features.h         |   1 +
>  target/s390x/cpu_features_def.inc.h |   4 ++
>  target/s390x/cpu_models.c           |   1 +
>  target/s390x/gen-features.c         |   2 +
>  target/s390x/kvm-stub.c             |  10 +++
>  target/s390x/kvm.c                  |  52 ++++++++++++++
>  target/s390x/kvm_s390x.h            |   3 +
>  15 files changed, 229 insertions(+), 23 deletions(-)
>  create mode 100644 smp.max_cpus
> 


