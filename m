Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB25C35250
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F09F22314
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gczhp7/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F09F22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59415 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05VT-0000Hr-QM
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j05Uf-0007PB-Tt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j05Ue-0007Po-Pa
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:24:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j05Ue-0007Pe-Lq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581089072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95HNyZLzTVgc+rMg1S2GcJQc40c5OxOjsFv1scrmkws=;
 b=gczhp7/21PB8c6MfG+XxPNdDxzSUP6HTOpMADAHV4kyMqyj23Bixu1anKnOWKhVikEhJnU
 lFNjngFJ+yFnXr16ewfHr3KUzvjHFdPQsx2zkm0Eyi6Q3vWfoiY1cC+JUEGo+eaENLT5FN
 F6BxaVsLFq4+gwEdSR+jMulJRpaRLDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-r_FgCRhfMjmSRKzk7vJ0Aw-1; Fri, 07 Feb 2020 10:24:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53290184AEAA;
 Fri,  7 Feb 2020 15:24:19 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B67C15C28C;
 Fri,  7 Feb 2020 15:24:15 +0000 (UTC)
Date: Fri, 7 Feb 2020 15:24:13 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: should we have a new 'tools' manual?
Message-ID: <20200207152413.GF3302@work-vm>
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: r_FgCRhfMjmSRKzk7vJ0Aw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> So far we've been converting docs to Sphinx and assigning them
> to manuals according to the division originally set out by
> Paolo on the wiki: https://wiki.qemu.org/Features/Documentation
>=20
>  * QEMU User-mode Emulation User's Guide (docs/user)
>  * QEMU System Emulation User's Guide (docs/system)
>  * QEMU System Emulation Management and Interoperability Guide (docs/inte=
rop)
>  * QEMU System Emulation Guest Hardware Specifications (docs/specs)
>  * QEMU Developer's Guide (docs/devel, not shipped to end-users)
>=20
> but some of our documentation has always been a bit of an awkward
> fit into this classification:
>  * qemu-img
>  * qemu-nbd
>  * virtfs-proxy-helper
> etc. I've tended to put these things into interop/.
>=20
> The proposal from Dan and David was that we should add a sixth
> top-level manual
>  * QEMU Tools Guide (docs/tools)
>=20
> which would be a more coherent place for these to live.
>=20
> This seems like a good idea to me -- do people agree? What's
> our definition of a "tool", or do we just know one when we see it?
> What in particular should go in tools/ ?

The virtiofs security guide that Stefan wrote doesn't really fit in the exi=
sting ones.
It's not about the use of qemu itself so it's not docs/user or
docs/system.
It's not specifying protocols or commands so it's not docs/interop.
It's not hardware.
And it's for end users not developers, so it's not docs/devel.

However, there's a question about whether it makes sense to bundle
the docs for all of the tools into one big manual when they're
really independent.

Dave


> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


