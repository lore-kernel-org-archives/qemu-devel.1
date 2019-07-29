Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB7C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4EA21655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 06:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYCK6+wx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4EA21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrzWV-0008VK-Hq
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 02:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58808)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hrzW4-000858-BR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hrzW2-0003yd-GT
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:52:16 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:41026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hrzW2-0003xL-89
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 02:52:14 -0400
Received: by mail-io1-xd44.google.com with SMTP id j5so113535160ioj.8
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2019 23:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o6lTs/wN0SZQ0scjN12ISn08asUI2fqeF63D7hOYIOU=;
 b=ZYCK6+wxDv/QG3bVnmoAVePQPHnct9ETTpXShydhxeSzA5Hg8rDlvXB44EpCp1U6Fu
 j8UYRJDqqgNYHZkPFwhEYMbfoCCWpBHP2B7RZSAag5kwkwBDpce7brzcnvz6ZWnSWWiv
 SPjuUhjugKvQHT0R6muZ+GUgiEhPhnOurpWIh8KITq6806y4bhjqSVF0Xq24WznJ96Mf
 Ao77L/9Mzd9s/ba981cPCRLn+0bxzLt2yCYzm4m2J/Q6LaWEnzymZcfU3E6fQJH1L5Us
 QXcyYfLqS0KMqHNxlxk+8QqxTXrslynzUjfRKrIInm/5yraPy4vdl5IHbFf2BN+9yIFl
 a41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o6lTs/wN0SZQ0scjN12ISn08asUI2fqeF63D7hOYIOU=;
 b=dM87Qr3CK1TslVrOsSCG0/dOYQjwQUp5gHfexnFpRJCvPnf6mhi40tzPedItSpo7JK
 xTLzhycQTje2IyNzRcyHZtsqgMSw2ejuC4eMcTaemSYEgTqQw/ciWdpcR4c3KLQ5M5TI
 JBMZxybaQprzoXTgV8Sbqb/8vHWIb2NfLv04Xo8G05hdoIi7YGO+GZzV3fQ7H44zjj+o
 DZcPjf/pmqeJw9Sz1BehMlOWb3xiavwsA25JGtkcz+Zrwhi/eXqBa1gz7I2TuChVadhI
 b7cJYNZwVE4M1T5uY8SMIQvGm1jmxkyCaFOK2z3lxazktshS301BAyoNyOXE0+ZFsxCr
 hOPw==
X-Gm-Message-State: APjAAAW6kjIDdh9wqCHcooRx1NhTW6GdcR8ksdWvLNNnZc8AjjMGZwHm
 t/LzSZqN28vxTvZ95oNnlHZK8m2VUQFp9WHPeUw=
X-Google-Smtp-Source: APXvYqyT264O2lGK7FW8iQbAPRpYwXFRbid5Rez3sBSdeZ9C0oVeNFiSNitwAVvtbWUnpOWoY2gferlwpu+hIPq+Dh0=
X-Received: by 2002:a05:6602:2248:: with SMTP id
 o8mr34672797ioo.90.1564383133036; 
 Sun, 28 Jul 2019 23:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <1564367573-6327-1-git-send-email-ivanren@tencent.com>
 <1564367573-6327-3-git-send-email-ivanren@tencent.com>
 <20190729064008.GB21091@richard>
