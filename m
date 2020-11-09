Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B305C4741F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA932074F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPTf3X/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA932074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc8Nk-0004Ea-NO
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kc8Lx-0002se-Oh
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:41:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vgoyal@redhat.com>) id 1kc8Lv-0004gn-8n
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:41:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604932862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9d/SHY+WFaz6JKDk45sbqm/h2XOfhjQZyVIjwcWgv8I=;
 b=JPTf3X/KDeN5/QDFfhet0IDaUolg55WimjE9P9mIAJDf6dOijE+d2N5DxPLwQ5KsN2mc3Z
 fXrCH3zJ+ebIYtQe6R1dLMNJXXf1ThvZ5tqAGSoLB8y2il935fEQ6NCdvBY9Ll78Y6VBUH
 t4VSaJYyQv08Zlt5lhviHtXngLa//Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-OUHwPoPqOyuOjs8TY2NOBQ-1; Mon, 09 Nov 2020 09:40:59 -0500
X-MC-Unique: OUHwPoPqOyuOjs8TY2NOBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE1841891E82;
 Mon,  9 Nov 2020 14:40:57 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-201.rdu2.redhat.com [10.10.115.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A4CE5D9DD;
 Mon,  9 Nov 2020 14:40:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 95301222E35; Mon,  9 Nov 2020 09:40:49 -0500 (EST)
Date: Mon, 9 Nov 2020 09:40:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd: Use --thread-pool-size=0 to mean no thread pool
Message-ID: <20201109144049.GC1479853@redhat.com>
References: <20201105194416.GA1384085@redhat.com>
 <20201109101102.GE3024@work-vm>
MIME-Version: 1.0
In-Reply-To: <20201109101102.GE3024@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vgoyal@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vgoyal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, jose.carlos.venegas.munoz@intel.com,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 09, 2020 at 10:11:02AM +0000, Dr. David Alan Gilbert wrote:
> * Vivek Goyal (vgoyal@redhat.com) wrote:
> > Right now we create a thread pool and main thread hands over the request
> > to thread in thread pool to process. Number of threads in thread pool
> > can be managed by option --thread-pool-size.
> > 
> > There is a chance that in case of some workloads, we might get better
> > performance if we don't handover the request to a different thread
> > and process in the context of thread receiving the request.
> > 
> > To implement that, redefine the meaning of --thread-pool-size=0 to
> > mean that don't use a thread pool. Instead process the request in
> > the context of thread receiving request from the queue.
> > 
> > I can't think how --thread-pool-size=0 is useful and hence using
> > that. If it is already useful somehow, I could look at defining
> > a new option say "--no-thread-pool".
> > 
> > I think this patch will be used more as a debug help to do comparison
> > when it is more effecient to do not hand over the requests to a
> > thread pool.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> I think this is OK, but you need to fix the style to match qemu rather
> than kernel style.
> (See qemu's scripts/checpatch.pl)

Sure. I just posted V2 of the patch and took care of all the issues
reported by qemu's scripts/checkpatch.pl.

Vivek


