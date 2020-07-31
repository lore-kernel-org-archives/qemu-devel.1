Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49E3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7089E2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9/fXd6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7089E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1XEd-0002pE-P6
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 11:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1XDR-0001RU-IO
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:45:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1XDO-0001iD-G8
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 11:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596210296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=u8AVr8gNzWhd4MgxSu5zSz/iLajKXPiuasHmXJXn8jY=;
 b=L9/fXd6ovJy8t7tiUiYpQkZCtyZ9WzdznFFba668LjvAFoEYsbthuG//qILz3sucY7zZNK
 N/GMzpOQJCNrD+j/XyoDnLOGGLI+/jvyeBSQzIkOnocbdWfP65EJrcuAMKUu1DomKtN8fq
 jMT+cmpA3/wXfh66URE+acoDW0MVO3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-1sZ9PN98MV2gbf_IF2A8Bw-1; Fri, 31 Jul 2020 11:44:48 -0400
X-MC-Unique: 1sZ9PN98MV2gbf_IF2A8Bw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3000100CCC2;
 Fri, 31 Jul 2020 15:44:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8328F5D9F1;
 Fri, 31 Jul 2020 15:44:32 +0000 (UTC)
Date: Fri, 31 Jul 2020 16:44:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
Message-ID: <20200731154429.GD3660103@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:39:53
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 11:26:28AM -0400, John Snow wrote:
> > The long answer is that as a general philosophy I'm in favour of agressively
> > eliminating anything that is custom to a project and isn't offering an
> > compelling benefit over a functionally equivalent, commonly used / standard
> > solution.
> > 
> 
> I agree as violently as I know how. The purpose of this is not for us, it's
> for the ecosystem.
> 
> I saw the critique that we still use JSON-ish for the runtime QMP protocol,
> and moving the QAPI IDL to a standard wouldn't remove all instances of a
> custom format from our tree.

I'd consider the runtime protocol separately. In terms of what's on the
wire, we use genuine JSON format. The runtime problem is simply that JSON
standard is useless when it comes to integers, leaving behaviour undefined
in the standard if you exceed 53 bits of precision. So there's no way to
reliably parse unsigned 64-bit integers. Given that QEMU needs to pass
uint64 values, JSON was simply the wrong choice of format for QMP.

There's a 3rd aspect which is our source code that deals with JSON, where
we defined some JSON extensions to make it easier for C code to construct
JSON documents for sending over the wire. Back when we did this, it was a
reasonably good idea as no obvious alternative existed for this problem.
Today, I would just suggest using GLib's  GVariant feature, which solves
the same problem for GLib's DBus APIs.

It is a shame we didn't just use DBus back in the day as that's a well
specified, simple protocol that would have done everything we needed,
including the ability to actually represent integers reliably. We
would be able to trivially talk to QEMU from any programming language,
and use common DBus code-generator tools instead of writing code
generators ourselves.


I wish that libvirt had picked DBus all that time ago too, instead of
creating our own RPC based on XDR, which is 95% identical to what
DBus provides but with a massive maint burden for ourselves. Back then
DBus didn't seem like it was good enough as it didn't offer TLS or
SASL support and that looked like such a big deal. With hindsight the
right answer was to add TLS + SASL to DBus, and not invent our own
protocol. We would have lacked TLS/SASL support in libvirt for 6
to 12 months or so, but then would have had 10 years benefitting
from the DBus ecosystem. Life would have been much easier for mgmt
tools using libvirt too, as they could have used native DBus APIs
instead of having to use the C libvirt.so client. This is one of my
biggest regrets with libvirt's architecture, and even ater 10 years
it is still probably worth fixing this mistake and adopting DBus.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


