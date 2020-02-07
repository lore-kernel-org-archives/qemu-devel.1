Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A4C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32ECA2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBoYC1L3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ECA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00pM-0004Zw-Dk
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j00oX-0002eW-Nq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j00oW-0004IO-N7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:24:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44568
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j00oW-0004HL-JF
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581071084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymCbQtwTdVv0SUivmAgpoMZL4kMp774puPfVd3PoWuo=;
 b=iBoYC1L3FOhYFRF6v9oKqd1FEb3GD7vOgKo4WFtkVZc1ktZ1ZlE4WR2mWNFWE2dZtY629U
 xKH20wE/6orZCt4rdS732JJqpr+zKG5w+cJ1//WM+CBQl6M6Q14A1lKs+GHHi4jQfhzI8G
 j6QeO7WFdeyIRVtE6P9ftrFQhuKDLDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-jyhCeIFaPYq_cnPaVhSIXg-1; Fri, 07 Feb 2020 05:24:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41D6D189F762;
 Fri,  7 Feb 2020 10:24:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9E901001B07;
 Fri,  7 Feb 2020 10:24:34 +0000 (UTC)
Date: Fri, 7 Feb 2020 11:24:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 08/29] qapi: Use ':' after @argument in doc comments
Message-ID: <20200207102433.GC6031@linux.fritz.box>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-9-peter.maydell@linaro.org>
 <87pnequ4og.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87pnequ4og.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: jyhCeIFaPYq_cnPaVhSIXg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.02.2020 um 10:28 hat Markus Armbruster geschrieben:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > @@ -4703,7 +4703,7 @@
> >  #
> >  # Options for creating an image format on a given node.
> >  #
> > -# @driver           block driver to create the image format
> > +# @driver: block driver to create the image format
> >  #
> >  # Since: 2.12
> >  ##
>=20
> Loses the visual alignment.  I'm okay with that, but the folks who took
> the trouble to align the text may have different ideas.  Cc'ing Kevin
> and Max.

I think the documentation is much easier to parse visually with aligned
text as it makes both the option name and the whole part of the comment
that documents options stand out clearly.

Of course, "It is the QEMU coding style." would trump everything, but as
long as there isn't a style guide that requires a wall of text without
spaces and alignment, I'd prefer to leave at least those aligned texts
in place that we have.

Kevin


