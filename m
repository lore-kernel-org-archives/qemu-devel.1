Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23059C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 21:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DB921783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 21:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll/sfDUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUHaH-0003Q3-HT
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 16:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iUHZe-0002mn-Dn
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 16:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iUHZd-00063z-BY
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 16:50:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iUHZd-00063r-7z
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 16:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573509012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FFPhjTRyOHdSMVKAskNdWCVEzS8Rzo3OFT9WQV2n+E=;
 b=Ll/sfDUzcooMqymyBdeYKg2jljndfA/Ut0zXqArXZlmg9bEfGNXBBKyHUQ/1kwytrDukt5
 S641ai7yyx0MTuPXbEMnRMPbflvVch2W9bLdz83uc6UVQOyzkQrsyePlnHjfnL2V2rCw4P
 9TmzHitFGoLdtn9+vA1gStekH5n6TEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-6x18aJklOdipzSwUPZIfag-1; Mon, 11 Nov 2019 16:50:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4250E835BCD;
 Mon, 11 Nov 2019 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 687CA60852;
 Mon, 11 Nov 2019 21:49:58 +0000 (UTC)
Date: Mon, 11 Nov 2019 16:49:57 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 3/8] Acceptance tests: use avocado tags for machine type
Message-ID: <20191111214957.GC19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-4-crosa@redhat.com>
 <b1730ec3-51ce-719b-81ca-e24194283ec7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b1730ec3-51ce-719b-81ca-e24194283ec7@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6x18aJklOdipzSwUPZIfag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 02:20:45PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > @@ -310,7 +302,7 @@ class BootLinuxConsole(Test):
> >       def test_arm_emcraft_sf2(self):
> >           """
> >           :avocado: tags=3Darch:arm
> > -        :avocado: tags=3Dmachine:emcraft_sf2
> > +        :avocado: tags=3Dmachine:emcraft-sf2
>=20
> Maybe add a comment about this change, "Since avocado 72(?) we can ... so
> use ..."
>=20

You mean on this specific test docstring?  I'm confused if there's a
special reason for doing it here, of if you're suggesting adding a
similar command to all tag entries which make use of the extended
character set (which I think would be too verbose, repetitve, and hard
to maintain).

> > diff --git a/tests/acceptance/cpu_queries.py b/tests/acceptance/cpu_que=
ries.py
> > index af47d2795a..293dccb89a 100644
> > --- a/tests/acceptance/cpu_queries.py
> > +++ b/tests/acceptance/cpu_queries.py
> > @@ -20,8 +20,8 @@ class QueryCPUModelExpansion(Test):
> >       def test(self):
> >           """
> >           :avocado: tags=3Darch:x86_64
> > +        :avocado: tags=3Dmachine:none
>=20
> Not to confuse with None :)
>=20

Yep! :)

- Cleber.


