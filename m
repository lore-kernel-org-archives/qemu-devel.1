Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7BBC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF3020DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3DzxChK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF3020DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJOW8-0004uv-JN
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 18:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNS8-0008Qc-HY
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJNS6-0007aN-MI
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600462673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5E9KekElfZ5c25ZojIoGWnFymY3aYNmxoeu9TZdgfr0=;
 b=D3DzxChKgof9UkTeEbkmuPV2FjxZmyadMhnyHVJJOsrm9w6QUqdxWNwP4imQQEHbAIPLc8
 vskJZN5k6Zucdb8Y2pE7ni3f06xHf/M1Rar7shWVqiKsE1c0BDfjdRuAIgWDC9M25Qdenx
 rW+cwN3gmIqqpvs/iR1V2JBDODGFYR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-FDSptGhhNaSuGK-KPXCBxw-1; Fri, 18 Sep 2020 16:57:51 -0400
X-MC-Unique: FDSptGhhNaSuGK-KPXCBxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6BEC1014E0D;
 Fri, 18 Sep 2020 20:57:50 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 959EC78802;
 Fri, 18 Sep 2020 20:57:43 +0000 (UTC)
Date: Fri, 18 Sep 2020 16:57:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] smp: drop support for deprecated (invalid topologies)
Message-ID: <20200918205742.GB8041@habkost.net>
References: <20200911133202.938754-1-imammedo@redhat.com>
 <20200911110407-mutt-send-email-mst@kernel.org>
 <20200914093720.6c3583c7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200914093720.6c3583c7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: libvir-list@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 14, 2020 at 09:37:20AM +0200, Igor Mammedov wrote:
> On Fri, 11 Sep 2020 11:04:47 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Sep 11, 2020 at 09:32:02AM -0400, Igor Mammedov wrote:
> > > it's was deprecated since 3.1
> > > 
> > > Support for invalid topologies is removed, the user must ensure
> > > that topologies described with -smp include all possible cpus,
> > > i.e. (sockets * cores * threads) == maxcpus or QEMU will
> > > exit with error.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > Acked-by: 
> > 
> > memory tree I guess?
> 
> It would be better for Paolo to take it since he has
> queued numa deprecations, due to context confilict in
> deprecated.rst.
> 
> Paolo,
> can you queue this patch as well?

I'm queueing this in machine-next (sorry for not noticing it
before I sent today's pull request).

-- 
Eduardo


