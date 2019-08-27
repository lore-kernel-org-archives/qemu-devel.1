Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ABAC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F59E2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 13:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F59E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2blt-0006Ji-Sa
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 09:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1i2bl0-0005i9-Vl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1i2bky-0000ty-Lt
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:43:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1i2bky-0000sh-Ee
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 09:43:32 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CC0E91762
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 13:43:30 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id c25so11905362otp.15
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 06:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=exJLbOqq35XiPgsDG6Umhc0CpHyNr+XZvpR88d8Lwug=;
 b=PAe/sdx5sXt1G97kT7lq7+cTBogAM8xhpUq9M+sXhYAqrucDabDWrBAjPW4Fua57bl
 Vs8UIoN+jOKxevIykzlnFmA4Dz6f7fjMkivAhYYlBkvWeCCWWqCHvw5tGcAAvY94sNd+
 0c5EV950JIUE97RwdBm6W+FLDxSQuYT2L76bvn98sXqvzI2VXx55/+66BBa+H5VgN+gx
 /zyd+ej3qkxcA7JoJ4zgOV84ynwxsBxtetdoR5EZ544lf7c6xdF7gqziuKTqBuqhkD7/
 QDPUAhLryu9b9GhLHsBAa8fENCHOGIxR/yE8riygEKbBhabN6cu7sNhP4dQaxDdWRE9+
 d2MQ==
X-Gm-Message-State: APjAAAWL4M2mbm3RehyP9k8+TxqmYIUjcGRfWAdLeAcdJvbBAyxmNB6W
 n+b+DFN5arykRZCFjIEWu2v2t1mpj7LchgN2Cqvb2wnVYIu2VjUBVyfG5tItWr5Iu1ziMp0MDV5
 ssVf5hZppZq8uoJuu/zUrIVMQJxcPyZY=
X-Received: by 2002:a05:6830:1e96:: with SMTP id
 n22mr4833476otr.368.1566913409841; 
 Tue, 27 Aug 2019 06:43:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzTR4a42jWAhocWSTVj73zrZzY0rQC0XM4GaXqgyreaCfODVG5g9+46KyV9HADEXxCRySI4n4ySPNw1TGil/pg=
X-Received: by 2002:a05:6830:1e96:: with SMTP id
 n22mr4833461otr.368.1566913409567; 
 Tue, 27 Aug 2019 06:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190827124909.16824-1-johannes@sipsolutions.net>
In-Reply-To: <20190827124909.16824-1-johannes@sipsolutions.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Aug 2019 17:43:18 +0400
Message-ID: <CAMxuvaykLW7U5gppHe8Z2zCg6bcGxeVuBMrkKk8Eh9V3oQAY6w@mail.gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] libvhost-user-glib: fix VugDev main fd
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Johannes Berg <johannes.berg@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Aug 27, 2019 at 4:49 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> If you try to make a device implementation that can handle multiple
> connections and allow disconnections (which requires overriding the
> VHOST_USER_NONE handling), then glib will warn that we remove a src
> while it's still on the mainloop, and will poll() an FD that doesn't
> exist anymore.
>
> Fix this by making vug_source_new() require pairing with the new
> vug_source_destroy() so we can keep the GSource referenced in the
> meantime.
>
> Note that this requires calling the new API in vhost-user-input.
> vhost-user-gpu also uses vug_source_new(), but never seems to free
> the result at all, so I haven't changed anything there.
>
> Fixes: 8bb7ddb78a1c ("libvhost-user: add glib source helper")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  contrib/libvhost-user/libvhost-user-glib.c | 15 ++++++++++++---
>  contrib/libvhost-user/libvhost-user-glib.h |  1 +
>  contrib/vhost-user-input/main.c            |  6 ++----
>  3 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user-glib.c b/contrib/libvhost-user/libvhost-user-glib.c
> index 99edd2f3de45..eaf88b8aa749 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.c
> +++ b/contrib/libvhost-user/libvhost-user-glib.c
> @@ -91,7 +91,6 @@ vug_source_new(VugDev *gdev, int fd, GIOCondition cond,
>      g_source_add_poll(gsrc, &src->gfd);
>      id = g_source_attach(gsrc, NULL);
>      g_assert(id);
> -    g_source_unref(gsrc);
>
>      return gsrc;
>  }
> @@ -131,6 +130,16 @@ static void vug_watch(VuDev *dev, int condition, void *data)
>      }
>  }
>
> +void vug_source_destroy(GSource *src)
> +{
> +    if (!src) {
> +        return;
> +    }
> +
> +    g_source_unref(src);
> +    g_source_destroy(src);

I would call destroy() (detach) before unref().

> +}
> +
>  bool
>  vug_init(VugDev *dev, uint16_t max_queues, int socket,
>           vu_panic_cb panic, const VuDevIface *iface)
> @@ -144,7 +153,7 @@ vug_init(VugDev *dev, uint16_t max_queues, int socket,
>      }
>
>      dev->fdmap = g_hash_table_new_full(NULL, NULL, NULL,
> -                                       (GDestroyNotify) g_source_destroy);
> +                                       (GDestroyNotify) vug_source_destroy);
>
>      dev->src = vug_source_new(dev, socket, G_IO_IN, vug_watch, NULL);
>
> @@ -157,5 +166,5 @@ vug_deinit(VugDev *dev)
>      g_assert(dev);
>
>      g_hash_table_unref(dev->fdmap);
> -    g_source_unref(dev->src);
> +    vug_source_destroy(dev->src);
>  }
> diff --git a/contrib/libvhost-user/libvhost-user-glib.h b/contrib/libvhost-user/libvhost-user-glib.h
> index 64d539d93aba..1a79a4916ef2 100644
> --- a/contrib/libvhost-user/libvhost-user-glib.h
> +++ b/contrib/libvhost-user/libvhost-user-glib.h
> @@ -31,5 +31,6 @@ void vug_deinit(VugDev *dev);
>
>  GSource *vug_source_new(VugDev *dev, int fd, GIOCondition cond,
>                          vu_watch_cb vu_cb, gpointer data);
> +void vug_source_destroy(GSource *src);
>
>  #endif /* LIBVHOST_USER_GLIB_H */
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
> index 449fd2171a5a..7d6b0f9d80cc 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -187,7 +187,7 @@ vi_queue_set_started(VuDev *dev, int qidx, bool started)
>      }
>
>      if (!started && vi->evsrc) {
> -        g_source_destroy(vi->evsrc);
> +        vug_source_destroy(vi->evsrc);
>          vi->evsrc = NULL;
>      }
>  }
> @@ -401,9 +401,7 @@ main(int argc, char *argv[])
>
>      vug_deinit(&vi.dev);
>
> -    if (vi.evsrc) {
> -        g_source_unref(vi.evsrc);
> -    }
> +    vugg_source_destroy(vi.evsrc);

typo

>      g_array_free(vi.config, TRUE);
>      g_free(vi.queue);
>      return 0;

vhost-user-input calls g_source_destroy(), please replace it too with
vug_source_destroy().

vhost-user-gpu "renderer_source" leaks, not this patch fault, but
worth to mention in the commit. Feel free to add a second commit to
fix that too.

