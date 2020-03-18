Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C53C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FB420663
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyVBWU5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FB420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEbK2-0000BH-Of
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jEbJP-00083S-CI
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jEbJM-0004R5-VQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:12:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21993)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jEbJM-0004Q7-Lp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 12:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584547971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MKesYWZ1xwFrJXzc4tmbP1Mshq1TklE3V+Qhk1VyeHQ=;
 b=CyVBWU5IDz1r3MWaEis7G/i3ftnHbZxIcuxXieTrjJ5G/ynLFpsnxybaE0Sm1FkZDuVx2y
 3i7P9a9sa3fedktuJg1SwercW4dndi6Mol6FAaa1t3fbXWFTxHwUpchpyGgTym7FBRmawg
 4C21oNsYdQjB5xxJJUMWRaCS+tLphgs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-8tSJEG03NMi6JWQWO0bqmw-1; Wed, 18 Mar 2020 12:12:26 -0400
X-MC-Unique: 8tSJEG03NMi6JWQWO0bqmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AB3A18FF661;
 Wed, 18 Mar 2020 16:12:25 +0000 (UTC)
Received: from localhost (ovpn-114-216.rdu2.redhat.com [10.10.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B41555C1A4;
 Wed, 18 Mar 2020 16:12:24 +0000 (UTC)
Date: Wed, 18 Mar 2020 12:12:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
Message-ID: <20200318161223.GL1817047@habkost.net>
References: <158450473711.25478.16951249008771308992@39012742ff91>
 <04961888-5610-6805-c4c0-6f952df99d4f@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <04961888-5610-6805-c4c0-6f952df99d4f@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 18, 2020 at 10:59:22AM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 18.03.2020 7:12, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20200318011217.2102748-1-ehabkost=
@redhat.com/
> >=20
> >=20
> >=20
> > Hi,
> >=20
> > This series seems to have some coding style problems. See output below =
for
> > more information:
> >=20
> > Subject: [PULL 0/4] Python queue for 5.0 soft freeze
> > Message-id: 20200318011217.2102748-1-ehabkost@redhat.com
> > Type: series
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > git rev-parse base > /dev/null || exit 0
> > git config --local diff.renamelimit 0
> > git config --local diff.renames True
> > git config --local diff.algorithm histogram
> > ./scripts/checkpatch.pl --mailback base..
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > Switched to a new branch 'test'
> > 1b4f6f3 MAINTAINERS: add simplebench
> > 57b42b6 scripts/simplebench: add example usage of simplebench
> > 99ea4d7 scripts/simplebench: add qemu/bench_block_job.py
> > 196f97d scripts/simplebench: add simplebench.py
> >=20
> > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > 1/4 Checking commit 196f97d8566d (scripts/simplebench: add simplebench.=
py)
> > WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
> > #16:
> > new file mode 100644
> >=20
> > ERROR: please use python3 interpreter
> > #21: FILE: scripts/simplebench/simplebench.py:1:
> > +#!/usr/bin/env python
>=20
> Hmm, yes, we need to fix it.
>=20
> Should I resend?
>=20

Just send that as follow up bug fixes.  No need to resend the
whole series.

--=20
Eduardo