In-Reply-To: <20190729064008.GB21091@richard>
From: Ivan Ren <renyime@gmail.com>
Date: Mon, 29 Jul 2019 14:52:01 +0800
Message-ID: <CA+6E1=n7akkQDMTN2hnyQk_7GkaEW8fkim8tSmiKCKS47npyng@mail.gmail.com>
To: Wei Yang <richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: add speed limit for multifd
 migration
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>>     if (multifd_send_state->pages->used) {
>>-        if (multifd_send_pages() < 0) {
>>+        if (multifd_send_pages(rs) < 0) {
>>             error_report("%s: multifd_send_pages fail", __func__);
>>             return;
>>         }
>>@@ -1083,6 +1084,7 @@ static void multifd_send_sync_main(void)
>>         p->packet_num = multifd_send_state->packet_num++;
>>         p->flags |= MULTIFD_FLAG_SYNC;
>>         p->pending_job++;
>>+        qemu_file_update_rate_transfer(rs->f, p->packet_len);
>
>The original code seems forget to update
>
>    ram_counters.multifd_bytes
>    ram_counters.transferred
>
>Sounds we need to update these counters here too.

Yes, Thanks for review
I'll send a new version with a new patch to fix it.

On Mon, Jul 29, 2019 at 2:40 PM Wei Yang <richardw.yang@linux.intel.com>
wrote:

> On Mon, Jul 29, 2019 at 10:32:53AM +0800, Ivan Ren wrote:
> >Limit the speed of multifd migration through common speed limitation
> >qemu file.
> >
> >Signed-off-by: Ivan Ren <ivanren@tencent.com>
> >---
> > migration/ram.c | 22 ++++++++++++----------
> > 1 file changed, 12 insertions(+), 10 deletions(-)
> >
> >diff --git a/migration/ram.c b/migration/ram.c
> >index 889148dd84..e3fde16776 100644
> >--- a/migration/ram.c
> >+++ b/migration/ram.c
> >@@ -922,7 +922,7 @@ struct {
> >  * false.
> >  */
> >
> >-static int multifd_send_pages(void)
> >+static int multifd_send_pages(RAMState *rs)
> > {
> >     int i;
> >     static int next_channel;
> >@@ -954,6 +954,7 @@ static int multifd_send_pages(void)
> >     multifd_send_state->pages = p->pages;
> >     p->pages = pages;
> >     transferred = ((uint64_t) pages->used) * TARGET_PAGE_SIZE +
> p->packet_len;
> >+    qemu_file_update_rate_transfer(rs->f, transferred);
> >     ram_counters.multifd_bytes += transferred;
> >     ram_counters.transferred += transferred;;
> >     qemu_mutex_unlock(&p->mutex);
> >@@ -962,7 +963,7 @@ static int multifd_send_pages(void)
> >     return 1;
> > }
> >
> >-static int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> >+static int multifd_queue_page(RAMState *rs, RAMBlock *block, ram_addr_t
> offset)
> > {
> >     MultiFDPages_t *pages = multifd_send_state->pages;
> >
> >@@ -981,12 +982,12 @@ static int multifd_queue_page(RAMBlock *block,
> ram_addr_t offset)
> >         }
> >     }
> >
> >-    if (multifd_send_pages() < 0) {
> >+    if (multifd_send_pages(rs) < 0) {
> >         return -1;
> >     }
> >
> >     if (pages->block != block) {
> >-        return  multifd_queue_page(block, offset);
> >+        return  multifd_queue_page(rs, block, offset);
> >     }
> >
> >     return 1;
> >@@ -1054,7 +1055,7 @@ void multifd_save_cleanup(void)
> >     multifd_send_state = NULL;
> > }
> >
> >-static void multifd_send_sync_main(void)
> >+static void multifd_send_sync_main(RAMState *rs)
> > {
> >     int i;
> >
> >@@ -1062,7 +1063,7 @@ static void multifd_send_sync_main(void)
> >         return;
> >     }
> >     if (multifd_send_state->pages->used) {
> >-        if (multifd_send_pages() < 0) {
> >+        if (multifd_send_pages(rs) < 0) {
> >             error_report("%s: multifd_send_pages fail", __func__);
> >             return;
> >         }
> >@@ -1083,6 +1084,7 @@ static void multifd_send_sync_main(void)
> >         p->packet_num = multifd_send_state->packet_num++;
> >         p->flags |= MULTIFD_FLAG_SYNC;
> >         p->pending_job++;
> >+        qemu_file_update_rate_transfer(rs->f, p->packet_len);
>
> The original code seems forget to update
>
>     ram_counters.multifd_bytes
>     ram_counters.transferred
>
> Sounds we need to update these counters here too.
>
> >         qemu_mutex_unlock(&p->mutex);
> >         qemu_sem_post(&p->sem);
> >     }
> >@@ -2079,7 +2081,7 @@ static int ram_save_page(RAMState *rs,
> PageSearchStatus *pss, bool last_stage)
> > static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
> >                                  ram_addr_t offset)
> > {
> >-    if (multifd_queue_page(block, offset) < 0) {
> >+    if (multifd_queue_page(rs, block, offset) < 0) {
> >         return -1;
> >     }
> >     ram_counters.normal++;
> >@@ -3482,7 +3484,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >     ram_control_before_iterate(f, RAM_CONTROL_SETUP);
> >     ram_control_after_iterate(f, RAM_CONTROL_SETUP);
> >
> >-    multifd_send_sync_main();
> >+    multifd_send_sync_main(*rsp);
> >     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> >     qemu_fflush(f);
> >
> >@@ -3570,7 +3572,7 @@ static int ram_save_iterate(QEMUFile *f, void
> *opaque)
> >     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
> >
> > out:
> >-    multifd_send_sync_main();
> >+    multifd_send_sync_main(rs);
> >     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> >     qemu_fflush(f);
> >     ram_counters.transferred += 8;
> >@@ -3629,7 +3631,7 @@ static int ram_save_complete(QEMUFile *f, void
> *opaque)
> >
> >     rcu_read_unlock();
> >
> >-    multifd_send_sync_main();
> >+    multifd_send_sync_main(rs);
> >     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> >     qemu_fflush(f);
> >
> >--
> >2.17.2 (Apple Git-113)
> >
>
> --
> Wei Yang
> Help you, Help me
>
