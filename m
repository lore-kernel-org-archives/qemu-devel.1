Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0114C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582642073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCkTa6kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582642073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itiSu-0000NY-Da
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1itiPt-0007Qw-NF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1itiPs-0000Zd-He
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:33:17 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:35687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1itiPp-0000Y5-EX; Mon, 20 Jan 2020 20:33:13 -0500
Received: by mail-pg1-x532.google.com with SMTP id l24so581660pgk.2;
 Mon, 20 Jan 2020 17:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wt9J/V15daU/9dXui9BqrGJFV38IpBWg9A6QEYLyt8w=;
 b=bCkTa6kxomnNxRzE5tStW6gpW1JgEIWh9bFNoi4/Hhq709CuoM39nUAmy7vGLO7iCm
 hRkTo3Fk2z34fyTf4o4twf0FcLQAuCO6Q3HM7MK/fmFgYyf0OX9GBf+F3bGHK8fOI1Y/
 o4vWirjzCXJ9tTARaTOqd3/Z7EyibWBlHNi3dFdjhYzoxIuqXcRy9So5qwraPKJYWlzS
 i4ZMoQK4wwqhH2lrk14Pt2gp+LW6g2RGo+w0H3qvzh+2CTgJF+5XLFGtLcX4t8nTLryE
 2zpGg/fSGW6kmJKDyXb3P7FkfltHfPDDr/pPGJcz2RNfaYOV9T48thNlUWrWaOlPlAte
 DNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wt9J/V15daU/9dXui9BqrGJFV38IpBWg9A6QEYLyt8w=;
 b=dXwSLkvOM+zVZNRgTBXuCjKgtHDG92jb9O+Vlm9A3N/+20hvH8GPXZS3VVNkUYnesX
 PqO3LrbFWGG3HMN16HLOgGfNPXq5DPo9Cn6Ssv7igXz6RKRcxriPjnqXCoBqBlYM+qan
 aAtWEgL2SGxiwaTpv3h+RU+bQQhF8Dj7qn+Ad1bVQTnvqVKi0gueOXO7wtGQB/nxnvC+
 mJdEPqUcrbVqMEcdmKh5NbUTecoyziX8oC4s3be6cvE0v5EfcT2DDmbSF5rUeV5TTeS3
 dXrgkgimWpYze9ktQYyesIEDAkKR2NhASkeKN9lBe+7ODp35Ta/Qtq6nXhh4Z8cZyyJZ
 ID9Q==
X-Gm-Message-State: APjAAAXcjQeRQy6O2eo1gSzgmAbDkp2aSEGEEbh7zBzav+W8eOcQ+hlG
 UTvW3qu4/oyP66cXbX11E7E=
X-Google-Smtp-Source: APXvYqzBYv+k6xMFETQNvWwxpaiZ8ldzWCwmI0NBntXN3oa3nfGZsekDqfpUSO3Gx4B1lF+duqJgrw==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr2679894pgb.102.1579570390669; 
 Mon, 20 Jan 2020 17:33:10 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id x132sm40628397pfc.148.2020.01.20.17.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 17:33:10 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 0/2] aspeed/scu: Implement chip id register
Date: Tue, 21 Jan 2020 12:03:00 +1030
Message-Id: <20200121013302.43839-1-joel@jms.id.au>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::532
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements the chip id register in the SCU for the ast2500 and
ast2600. The first patch is a cleanup to separate out ast2400 and
ast2500 functionality.

Joel Stanley (2):
  aspeed/scu: Create separate write callbacks
  aspeed/scu: Implement chip ID register

 hw/misc/aspeed_scu.c | 93 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 23 deletions(-)

-- 
2.24.1


