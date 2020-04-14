Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EECC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C480B2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeLjkgcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C480B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOry-00085F-RJ
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOoI-00015K-NU
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOoE-0004tB-9z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:53:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOMcJ-0008NV-GQ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 10:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586874766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bmyh+jYPcDijCvpDxDWwxU9xm/Alqb+kJhD/zBQdiwY=;
 b=CeLjkgcZw4PpTNXTar30JufDbMMA1/jqdJkKd5H7TQFU8z5Ql/MaRs+K/R6VXcteCKxEZ0
 jCVIMPcjiWgjJVOFRArDMPXlPeESwV9fszjiPB1k+boygN+3oVkn0rfvB1hToql7ZGrcfX
 UtmKoY+NxE1hcFltjowfEUODgtFLA0g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-loFpgm3yNeGNo1eV0rhkoQ-1; Tue, 14 Apr 2020 10:32:43 -0400
X-MC-Unique: loFpgm3yNeGNo1eV0rhkoQ-1
Received: by mail-wr1-f72.google.com with SMTP id f2so344642wrm.9
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 07:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JgmJ4RQhAwCkbJTUNgKdOeWwPSHSXH8OU4HtYAg8Hi4=;
 b=QSEK14P5DROKdWHJOBETLTIQmzLasjzgs7Ywq+bV1sv5cghDoYXt7P+aLTWIho7baQ
 C8delmWkxfB4c/0HZSVR2WsU5u3I/3E6q4+AC3UCPkRICkDxjVOieZUats+AetgqSYP3
 8LkBGpuuU7DshfXkHRN77EjNhR3GHVAVMeLkK+n4xX47EvbZKl1r6hh5tDR2A2YY6WCJ
 ugtzw/u5NMNFh29vO18rwObqI4RFZ3pBlt8f/d7yhQE9qegeCd8sSs/fPHGR6qIoT+PN
 aEwK0evBFPuXV1LxqPHG74pED/phJCtq81YAM3/f+owCIyfetYrbXBc2JYqUp98KVJT4
 47ww==
X-Gm-Message-State: AGi0PuYIiTdPOYDgFm5ZW7xffksKEe83Yj1U2kfuDJFnnvKvXKDL2hqy
 fxEIB9ICZvptkkqSiDMOfg73TUe3Waof3hTj2qpLoIzj7/qLxlH4D6pXWp0lSo4z4f2ZNVOCYEk
 xp4gPhuDeyU9d7J4=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr23717640wrw.402.1586874762075; 
 Tue, 14 Apr 2020 07:32:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypItr5hxDjn2lOtndBCgMPvZQdbWyHGM6ulmAb3PhtoyhkiRAhtfgF4Cg6Oeqe452dzR7LD66g==
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr23717617wrw.402.1586874761815; 
 Tue, 14 Apr 2020 07:32:41 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b7sm19340044wrn.67.2020.04.14.07.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 07:32:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 0/2] gdbstub: Introduce
 gdb_get_float32/gdb_get_float64 helpers
Date: Tue, 14 Apr 2020 16:32:38 +0200
Message-Id: <20200414143240.21764-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes for GByteArray (commits 462474d760c & a010bdbe719).

Based-on: <20200414102427.7459-1-philmd@redhat.com>
Supersedes: <20200414111846.27495-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (2):
  gdbstub: Introduce gdb_get_float32() to get 32-bit float registers
  gdbstub: Introduce gdb_get_float64() to get 64-bit float registers

 include/exec/gdbstub.h          | 24 ++++++++++++++++++++++++
 target/m68k/helper.c            |  3 ++-
 target/ppc/gdbstub.c            |  4 ++--
 target/ppc/translate_init.inc.c |  2 +-
 target/sh4/gdbstub.c            |  6 ++----
 5 files changed, 31 insertions(+), 8 deletions(-)

--=20
2.21.1


