Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F67206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjfXTE02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F67206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k80XS-0003bl-Vg
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k80Wk-0002tX-TS
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:15:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k80Wh-00010b-1h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597752937;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tLBiiDqfJu5kLyAk6fNy6im+fDJYOW5J4bNG9hYkYEY=;
 b=ZjfXTE02WvcUDJeiyyTRXjE696vHUNXQg5Vy/a9FdyqBmAOkzzSE5wl9TYqzAXywk9kbNb
 SfClSZzZ2ID2Zf8/RHoaadj7oCWDGlkOCEdaJm00QxvyI/9QLRRWt35dnhCkMltcdEqSiw
 fov5qqZ0x6Fnxh/84pFKSzv/Tk39HPk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-ZIdCSJEyNZKzo3n6cC7MHQ-1; Tue, 18 Aug 2020 08:15:30 -0400
X-MC-Unique: ZIdCSJEyNZKzo3n6cC7MHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8491AD6384;
 Tue, 18 Aug 2020 12:15:29 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53871702F1;
 Tue, 18 Aug 2020 12:15:24 +0000 (UTC)
Date: Tue, 18 Aug 2020 13:15:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cole Robinson <crobinso@redhat.com>
Subject: Re: hw-display-qxl.so: undefined symbol: qemu_qxl_io_log_semaphore
Message-ID: <20200818121521.GA23702@redhat.com>
References: <3a19e8c0-215a-bc18-9817-450affec7f08@redhat.com>
 <20200729125034.GG37763@stefanha-x1.localdomain>
 <3206f141-be6b-02e1-d1f3-5f56551ef1d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3206f141-be6b-02e1-d1f3-5f56551ef1d5@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: none client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 11:46:21AM -0400, Cole Robinson wrote:
> On 7/29/20 8:50 AM, Stefan Hajnoczi wrote:
> > On Thu, Jul 16, 2020 at 05:10:26PM -0400, Cole Robinson wrote:
> >> I'm trying to build qemu 5.1.0-rc0 in Fedora. I'm hitting some issues.
> > 
> > For anyone else reading this email thread, this was fixed in QEMU
> > 5.1.0-rc1:
> > 
> >   commit d97df4b84bc42613cf9a03619de453ebd0be30b7
> >   Author: Gerd Hoffmann <kraxel@redhat.com>
> >   Date:   Mon Jul 20 12:03:50 2020 +0200
> > 
> >       qxl: fix modular builds with dtrace
> > 
> 
> FWIW I'm still hitting issues with qemu-5.1.0 GA but maybe it's
> unrelated to that specific fix. Issues reproduce on fedora 33+, not
> fedora 32.

Gerd's fix here was to remove the reference to the
conditional trace_event_get_state_backends()  checks.

This avoids referencing the systemtap  semaphore symbol.

This works..... with systemtap 4.3  or earlier.

In systemtap 4.4 they attempted to support LTO, by changing
the _SDT_PROBE macro so that it *always* references the
semaphore symbol as a hint for LTO.

This broke QEMU again.

While this is obviously a regression in behaviour in systemtap,
I think its possible to argue that QEMU's use of probes is
itself broken.

We have tracepoints in the qxl.so module, but the probes
are all linked into the qemu-system-x86_64 binary, and
not exported for use by the modules.  AFAICT, we've merely
been lucky not to hit this previously, as none of the
modules we had upto now used trace_event_get_state_backends()
checks. Any such use would always have been broken with all
systemtap versions.

IOW, new systemtap 4.4 is exposing a long standing design
flaw in QEMU's probe.

I'm gong to ask the systemtap maintainers for an opinion on
this behaviour change none the less.


If systemtap won't change, then to fix this, for any foo.c
that will be in a module, we need a separate 'foo.trace'
file that generates a .o that is directly linked to the
foo.so, not the qemu-system-x86_64 binary.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


