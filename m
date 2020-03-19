Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A607C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB43A20724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyBQtPsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB43A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEkmJ-00085C-V4
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 22:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1jEklY-00070U-UL
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1jEklX-000865-R8
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1jEklX-0007y3-JP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 22:18:35 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so338229plr.11
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 19:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6bBz5V/WtkwwqhyJmsiCB2xh086GQ/HDrZAoGycCDqY=;
 b=FyBQtPsq8bx5OCsSO0dGRPlcZN4yQ4dilDnc0G/EjPeWrM+7Z9NNLmLnKUTTpEgpOW
 fotqM6GXOjifswMfDoV4MXousDAWQo2iZFgpf7jXcx8OEy8uSQ1pzPHzCqDztZHpAR1a
 ZJkUESD3QWhQ6MTVbTdcaYamhKJnqPErNPakQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6bBz5V/WtkwwqhyJmsiCB2xh086GQ/HDrZAoGycCDqY=;
 b=KG3zbKiK5rkEO/cThaVBzZyF++ZBxG8TCAaxz+Dyg5QZO95xtnj7DMkHx/5vzKFcFi
 zFjlm+0OBlYTqKmzDRWX0ak99vf+eawOK+8GjHxf0tEbUDzuBO9zK/HN64O7AkMIRuvr
 qzvtRT4sX5Y6tSAwgP/FoH74UEX7YQmE1wGH2enaC2BYEw5nKXHLWIPpkkttj0gBCF9T
 MZrw0smTBK+aUi0ZQKbpxokbV2XrbjdsWnElKED1ygTCM4tqfa1S7Rp0+ubusApDtpRa
 0eqIBTaSOa3T3riBQdqKsk7xDC+oVttItmrr73Sd+ca4cuqBJdXp/alz9yfO9VnqhaHa
 1rEw==
X-Gm-Message-State: ANhLgQ2swDtojkbrD9NtnK5vXViqIL5WJLmG2i5HXVaqf9ptzzQMBC9+
 r9+UhqUz1dlW5Uw2FGvd7fN4WQ==
X-Google-Smtp-Source: ADFU+vu185Om/KiLaJ5I6R9LggSBMYF/vdJXMV0dPyaYDQ0gYr8yH5gFBEPHWK46VajxmqHXBz9gGA==
X-Received: by 2002:a17:90a:730b:: with SMTP id
 m11mr1305446pjk.195.1584584314128; 
 Wed, 18 Mar 2020 19:18:34 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:30f2:7a9c:387e:6c7])
 by smtp.gmail.com with ESMTPSA id d11sm305928pfo.39.2020.03.18.19.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 19:18:33 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: virtio-comment@lists.oasis-open.org
Subject: [PATCH v4 0/2] Cross-device resource sharing
Date: Thu, 19 Mar 2020 11:18:21 +0900
Message-Id: <20200319021823.57219-1-stevensd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
resources between different virtio devices. The corresponding Linux
implementation is [1].

In addition to these patches, the most recent virtio-video patchset
includes a patch for importing objects into that device [2].

[1] https://markmail.org/thread/bfy6uk4q4v4cus7h
[2] https://markmail.org/message/wxdne5re7aaugbjg

Changes v3 -> v4:
 - Add virtio-gpu feature bit
 - Move virtio-gpu assign uuid command into 2d command group
 - Rename virtio-gpu uuid response

David Stevens (2):
  content: define what an exported object is
  virtio-gpu: add the ability to export resources

 content.tex      | 12 ++++++++++++
 introduction.tex |  4 ++++
 virtio-gpu.tex   | 29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

-- 
2.25.1.481.gfbce0eb801-goog


