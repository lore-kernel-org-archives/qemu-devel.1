Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B1C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB31922262
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 16:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VFqTqDPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB31922262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlYU-0000i9-UW
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKlX5-0007zD-CA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:52:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKlX2-0005Vh-Qn
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600793560;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qc6TZL54s4dJFarQuN3iq4D6GuscyYqHZtW3brPE1IA=;
 b=VFqTqDPKGrBPYd9ubPy25GQfyhqZRVjka7Pesl7Y815eu+cOfloHOTJaoP4RZgKKh1n9eB
 4xGC6yva1f0Pb1mvlakjDJVF5BjKNdUMPQorY/vov1h/xf+q5EsPqxTHYUOolkqwaxpROk
 d3DRmgV0fgyozl29nQspOYk8Dhz8InA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-USqeik3gNUymft68ZFmWEQ-1; Tue, 22 Sep 2020 12:52:35 -0400
X-MC-Unique: USqeik3gNUymft68ZFmWEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3102F57037;
 Tue, 22 Sep 2020 16:52:34 +0000 (UTC)
Received: from redhat.com (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58486614F5;
 Tue, 22 Sep 2020 16:52:26 +0000 (UTC)
Date: Tue, 22 Sep 2020 17:52:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
Message-ID: <20200922165223.GT1989025@redhat.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874knpluez.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi,
 Stefan" <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, "Bonzini,
 Paolo" <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 05:09:56PM +0200, Markus Armbruster wrote:
> Marc-André Lureau <marcandre.lureau@redhat.com> writes:
> 
> > Hi
> >
> > On Mon, Sep 21, 2020 at 1:16 PM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> We've made use of this extensively.  See also
> >> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
> >>
> >> How do such changes affect clients of the proposed D-Bus interface?
> >
> > The introspection XML will always reflect the expected signature. You
> > should bump your interface version whenever you make incompatible
> > changes.
> 
> How do "interface versions" work?  Client's and server's version need to
> match, or else no go?

Yes, both client and server need to support the same "interface" in order
to talk to each other. If a service makes an incompatible API change, then
then change the interface name. It is common to include a number in the
interface name.

Of course some changes can be made in a backwards compatible manner so
don't require changing the interface. eg adding new methods, adding
new signals (aka async events), adding new properties.

Adding/changing/removing parameters  in an existing method is what
causes an interface incompatability.

You can potentially mitigate the inability to change parameters by
modelling parameters in a variety of ways.

Many of the tricks common in traditional C libraries for future
proofing API designs will apply equally well to DBus APIs.

For example, instead of modelling everything as a distinct positional
parameter, you can model them as optional named parameters. These would
be exposed as an array(map(string-variant)) - basically think of it as a
hash table. This is a half-way house between very strongly typed and very
weakly typed worlds.  Libvirt takes this approach with some of our C APIs
that we expect to grow parameters over time.

A variant on this is to expose some data in a custom document format
as a single parameter. For example if there was an API requesting a
description of a block backend properties, instead of having a DBus
API where all the block backend props were explicitly modelled, just
have a single string parameter that returns a JSON/XML doc. You can
extend that doc at will without impacting the DBus API. Again libvirt
takes this approach with our XML doc schema.

A final useful technique is to have a generic "int flags" parameter as
a way to express new functional behaviour by defining extra flags.


The challenge with all these ideas is figuring out whether there's
a viable way to map them into how we describe the current QMP protocol.
I don't think there's a especially good answer to do a 100% automated
mapping from QMP to DBus, while keeping extensibility and also maximising
strong type checking benefits. There's a tradeoff between extensibility
and strong typing that needs some intelligent thought on a case by case
basis IMHO.

For an automated mapping, either we go fully strong typed and accept
that we'll be breaking DBus interface compatibility continually, or
we go full weakly typed and accept that clients won't get much type
validation benefits at build time.

It is the inherant problem with using something weakly typed as the
master specification and trying to translate it to something strongly
typed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


