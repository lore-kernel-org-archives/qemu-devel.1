Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D860CC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADED620C01
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADED620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmw9i-0002YR-DB
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 04:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35592)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hmw9W-00025w-CB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hmw9V-0007qS-7z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:16:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hmw9V-0007pk-0M
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:16:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so16059570wrm.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 01:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ZXe1tJnzYaaCKKWbquZTx1iP6Fn8k98oY9fj7dmSc6o=;
 b=t3gW3OGmb91ShSyboyKPLpCAu75cnm5PLwUHbugZYWRfaD+N1WsUd7IP9F1DIY2TJv
 Ux97hMZOLpwKDYojLJqbbOxfb7EXtbELF+1fHCbwHuF93tHfq0SLS0l+Hl3S6BdUeVyP
 WbQ7BLpp115CgvzoJGm9EG6P7ObnEmoSFmMgskLUOGCj2fRaNu5gVGxCn0Zdots5wkQl
 aEPJoMKRCBRZH1+/th77q6juu1iEKNwrxJlC2Tvg23swgg37z/DdkXuYkqPYWq9G13aE
 ZcPVseVRx1oOMNG3V0ofgUXTSQ7C5Tg0WvP5DTzsCpjnXoPiSPyu0oTjDSMQG2WsJD+s
 4Ncg==
X-Gm-Message-State: APjAAAUT+Q5ick+Qs/taXe3wQwO3lFis2Mya/XxCTNv0HTEJN8e1wgwJ
 i0hc05cX2117gcPIioCiTNwpcw==
X-Google-Smtp-Source: APXvYqzUXK9NXNEFf4NRVhB7r3C/IQTBKBaBO0PMe+/fdXH14ODy3M4QT5Xeh9jueOZIwngi2i0FjA==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr26821428wrw.96.1563178564006; 
 Mon, 15 Jul 2019 01:16:04 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id r12sm19490582wrt.95.2019.07.15.01.16.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 01:16:03 -0700 (PDT)
Date: Mon, 15 Jul 2019 10:16:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190715081601.rpvavykcuhyr3fiw@steredhat>
References: <20190712104617.94707-1-sgarzare@redhat.com>
 <5017daf6-2739-d260-09fd-cfccd6c77bc1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5017daf6-2739-d260-09fd-cfccd6c77bc1@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] gluster: fix .bdrv_reopen_prepare when
 backing file is a JSON object
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 12, 2019 at 08:35:12PM +0200, Max Reitz wrote:
> On 12.07.19 12:46, Stefano Garzarella wrote:
> > When the backing_file is specified as a JSON object, the
> > qemu_gluster_reopen_prepare() fails with this message:
> >     invalid URI json:{"server.0.host": ...}
> > 
> > In this case, we should call qemu_gluster_init() using the QDict
> > 'state->options' that contains the parameters already parsed.
> > 
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1542445
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/gluster.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/gluster.c b/block/gluster.c
> > index 62f8ff2147..26971db1ea 100644
> > --- a/block/gluster.c
> > +++ b/block/gluster.c
> > @@ -931,7 +931,16 @@ static int qemu_gluster_reopen_prepare(BDRVReopenState *state,
> >      gconf->has_debug = true;
> >      gconf->logfile = g_strdup(s->logfile);
> >      gconf->has_logfile = true;
> > -    reop_s->glfs = qemu_gluster_init(gconf, state->bs->filename, NULL, errp);
> > +    /*
> > +     * If 'bs->filename' starts with "json:", then 'state->options' will
> > +     * contain the parameters already parsed.
> > +     */
> > +    if (state->bs->filename && !strstart(state->bs->filename, "json:", NULL)) {
> > +        reop_s->glfs = qemu_gluster_init(gconf, state->bs->filename, NULL,
> > +                                         errp);
> > +    } else {
> > +        reop_s->glfs = qemu_gluster_init(gconf, NULL, state->options, errp);
> > +    }
> 
> Hmmm, aren’t they always in state->options?

Yes, you are rigth, but the qemu_gluster_parse() doesn't search for the
'filename' in the QDict *options.

Maybe I can simply modify it in this way in order to hanlde this case,
calling qemu_gluster_init() only with 'state->options'.

diff --git a/block/gluster.c b/block/gluster.c
index 26971db1ea..91d674cd2b 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -695,6 +695,11 @@ static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
                               QDict *options, Error **errp)
 {
     int ret;
+
+    if (!filename) {
+        filename = qdict_get_try_str(options, GLUSTER_OPT_FILENAME);
+    }
+
     if (filename) {
         ret = qemu_gluster_parse_uri(gconf, filename);
         if (ret < 0) {


Do you think it is better/cleaner?

Thanks,
Stefano

