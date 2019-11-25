Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992D6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6587E2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VS9RnaCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6587E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFJG-0006tq-Er
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iZFG1-0002mk-1z
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iZF9q-0004g6-7K
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:16:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iZF9q-0004eh-3R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574691365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mgotSoUNbxcCWh+6DzlU1YcbQ2Ye8GRyO4y9HJ4noiE=;
 b=VS9RnaCrPeS/p6eblf2ZeMqlfJ7hUpbAh+2I7iQKA3w8FvGf5y3WJ9TQnWGlGzpOZYraqE
 1Sfb7UiTN7rF3p/5TReQthdoHzIcGWkelle6JChTOWa7O3F6A8pjQ5Dfj2kjkN0vZcxW+g
 /m3+CDJKGTOpRmvew+YFnZwJnUas4z0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-1_TftK4vP8i-1zj7kUZB6w-1; Mon, 25 Nov 2019 09:16:03 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99D3010B169F
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 14:16:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9639D5C1D4;
 Mon, 25 Nov 2019 14:15:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6C05D9C90; Mon, 25 Nov 2019 15:15:53 +0100 (CET)
Date: Mon, 25 Nov 2019 15:15:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Avocado notes from KVM forum 2019
Message-ID: <20191125141553.kb6y2zx2qlley27p@sirius.home.kraxel.org>
References: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
 <20191125135802.GH4438@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20191125135802.GH4438@habkost.net>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1_TftK4vP8i-1zj7kUZB6w-1
X-Mimecast-Spam-Score: 0
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
Cc: avocado-devel@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > 1) Working offline
> >=20
> > Various people complained Avocado requires online access, and they woul=
d
> > like to use it offline.
> >=20
> >   Maintainer workflow example is:
> >=20
> >   - run avocado
> >   - hack QEMU, build
> >   - git pull
> >   - build
> >   - hack QEMU
> >   (go offline)
> >   - hack QEMU
> >   - build
> >   - run avocado <- FAILS
> >=20
>=20
> Ouch.  This shouldn't happen even with no explicit --offline
> option.  Failure to download artifacts shouldn't make tests
> report failure.

Related (and already discussed in the past):  There should be a separate
"downloads artifacts", especially for larger ones which easily fail to
download on slower internet links due to hitting the test timeout while
downloading ...

cheers,
  Gerd


