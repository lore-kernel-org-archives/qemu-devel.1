Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BF521D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR/QYxJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BF521D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiLw-0008Oo-Lv
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iugPT-00049k-6W
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iugPS-0002eH-5M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:36:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iugPS-0002eA-0T
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:36:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579801009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=u4I5sPZ0KV2tFyBD30BSwH+JDJsmHG5U+2z2Fwrie2I=;
 b=QR/QYxJdu9pd6u6Fy2ufyNicSW2aeYdmISDxkRQ3WzB4FV1VXaCQUsG+A6SnbU+ny5b7Jv
 /jbf/GvB1Oy9pxo3XZMirAY3rKTYDMfU+0pbW3MRdHUFkpafPKZ9t9Kg+FerkB5k26CR2g
 IxTRBETnGE2T48s6nwpw3wb8KELZswY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-5YfkmUWtMKGwVKbBTEga6g-1; Thu, 23 Jan 2020 12:36:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A621800D4C;
 Thu, 23 Jan 2020 17:36:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8868F5DA2C;
 Thu, 23 Jan 2020 17:36:35 +0000 (UTC)
Subject: Re: [PATCH rc1 00/24] target/avr merger
To: Michael Rolnik <mrolnik@gmail.com>
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <bdcf69f2-a88a-6484-8321-f8b6a9977763@redhat.com>
 <CAK4993j5xy6uJhi4e-denFjPt3BX+2yLnLcHKSg9hEYHj7QpKw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d3fe7b9d-37ac-e445-4bca-403cdd2dfd80@redhat.com>
Date: Thu, 23 Jan 2020 18:36:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK4993j5xy6uJhi4e-denFjPt3BX+2yLnLcHKSg9hEYHj7QpKw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 5YfkmUWtMKGwVKbBTEga6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 12.56, Michael Rolnik wrote:
> How do I get it? from where?

It's not merged yet. But I hope Richard will send a pull request for
these patches soon...?

 Thomas


> On Thu, Jan 23, 2020 at 7:12 AM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
>=20
>     On 23/01/2020 01.02, Richard Henderson wrote:
>     > This is a merger of Michael's v41 of the base avr architecture,
>     > and v4 of Phil's arduino target boards.=C2=A0 Call this release, or
>     > merge, candidate 1.
>     >
>     > Has all commentary been addressed?=C2=A0 How much more, if anything=
,
>     > does anyone require before allowing normal development in tree?
>=20
>     I just had a quick look at the series. Apart from some few nits, it
>     looks fine to me, so I think it's fine to merge it now.
>=20
>     =C2=A0Thomas
>=20
> --=20
> Best Regards,
> Michael Rolnik


