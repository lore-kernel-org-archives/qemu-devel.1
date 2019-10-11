Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D70BC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4F72089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4F72089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ03i-0005V0-BX
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dann.frazier@canonical.com>) id 1iIz8f-0006el-LK
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 13:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dann.frazier@canonical.com>) id 1iIz8e-00069V-9h
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 13:55:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35073)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dann.frazier@canonical.com>)
 id 1iIz8e-00067g-41
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 13:55:40 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dann.frazier@canonical.com>) id 1iIz8b-0007uo-Ui
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:55:38 +0000
Received: by mail-io1-f70.google.com with SMTP id r20so15689610ioh.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 10:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TJabvGBzYoH+K4DTwkXfzex0GExkMyVSB8XXZLit9qI=;
 b=AtMRAdW8HnhyvcPm3ZJzBtqIhbJH0N6c386tlQ5JqH8FSwcBewMSMchZnDSnxVHI1k
 LmWwcOd49B6xygtsRIMEhl4on3TDkHDFo0t949HripxlsSOSkHU5JrMyK4/fhV9ACXCc
 Uv+5kOp9qGy5HFo8R7Bl2iSGzlrUCYsRvefTwYOwMl8O7SZ9/fxAX18IpB66XbX3BlpO
 UjtpJSP9/RQMB240tFMIfL0Px0R+4XBxAmjAi+BIatcN5fS+1aV/b4gHwyrpcyTKLy0X
 5k51y0QecrnRXhU4jqwg121/qsBUmsWVs59uHwkbtITN1q3sDjkcrV3I9841c3CWneg2
 TpVw==
X-Gm-Message-State: APjAAAU47nS36uc94Iu5ziJyOBgerUKVHH7M8ceKLVuceAvihMUOCJJq
 sZOdX6A8CsQzGEUcrqxZic1nu/Vi6PgWCddHaHEjm04zOcAmL8zOjg4srPU4lIP/nw7ZO/G0zr0
 BglfC7ZmsbfVexMyN2dZzjILqBOKr84wO
X-Received: by 2002:a5d:8991:: with SMTP id m17mr7780100iol.104.1570816536857; 
 Fri, 11 Oct 2019 10:55:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzrZ5NZjnnq4tF4R6PQev4BU0bFGzfLPJOith1vTdJsoQ3pyTj08BA+rbRfPaAGd4j0xD+ZTQ==
X-Received: by 2002:a5d:8991:: with SMTP id m17mr7780076iol.104.1570816536534; 
 Fri, 11 Oct 2019 10:55:36 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net.
 [71.56.235.36])
 by smtp.gmail.com with ESMTPSA id f12sm6162295iob.58.2019.10.11.10.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 10:55:35 -0700 (PDT)
Date: Fri, 11 Oct 2019 11:55:36 -0600
From: dann frazier <dann.frazier@canonical.com>
To: Jan Glauber <jglauber@marvell.com>
Subject: Re: [Qemu-devel] qemu_futex_wait() lockups in ARM64: 2 possible issues
Message-ID: <20191011175536.GB25464@xps13.dannf>
References: <20190924202517.GA21422@xps13.dannf> <20191002092253.GA3857@hc>
 <6dd73749-49b0-0fbc-b9bb-44c3736642b8@redhat.com>
 <20191007144432.GA29958@xps13.dannf>
 <065a52a9-5bb0-1259-6c73-41af60e0a05d@redhat.com>
 <20191009080220.GA2905@hc>
 <d5367b2a-84ee-1211-a2dc-7d631c94fe3f@redhat.com>
 <20191011060518.GA6920@hc>
 <966c119d-aa76-2149-108f-867aebd772f7@redhat.com>
 <20191011082954.GA10493@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20191011082954.GA10493@hc>
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
Message-ID: <20191011175536.cYY-aDIU6pxHm8wt_PwWlW2eP2oQAjn2_vgeDh-Segw@z>

On Fri, Oct 11, 2019 at 08:30:02AM +0000, Jan Glauber wrote:
> On Fri, Oct 11, 2019 at 10:18:18AM +0200, Paolo Bonzini wrote:
> > On 11/10/19 08:05, Jan Glauber wrote:
> > > On Wed, Oct 09, 2019 at 11:15:04AM +0200, Paolo Bonzini wrote:
> > >>> ...but if I bump notify_me size to uint64_t the issue goes away.
> > >>
> > >> Ouch. :)  Is this with or without my patch(es)?
> > 
> > You didn't answer this question.
> 
> Oh, sorry... I did but the mail probably didn't make it out.
> I have both of your changes applied (as I think they make sense).
> 
> > >> Also, what if you just add a dummy uint32_t after notify_me?
> > > 
> > > With the dummy the testcase also runs fine for 500 iterations.
> > 
> > You might be lucky and causing list_lock to be in another cache line.
> > What if you add __attribute__((aligned(16)) to notify_me (and keep the
> > dummy)?
> 
> Good point. I'll try to force both into the same cacheline.

On the Hi1620, this still hangs in the first iteration:

diff --git a/include/block/aio.h b/include/block/aio.h
index 6b0d52f732..00e56a5412 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -82,7 +82,7 @@ struct AioContext {
      * Instead, the aio_poll calls include both the prepare and the
      * dispatch phase, hence a simple counter is enough for them.
      */
-    uint32_t notify_me;
+    __attribute__((aligned(16))) uint64_t notify_me;
 
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

