Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89503C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 21:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43EB8206BE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFs42xcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43EB8206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsYS4-0007W2-Gs
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 17:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jsYR5-0006XM-55
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 17:13:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:41941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jsYR3-0000Ec-J7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 17:13:58 -0400
Received: by mail-pl1-x62e.google.com with SMTP id f2so15824949plr.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=8drZMpZ5bnfxccFqrTd2a6dZ3UiU9Mt2eHg/kKxUFOc=;
 b=pFs42xcuxJZP3kwh0lBn3i3GhM774yOw6+jOXvxBcucI7fJ6chBMSXH89KvW1ZSOAB
 kR2EXOA1rA2iGEfgTIPq6iH3fIZtHJUV0/Oly+Tk7PX2h15657/4uuxlMHutwYOEd+cq
 0fJ3d68AulHw+ZBSm3TRKZAnLI8d133t9T0M0jOiVsJfVTHYWw2ZqyPVA0hhhLxLNsI1
 7/Dj2cynIQnt5SP4GQLc8LFGzP6IZKK6tG8LRHMo0m53gmk1/ycxiy//O/bRHTlmWRyK
 RXjBQkyEeJnKA4kUvUEjvzHS2AIaHwOttBmGW49viQXSyTbZVBEPzQJzhrj8IpFVz0dW
 7FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
 :mime-version:content-transfer-encoding;
 bh=8drZMpZ5bnfxccFqrTd2a6dZ3UiU9Mt2eHg/kKxUFOc=;
 b=Upd2lf6E1FmB0+2x/lc0SKYmyavs1FlODzCsrKHYm+9xChVbBg0Thw7JMwPcduHB7B
 YCmpBRAEL30FFjuDuslDFvNu89UAuSX5io8On2eCa3yQeQelC9JS4jy+ReGTTY5CiyeB
 VLAW6kCTSw8UYG5gc0umCfqC3XRMe0qwET/0lnVdd80vtiCQyNQfExgo0HL0LTurcwS0
 KyQhO5Uw9wE/KeKRKOTf/5nWHUrca3CZzS8XMj5toXz1GK2y8FAM6OOJGD2thghgVTjI
 UxW8s3ZgLCnAdpjRphmbuyopETQ9ryIo2pirs0yN1kFp6xzRpqLcepOdPDFGKoN/Iq6A
 Q4xg==
X-Gm-Message-State: AOAM532FYvF1jf5gU/3XdPbbWpu+Flr0VOnp9LmTmGKZo9i5U3kLSZ+H
 KF6qmCT1HBX4PvCNRu9k6Z8=
X-Google-Smtp-Source: ABdhPJxXaYuus0a3pNO85L+POfMq9MQ9fngq2pYTF1TfskYkge7Pbt8IwnGMiqFWRD2HWdUo8rmWxA==
X-Received: by 2002:a17:902:bb95:: with SMTP id
 m21mr2224750pls.41.1594070035438; 
 Mon, 06 Jul 2020 14:13:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id k71sm361975pje.33.2020.07.06.14.13.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jul 2020 14:13:54 -0700 (PDT)
Subject: [PATCH v2 0/3] virtio-balloon: Free page hinting clean-ups
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Mon, 06 Jul 2020 14:13:53 -0700
Message-ID: <20200706211314.20018.89695.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pl1-x62e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series contains a couple minor cleanups related to free page hinting.

The first patch addresses what I believe is a possible issue in which the
driver could potentially force the device out of the stop state and back
into the running state if it were to replay an earlier virtqueue element
containing the same ID it had submitted earlier.

The second patch takes care of a possible race due to a mutex lock not being
used when starting the hinting from the device-side.

The final patch takes care of renaming various hinting objects that were
using "reporting" in the name to try and clarify which objects are for free
page reporting and which are for free page hinting.

Changes from v1:
Split first patch into two patches as each addresses a separate issue.
Added acked-by for first patch.

---

Alexander Duyck (3):
      virtio-balloon: Prevent guest from starting a report when we didn't request one
      virtio-balloon: Add locking to prevent possible race when starting hinting
      virtio-balloon: Replace free page hinting references to 'report' with 'hint'


 hw/virtio/virtio-balloon.c         |   77 +++++++++++++++++++-----------------
 include/hw/virtio/virtio-balloon.h |   20 +++++----
 2 files changed, 51 insertions(+), 46 deletions(-)

--

