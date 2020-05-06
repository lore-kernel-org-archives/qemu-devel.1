Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9694C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83887206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2RApQnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83887206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFkx-0006WH-K3
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWFkF-00065I-9u
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:49:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23131
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jWFkE-0005W2-G5
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588754973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RI2GcMOVNGDjHl8hBgmUlfDtBJHyznF1AtGygcU0p4=;
 b=L2RApQnUW7kZtiWbF/seJ5B7r88hXjAOIgHZ/Yck5GKaaEsBM3E/34+MRNLeLyWvuvKGfI
 EfBwr6PdJNOb8MYgxaZAzPeh0odxEDNb7Lt7iM37l8L90wf9UNtCgrRHbqQy/FsishtmH0
 6n8iFwu9k2SEOjSzwlezSdIIDT1TFTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-IOeaUmZXNTOIY_Rc34Ul9w-1; Wed, 06 May 2020 04:49:30 -0400
X-MC-Unique: IOeaUmZXNTOIY_Rc34Ul9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 953FF835B49;
 Wed,  6 May 2020 08:49:29 +0000 (UTC)
Received: from gondolin (ovpn-112-211.ams2.redhat.com [10.36.112.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEFBE63F90;
 Wed,  6 May 2020 08:49:24 +0000 (UTC)
Date: Wed, 6 May 2020 10:49:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH] s390x: pv: Fix KVM_PV_PREP_RESET command wrapper name
Message-ID: <20200506104922.29b4cc32.cohuck@redhat.com>
In-Reply-To: <20200505124159.24099-1-frankja@linux.ibm.com>
References: <20200505124159.24099-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 08:41:59 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> s390_pv_perf_clear_reset() is not a very helpful name since that
> function needs to be called for a normal and a clear reset via
> diag308.
> 
> Let's instead name it s390_pv_prep_reset() which reflects the purpose
> of the function a bit better.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/pv.c              | 2 +-
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  include/hw/s390x/pv.h      | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Thanks, applied.


