Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC27C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DE6206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 14:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZDfW83p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DE6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipCmG-0006af-TJ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 09:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCkb-0004aI-O3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipCka-0005Q2-Ot
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 09:56:01 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37135)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipCka-0005OZ-JN; Wed, 08 Jan 2020 09:56:00 -0500
Received: by mail-wr1-x435.google.com with SMTP id w15so3716487wru.4;
 Wed, 08 Jan 2020 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=MA4/B3kJOjZbuduBVuk/7Xq1dFcUYCEZ4vmOrJDPzh8=;
 b=SZDfW83pT9yuDqcBVY+QubNRLlNzGn9iWcvYhnxkPOc2bOEGQWvE0LtyyiJxRYn3hd
 3wgM50j1rg1m+S/vihtu/f7lLexF5z1OPAaDtOfu2UOBDSu1qHRE4GEsmbSIFfHuW8Dz
 3Ce4wCDmqZvTSaCR9zxuhHmrLi0C11SudSDQMRJ51UqOkfFhdv4aRQLIvkVaCbWnLywB
 MJHKIIkS5BH/kYXAeWQkJbgkxRZcCkEVbOJdPfjv7u2NwOlmJrPXc10xXS63X6Ul6Y1d
 OKZnKCAc7NrgItEpYshe0N7v/VYVQm6bHJF23RFydYWNvSB9PNSouL6aqtjRCgKdzuGv
 7fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=MA4/B3kJOjZbuduBVuk/7Xq1dFcUYCEZ4vmOrJDPzh8=;
 b=WNZekVz243XwIRX7jfhxyk3SkktgCfqTD6hsP4qCErZSSn5ee4r+s+xq5zMnmrW21p
 P9sCw3oPZvpSITr5aryHNF1axJm5Lt0iZQzt5sBptOomCP+AMTDl82q+CJnQA19UbPXd
 2WK3rNCi3YghZkY1ej6moZCRcZw9YotxR4TTaHdwOAxwxiCsJ+z5q7uUoEWtgKL7l25C
 aTgNbD2ZMsd2M+YcoLvXVKF5RQUR7AUVGGJtMRMRJcDb0xylkBCR1V4hdIHLa3qfawBg
 meu42HMabpvTcFVPM88+HDnzG8NGlcTN+7iFqJFN23moPCS8AvXwun684VC9NCmbihZj
 bYlA==
X-Gm-Message-State: APjAAAVq3dXurLTd909EerQleSthyluiRq0/U7LfFl1EFvUUnE0Nyt5W
 DripOkHjefnOY+vBX/1sslHESV5n
X-Google-Smtp-Source: APXvYqzg9V75UtZGZg8rj7U49+y5ec3Eyj5xDlirIIBpAjrrqgUE7V6jBxtqPQOgElr/lCWAqDHfSA==
X-Received: by 2002:adf:f990:: with SMTP id f16mr5163292wrr.185.1578495358479; 
 Wed, 08 Jan 2020 06:55:58 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g21sm4703529wrb.48.2020.01.08.06.55.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 06:55:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] block/io: serialising request clean up and locking fix
Date: Wed,  8 Jan 2020 15:55:53 +0100
Message-Id: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Lieven noticed that reqs->overlap_offset and reqs->overlap_bytes
are written outside bs->reqs_lock.  Patch 3 fixes it, while patches 1
and 2 are preparatory cleanups.

v1->v2: fix comment in patch 2, commit message in patch 3 [Kevin]

Paolo Bonzini (3):
  block: eliminate BDRV_REQ_NO_SERIALISING
  block/io: wait for serialising requests when a request becomes
    serialising
  block/io: take bs->reqs_lock in bdrv_mark_request_serialising

 block/file-posix.c        |   1 -
 block/io.c                | 162 +++++++++++++++++++++++-----------------------
 include/block/block.h     |  12 ----
 include/block/block_int.h |   3 +-
 4 files changed, 81 insertions(+), 97 deletions(-)

-- 
1.8.3.1


