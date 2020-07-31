Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D52B20829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 07:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaOVWEqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D52B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1PHK-0003tu-96
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 03:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k1PGT-0003Ny-1t
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:15:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k1PGQ-0004qo-DY
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 03:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596179732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wa3x27q4SkJPfVoRTO7Mt+3T1jWN7NAcJ0F326z38YI=;
 b=CaOVWEqv1GpycLJR/24KnC2HI02OIifzKXE93qX8HodCoovrTfv6RWlGsmhze8rkVbEZjc
 4W7yBaGN8NMHgIQ+U5nI0DkcVcVHLjHoYnQG5BmONz5TWGrIPa2QqSC93FbJkkQU38QKD0
 tnwoFH6snvQBNVjQitXHbpy8eA9Rsg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-KZQOlwiNO2GcmTqdv0XM_w-1; Fri, 31 Jul 2020 03:15:29 -0400
X-MC-Unique: KZQOlwiNO2GcmTqdv0XM_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EADE01005510;
 Fri, 31 Jul 2020 07:15:27 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-24.ams2.redhat.com [10.36.113.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2860100238C;
 Fri, 31 Jul 2020 07:15:14 +0000 (UTC)
Date: Fri, 31 Jul 2020 09:15:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
Message-ID: <20200731071513.GA4707@linux.fritz.box>
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <d3625b38-7f07-ea8b-42c3-1d462d18018f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d3625b38-7f07-ea8b-42c3-1d462d18018f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 03:06:50
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.07.2020 um 17:11 hat Eric Blake geschrieben:
> > The QAPI schema language has two layers:
> > 
> > * JSON, with a lexical and a syntactical sub-layer (both in parser.py)
> > 
> > * QAPI, with a context-free and a context-dependend sub-layer (in
> >    expr.py and schema.py, respectively)
> > 
> > Replacing the JSON layer is possible as long as the replacement is
> > sufficiently expressive (not a tall order).
> 
> I'm open to the idea, if we want to attempt it, and agree with the
> assessment that it is not a tall order.

I'm not so sure about that. I mean, it certainly sounds doable if need
be, but getting better syntax highlighting by default in some editors
feels like a pretty weak reason to switch out the complete schema
language.

At first I was going to say "but if you don't have anything else to do
with your time...", but it's actually not only your time, but the time
of everyone who has development branches or downstream repositories and
will suffer rather nasty merge conflicts. So this will likely end up
having a non-negligible cost.

So is there more to it or are we really considering doing this just
because editors can tell more easily what to do with a different syntax?

Kevin


