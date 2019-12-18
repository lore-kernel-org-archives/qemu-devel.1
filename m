Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F328C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AF72146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/aGf/ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AF72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZOK-0001pn-DX
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihZCR-0006bQ-Ob
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihZCQ-0008Jc-JT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:17:11 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihZCQ-0008CR-9n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:17:10 -0500
Received: by mail-wr1-x434.google.com with SMTP id g17so2277583wro.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 05:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=qUVNMny0iXUgGdtuz3IrTcDIv1gr6mfwBXXEaqnH0mo=;
 b=E/aGf/ZYKI4wIv2QVi0j+2dcDSjOcVE1rLVPGEF1ibvzSvP2+yFaZBj8A9ljqGKp02
 G453kC02Fg5mRlNSEWBcLv82+GohGmh2nkRMF7U/1iHJO/jtp+PGUf8H3SIHEPvZtLY+
 fwNxXiGyO4/6KvnfswD4k1n8604D3Spb8+NQVYdc/oOPpkcX85/F2UJYmystgsgxaLPK
 qpfQEKaKpx7wrrlL3Qr4RtKrOPeLV7cdZ5Kw9siMpWshbUakxHwVHskjcuidZSlPfDSl
 m2KkRkHp8O1VhZn3FR8/e2OQPaqe2Bya9iWF440Xt5vXbw9Mxqh9oAT+Y4Y9g8VFEdvT
 AaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=qUVNMny0iXUgGdtuz3IrTcDIv1gr6mfwBXXEaqnH0mo=;
 b=dch6OQomyZmN/7fa5JWbOMm+d1yaI5gjy9hvofI3fhKv9lng29g7cbn+Ax1JlBLwld
 4Y59RJ8oMOZV6OWweMUP7cHcUPJufH/H2PYr0sB8cTDwsja0HfDayT0999Rr/qBEGVde
 atij449i+bhCCXDVi9wuvNueTKiutB44zZ1FHT5aaMhtIJ4vCkgftb84N/bg53B1tfHx
 6lhio2iajctaV07qoAmSlFRGwgMq5YJzn44HxXMUqdqk+nHxonCx1eg6JtLjLCBFLCie
 SFqi+4dSBAn2fQQkNZu7SBJtWe9NmP9ScbH8SvhBauvKRD2hM/bYzLOhzlG4ParXvcLu
 cr9g==
X-Gm-Message-State: APjAAAWH+xWhbUer5Z7ffrOavn34lEJZbIrJ3j+QfXJ9/fdi1+2MFKOg
 1O0gECsNOdTLxYZ1GIPhJpy0x1kP
X-Google-Smtp-Source: APXvYqyZ1B8wce7RkBqU8fSc+MZpjYBz3XSzY8fIwq/3n3nXcGWBznDSQDt19W+UmoM/Ni9cNgENnQ==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr2782394wrt.343.1576675028734; 
 Wed, 18 Dec 2019 05:17:08 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id t1sm2447980wma.43.2019.12.18.05.17.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 05:17:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] block/io: serialising request clean up and locking fix
Date: Wed, 18 Dec 2019 14:17:03 +0100
Message-Id: <1576675026-25046-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: kwolf@redhat.com, Peter Lieven <pl@kamp.de>, qemu-block@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Lieven noticed that reqs->overlap_offset and reqs->overlap_bytes
are written outside bs->reqs_lock.  Patch 3 fixes it, while patches 1
and 2 are preparatory cleanups.

Paolo Bonzini (3):
  block: eliminate BDRV_REQ_NO_SERIALISING
  block/io: wait for serialising requests when a request becomes
    serialising
  block/io: take bs->reqs_lock in bdrv_mark_request_serialising

 block/file-posix.c        |   1 -
 block/io.c                | 161 +++++++++++++++++++++++-----------------------
 include/block/block.h     |  12 ----
 include/block/block_int.h |   3 +-
 4 files changed, 80 insertions(+), 97 deletions(-)

-- 
1.8.3.1


