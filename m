Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CBAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47BF207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbmX0639"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47BF207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnRe-0005HQ-14
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbnQy-0002yX-It
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:48:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbnQx-0001x9-3P
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590076113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zBH8atWFDlPPOx7CdZcY6nT/3fT0D+F9IB0HdGBJsBU=;
 b=MbmX0639Y6r4i4cSaUgVm6NF71w8wMWjhePtqCu/PB2tnZAMqnMv5rNRd4DQnqeJ4F6FQI
 GalKvXFu21qCtqVDNt7LldEPDl+mfluriUHX6h6jffnL5dmn9um3mNvRDttxVm0TQnRCEG
 Gze5reUugfcfaa9hC1VnviJ1k4uD9Kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-xjRZlXfoMmyOOKY3hPeeqg-1; Thu, 21 May 2020 11:48:20 -0400
X-MC-Unique: xjRZlXfoMmyOOKY3hPeeqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C04C78018A5;
 Thu, 21 May 2020 15:48:19 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B0ED90068;
 Thu, 21 May 2020 15:48:09 +0000 (UTC)
Date: Thu, 21 May 2020 16:48:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v2 1/4] Introduce yank feature
Message-ID: <20200521154806.GI2211791@redhat.com>
References: <cover.1590008051.git.lukasstraub2@web.de>
 <20005a15c708fbda983f9be602c55fc0b1979a18.1590008051.git.lukasstraub2@web.de>
 <20200521150335.GO251811@stefanha-x1.localdomain>
 <20200521174241.3b0a267f@luklap>
MIME-Version: 1.0
In-Reply-To: <20200521174241.3b0a267f@luklap>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 05:42:41PM +0200, Lukas Straub wrote:
> On Thu, 21 May 2020 16:03:35 +0100
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
> 
> > On Wed, May 20, 2020 at 11:05:39PM +0200, Lukas Straub wrote:
> > > +void yank_generic_iochannel(void *opaque)
> > > +{
> > > +    QIOChannel *ioc = QIO_CHANNEL(opaque);
> > > +
> > > +    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> > > +}
> > > +
> > > +void qmp_yank(strList *instances, Error **errp)
> > > +{
> > > +    strList *tmp;
> > > +    struct YankInstance *instance;
> > > +    struct YankFuncAndParam *entry;
> > > +
> > > +    qemu_mutex_lock(&lock);
> > > +    tmp = instances;
> > > +    for (; tmp; tmp = tmp->next) {
> > > +        instance = yank_find_instance(tmp->value);
> > > +        if (!instance) {
> > > +            error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> > > +                      "Instance '%s' not found", tmp->value);
> > > +            qemu_mutex_unlock(&lock);
> > > +            return;
> > > +        }
> > > +    }
> > > +    tmp = instances;
> > > +    for (; tmp; tmp = tmp->next) {
> > > +        instance = yank_find_instance(tmp->value);
> > > +        assert(instance);
> > > +        QLIST_FOREACH(entry, &instance->yankfns, next) {
> > > +            entry->func(entry->opaque);
> > > +        }
> > > +    }
> > > +    qemu_mutex_unlock(&lock);
> > > +}  
> > 
> > From docs/devel/qapi-code-gen.txt:
> > 
> >   An OOB-capable command handler must satisfy the following conditions:
> > 
> >   - It terminates quickly.
> Check.
> 
> >   - It does not invoke system calls that may block.
> brk/sbrk (malloc and friends):
> The manpage doesn't say anything about blocking, but malloc is already used while handling the qmp command.
> 
> shutdown():
> The manpage doesn't say anything about blocking, but this is already used in migration oob qmp commands.

It just marks the socket state in local kernel side. It doesn't involve
any blocking roundtrips over the wire, so this is fine.

> 
> There are no other syscalls involved to my knowledge.
> 
> >   - It does not access guest RAM that may block when userfaultfd is
> >     enabled for postcopy live migration.
> Check.
> 
> >   - It takes only "fast" locks, i.e. all critical sections protected by
> >     any lock it takes also satisfy the conditions for OOB command
> >     handler code.
> 
> The lock in yank.c satisfies this requirement.
> 
> qio_channel_shutdown doesn't take any locks.

Agreed, I think the yank code is compliant with all the points
listed above.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


