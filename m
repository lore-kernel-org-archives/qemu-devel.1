Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC954C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BB821BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYRVO05j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BB821BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3Jf-0002c6-5g
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL3Is-0001cM-B4
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kL3Ip-00008D-Ki
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600861873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGQNGd8yUY4i0Y82loUSbithRncGThHlK82KpK97xa0=;
 b=bYRVO05jqAajiZG2jtEDuQeV7emoPlFdk1aXDO/5gC3ekifQoADTCTQPauk1aP0wRX9hnv
 fVOES9mJHYto0B2j3u0in+J3YbGSeWW/7v9ts2143JfoHaVldlqLMxe6d9Et7vq50PPV8p
 Dh79+PiMXuZWXiSrLudGZkgTs3GrfqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-d0lQPqhEOVWHCslA_tKhog-1; Wed, 23 Sep 2020 07:51:11 -0400
X-MC-Unique: d0lQPqhEOVWHCslA_tKhog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 951961009446;
 Wed, 23 Sep 2020 11:51:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BA34100239A;
 Wed, 23 Sep 2020 11:51:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 325BB1132E9A; Wed, 23 Sep 2020 13:51:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <20200922165223.GT1989025@redhat.com>
Date: Wed, 23 Sep 2020 13:51:02 +0200
In-Reply-To: <20200922165223.GT1989025@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Tue, 22 Sep 2020 17:52:23 +0100")
Message-ID: <87k0wkd849.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi,
 Stefan" <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, "Bonzini, 
 Paolo" <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

[...]
> The challenge with all these ideas is figuring out whether there's
> a viable way to map them into how we describe the current QMP protocol.
> I don't think there's a especially good answer to do a 100% automated
> mapping from QMP to DBus, while keeping extensibility and also maximising
> strong type checking benefits. There's a tradeoff between extensibility
> and strong typing that needs some intelligent thought on a case by case
> basis IMHO.
>
> For an automated mapping, either we go fully strong typed and accept
> that we'll be breaking DBus interface compatibility continually, or
> we go full weakly typed and accept that clients won't get much type
> validation benefits at build time.
>
> It is the inherant problem with using something weakly typed as the
> master specification and trying to translate it to something strongly
> typed.

I avoid "weakly typed" and "strongly typed", because it means different
things to different people.  "Statically typed" and "dynamically typed"
are clear concepts.

Interfaces defined with QAPI are statically typed.

Serialization / deserialization via QMP works even when the interfaces
on both ends differ in certain limited ways.  It supports more
differences than an RPC transport whose idea of "procedure" has both
feet in the grave of ALGOL 60 could.

At either end of the wire, we need to bridge the gap between a
programming language and the wire format.

At the server end (QEMU), we use the QAPI code generator to bridge from
C, and for the one specific version of the QAPI-defined interface this
build of QEMU provides.

Clients we've left to fend for themselves.  Perhaps it's been a matter
of not understanding client requirements well enough, and chickening
out.

A client could do the same as QEMU does: bridge one specific version of
the QAPI-defined interface.  Could even be done with a suitably extended
QAPI code generator.  A client could also bridge multiple interface
versions, if that us useful.

Regardless of the number of versions bridged, the client could still
talk to servers that use another version, thanks to the QMP transport.

When the server (i.e. QEMU) is newer, any new stuff it may provide is
inaccessible (d'oh).  Also, old stuff may be gone (rare, involves going
through the deprecation process).  Graceful degradation when the client
lags behind too much.

When the server is older than the client, any new stuff the client
actually uses won't work.  The client can use introspection to adjust
itself to older servers.  Graceful degradation again.

Nothing so far precludes a statically typed interface for client code!

The problem isn't "weakly typed" QMP (whatever that may mean), it's that
chasing the evolving QAPI-defined interface with manually written code
is a lot of work.

Libvirt has been doing that work, but you know, "what have the Romans
ever done for us?"

Marc-Andr=C3=A9's D-Bus experiment explores another way to bridge the gap.
This bridge is generated, not hand-written.  Because the QMP transport
also gets replaced by one that lacks QMP's capability to "mediate"
between versions, client and server versions become tightly coupled.

This isn't due to static typing.  It's due to use of a tool that makes
different tradeoffs than we made with QAPI/QMP.

I'm not fundamentally opposed to adding some QAPI/not-QMP external
interface, but I'd prefer not to end up with the union of disadvantages
and the intersection of advantages.

If QMP no longer matches our requirements, we should replace it
wholesale.


