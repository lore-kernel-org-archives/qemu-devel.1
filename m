Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B62AC2D0E3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BEC217BA
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkEgY7YF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BEC217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrBi-0006yV-IF
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHpjY-0000UA-11
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:45:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25471
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHpjT-0004T9-Uu
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600094726;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9iSo/nBto7/ia7Ikp+4w6vHJ1rNN0VdrSVMuqKA8QqM=;
 b=CkEgY7YFrmT6lFKgTXN64zQGmczxkHDbfaarNbzG0Gt6pMRufklPBT26Vmd0VI4BSwW7NH
 Mr4U1995eF+jXbAMTtE5Bm5VsH8gMWNekbTKR/8Vvk+pDOanjtYTwVEtydp/z9gZvvk/c6
 O4872eXiaaJ2FVry8Fh+B2HJLGReGDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-11HKVveCMiicmntMBR2lrg-1; Mon, 14 Sep 2020 10:44:49 -0400
X-MC-Unique: 11HKVveCMiicmntMBR2lrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D91A9053D6;
 Mon, 14 Sep 2020 14:43:11 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2048E81C51;
 Mon, 14 Sep 2020 14:42:54 +0000 (UTC)
Date: Mon, 14 Sep 2020 15:42:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200914144251.GO1252186@redhat.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
MIME-Version: 1.0
In-Reply-To: <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 01:39:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 09:54:08PM +0800, Zhenyu Ye wrote:
> Hi Kevin,
> 
> On 2020/8/10 23:38, Kevin Wolf wrote:
> > Am 10.08.2020 um 16:52 hat Zhenyu Ye geschrieben:
> >> Before doing qmp actions, we need to lock the qemu_global_mutex,
> >> so the qmp actions should not take too long time.
> >>
> >> Unfortunately, some qmp actions need to acquire aio context and
> >> this may take a long time.  The vm will soft lockup if this time
> >> is too long.
> > 
> > Do you have a specific situation in mind where getting the lock of an
> > AioContext can take a long time? I know that the main thread can
> > block for considerable time, but QMP commands run in the main thread, so
> > this patch doesn't change anything for this case. It would be effective
> > if an iothread blocks, but shouldn't everything running in an iothread
> > be asynchronous and therefore keep the AioContext lock only for a short
> > time?
> > 
> 
> Theoretically, everything running in an iothread is asynchronous. However,
> some 'asynchronous' actions are not non-blocking entirely, such as
> io_submit().  This will block while the iodepth is too big and I/O pressure
> is too high.  If we do some qmp actions, such as 'info block', at this time,
> may cause vm soft lockup.  This series can make these qmp actions safer.
> 
> I constructed the scene as follow:
> 1. create a vm with 4 disks, using iothread.
> 2. add press to the CPU on the host.  In my scene, the CPU usage exceeds 95%.
> 3. add press to the 4 disks in the vm at the same time.  I used the fio and
> some parameters are:
> 
> 	 fio -rw=randrw -bs=1M -size=1G -iodepth=512 -ioengine=libaio -numjobs=4
> 
> 4. do block query actions, for example, by virsh:
> 
> 	virsh qemu-monitor-command [vm name] --hmp info block
> 
> Then the vm will soft lockup, the calltrace is:

[snip]

> This problem can be avoided after this series applied.

At what cost though ?   With this timeout, QEMU is going to start
reporting bogus failures for various QMP commands when running
under high load, even if those commands would actually run
successfully.  This will turn into an error report from libvirt
which will in turn probably cause an error in the mgmt application
using libvirt, and in turn could break the user's automation.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


