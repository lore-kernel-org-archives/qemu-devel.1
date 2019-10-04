Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A55C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1033D215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 03:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmb4M+X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1033D215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGEgX-00011u-Mt
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 23:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mattkilgore12@gmail.com>) id 1iGEfL-0000D1-9E
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mattkilgore12@gmail.com>) id 1iGEfK-0005aH-8A
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:54:03 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a]:41525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mattkilgore12@gmail.com>)
 id 1iGEfK-0005Zq-2G
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 23:54:02 -0400
Received: by mail-io1-xd2a.google.com with SMTP id n26so10513375ioj.8
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 20:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pn7BgHsmsBPGfPvSzaGz7jXvEMfKGavJUaa+O3+Rp48=;
 b=Gmb4M+X6bhFPAo84OaeeWPXXQAVclyLhPXmBd6JlPmcXfZlxK21m/pxH9NszMWCwHy
 j8lFTBbiAbIkABD3kruUVLwXallmfvHqYPsyWVPloYmtnKUIpbOd4Sliavw8YA+MBvkF
 HBJvc/iGyq756KmEmwLWn0hmDw0UaXZ8xZ5gupr5uAh1iox8+i1p9JcWqnEVe5tryK6N
 P+KswlD6CfdAin9DuDxhn6BTtlWwfkM9HbxDluHNl+wGg7AUnuwbBaSRwTcH9GhFMlLz
 K2um9W6AGMBl7PB4TlrCY2Te/sD9MepZXnByOoCqVrzbri3n20ODECa9XlZpM+ldXpR5
 1/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Pn7BgHsmsBPGfPvSzaGz7jXvEMfKGavJUaa+O3+Rp48=;
 b=DvWIoJulSIugVCW2+SCDQeb4kjxohl3InChrMVjfilgqkqwM8ePG9YEu0MleB4Ue4B
 dGyQPRZU+T1G0q8hHGAl7zH3GA/9umtMbrf+ybLZPGH+zjL2p4JEK+vORbIShroZe6Fg
 yR6+hFKo2TRjggDtwpt+Kiw/us8txSVpY5LwlPUppGqzuh7wp6BlQLc88xQSV7W0N3Qu
 ZLEnrGr8Vp7P2rXHJRO83QDr5Ev6SGUdRVHGCruahJvWT5ojUk9aODorjTTsad4GNOYq
 Hoc93G1w4gRxOUIUyRQ0DvLMGb+DDvmD/62yUGsjnpNc9PqNUh9ESZQ9rPXC61xH2UVA
 qV9Q==
X-Gm-Message-State: APjAAAVq6GhJSbyz85uRsVchNPt3arf1CfaKBMqlZFiAQkpOb9xvGSeU
 JbVSkEX1rKDOwBYaz1JA59aiING5
X-Google-Smtp-Source: APXvYqwB7FHV8Cj3Ez0uyRwVjQ0PcgLNe319zu8TPKy8O00wb9D3d1V3P9LXws7uULNBFqAwiR0pmA==
X-Received: by 2002:a6b:6613:: with SMTP id a19mr11412417ioc.241.1570161240632; 
 Thu, 03 Oct 2019 20:54:00 -0700 (PDT)
Received: from matt-laptop3.localdomain (d118-75-38-58.col.wideopenwest.com.
 [75.118.58.38])
 by smtp.gmail.com with ESMTPSA id n17sm1570274ioj.73.2019.10.03.20.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2019 20:53:59 -0700 (PDT)
From: Matthew Kilgore <mattkilgore12@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] curses: fix attribute passing
Date: Thu,  3 Oct 2019 23:53:36 -0400
Message-Id: <20191004035338.25601-1-mattkilgore12@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2a
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
Cc: samuel.thibault@ens-lyon.org, Matthew Kilgore <mattkilgore12@gmail.com>,
 philmd@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch set fixes up ui/curses.c. A previous change to ui/curses.c,
commit 962cf8fd4fae ("ui/curses: manipulate cchar_t with standard curses
functions"), did not correctly pass the attributes from the chtype to
`setcchar()`.

The biggest issue this caused is that colors no longer work when using
the curses display, it instead renders everything in white on black.
This was fixed by correctly passing the color pair number to setcchar().
I also fixed two spots where 0xff was used instead of the bit mask
constants that are part of the curses API.

changes in v2:
- Split into two patches, one dealing with the attribute masks, and one
  dealing with correctly passing the color pair number.

Thanks,
Matthew Kilgore

Matthew Kilgore (2):
  curses: use the bit mask constants provided by curses
  curses: correctly pass the color pair to setcchar()

 ui/curses.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.23.0


