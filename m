Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138A9C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB17B21852
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayF7kybc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB17B21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRRb-0004iO-U5
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:11:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQR-00045C-MJ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQM-0001kB-BG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hCRPd-0000IF-3j
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id w10so8689873wrm.4
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=owOvWZvwg1TWjVkzRjTWqmhf4gaRveUmGDoMXVuzuJ8=;
	b=ayF7kybc6slS1OrOzymaOXD8LtOH/C0F6OSL8vog08yAQn85XvzwUwBy/CNVGqSxAh
	jdoEBdNpXPGNLj3Aa02HSIna6YSpW3rvQFbUHZ/WPfV3ee0UvxdtIb2JoWymKkjW7shf
	7JD7PPmAGoMu2zayHmCPdl7Tr9VQ0nUWuMwV/c/gpqFxPVWPND2PbIKp6LJ9aTaOzZvA
	JWI+cttlbkg5ZjsgBHGeRA0C26k1riSWZWQP+f/Xp6CG/Vd3TJLd4LzYVdbiWRenIvw0
	8KHRd1vmKEZ50Ay8Hq6HL7GwLvXgZqqjH9lS+GJ7j8tq1HQqG0Tr526ADu1CW8vNoJI/
	uzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=owOvWZvwg1TWjVkzRjTWqmhf4gaRveUmGDoMXVuzuJ8=;
	b=g6hcHo39USqZsMGxd9D4+lKG0puMRk1p6z29QV2ZK2x5Kt6mshmGg7wRN3xwkUOjEv
	iUTe6jwyh0EbNFTW+akNiG+JZslIluHvCx6PGFqivhgavMqLDiw4kDeI+ru3AxCgGiY8
	oC66yAsiDjCEBXJjXdZBzRy6Th7KSAjzKcvnLmjdDNYO3Yu5ebACHfZW4YHmKen+fuay
	as8gza8ZcW1m8bvTdA/HzICJfumYgHtat4Tg+HjZTkSJviEIg2Hz66NydTEh82L7rnea
	abnTo9NrYUM/LHE6+RaNhPd9BH5dCW5kggEGjOVkKZFKOGM+mmJulcPnnSweQi2gs3K0
	jEpQ==
X-Gm-Message-State: APjAAAWkIb3lxOy52qtlZpOHtQ0sg4o0yJW+StlFlge/7j3SEuM+islN
	kEmdpB7O76KBTcsVI+oJpeK8Me4=
X-Google-Smtp-Source: APXvYqz0u/rSNNw3NhVAfPbveNHngTEP4rCCSug92z8La+Ub8iazdJQzoHrzgycpujfA4ubJBINC0Q==
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr8759457wrw.22.1554480589760; 
	Fri, 05 Apr 2019 09:09:49 -0700 (PDT)
Received: from ninjatsu.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	z10sm2966029wmi.15.2019.04.05.09.09.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 09:09:49 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: amarkovic@wavecomp.com
Date: Fri,  5 Apr 2019 17:09:34 +0100
Message-Id: <20190405160938.27494-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v3 0/4] target/mips: errors and warnings
 cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405160934.6GFjyZBldgIHdMx5jsjxUcSVHBfGQ9nxMfoPQhRkA24@z>

This v3 improves on code alignments

Jules Irenge (4):
  target/mips: realign comments to fix checkpatch warnings
  target/mips: add or remove space to fix checkpatch errors
  target/mips: wrap lines to fix checkpatch errors
  target/mips: replace tab code indent with spaces to fix checkpatch
    errors

 target/mips/cpu.h | 213 +++++++++++++++++++++++++---------------------
 1 file changed, 118 insertions(+), 95 deletions(-)

-- 
2.20.1


