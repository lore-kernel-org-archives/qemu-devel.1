Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB83C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92842070A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+ACd5I9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92842070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZtPg-0005up-Tp
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iZtOu-00052S-9y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iZtOr-0000l2-5c
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:14:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42976
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iZtOq-0000iw-Fm
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574846053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWksnq0KsgOQBCM/rvMvoMbGatlFf60tZKcDP4OdFN0=;
 b=H+ACd5I9qhYe0YJdf7IRycPODMfy9sR3inKYR+3h6HouR11NlcTWdgMWFxKw7xL2bwBklV
 jD3XWYt+j2DiOh04DVgb4t8G1301R7PFGs2WYs9Saxa4Z8FMWXBa2Y2M9lOPDe075r64Vz
 KBOR0P0NiZe6IttvA00vP1knMsQJ6BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-uzQjB2fvPyKXVB1Hwrih2A-1; Wed, 27 Nov 2019 04:14:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37B2E1010FC3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:14:10 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ABFC600CA;
 Wed, 27 Nov 2019 09:14:03 +0000 (UTC)
Date: Wed, 27 Nov 2019 09:14:01 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 jfreimann@redhat.com
Subject: Re: [PULL 0/5] i386 patches for QEMU 4.2-rc
Message-ID: <20191127091401.GA3016@work-vm>
References: <157475994490.31055.5778115059405326734@37313f22b938>
 <e5352867-943c-6010-4700-78a0e25cea10@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e5352867-943c-6010-4700-78a0e25cea10@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: uzQjB2fvPyKXVB1Hwrih2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 11/26/19 10:19 AM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20191126085936.1689-1-pbonzini@re=
dhat.com/
> >=20
> > This series failed the docker-quick@centos7 build test. Please find the=
 testing commands and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > make docker-image-centos7 V=3D1 NETWORK=3D1
> > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> >    TEST    check-unit: tests/test-thread-pool
> > wait_for_migration_fail: unexpected status status=3Dwait-unplug allow_a=
ctive=3D1
> > **
> > ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:wait_for_migration_=
fail: assertion failed: (result)
> > ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:w=
ait_for_migration_fail: assertion failed: (result)
> > make: *** [check-qtest-aarch64] Error 1
>=20
> Should we worry about this error?

Interesting; that should be fixed by Jens'
284f42a520cd9f5905abac2fa50397423890de8f - unless fix dev_unplug_pending
is still lying;  it's showing we're still landing in 'wait-unplug' on
aarch, because it's got a virtio-net by default; even though we've not
got a failover device setup.  CCing Jens.

Dave

> [...]
> > real    9m26.610s
> > user    0m8.328s
> >=20
> >=20
> > The full log is available at
> > http://patchew.org/logs/20191126085936.1689-1-pbonzini@redhat.com/testi=
ng.docker-quick@centos7/?type=3Dmessage.
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


