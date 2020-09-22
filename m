Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01737C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD05235FD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRuuYkft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD05235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmP1-00081t-Ap
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKmN9-0006ZN-Iw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKmN7-0004Dr-Mi
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600796791;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOpNvAmGmsNtzoMJ+JuvpmPoWFaYH49v42cE5SGuJZ0=;
 b=DRuuYkftuVcEkCTpAkZ62PS1ikuHm5Wqss4cuPTrogRUOPmKKcLb6z9mslackuFkD37joC
 tDiaKA4C3nY6AjwKV/guGuc9ppZjBvxEV4cfAY5TjJvwaOjdRuOiqimQ3B+cH4s+4Z9rYY
 lEB7F2N6vMd0YdAWhoWhUGqu+Zh+tiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-zxk9PuFYNBWQiqxFy3bi-g-1; Tue, 22 Sep 2020 13:46:29 -0400
X-MC-Unique: zxk9PuFYNBWQiqxFy3bi-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5F8B109107A;
 Tue, 22 Sep 2020 17:46:28 +0000 (UTC)
Received: from redhat.com (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 074DB5C1D0;
 Tue, 22 Sep 2020 17:46:20 +0000 (UTC)
Date: Tue, 22 Sep 2020 18:46:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] virtiofsd: Used glib "shared" thread pool
Message-ID: <20200922174618.GV1989025@redhat.com>
References: <20200921213216.GE13362@redhat.com>
 <20200922125957.GN1989025@redhat.com>
 <20200922174255.GC57620@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922174255.GC57620@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: virtio-fs-list <virtio-fs@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 01:42:55PM -0400, Vivek Goyal wrote:
> On Tue, Sep 22, 2020 at 01:59:57PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Sep 21, 2020 at 05:32:16PM -0400, Vivek Goyal wrote:
> > > glib offers thread pools and it seems to support "exclusive" and "shared"
> > > thread pools.
> > > 
> > > https://developer.gnome.org/glib/stable/glib-Thread-Pools.html#g-thread-pool-new
> > > 
> > > Currently we use "exlusive" thread pools but its performance seems to be
> > > poor. I tried using "shared" thread pools and performance seems much
> > > better. I posted performance results here.
> > > 
> > > https://www.redhat.com/archives/virtio-fs/2020-September/msg00080.html
> > > 
> > > So lets switch to shared thread pools. We can think of making it optional
> > > once somebody can show in what cases exclusive thread pools offer better
> > > results. For now, my simple performance tests across the board see
> > > better results with shared thread pools.
> > 
> > I'm really curious why  there's any perf difference between shared and
> > exclusive thread pools in the GLib impl.
> > 
> > Looking at the code the main difference between the two is appears to
> > be around the way threads are spawned, specifically around the scheduler
> > attributes assigned.
> > 
> > In the shared case, the threads in the pool will have their scheduler
> > attributes copied from the very first thread that calls g_thread_pool_new.
> > 
> > In the exclusive case, the threads in the pool will inherit their
> > scheduler attributes from the thread which pushs the job that
> > causes the worker thread to be created.
> > 
> > By schedular attributes, I mean all the items in the 'struct schedattr'
> > filled by sched_getattr()
> > 
> > IOW, if threads in virtiofsd have varying schedular attributes this
> > could possibly explain the difference in performance you see between
> > the two setups.
> 
> Hi Daniel,
> 
> Few things.
> 
> - I think scheduler attributes are same for the thread creating
>   pool as well as for thread pushing the job for virtiofsd.
> 
> - My glib2 is old (2.58.3) and I think that did not have sched_getattr()
>   stuff.
> 
> - One difference I noticed is that in case of shared pool, it does not
>   create extra threads if client is doing one request at a time. While
>   exclusive pool seemed to push every request to a new thread in pool
>   in sort of round robin fashion. It feels keeping requests being served
>   from same thread helps in this particilar workload case.

Yeah, that does sound like a candidate for the cause. I wonder if that
was intentional in the GLib design or just an accidental impl they didn't
realize had performance implications. Might be worth filing a bug against
GLib if someone has free time & motivation to figure out a standalone
reproducer to demonstrate the performance difference in the GLib APIs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


