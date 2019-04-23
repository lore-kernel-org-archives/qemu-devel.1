Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803CC282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D64621738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3eW+xAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D64621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIsaN-0004YZ-SO
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 06:23:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYj-0003ZX-Q7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYg-0005si-P3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYg-0005s4-IQ; Tue, 23 Apr 2019 06:21:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id o25so17967973wmf.5;
	Tue, 23 Apr 2019 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=ABMVRh/EebAPEu8p0CxgLcyM7hB6Pd0N1p3ZvK/9ds8=;
	b=k3eW+xAZh/2zQmtIbAJTE7Icpv9kHC2/CfV2SaLiwOhOw4/hLRgKtU/F0XGijTj9YW
	5Z1xsH2SGCFpLhT9M8QW5niPXSVwgcpAUjbdeaP2IdOW/wOzSQMwKkGRgWFq/Ll20ukr
	y8w20ngH3Lw9XUHOW4HQPAxcAFqu+/Jtavr2H456wng3s/Ym3ZtX8TEiXmF/xm5j2Mo2
	765JnZcVjplKJOsBNQWh6jR0yTDuQl2CyAzdZtuFfrZimi8IA9+ppDTjgRSGzhCnj9y7
	TK+S55Ovt3Gy2CegeRyA37VdqbfZCN3zH5l+qJYakUlYz2DyzhrRr8B7Hp1X9ivzfm0k
	et1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding;
	bh=ABMVRh/EebAPEu8p0CxgLcyM7hB6Pd0N1p3ZvK/9ds8=;
	b=si0wAK4rD1OWhnAwwkornbGXc+ecSglZJZKA5KqRTgrHLA2QYJYry06sC2Nw2rNZa7
	w5B5hJDDjGTy2KFCtCwP7swKBOXFQSB4w3peftB95Auz3KYtsR8iy2k0LzMBKeHGtXac
	T656x37rJluAltvFoJVdAEkPHUaFJVRFQW22M2XW0wT9MMo8bPmHvv5gNT2PbgVMKKjB
	u/64PAPN0E6kSHjRWKwrP2vtcwO9wAbBM6rsnl34QAlapRh3t+Jr6fFjx0SvSQwbWjWs
	Jk9ziB+l8VMa92W19Eo1ZsHxdyFynDjuEtpsA3ZSdUWOpeYEhDmQgQTmUwzysoF1qOvr
	QoFQ==
X-Gm-Message-State: APjAAAUPZiRTsSPAKyfxGiACgdLewH+nnjAKCFZpvyPujPf8IV6BMwRP
	IjnYdjHX8qHuRTTduKwNk1g=
X-Google-Smtp-Source: APXvYqxi4ingIcR9eYab9+ryBID2DaYZhXApqtzoogLZNpdMTB9jMVrFWauecVBMw1F7GDUU+uqkZQ==
X-Received: by 2002:a1c:21c1:: with SMTP id h184mr1767913wmh.128.1556014907499;
	Tue, 23 Apr 2019 03:21:47 -0700 (PDT)
Received: from x1.local (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	j190sm17934653wmb.19.2019.04.23.03.21.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 03:21:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 12:21:43 +0200
Message-Id: <20190423102145.14812-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH 0/2] tcg: more tcg_gen_abs() uses
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423102143.z2KhSLrt8eaR-aV_YBD6P6_vQ6hfmMDv5K9UEZARYCs@z>

Hi Richard, 2 patches to complete your series.

Based on Richard's "tcg vector improvements" series:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03430.html

Regards,

Phil.

Based-on: <20190420073442.7488-1-richard.henderson@linaro.org>

Philippe Mathieu-Daudé (2):
  target/ppc: Use tcg_gen_abs_i32
  target/tricore: Use tcg_gen_abs_tl

 target/ppc/translate/spe-impl.inc.c | 14 +-------------
 target/tricore/translate.c          | 27 +++++----------------------
 2 files changed, 6 insertions(+), 35 deletions(-)

-- 
2.19.1


