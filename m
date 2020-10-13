Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B91252EC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evN0HhNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B91252EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNZ3-0006jC-3m
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSNXu-0005RJ-9Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSNXo-0005wW-3z
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602607979;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lAG9V3GRwiHZjgvCGFKH0hGxXT9kGuK4agpvpBYZsiQ=;
 b=evN0HhNGl8bJ/TKQRaYeKK6D90nuux5o4ZBvPTJJTaME0DA1Q938oW9Rg9HZvQHWO/9wRK
 p8mncaRJFrezH0t1KbtztMjuKsavZv+8rqsU0CcIAuBuE87lZEjga9vF4pzEkFqKtrs5or
 ae8MowCCmukjvgXWsDo0UpdJ4oVNVqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-20w6r-QXM5Sls0ZTgmsmFg-1; Tue, 13 Oct 2020 12:52:57 -0400
X-MC-Unique: 20w6r-QXM5Sls0ZTgmsmFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 065351084D65;
 Tue, 13 Oct 2020 16:52:56 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E2BE610F3;
 Tue, 13 Oct 2020 16:52:49 +0000 (UTC)
Date: Tue, 13 Oct 2020 17:52:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] fuzz: Disable QEMU's signal handlers
Message-ID: <20201013165246.GU70612@redhat.com>
References: <20201013152920.448335-1-alxndr@bu.edu> <m2r1q2m5nm.fsf@oracle.com>
MIME-Version: 1.0
In-Reply-To: <m2r1q2m5nm.fsf@oracle.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 05:50:37PM +0100, Darren Kenny wrote:
> Hi Alex,
> 
> This mentions the use of atexit() to perform some cleanup, but I'm not
> seeing that being added here, should it be?

The reference to atexit is strange, because it says the only way to
kill the fuzzer is SIGKILL, and that won't let atexit handlers run
anyway.

> 
> Thanks,
> 
> Darren.
> 
> On Tuesday, 2020-10-13 at 11:29:20 -04, Alexander Bulekov wrote:
> > With the fuzzer, we never call main_loop_should_exit, since we manually
> > call main_loop_wait. This means that the only way to terminate the
> > fuzzer is with SIGKILL. Disable the signal handlers, so there are
> > reasonable ways to terminate the fuzzer and use atexit() to clean-up
> > after the fuzzer.
> >
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> >  tests/qtest/fuzz/fuzz.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> > index d926c490c5..eb0070437f 100644
> > --- a/tests/qtest/fuzz/fuzz.c
> > +++ b/tests/qtest/fuzz/fuzz.c
> > @@ -217,5 +217,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
> >      /* re-enable the rcu atfork, which was previously disabled in qemu_init */
> >      rcu_enable_atfork();
> >  
> > +    /*
> > +     * Disable QEMU's signal handlers, since we manually control the main_loop,
> > +     * and don't check for main_loop_should_exit
> > +     */
> > +    signal(SIGINT, SIG_DFL);
> > +    signal(SIGHUP, SIG_DFL);
> > +    signal(SIGTERM, SIG_DFL);
> > +
> >      return 0;
> >  }
> > -- 
> > 2.28.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


