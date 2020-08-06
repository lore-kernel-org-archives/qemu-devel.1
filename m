Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C92C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5AB22D00
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lf6FZGc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5AB22D00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3bRs-0005u1-Q3
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 04:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3bR9-0005QQ-QS
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:39:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3bR7-0000s0-DT
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 04:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596703179;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GqG+JA+Gqx9K0v+2iqLpk3uvYM5+OokXWP84pT375gs=;
 b=Lf6FZGc24Ch3NferHyjysguu1eKMB6xZ2Eh1JRZObNLVSGfr+wSJpEoxoQPP3vU9d4hww4
 yFiCf+mMk8Hai3vV642JCB89Q6KffIPAdSg2gKmn4DvO7vgQTFr5WYqeguvLnXHXAHmu26
 o/gh4mnqicfURotLD5d2RL2lxOgzecI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-ROiBYr-_PuuuMbqfiG5i7w-1; Thu, 06 Aug 2020 04:38:50 -0400
X-MC-Unique: ROiBYr-_PuuuMbqfiG5i7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4F7102C7ED;
 Thu,  6 Aug 2020 08:38:49 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B7C25DA6A;
 Thu,  6 Aug 2020 08:38:43 +0000 (UTC)
Date: Thu, 6 Aug 2020 09:38:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] ide: Get rid of IDEDrive struct
Message-ID: <20200806083841.GA4159383@redhat.com>
References: <20200805194812.1735218-1-ehabkost@redhat.com>
 <CAFEAcA8-REfRgq=713Tq9PfSNmRPZVzBKmLzoWLauZjqF5q5eQ@mail.gmail.com>
 <20200805221417.GC1700540@habkost.net>
 <877ducb9jl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <877ducb9jl.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 07:58:06AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Wed, Aug 05, 2020 at 09:41:25PM +0100, Peter Maydell wrote:
> >> On Wed, 5 Aug 2020 at 20:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> >
> >> > The struct had a single field (IDEDevice dev), and is only used
> >> > in the QOM type declarations and property lists.  We can simply
> >> > use the IDEDevice struct directly instead.
> >> >
> >> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> > @@ -327,7 +323,6 @@ static void ide_hd_class_init(ObjectClass *klass, void *data)
> >> >  static const TypeInfo ide_hd_info = {
> >> >      .name          = "ide-hd",
> >> >      .parent        = TYPE_IDE_DEVICE,
> >> > -    .instance_size = sizeof(IDEDrive),
> >> >      .class_init    = ide_hd_class_init,
> >> >  };
> >> 
> >> This is one of those areas where this change works and reduces
> >> amount of code, but on the other hand it means the QOM type
> >> doesn't follow the common pattern for a leaf type of:
> >>  * it has a struct
> >>  * it has cast macros that cast to that struct
> >>  * the typeinfo instance_size is the size of that struct
> >> (it wasn't exactly following this pattern before, of course).
> >
> > Is this really a pattern that exists and we want to follow?
> > I don't see why that pattern would be useful for simple leaf
> > types.
> 
> I think the pattern exists, but we deviate from it in quite a few
> places, probably just because it's so much boilerplate.
> 
> Related: Daniel's "[PATCH 0/4] qom: reduce boilerplate required for
> declaring and defining objects".  Perhaps Daniel has an opinion on
> taking shortcuts with leaf types.

I think following a consistent pattern everywhere is important,
because people look at existing code to guide their new code.
The boilerplate pain is very real, but I think my patch series
you point to will reduce the burden sufficiently that the kind
of optimization proposed here is not required.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


