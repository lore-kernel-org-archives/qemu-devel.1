Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E763BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B618F20885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXAn1F4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B618F20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3C9-0005gM-W3
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AG-0003p8-Lm; Thu, 02 Jul 2020 13:38:26 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AE-00073y-Tl; Thu, 02 Jul 2020 13:38:24 -0400
Received: by mail-ej1-x644.google.com with SMTP id a1so30708413ejg.12;
 Thu, 02 Jul 2020 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hVuELmh2NIASA91T3RMpAA0z5YbUxZtHzawDfWJCcQY=;
 b=KXAn1F4f3Vgo6aSb7IeGH7cYRQYkUSbFSuki75+Calk3Qur683abzvCxshCb8bCAbZ
 uST/fCRFq0DfUvRxC9I0QGJF+nDSILVmOqMONsMWeQovqbBnHSATvn5yU2uyNCbyGhwE
 2sWdtk2eqhHIvALJu6NpPG6SwN4YyFUA6y7tKRD5l7iJam2y93lXZqQPSp43HfjVmKxU
 TOS1j5hiU9DcqcQrcqn/0sXfucAsGFkZrygh3aiRNOgliedsIRNDuUKjDOkQbpQq1Jl3
 cLSqAR+12UbCnXRlNpID3QmNL3cKsTZSjl/3NphscrUKcsNusWnpCeZN02XEwUeSBhJv
 b+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=hVuELmh2NIASA91T3RMpAA0z5YbUxZtHzawDfWJCcQY=;
 b=e4SL+0YBETehkZmK+iuvnbjCNS8fOgBBTL/uBsQKyQKDLZi8hYMuxq8JanNibXHkO4
 eR1VBy3gN7HXrjA1yuEZbqGfQmgC9JM9bwc8nwiw1LKu+zLtQWJ8JsT9EdUfqwQFhIYt
 +sebxcP7M3+DCTJQJDEDVR7XRN7B2EabEu8hOhU8DWiP3p/uEFhBMbMBdx0ajOCIBl40
 7CYkHHXXYtx3GFMOGnBq8i1uih1AqH59mR77YOqZoDFHQuZxkAYlYDk5kwQ6QexZVvt3
 c3MUSsWAHl/CtZCCh2mpje3ZdEPFg0YEkO57d0XEeDPVxxw6REJXTR3xVuWK8gMx1h6A
 dDlg==
X-Gm-Message-State: AOAM531o/0031DqUSx8A37iIJ+Dzy/VGN+OWvHWjCmyce3P9k8txRQAp
 CZ+Hi1ryu5ndj30eITVs6qidqfFWBIs=
X-Google-Smtp-Source: ABdhPJwGKH/VsyyM1pMlvach7uOkVVYradx8rZX2kwz4ciMv5O8H1rEWdRHwdh6P+j4IIDJwPQTZaQ==
X-Received: by 2002:a17:906:4c48:: with SMTP id
 d8mr27031877ejw.331.1593711500187; 
 Thu, 02 Jul 2020 10:38:20 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/19] mailmap: Add more entries to sanitize 'git log'
 output
Date: Thu,  2 Jul 2020 19:37:59 +0200
Message-Id: <20200702173818.14651-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of these developers have the Signed-off-by tag properly
written, but not the author/committer name. Fix this.
Also we incorrectly wrote Arei Gonglei name, update and reorder.

The committer name/email is displayed when using:

  $ git log --format=fuller

(which can be set in git-config setting format.pretty=fuller).

Example of commits with miswritten committer email:
  3b08098b40 76349f5ba8 eb83c2030a 572992eefa 0d4abda8f7

Note: git-log does not use this file by default until you specify
the --use-mailmap flag:

  $ git log --use-mailmap

Since v3:
- Split 1 patch per developer, Cc'ing each developer (lvivier)

Philippe Mathieu-Daudé (19):
  .mailmap: Update Alexander Graf email address
  .mailmap: Update Paul Burton email address
  .mailmap: Display Andreas Faerber name with diaeresis
  .mailmap: Display correct email address for Arei Gonglei
  .mailmap: Display correctly Chen Fan name
  .mailmap: Display correct email address for Christoph Hellwig
  .mailmap: Display Disheng Su name correctly
  .mailmap: Display Hiroyuki Obinata name correctly
  .mailmap: Display correct email address for Jean-Christophe Dubois
  .mailmap: Display Jia Lina name correctly
  .mailmap: Display Lili Huang name correctly
  .mailmap: Display Marek Dolata name properly
  .mailmap: Display correct email address for Michael S. Tsirkin
  .mailmap: Display correct email address for Michael Tokarev
  .mailmap: Display correct email address for Peter Maydell
  .mailmap: Display correct email address for Richard Henderson
  .mailmap: Display correct email address for Stefan Berger
  .mailmap: Display correct email address for Stefan Weil
  .mailmap: Display Ying Fang name correctly

 .mailmap | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

-- 
2.21.3


