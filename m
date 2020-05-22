Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A31FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B2692072C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeJmDC53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2692072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBll-0001lQ-Gn
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjh-00077V-Vw
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48212
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBjg-00067Z-5j
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590169529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=REcohPbhG9fGgxyS9sZyxolC0rPsb35OGuQqGbRsgV4=;
 b=KeJmDC53WcGIEMYuv9o5KBb6B7IsdmpQG8vLPw+ccWEZCjEsJ3ng4udCdoPgjkx1ncZuMI
 hYQhKt1wFHtU4q9PYiKI3Is7I26yr7mTdlbOyOFNQ6yyW5+XcesFfAfxH2xlb2OYEVcMoY
 Khh1M54GbZz1sIH+DZycWnsvmUPbjsg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-PMfdBwznMPawjUV6S6H_TQ-1; Fri, 22 May 2020 13:45:28 -0400
X-MC-Unique: PMfdBwznMPawjUV6S6H_TQ-1
Received: by mail-wr1-f72.google.com with SMTP id e1so2187389wrm.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=REcohPbhG9fGgxyS9sZyxolC0rPsb35OGuQqGbRsgV4=;
 b=Ju0dh75K8RnIo+S7SzMecL5cnbllObf7qSrSsXaaBOQ+crJYbpTWN9uqtEMmjbj4uS
 rFpPhBQiN+sLD74INjpONhynSv7obF377xdz98GygVawDYHwb3rACV9+bAJstRZX8oLM
 z5c4aBJLtM1dI+lr+Vjkv91ZYSFaxCO7N21mBcwisoKjLsoEJNsad9uzyKdAAvylJohN
 1aAyRzxXzpFl10zbNPkbxfv/ujV0kaIUx0MLOTXpFUStEWcrVQeQ4oNGtXHOAK9fLIGA
 iGmEbDHmz2SOf6sVlVdLqM1Ffe/9u8Ruavn/wJof9Q0vKqMgu37N2zioQdlT3qhpovLC
 Yl6Q==
X-Gm-Message-State: AOAM5316p3wwJ39k1LB705L7264bqK91fvqeXw/f/gmtY8P9esWhteMo
 GMA3MKwPLw9DTUZfQ+vRnuEgUWIRwOXaXW/DaKplZPSGnMEjzZg0BeImbw1VbcI4wK3P6gRGuHO
 QWUbclDU/cJe0eFc=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr15008087wmr.49.1590169526324; 
 Fri, 22 May 2020 10:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrd5z2S2lfF8LR4uE48pOwzeZ79Y2+4w7SDSsZpvqGHs2F3/8+puGWU8L6zuF2FprZXUvg5A==
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr15008072wmr.49.1590169526122; 
 Fri, 22 May 2020 10:45:26 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id f123sm10137308wmf.44.2020.05.22.10.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:45:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] pflash-next patches for 2020-05-22
Date: Fri, 22 May 2020 19:45:20 +0200
Message-Id: <20200522174524.29152-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d19f1ab0de8b763159513e3eaa12c5bc68122361:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2020052=
1-1' into staging (2020-05-21 22:06:56 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/pflash-next-20200522

for you to fetch changes up to 1857b9db49770590483be44eb90993c42b2a5a99:

  hw/block/pflash: Check return value of blk_pwrite() (2020-05-22 19:38:14 +0=
200)

----------------------------------------------------------------

- Remove unused timer in CFI01 flash,
- Clean up code documentation,
- Silent a long-standing Coverity warning (2016-07-15).

----------------------------------------------------------------

Mansour Ahmadi (1):
  hw/block/pflash: Check return value of blk_pwrite()

Philippe Mathieu-Daud=C3=A9 (3):
  hw/block/pflash_cfi01: Removed an unused timer
  hw/block/pflash_cfi01: Document use of non-CFI compliant command
    '0x00'
  hw/block/pflash_cfi01: Rename 'reset_flash' label as 'mode_read_array'

 hw/block/pflash_cfi01.c | 71 ++++++++++++++++++++---------------------
 hw/block/pflash_cfi02.c |  8 ++++-
 2 files changed, 42 insertions(+), 37 deletions(-)

--=20
2.21.3


