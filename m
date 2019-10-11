Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4FAC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F09820673
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F09820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzdr-0001fO-94
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dann.frazier@canonical.com>) id 1iIz3K-0008Sh-Mc
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 13:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dann.frazier@canonical.com>) id 1iIz3J-000333-Kr
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 13:50:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dann.frazier@canonical.com>)
 id 1iIz3J-00032R-Fd
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 13:50:09 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dann.frazier@canonical.com>) id 1iIz3I-0007f6-4w
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:50:08 +0000
Received: by mail-io1-f70.google.com with SMTP id o11so15578742iop.12
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 10:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0IbGoxc82xatwrwn5PJ3w2SXIJIdha2Kkk4OjLJe6bw=;
 b=sjGvHMZwKYVx+LcH2JFJU7/uP5KcWhqbh8kEANpdi63EfFRsvwwD3cNxA92LSi/rTf
 50agCYmlPkrEc0/UTu2KEauzxYDDqR8hWgqg/lsY61rZRdmkKzKVE5Q8jexzOoqM7+wW
 LezQTf2TYylKibEiyf1l9OLYBf47VpU03e1zvwC1dbYf1wtgTRcqTNLqb/ACTqomWImX
 zrb/F5V6+L/wzBborbk6brw8XbxAnz7fSIjADLIz5NqZrMLiSLmfpduKf01JDT9th7hP
 K3W7G3P/qkEN2JY4RrPk0ZYmyg7mzaIxK8AObb1XnkQx98A8nkuMAZSW5tIPLZVeSXiU
 TKBg==
X-Gm-Message-State: APjAAAVQUz6CjE6DEtPfjmRkM/H28GEfh7o40b1OKF5pg/41eV7GzS8A
 LjTc/LpQ4auLmAtV30yO5lgM78fFBIBCvSSUemqTzjxGhOer8b8+ZC4mi7LmmbHI88juJ/4+Bdm
 9MUNdBdKC+NdhOJIpYzdrSXVBuIISlWYu
X-Received: by 2002:a5e:9b04:: with SMTP id j4mr815729iok.45.1570816206947;
 Fri, 11 Oct 2019 10:50:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPYW/ueoUdYFkDu0vjH8lYV/22VYKenaeoz+EsWRsEdshsk00HDcpzdJcwoqjc08F4Ut9MzQ==
X-Received: by 2002:a5e:9b04:: with SMTP id j4mr815676iok.45.1570816206534;
 Fri, 11 Oct 2019 10:50:06 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net.
 [71.56.235.36])
 by smtp.gmail.com with ESMTPSA id 26sm8058970iog.10.2019.10.11.10.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 10:50:05 -0700 (PDT)
Date: Fri, 11 Oct 2019 11:50:06 -0600
From: dann frazier <dann.frazier@canonical.com>
To: Jan Glauber <jglauber@marvell.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Message-ID: <20191011175006.GA25464@xps13.dannf>
References: <d94f18f1-986f-ec19-02c0-e83e5e7af3d0@redhat.com>
 <1864070a-2f84-1d98-341e-f01ddf74ec4b@ubuntu.com>
 <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
 <20191007144432.GA29958@xps13.dannf>
 <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com>
 <20191009080220.GA2905@hc>
 <d5367b2a-84ee-1211-a2dc-7d631c94fe3f@redhat.com>
 <20191011060518.GA6920@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011060518.GA6920@hc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 91.189.89.112
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
Cc: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>,
 lizhengui <lizhengui@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1805256 <1805256@bugs.launchpad.net>,
 QEMU Developers - ARM <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 06:05:25AM +0000, Jan Glauber wrote:
> On Wed, Oct 09, 2019 at 11:15:04AM +0200, Paolo Bonzini wrote:
> > On 09/10/19 10:02, Jan Glauber wrote:
> 
> > > I'm still not sure what the actual issue is here, but could it be some bad
> > > interaction between the notify_me and the list_lock? The are both 4 byte
> > > and side-by-side:
> > > 
> > > address notify_me: 0xaaaadb528aa0  sizeof notify_me: 4
> > > address list_lock: 0xaaaadb528aa4  sizeof list_lock: 4
> > > 
> > > AFAICS the generated code looks OK (all load/store exclusive done
> > > with 32 bit size):
> > > 
> > >      e6c:       885ffc01        ldaxr   w1, [x0]
> > >      e70:       11000821        add     w1, w1, #0x2
> > >      e74:       8802fc01        stlxr   w2, w1, [x0]
> > > 
> > > ...but if I bump notify_me size to uint64_t the issue goes away.
> > 
> > Ouch. :)  Is this with or without my patch(es)?
> > 
> > Also, what if you just add a dummy uint32_t after notify_me?
> 
> With the dummy the testcase also runs fine for 500 iterations.
> 
> Dann, can you try if this works on the Hi1620 too?

On Hi1620, it hung on the first iteration. Here's the complete patch
I'm running with:

diff --git a/include/block/aio.h b/include/block/aio.h
index 6b0d52f732..e6fd6f1a1a 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -82,7 +82,7 @@ struct AioContext {
      * Instead, the aio_poll calls include both the prepare and the
      * dispatch phase, hence a simple counter is enough for them.
      */
-    uint32_t notify_me;
+    uint64_t notify_me;
 
     /* A lock to protect between QEMUBH and AioHandler adders and deleter,
      * and to ensure that no callbacks are removed while we're walking and
diff --git a/util/async.c b/util/async.c
index ca83e32c7f..024c4c567d 100644
--- a/util/async.c
+++ b/util/async.c
@@ -242,7 +242,7 @@ aio_ctx_check(GSource *source)
     aio_notify_accept(ctx);
 
     for (bh = ctx->first_bh; bh; bh = bh->next) {
-        if (bh->scheduled) {
+        if (atomic_mb_read(&bh->scheduled)) {
             return true;
         }
     }
@@ -342,12 +342,12 @@ LinuxAioState *aio_get_linux_aio(AioContext *ctx)
 
 void aio_notify(AioContext *ctx)
 {
-    /* Write e.g. bh->scheduled before reading ctx->notify_me.  Pairs
-     * with atomic_or in aio_ctx_prepare or atomic_add in aio_poll.
+    /* Using atomic_mb_read ensures that e.g. bh->scheduled is written before
+     * ctx->notify_me is read.  Pairs with atomic_or in aio_ctx_prepare or
+     * atomic_add in aio_poll.
      */
-    smp_mb();
-    if (ctx->notify_me) {
-        event_notifier_set(&ctx->notifier);
+    if (atomic_mb_read(&ctx->notify_me)) {
+	event_notifier_set(&ctx->notifier);
         atomic_mb_set(&ctx->notified, true);
     }
 }

