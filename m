Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DEAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 13:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB0F2245C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 13:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRx3/6nH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB0F2245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1VT6-0006Hf-AQ
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 09:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1VS7-0005i2-0A
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 09:52:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31809
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1VS4-0002l7-TL
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 09:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596203517;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bLD7qhZ5z9SabAGGdUp6JMO50GawjWw0BOEiS4MoI08=;
 b=iRx3/6nHXD31SA5NH6mTAjHjca25Zr/XLYGncXL+DaZeoQgRVN/XSZZMUoAAUIUz0TTjtV
 qLayB7o0EvPUXajysojHuvky3FcdqEuXd9lvsCk/VlAz4v7DZ1+uutJWOIOKeA2sSmOzyK
 neR6X1+c9a6y0i1937hEGk5lm72nyws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-FYF9h1zWPq2P0SDICJE41A-1; Fri, 31 Jul 2020 09:51:49 -0400
X-MC-Unique: FYF9h1zWPq2P0SDICJE41A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 698011005504;
 Fri, 31 Jul 2020 13:51:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C49766179C;
 Fri, 31 Jul 2020 13:51:46 +0000 (UTC)
Date: Fri, 31 Jul 2020 14:51:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] osdep.h: Add doc comment for qemu_get_thread_id()
Message-ID: <20200731135143.GG3641941@redhat.com>
References: <20200716154114.10838-1-peter.maydell@linaro.org>
 <0f8b8fea-2bd0-7616-292b-8fb0f87cec75@redhat.com>
 <CAFEAcA9ukzKGiaV6Tazu8Aezn39v81DKQik1b=jEy=NLnau05w@mail.gmail.com>
 <87k0ylvy0t.fsf@dusky.pond.sub.org>
 <CAFEAcA-AYJ64HE698TMRS6cV=u4ig6S6TU2xufns7fCVbcQXrg@mail.gmail.com>
 <20200730155939.GP3477223@redhat.com>
 <4d2cba04-04d8-9b82-562f-acb84b6010d2@redhat.com>
 <87pn8ct9ga.fsf@dusky.pond.sub.org>
 <53b70f7f-1777-64e5-d80f-6af3d6c1252d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <53b70f7f-1777-64e5-d80f-6af3d6c1252d@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 02:46:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 31, 2020 at 08:46:40AM -0500, Eric Blake wrote:
> On 7/31/20 2:44 AM, Markus Armbruster wrote:
> 
> > > > Thread_id should be optional and thus not filled in if we
> > > > can't provide a sensible value. Unfortunately we made it
> > > > mandatory in QMP.
> > > 
> > > Normally, converting a mandatory output value to optional is a
> > > back-compatibility risk (we could break apps that depended on it being
> > > present).  But if the only apps that depended on it being present are
> > > compiled on Linux, where the member will actually be present, I think
> > > that changing the schema to make it optional for non-Linux platforms
> > > won't be a back-compatibility nightmare (but we will have to be
> > > careful in our documentation).
> > 
> > Options for systems where don't know how to compute a system-wide thread
> > ID:
> > 
> > 0. Return a bogus value: the PID.  This is the status quo.
> > 
> > 1. Return a more obviously bogus value: -1.  Semantic compatibility
> >     break.  Should be harmless, because a QMP client relying on the
> >     thread-id being the PID would be insane.
> > 
> > 2. Make thread-id optional, present iff we can compute a value.
> > 
> >     This is what we should have done, but we didn't, and now it's a
> >     syntactic compatibility break.  Matters only if it actually breaks
> >     QMP clients.  We believe the one we know shouldn't break.
> > 
> > Preferences?
> 
> I'm in favor of 2, but can easily live with 1 if we decide to be that much
> more conservative.  Tooling that can't handle a missing value is not going
> to fare any better with a value that is unusable because it is -1, but the
> important point is that I don't think we have a scenario with such tooling
> depending on the value (the tools that DO depend on the value are built on
> platforms where the value is usable).

I'm fine with (2) too. While technically a backcompat break, it won't
hurt us in the real world, and so is the pragmatic choice that gets us
to a long term better solution.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


