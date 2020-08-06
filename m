Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5009C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A0722D05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUjdZJ2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A0722D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eC4-0000HG-6k
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3djd-0002Sj-LG
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:06:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3djb-00025I-IB
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596712014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDIxsyaPn4jGa+tydmDkRaPhAN7KaYsexFPKCr5P5l4=;
 b=NUjdZJ2ydZdJ/tWPTaSBTeqjNJ+mH6UBHKg8FmtGEfHXc7hCC7CaIdVx9hgA/9HcFp0wbB
 NZQOAAsyGAFxoGN5Nnss3VyWs3pZj5aF/+uZUGQrgjygmkpNYC3vq1QYQKV/XCb3vjcbOw
 Qf9ZfInx073JnEYbuWq2SH7SyB/hae8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-3tt2L3tyMPuOk3-1TGh8-A-1; Thu, 06 Aug 2020 07:06:51 -0400
X-MC-Unique: 3tt2L3tyMPuOk3-1TGh8-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC6BD800688;
 Thu,  6 Aug 2020 11:06:49 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAA6319C4F;
 Thu,  6 Aug 2020 11:06:47 +0000 (UTC)
Date: Thu, 6 Aug 2020 13:06:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH for-5.2 v2 3/9] pc-bios/s390-ccw: Introduce ENODEV
 define and remove guards of others
Message-ID: <20200806130645.5c00e7ac.cohuck@redhat.com>
In-Reply-To: <20200806105349.632-4-thuth@redhat.com>
References: <20200806105349.632-1-thuth@redhat.com>
 <20200806105349.632-4-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  6 Aug 2020 12:53:43 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Remove the "#ifndef E..." guards from the defines here - the header
> guard S390_CCW_H at the top of the file should avoid double definition,
> and if the error code is defined in a different file already, we're in
> trouble anyway, then it's better to see the error at compile time instead
> of hunting weird behavior during runtime later.
> Also define ENODEV - we will use this in a later patch.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/s390-ccw.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


