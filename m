Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1076C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D28206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D28206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aHM-0007Jk-MY
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <johannes@sipsolutions.net>) id 1i2aE8-0004bs-12
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <johannes@sipsolutions.net>) id 1i2aE5-0004SS-VR
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:05:31 -0400
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]:44938
 helo=sipsolutions.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <johannes@sipsolutions.net>)
 id 1i2aE5-0004P2-Lp
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:05:29 -0400
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>)
 id 1i2aE3-0007RV-EZ; Tue, 27 Aug 2019 14:05:27 +0200
Message-ID: <6bc59e7805274911b87850442bebf124d586ac71.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Date: Tue, 27 Aug 2019 14:05:26 +0200
In-Reply-To: <CAJ+F1CKay50ZPhEORdY4N1OzBM6+-Dr9uzZwxTvRFJsFYb5qCA@mail.gmail.com>
 (sfid-20190827_134449_376172_CFE2EE59)
References: <20190827083124.30791-1-johannes@sipsolutions.net>
 <CAJ+F1CJo+oo74_Y6c1PGKq4uULUKXwky3cxSpopxLVmcow-9_w@mail.gmail.com>
 <06c72fcfdafa1028439e10ad6cbf15434f11764f.camel@sipsolutions.net>
 <CAJ+F1CKay50ZPhEORdY4N1OzBM6+-Dr9uzZwxTvRFJsFYb5qCA@mail.gmail.com>
 (sfid-20190827_134449_376172_CFE2EE59)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:191:4433::2
Subject: Re: [Qemu-devel] [PATCH] libvhost-user-glib: fix VugDev main fd
 cleanup
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

> What other problems? Sure we need the caller to unref.

Don't recall, and now I can't reproduce it, sorry.

> > > Imho, we should change the behaviour of the function to return a ref
> > > source.
> > 
> > Which "the function" do you mean?
> 
> The vug_source_new() function.
[...]
> Sure we can add the socket to the hashtable, but it's better to avoid
> since we can.

Ok, that works. Does this seem better to you?

diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-user/libvhost-user-glib.c
index 99edd2f3de45..3e902ccd2efb 100644
--- a/contrib/libvhost-user/libvhost-user-glib.c
+++ b/contrib/libvhost-user/libvhost-user-glib.c
@@ -91,7 +91,6 @@ vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
     g_source_add_poll(gsrc, &src->gfd);
     id = g_source_attach(gsrc, NULL);
     g_assert(id);
-    g_source_unref(gsrc);
 
     return gsrc;
 }
@@ -131,6 +130,15 @@ static void vug_watch(VuDev *dev, int condition, void *data)
     }
 }
 
+void vug_source_destroy(GSource *src)
+{
+    if (!src)
+        return;
+
+    g_source_unref(src);
+    g_source_destroy(src);
+}
+
 bool
 vug_init(VugDev *dev, uint16_t max_queues, int socket,
          vu_panic_cb panic, const VuDevIface *iface)
@@ -144,7 +152,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket,
     }
 
     dev->fdmap = g_hash_table_new_full(NULL, NULL, NULL,
-                                       (GDestroyNotify) g_source_destroy);
+                                       (GDestroyNotify) vug_source_destroy);
 
     dev->src = vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
 
@@ -157,5 +165,5 @@ vug_deinit(VugDev *dev)
     g_assert(dev);
 
     g_hash_table_unref(dev->fdmap);
-    g_source_unref(dev->src);
+    vug_source_destroy(dev->src);
 }
diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhost-user/libvhost-user-glib.h
index 64d539d93aba..1a79a4916ef2 100644
--- a/contrib/libvhost-user/libvhost-user-glib.h
+++ b/contrib/libvhost-user/libvhost-user-glib.h
@@ -31,5 +31,6 @@ void vug_deinit(VugDev *dev);
 
 GSource *vug_source_new(VugDev *dev, int fd, GIOCondition cond,
                         vu_watch_cb vu_cb, gpointer data);
+void vug_source_destroy(GSource *src);
 
 #endif /* LIBVHOST_USER_GLIB_H */
diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
index 449fd2171a5a..7d6b0f9d80cc 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -187,7 +187,7 @@ vi_queue_set_started(VuDev *dev, int qidx, bool started)
     }
 
     if (!started && vi->evsrc) {
-        g_source_destroy(vi->evsrc);
+        vug_source_destroy(vi->evsrc);
         vi->evsrc = NULL;
     }
 }
@@ -401,9 +401,7 @@ main(int argc, char *argv[])
 
     vug_deinit(&vi.dev);
 
-    if (vi.evsrc) {
-        g_source_unref(vi.evsrc);
-    }
+    vugg_source_destroy(vi.evsrc);
     g_array_free(vi.config, TRUE);
     g_free(vi.queue);
     return 0;


