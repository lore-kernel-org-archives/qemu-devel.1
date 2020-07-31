Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E8EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D14B022B3F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aB72qbpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14B022B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YjT-0007Xp-3N
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Yhs-000643-Nu
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:20:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k1Yhq-0006m6-QV
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596216030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3Mt3n/tM91XPpsvn32E5YcUkFNaOeXdBYEWC24yJvYo=;
 b=aB72qbpUwzA75WS2+ujOxhCP8pJ1TijuR3C3lt6p3/1E/52TCCVxxaRbq2otae9OVqT79e
 YzplnRiJ+Dmf8SirHvVmqgGovNjv58XIKgAD1w49HUFQ1sk+UwXKKniXg4z4+/maFK+nvl
 hehjRYRHrDtrYhps/xW4Uq9/Rp+/wK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-Rx0y1yPOO0GJeeSuzyJWWw-1; Fri, 31 Jul 2020 13:20:28 -0400
X-MC-Unique: Rx0y1yPOO0GJeeSuzyJWWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC0AA8015F3;
 Fri, 31 Jul 2020 17:20:26 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 463C874F53;
 Fri, 31 Jul 2020 17:20:13 +0000 (UTC)
Date: Fri, 31 Jul 2020 18:20:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
Message-ID: <20200731172010.GG3660103@redhat.com>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6ceef1ab-5078-d77e-6e6c-4e1bfc01418a@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 12:39:31
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
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 06:35:23PM +0200, Paolo Bonzini wrote:
> On 31/07/20 17:26, John Snow wrote:
> > I saw the critique that we still use JSON-ish for the runtime QMP
> > protocol, and moving the QAPI IDL to a standard wouldn't remove all
> > instances of a custom format from our tree.
> 
> Sorry, but "still using JSON" is not a critique that makes any sense.
> 
> 99% of the websites you use daily use JSON as their RPC
> frontend-to-backend language; OpenAPI is essentially JSON over HTTP.
> There must be something good in JSON.

I think it is more about the way we're using JSON to define QMP.

We take a raw socket (or really arbitrary reliable stream no matter
what its transport), and are defining the full RPC protocol. We define
the initial QMP handshake, the separation of commands/replies/events
and of course the data format for the content sent. We've invented
the whole stack above the raw sockets layer.

In the case of typical REST APIs, HTTP provides the core protocol
with handshake, and separation of commands/replies. The application
is merely declaring JSON to be the data format for the messages.

So in the case of REST APIS with JSON, you can use any standard
HTTP / REST client library, for the protocol part and any standard
JSON library for the data (de)serialization.

Talking to QEMU you get to build your own client from first
principals. QMP isn't especially complicated, so this isn't a
massive burden, but it doesn't exactly give a good first impression
either. It also means QMP isn't easily extensible. eg if we used
HTTP as our base, then we'd get remote TLS support for free from
whatever library we used. We could do TLS with QMP, but again we
get to build the pieces for this on both client/server side.
Using a standard like HTTP would open door to other interesting
ideas, like putting a HTTP proxy on a host, so you can have 1
HTTP server fronting all 1000 VMs on the host, meaning only need
a single port instead of 1000 ports in the firewall.  Again you
can build such an architecture on top of QMP but its all wheel
reinvention.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


