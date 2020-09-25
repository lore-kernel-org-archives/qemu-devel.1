Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDF4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AE220878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhYf4L6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AE220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpYk-0001eC-MW
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLpVF-0008WT-Lk
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kLpVD-00058f-LJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:19:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601047154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gd1+XIDp9heQWKdzQk4NicZbbuBB407HHDBa4c32iDk=;
 b=dhYf4L6ITzMO6vT4wviXJT3/8SJEBtV3SBgxqNyqkb+vVt0sXkncebQunrNjKOsMN7XiEh
 +gcUm1Fm9JAmxE7XgmGXi+jaGTZ7Ks+CWDcldZ5xMWZji9SdUUgIUpYK2hF4grvMPoHFE6
 5PEiHx1lqqhYbYc0mv+XR7X6yBS5fxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-jvlPFOvRNJ2JrkxI61MH0A-1; Fri, 25 Sep 2020 11:19:09 -0400
X-MC-Unique: jvlPFOvRNJ2JrkxI61MH0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74338B9512;
 Fri, 25 Sep 2020 15:19:00 +0000 (UTC)
Received: from gondolin (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E362B87D97;
 Fri, 25 Sep 2020 15:18:57 +0000 (UTC)
Date: Fri, 25 Sep 2020 17:18:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v6 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Message-ID: <20200925171855.670bd93a.cohuck@redhat.com>
In-Reply-To: <82f7c31c-16f6-8450-d241-ca8257db6469@linux.ibm.com>
References: <20200915194416.107460-1-walling@linux.ibm.com>
 <20200916175300.5c2b6bbb.cohuck@redhat.com>
 <3f4c28d6-fe5f-2e52-2e51-3190621ea63d@linux.ibm.com>
 <82f7c31c-16f6-8450-d241-ca8257db6469@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, pbonzini@redhat.com, sumanthk@linux.ibm.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Sep 2020 11:13:49 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 9/16/20 1:15 PM, Collin Walling wrote:
> > On 9/16/20 11:53 AM, Cornelia Huck wrote:
> > 
> > [...]
> >   
> >>>  
> >>
> >> Thanks, applied.
> >>
> >>  
> > 
> > Thanks Conny.
> > 
> > Much appreciated for everyone's patience and review. The only thing I'd
> > like to hold out on for now is for someone to take a peek at patch #3
> > with respect to the protected virtualization stuff. I don't know too
> > much about it, honestly, and I want to ensure that dynamically
> > allocating memory for the SCCB makes sense there. The alternative would
> > be to allocate a static 4K for the work_sccb.
> >   
> 
> I had someone take a look at the patch for PV and was told everything
> looks sane. Since the patches have already been applied, it seems like
> it's too late to add a reviewed-by from someone?

Have the reviewer reply with their R-b, and I'll happily add it, as I
rebase s390-next before doing a pull req anyway :)

> 
> Either way: thanks to everyone for the journey on getting these patches
> through!
> 


