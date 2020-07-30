Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7753BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4368F206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 16:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSeAPPqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4368F206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1BcQ-0004tk-Jz
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 12:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Bbl-0004Kp-Qz
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:40:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Bbi-0004zT-1Q
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 12:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596127236;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgc/fJs8eXhr8X4qXczjyff12t2FQa3Z2DmuoTMW/Kk=;
 b=MSeAPPqzUOV7gtaRxADWHKVbiwKSAZFszUwsqD73KTAsddldxKTzPEr74W/JYwZuRm5giU
 fUOwjm6mJrcRFYp2FSWmLvguSijN5+n4PeLK73DnVKoJI6YXRtmUGfEBUVy/DDX8azAwbb
 BqC0Mlk4VVlr55/Z3lgK3+eEkBBjRQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-MJYViyPONXmqKyDlMGGOwA-1; Thu, 30 Jul 2020 12:40:28 -0400
X-MC-Unique: MJYViyPONXmqKyDlMGGOwA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8186B57;
 Thu, 30 Jul 2020 16:40:27 +0000 (UTC)
Received: from redhat.com (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 211451992D;
 Thu, 30 Jul 2020 16:40:25 +0000 (UTC)
Date: Thu, 30 Jul 2020 17:40:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
Message-ID: <20200730164023.GQ3477223@redhat.com>
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
 <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
 <87k0ylvy0t.fsf@dusky.pond.sub.org>
 <CAFEAcA-AYJ64HE698TMRS6cV=u4ig6S6TU2xufns7fCVbcQXrg@mail.gmail.com>
 <20200730155939.GP3477223@redhat.com>
 <4d2cba04-04d8-9b82-562f-acb84b6010d2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4d2cba04-04d8-9b82-562f-acb84b6010d2@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 11:24:51AM -0500, Eric Blake wrote:
> On 7/30/20 10:59 AM, Daniel P. Berrangé wrote:
> 
> > > Well, I suspect that management-layer code currently has
> > > gone for "assume we're always running on Linux" and was
> > > written by people who knew they were getting a Linux tid...
> > 
> > Yes, on the libvirt side, the functionality that relies on thread_is is
> > only compiled on Linux. If someone wants to use it on other OS, they'll
> > have to provide an impl using their platforms equivalent of
> > sched_setaffinity and friends since none of this stuff is standardized
> > across OS.
> > 
> > 
> > > > The PID is quite unlikely to be "an OS-specific identifier of the
> > > > current thread".  Shouldn't we fail instead of lie when we don't know
> > > > how to compute the truth?
> > > 
> > > Yeah, I think the default codepath is pretty bogus too. Should
> > > the QMP functions have a mechanism for saying "we don't know
> > > a thread-id on this platform" ?
> > 
> > Thread_id should be optional and thus not filled in if we
> > can't provide a sensible value. Unfortunately we made it
> > mandatory in QMP.
> 
> Normally, converting a mandatory output value to optional is a
> back-compatibility risk (we could break apps that depended on it being
> present).  But if the only apps that depended on it being present are
> compiled on Linux, where the member will actually be present, I think that
> changing the schema to make it optional for non-Linux platforms won't be a
> back-compatibility nightmare (but we will have to be careful in our
> documentation).

FWIW, libvirt treats it as mandatory for query-iothreads, but optional
for query-cpus because it was missing in some older QEMU versions
entirely.

Libvirt explicitly only supports macOS, Linux and FreeBSD, so if those
platforms all report a value, libvirt won't care if you make it optional
and omit it for other platforms.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


