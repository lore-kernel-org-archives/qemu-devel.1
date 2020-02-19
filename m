Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F482C3405F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC19206E2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcS6eSXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC19206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SoB-0007fI-Ji
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4SOW-0003iD-5M
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4SOU-0008HC-Vi
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4SOU-0008Gb-QE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582130414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/dgz8nC3hXpg4D7MtsdYlhbmIeIO1OpXIXWSIDFK/Y=;
 b=KcS6eSXafPCCzT66OXDdcQPYu/qZ1cmELdjCQT0iyFYT1VHgC4cw+8Sl8d5nUBtUEakX6a
 UO/K19lU44VyR1FhMN/MI8AqYcU54lVUni/zs+Hb/crix5GBR8dvny2E4LyJ8gPGlsQGHi
 Gj/MfAZUWNJcUqCfj29TT3cwZJbeGp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-Y1m9mcb8MwGmEaKzFCddzQ-1; Wed, 19 Feb 2020 11:40:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DDB1190D341;
 Wed, 19 Feb 2020 16:40:09 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3604F5DA60;
 Wed, 19 Feb 2020 16:40:09 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 99E2E3E04B8; Wed, 19 Feb 2020 17:40:07 +0100 (CET)
Date: Wed, 19 Feb 2020 17:40:07 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 1/2] docs: Convert qemu-cpu-models.texi to rST
Message-ID: <20200219164007.GC24572@paraplu>
References: <20200219114607.1855-1-kchamart@redhat.com>
 <20200219114607.1855-2-kchamart@redhat.com>
 <CAFEAcA94A3doGQthOTrPuMadOfqrSLBadUbi+3BpHr1MGp_w1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94A3doGQthOTrPuMadOfqrSLBadUbi+3BpHr1MGp_w1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Y1m9mcb8MwGmEaKzFCddzQ-1
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 19, 2020 at 01:16:11PM +0000, Peter Maydell wrote:

[...]

> 3) we create a qemu-cpu-models.7 manpage, so the parts
> of Makefile that currently handle creating it from the
> texi need to be changed to do it from the rST instead.
> You can look at how we handle qemu-block-drivers.7
> for an example. Don't forget that you'll need to add
> a line to docs/system/conf.py to get Sphinx to build
> the manpage, as well as the makefile changes.
> You can check how the manpage renders with
> 'man -l /path/to/builddir/docs/interop/qemu-cpu-models.7'

Peter, how are you able to generate those *.7 `nroff` man pages?  When I
do 'make sphinxbuild' from my build dir ($HOME/buld/qemu), I only see:

    $> make sphinxdocs
    [...]
    make: Nothing to be done for 'sphinxdocs'.
   =20
    $> ls -ls docs/system/ | awk '{print $10}';
   =20
    genindex.html
    index.html
    objects.inv
    qemu-block-drivers.html
    qemu-cpu-models.html
    search.html
    searchindex.js
    _static

No *.7 `nroff` files in docs/system/ nor in docs/interop/. =20

FWIW, I do have the below bit in docs/system/conf.py:

  ...
  man_pages =3D [
      ('qemu-block-drivers', 'qemu-block-drivers',
       u'QEMU block drivers reference',
       ['Fabrice Bellard and the QEMU Project developers'], 7),
      ('qemu-cpu-models', 'qemu-cpu-models',
       u'QEMU CPU Models',
       ['Fabrice Bellard and the QEMU Project developers'], 7)
  ]
  ...


[...]

--=20
/kashyap


