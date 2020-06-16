Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B5BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74F7208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJnkOQ19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74F7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEz0-0005mP-2u
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlExi-0004yw-KK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:01:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlExg-0005jC-UB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592326884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LVkGOujtvHu0d03Sc39CHyeMkMJRCVPKv3IFhdO5ik=;
 b=QJnkOQ19U+9jV61tmP266wUQILw3qU98GNAMAFCeQudyUZHoSBj85PE5MDPUoPxlPaBdGI
 2fA1Zs7/i5pHgByIFh8mHcGOicYVmrRl6UNexPfT1K4wePKK7y0vOmkqWpBGdcLmup7JS3
 hCjiBk/ShKICxp4vH9EkGmjU+UDg3Y4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-jSuXYXFwNgykrgE7JqmvNw-1; Tue, 16 Jun 2020 13:01:20 -0400
X-MC-Unique: jSuXYXFwNgykrgE7JqmvNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 387305AECC;
 Tue, 16 Jun 2020 17:01:19 +0000 (UTC)
Received: from gondolin (ovpn-112-222.ams2.redhat.com [10.36.112.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D60DF5D9D3;
 Tue, 16 Jun 2020 17:01:17 +0000 (UTC)
Date: Tue, 16 Jun 2020 19:01:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] s390x/vfio-ccw: Channel Path Handling [QEMU]
Message-ID: <20200616190115.27c8497f.cohuck@redhat.com>
In-Reply-To: <20200505125757.98209-1-farman@linux.ibm.com>
References: <20200505125757.98209-1-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  5 May 2020 14:57:51 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Here is a new pass at the channel-path handling code for vfio-ccw,
> to take advantage of the corresponding kernel patches posted here:
> 
> https://lore.kernel.org/kvm/20200505122745.53208-1-farman@linux.ibm.com/
> 
> I have all the main comments from v3 addressed, though I have a
> couple of additional patches that do some further cleanups
> (like, a generic callback for stsch) that weren't baked enough
> to include here. They're working fine, but need some cleanups
> (e.g., fixups vs standalone patches) before they're ready for
> submission. Just wanted to have the basic QEMU code to go with
> the new KVM series.
> 
> Changes are listed in git notes for the individual patches.
> 
> v3: https://lore.kernel.org/qemu-devel/20200417023440.70514-1-farman@linux.ibm.com/
> v2: https://lore.kernel.org/qemu-devel/20200206214509.16434-1-farman@linux.ibm.com/
> v1: https://lore.kernel.org/qemu-devel/20191115033437.37926-1-farman@linux.ibm.com/
> 
> Eric Farman (3):
>   vfio-ccw: Refactor cleanup of regions
>   vfio-ccw: Refactor ccw irq handler
>   s390x/css: Refactor the css_queue_crw() routine
> 
> Farhan Ali (3):
>   linux-headers: update
>   vfio-ccw: Add support for the schib region
>   vfio-ccw: Add support for the CRW region and IRQ
> 
>  hw/s390x/css.c                 |  57 ++++++---
>  hw/s390x/s390-ccw.c            |  21 ++++
>  hw/vfio/ccw.c                  | 208 +++++++++++++++++++++++++++++----
>  include/hw/s390x/css.h         |   4 +-
>  include/hw/s390x/s390-ccw.h    |   1 +
>  linux-headers/linux/vfio.h     |   3 +
>  linux-headers/linux/vfio_ccw.h |  18 +++
>  target/s390x/ioinst.c          |   3 +-
>  8 files changed, 274 insertions(+), 41 deletions(-)
> 

Thanks, replaced patch 1 with a proper headers update against 5.8-rc1
and applied.


