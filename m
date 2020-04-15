Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EA9C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27E52076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekpy+KLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27E52076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjsv-00047I-Oa
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:23:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jOjrz-0002rJ-Ff
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jOjry-00025g-Di
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:31 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:42348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jOjry-00024n-76
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:30 -0400
Received: by mail-ot1-x32c.google.com with SMTP id m18so235626otq.9
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VAFdPGwrZp2yCqP7xNhTZnqtgn9jFsgRW9R1IBHwPYQ=;
 b=ekpy+KLLrnP6ije9zo09cONxFHhqwBAacLW9aGdlqcZXpMop13f4YIHKOopvKxEmRr
 f4P3DxYAMvL02GeATATJ3pbz7VhlUYPexA6PtH4EdLdUqroByS5gQp3HZQsg0EOhy3Ul
 cOXZi3NbMeUi3UNVZnzU6Lmku12IPua3Vvig0DvMIX1dDl+c+W0iGAE9hIxwsHZjt4rg
 SQ6Iye5IGoWVa2236r+p+W37X++RmVgdmKh9MxJkIwhlROoPg0kBOz3oztkU3PHHYmYz
 axjDJaTy6Yxavc5xB3TsqywTdieV3bEQeldOmDhuctJpir+bQ32WYRXU+xuGnNlrPg+H
 mRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VAFdPGwrZp2yCqP7xNhTZnqtgn9jFsgRW9R1IBHwPYQ=;
 b=hqvkIuVoJ7hPC7L7wPcMIDofxouLlOlo+laLE7ff2hXfbxw2lS9uTp4v+y1L9VeJt4
 Of80PF6AGMQ4JAl3QESLTaz8bezdxwo48mt5lDtOGDjGmpTwzUrqmssb6Vt2Qywsgly7
 h1PYimwuO6k8nMjO5rQCYSx6VPaPWvX/LTEWYW3BMc5PTFGxXh/HLnEeSk39syA7VUll
 1YSr2Re7GXi9xEPmcPEuOMwg4+1YtFw43v3HbpiaLfYOj1vOQJhvy5BnBYnJ9FnqPJ+I
 jXZZjvqyTUL1Gu678exD9hGlNFG6+OWHGto0LRrVYvpgzaRRXDhgB94cB835w5aSjdFl
 I75g==
X-Gm-Message-State: AGi0Pubegg5IKpLju7LapjNlJEftfLefqVh+EhCBmPmLibSCbXavbe+u
 l27CXtEZVPz9Q18dExNQKaqe5xTvmk8=
X-Google-Smtp-Source: APiQypK+mapQB0rsFLzxN7+krtHwTuaSo/qp0pkwXJOyYq+cElt41jq+087oCyfU+rzVfr3+I+T6wg==
X-Received: by 2002:a9d:7201:: with SMTP id u1mr23405213otj.293.1586964148588; 
 Wed, 15 Apr 2020 08:22:28 -0700 (PDT)
Received: from localhost ([2600:1700:70:e488:a034:916c:b66:c581])
 by smtp.gmail.com with ESMTPSA id s23sm6978222ook.4.2020.04.15.08.22.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Apr 2020 08:22:28 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/4] qemu-ga patch queue for hard-freeze
Date: Wed, 15 Apr 2020 10:21:58 -0500
Message-Id: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 73995d15557a3cf2328cc6b7982264897c65cf65:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-more-fixes-150420-1' into staging (2020-04-15 12:02:59 +0100)

are available in the Git repository at:

  git://github.com/mdroth/qemu.git tags/qga-pull-2020-04-15-tag

for you to fetch changes up to 1329651fb4d4c5068ad12fd86aff7e52f9e18c34:

  qga: Restrict guest-file-read count to 48 MB to avoid crashes (2020-04-15 09:18:48 -0500)

----------------------------------------------------------------
qemu-ga patch queue for hard-freeze

* enforce 48MB limit for guest-file-read to avoid memory allocation
  failures

----------------------------------------------------------------
Philippe Mathieu-Daudé (4):
      Revert "prevent crash when executing guest-file-read with large count"
      qga: Extract guest_file_handle_find() to commands-common.h
      qga: Extract qmp_guest_file_read() to common commands.c
      qga: Restrict guest-file-read count to 48 MB to avoid crashes

 qga/commands-common.h | 21 +++++++++++++++++++++
 qga/commands-posix.c  | 29 +++++++----------------------
 qga/commands-win32.c  | 35 ++++++++---------------------------
 qga/commands.c        | 33 +++++++++++++++++++++++++++++++++
 qga/qapi-schema.json  |  6 ++++--
 5 files changed, 73 insertions(+), 51 deletions(-)
 create mode 100644 qga/commands-common.h



