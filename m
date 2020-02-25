Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBC8C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C64A20658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5Y7Jj2T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C64A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6b7A-000886-Jc
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j6b6O-0007Cd-1W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j6b6M-0003mq-AZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:22:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44601
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j6b6M-0003mS-70
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:22:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582640541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2aLCFzhmAmB98WM/njRsLRD51oF6zudJ4HCxmvF6j4=;
 b=G5Y7Jj2TnGs79pWLvBXMvLsM+/5IUwYDTqy4DmmiFJ5VZ9KWfKFDBuYwL/ZsW/esoKit7z
 cCERHxY2Le6Dxd4bzOlRYkT2pBLKpTt7pyB/YGWXjbzBUb9g5s26Osn5hi2uQRF7AuDl/9
 ghX3ZhtR8aFuN2RNMJNrpEZUYrrjGtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-ri21FGsCNdiF7vVhXEyLrQ-1; Tue, 25 Feb 2020 09:22:17 -0500
X-MC-Unique: ri21FGsCNdiF7vVhXEyLrQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1214800D5B;
 Tue, 25 Feb 2020 14:22:16 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-203.ams2.redhat.com
 [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 663875D9CD;
 Tue, 25 Feb 2020 14:22:16 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 6476C3E04B9; Tue, 25 Feb 2020 15:22:13 +0100 (CET)
Date: Tue, 25 Feb 2020 15:22:13 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/2] docs: Convert qemu-cpu-models.texi to rST
Message-ID: <20200225142213.GI24572@paraplu>
References: <20200220142001.20774-1-kchamart@redhat.com>
 <20200220142001.20774-2-kchamart@redhat.com>
 <CAFEAcA9_tDWLxBrsw42uxs7E_QmA5XzsMs6zwmzpckv=B0ksuw@mail.gmail.com>
 <20200225091611.GF24572@paraplu>
MIME-Version: 1.0
In-Reply-To: <20200225091611.GF24572@paraplu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 10:16:11AM +0100, Kashyap Chamarthy wrote:
> On Fri, Feb 21, 2020 at 03:16:29PM +0000, Peter Maydell wrote:

[...]

> > rST is not a fan of having multiple definition list items
> > sharing a definition, which is probably why you ended up with
> > the list approach you did, but we can do:
> >=20
> > ``Skylake-Server``, ``Skylake-Server-IBRS``
> >     Intel Xeon Processor (Skylake, 2016)
> >=20
> > ``Skylake-Client``, ``Skylake-Client-IBRS``
> >     Intel Core Processor (Skylake, 2015)

For this series, I'll stick with the above approach throughout.  And
will do the separate description of each model and how it differs from
the previous, as a follow-up.  (No, I won't forget about it :-))

[...]

--=20
/kashyap


