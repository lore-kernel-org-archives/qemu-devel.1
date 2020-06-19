Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52EDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95535206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWpO7y87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95535206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKIW-0000T4-Sf
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmKHc-00089n-V2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:54:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35907
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jmKHb-00021A-1I
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592585666;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A//y9jUsGEhwIPdvgAsoNy1Db9+PrmiQ/+zFWOzTsM0=;
 b=UWpO7y87EmBW8jFd93aK3u4lAQlLhGHPEB5htlY7AM8XJJohnSOYM0CZFd56IcTpNWRCtq
 kb+Wx7+1OseieeYZBTL6bHIYMqR7eTiS0qcYNF+J1nZtYX6xP9Zw7/8OYAQQzCJOR4T8lS
 PFMKrfoOMEPs0In7J4DeVCs+SQnbiHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-1iO5acclOJan8WC9yIa7Kw-1; Fri, 19 Jun 2020 12:54:24 -0400
X-MC-Unique: 1iO5acclOJan8WC9yIa7Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32AA1801503;
 Fri, 19 Jun 2020 16:54:23 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09CFC1C8;
 Fri, 19 Jun 2020 16:54:02 +0000 (UTC)
Date: Fri, 19 Jun 2020 17:53:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 1/4] Introduce yank feature
Message-ID: <20200619165359.GC700896@redhat.com>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <dc2724aead900db8fb3bed0a066f7c7e2654edb0.1590421341.git.lukasstraub2@web.de>
 <20200616143957.GF550360@redhat.com>
 <20200619162350.5a1cb518@luklap>
MIME-Version: 1.0
In-Reply-To: <20200619162350.5a1cb518@luklap>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 04:23:50PM +0200, Lukas Straub wrote:
> On Tue, 16 Jun 2020 15:39:57 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Mon, May 25, 2020 at 05:44:23PM +0200, Lukas Straub wrote:
> > > The yank feature allows to recover from hanging qemu by "yanking"
> > > at various parts. Other qemu systems can register themselves and
> > > multiple yank functions. Then all yank functions for selected
> > > instances can be called by the 'yank' out-of-band qmp command.
> > > Available instances can be queried by a 'query-yank' oob command.
> > > 
> > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > ---
> > >  qapi/misc.json |  45 +++++++++++++
> > >  yank.c         | 174 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  yank.h         |  67 +++++++++++++++++++
> > >  3 files changed, 286 insertions(+)
> > >  create mode 100644 yank.c
> > >  create mode 100644 yank.h  
> > 
> > > +void yank_register_function(char *instance_name, YankFn *func, void *opaque)
> > > +{
> > > +    struct YankInstance *instance;
> > > +    struct YankFuncAndParam *entry;
> > > +
> > > +    qemu_mutex_lock(&lock);
> > > +    instance = yank_find_instance(instance_name);
> > > +    assert(instance);
> > > +
> > > +    entry = g_slice_new(struct YankFuncAndParam);
> > > +    entry->func = func;
> > > +    entry->opaque = opaque;
> > > +
> > > +    QLIST_INSERT_HEAD(&instance->yankfns, entry, next);
> > > +    qemu_mutex_unlock(&lock);
> > > +}
> > > +
> > > +void yank_unregister_function(char *instance_name, YankFn *func, void *opaque)
> > > +{
> > > +    struct YankInstance *instance;
> > > +    struct YankFuncAndParam *entry;
> > > +
> > > +    qemu_mutex_lock(&lock);
> > > +    instance = yank_find_instance(instance_name);
> > > +    assert(instance);
> > > +
> > > +    QLIST_FOREACH(entry, &instance->yankfns, next) {
> > > +        if (entry->func == func && entry->opaque == opaque) {
> > > +            QLIST_REMOVE(entry, next);
> > > +            g_slice_free(struct YankFuncAndParam, entry);
> > > +            qemu_mutex_unlock(&lock);
> > > +            return;
> > > +        }
> > > +    }
> > > +
> > > +    abort();
> > > +}  
> > 
> > Since the NBD impl no longer needs to register multiple different functions
> > on the same insance_nane, these methods could be be simplified, to only
> > accept a single function, instead of keeping a whole list. This would avoid
> > need to pass a function into the unregister() method at all.
> 
> Multiple yank functions are still needed for multifd migration.

Oh I missed that subtlety, so fine to ignore my suggestion.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


