Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5A1C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E9C22224
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbRMh0l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9C22224
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvJUs-0006u7-JG
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jvJTv-00060H-13
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:52:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27326
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jvJTr-0003Ab-Si
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594727534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/XflqdxoWQh4noUp5G2b7Z+oQGIe5Mg8uKdQZiKSVI=;
 b=bbRMh0l3s4E+Oy6Z+Pbdg+/9sGql0uvd9XKHHCPknl2bcbgVToMN1u4bwtamtS67kzifRA
 TXR1zSZVa5V18MQs+LBwAPbwhuAPBOJ8y4w7FvsydQgih50vt4aLqKepK97Qsrk3rwhvz9
 BWqxMrWfG4HvFKicMmvFMruHYQWN5Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-FuSqL0XMMDiStfmR0m9RqQ-1; Tue, 14 Jul 2020 07:52:10 -0400
X-MC-Unique: FuSqL0XMMDiStfmR0m9RqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B1668014D4;
 Tue, 14 Jul 2020 11:52:09 +0000 (UTC)
Received: from gondolin (ovpn-112-240.ams2.redhat.com [10.36.112.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AA3760BEC;
 Tue, 14 Jul 2020 11:51:57 +0000 (UTC)
Date: Tue, 14 Jul 2020 13:51:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200714135155.114f1a4f.cohuck@redhat.com>
In-Reply-To: <20200714083631.888605-2-ppandit@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 14:06:31 +0530
P J P <ppandit@redhat.com> wrote:

> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> QEMU supports numerous virtualisation and emulation use cases.
> It also offers many features to support guest's function(s).
> 
> All of these use cases and features are not always security relevant.
> Because some maybe used in trusted environments only. Some may still
> be in experimental stage. While other could be very old and not
> used or maintained actively.
> 
> For security bug analysis we generally consider use cases wherein
> QEMU is used in conjunction with the KVM hypervisor, which enables
> guest to use hardware processor's virtualisation features.
> 
> The CVE (or Security or Trust) Quotient field tries to capture this
> sensitivity pertaining to a feature or section of the code.
> 
> It indicates whether a potential issue should be treated as a security
> one OR it could be fixed as a regular non-security bug.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  MAINTAINERS | 324 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 324 insertions(+)
> 

(...)

> @@ -87,6 +95,7 @@ S390 general architecture support
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Thomas Huth <thuth@redhat.com>
>  S: Supported
> +C: High

Just to reiterate what others have previously stated:

The granularity in MAINTAINERS and how it is organized does not really
work well with what you are trying to do with this classification.

If I pick just this entry as an example: It covers *all* s390x-related
code, and this covers both things like support for protected
virtualization (definitely critical) and virtio-9p-ccw (definitely not
critical). It is important that somebody is looking after s390x overall
(hence the "Supported" state), but not all s390x-related code is
equally critical.

I see the main purpose of the MAINTAINERS file to find the right
contacts for an area; other approaches like tagging of devices and
features seem to be better suited for figuring out which areas are
deemed critical.

>  F: default-configs/s390x-softmmu.mak
>  F: gdb-xml/s390*.xml
>  F: hw/char/sclp*.[hc]


