Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF948C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 21:19:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EC0206DD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 21:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EC0206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Y0t-0004on-RP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 17:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i0Xz9-0003Jk-1o
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 17:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i0Xz5-0001yQ-22
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 17:17:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41634)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i0Xz4-0001y2-Sg
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 17:17:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47A7887630;
 Wed, 21 Aug 2019 21:00:34 +0000 (UTC)
Received: from localhost (ovpn-116-73.gru2.redhat.com [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 744296012E;
 Wed, 21 Aug 2019 21:00:33 +0000 (UTC)
Date: Wed, 21 Aug 2019 18:00:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190821210030.GH7077@habkost.net>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 21 Aug 2019 21:00:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] tests/acceptance: Update MIPS Malta
 ssh test
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
Cc: cohuck@redhat.com, f4bug@amsat.org, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, amarkovic@wavecomp.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 10:27:11PM +0200, Aleksandar Markovic wrote:
> 02.08.2019. 17.37, "Aleksandar Markovic" <aleksandar.markovic@rt-rk.com=
> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > This little series improves linux_ssh_mips_malta.py, both in the sens=
e
> > of code organization and in the sense of quantity of executed tests.
> >
>=20
> Hello, all.
>=20
> I am going to send a new version in few days, and I have a question for
> test team:
>=20
> Currently, the outcome of the script execition is either PASS:1 FAIL:0 =
or
> PASS:0 FAIL:1. But the test actually consists of several subtests. Is t=
here
> any way that this single Python script considers these subtests as sepa=
rate
> tests (test cases), reporting something like PASS:12 FAIL:7? If yes, wh=
at
> would be the best way to achieve that?

If you are talking about each test_*() method, they are already
treated like separate tests.  If you mean treating each
ssh_command_output_contains() call as a separate test, this might
be difficult.

Cleber, is there something already available in the Avocado API
that would help us report more fine-grained results inside each
test case?


>=20
> Thanks in advance,
> Aleksandar
>=20
> > Aleksandar Markovic (2):
> >   tests/acceptance: Refactor and improve reporting in
> >     linux_ssh_mips_malta.py
> >   tests/acceptance: Add new test cases in linux_ssh_mips_malta.py
> >
> >  tests/acceptance/linux_ssh_mips_malta.py | 81
> ++++++++++++++++++++++++++------
> >  1 file changed, 66 insertions(+), 15 deletions(-)
> >
> > --
> > 2.7.4
> >
> >

--=20
Eduardo

