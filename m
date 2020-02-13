Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12267C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3112082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RL43SGJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3112082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HOo-0006Ay-U6
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j2HNG-0004ut-EG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j2HNC-0005K5-Oa
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:29:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23991
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j2HNC-0005Ie-K0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581611393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=k0mio9km5bn7ph/hwWtbePoZwbHU/Brla2tsBL6srtU=;
 b=RL43SGJitUFug3S6R/aFpyKJY5f5dcd0khDYbTN96G8emNwE2TknCGwiY4RYzmN5nE0j21
 3HJ+3+D3jyOpqVua5JxaIvAw78Dm/Tvp4CHG9BQIgX0pUYuka18MQuEaCNt9ir8acHGhak
 mGZ09humVTJgXhv5TyGldaetTGtpeow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206--pH4hS84NYiT3cNe5UEFlw-1; Thu, 13 Feb 2020 11:29:49 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1275910054E3;
 Thu, 13 Feb 2020 16:29:48 +0000 (UTC)
Received: from localhost (ovpn-117-100.ams2.redhat.com [10.36.117.100])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7208D26E77;
 Thu, 13 Feb 2020 16:29:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>
Subject: [PATCH v2 0/2] docs: rstfy some s390 docs
Date: Thu, 13 Feb 2020 17:29:40 +0100
Message-Id: <20200213162942.14177-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -pH4hS84NYiT3cNe5UEFlw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://qemu.readthedocs.io/en/latest/index.html collects various
documents from the QEMU docs/ subdirectory; however, none of the
s390 files are currently included. Therefore, I set out to convert
the existing files to rst and hook them up.

s390-dasd-ipl was straightforward enough; I also found a numbering
issue.

vfio-ap was quite a bit more involved, but I hope I have produced
something readable (more review can never hurt...) I also
moved this into the system/ subdirectory; not sure if that is the
best resting place, but it seemed to be the most reasonable one.

Tested via running 'make html' and inspecting the output.

Branch: https://github.com/cohuck/qemu rstfy-s390-v2

Changes v1->v2 (mostly addressing feedback from Peter; thanks!):
- dasd ipl: fix some indentation
- vfio-ap: autogenerate contents table
- vfio-ap: use more literals
- vfio-ap: convert some examples to tables
- vfio-ap: various other formatting cleanups=20

Cornelia Huck (2):
  docs: rstfy s390 dasd ipl documentation
  docs: rstfy vfio-ap documentation

 MAINTAINERS                                   |   4 +-
 docs/devel/index.rst                          |   1 +
 .../{s390-dasd-ipl.txt =3D> s390-dasd-ipl.rst}  | 119 +--
 docs/system/index.rst                         |   1 +
 docs/{vfio-ap.txt =3D> system/vfio-ap.rst}      | 796 +++++++++---------
 5 files changed, 484 insertions(+), 437 deletions(-)
 rename docs/devel/{s390-dasd-ipl.txt =3D> s390-dasd-ipl.rst} (51%)
 rename docs/{vfio-ap.txt =3D> system/vfio-ap.rst} (55%)


base-commit: 81f49abaaac2b88062bd1b07f451d9527ed1c9ce
--=20
2.21.1


