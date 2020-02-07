Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F85C2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916FA21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSFFgD4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916FA21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyGd-0000tq-Ie
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1izyFs-0008Lx-Cn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1izyFr-0006gx-2D
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:48 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1izyFq-0006cX-Qd
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:40:47 -0500
Received: by mail-pj1-x1043.google.com with SMTP id j17so561326pjz.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 23:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9x3wiLa8nMck6bJR/xTvEfW1fgE8xeUy0DtSaO8sY4E=;
 b=LSFFgD4Amj8tYbW+x3ruwRO2vwL5fhAS6Q9E02+ZyFILW3OJ1WR15+2ePqwzSiQKcA
 ccOfxGP84Ze4Hn0ILpj22rELuw2S6G/S5sBTirowvoPJuUSm0mz85hsi0BBbbQbWTZD/
 OB9cSDNh3vDk52tKXJdE8ZzR6XkO9zA2DQY8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9x3wiLa8nMck6bJR/xTvEfW1fgE8xeUy0DtSaO8sY4E=;
 b=fOY8FzDHBOvRn0gdSuUY1TZMH68HhQO7mJgAR3dS1LzUCE4wNM2OFvoC/7A6sFmmft
 c9yKa5qJrMHs6NLhRGxNnk7g64/XQ5UNu+8C6NtUZtw/pBjd2u7GEqavBWWrg+7vz3FD
 g8r5auQfPcZbIPZFvg/Kd64N/X3HfOh2ANRxuJgXWjvB1N9jyLvQYoRGUjKxzHY5LV4O
 V0BrIsEdVkI3Bdt9ECtLyzXg9QvXo7ghRlelpQIUDrMz70IUmssirYx7LdzgYSOPX7DT
 zcUt+4zALrd+7RaPAmYWhrbwgxIqDxgpJF6gctM9Ar9UbJZsvWI1lu4D2mH6+mid8rRQ
 28pw==
X-Gm-Message-State: APjAAAVvqTbsMihn8mhmm4GNFEM3ICDwMhCkpAN1ucG2Ki9GN/sOkn9h
 FvQ6SCeBislyuV45MY+uFSAzgQ==
X-Google-Smtp-Source: APXvYqxI87m2j612o5zsvUs0WmCZeZTRgBEcpnZL7Nxm+UI5+5ILaps1qKJlVLEUiCpW1J0pfypgeA==
X-Received: by 2002:a17:90a:ac02:: with SMTP id
 o2mr2337469pjq.93.1581061245512; 
 Thu, 06 Feb 2020 23:40:45 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1f16:51f4:8631:68b2])
 by smtp.gmail.com with ESMTPSA id b21sm1862887pfp.0.2020.02.06.23.40.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 23:40:45 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org
Subject: [RFC PATCH v3 0/2] Cross-device resource sharing
Date: Fri,  7 Feb 2020 16:40:31 +0900
Message-Id: <20200207074033.172289-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

This is the next iteration of patches for adding support for sharing
resources between different virtio devices. In addition to these
patches, the most recent virtio-video patchset includes a patch for
importing objects into that device [1].

[1] https://markmail.org/message/wxdne5re7aaugbjg

Changes v2 -> v3:
* Replace references to guest/host
* Remove unnecessary paragraph and field in exported object section
* Recommend RFC4122 version 4 UUIDs
* Represent UUID as u8[16] instead of le64 pair

David Stevens (2):
  content: define what an exported object is
  virtio-gpu: add the ability to export resources

 content.tex      | 12 ++++++++++++
 introduction.tex |  4 ++++
 virtio-gpu.tex   | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

-- 
2.25.0.341.g760bfbb309-goog


