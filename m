Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2779C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43D6208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 07:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGffU8sp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43D6208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVss9-0007EP-P6
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 03:19:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjf-0000OB-Iq
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hVsjd-0006O8-Kv
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:10:55 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hVsjb-0006My-SK
	for qemu-devel@nongnu.org; Wed, 29 May 2019 03:10:53 -0400
Received: by mail-pl1-x644.google.com with SMTP id g9so658058plm.6
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 00:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=JUZGbiiSfwtgG6+C+pk4U0bdDVaD9HvtYKCMbozyaBc=;
	b=YGffU8spWs/c0/20Bxf0xYPMFODHpYE4XZ+M3rF62ZYbQ5bXxi8MUI1Hwn1OsBQAJG
	JtjBONn92czWOes14brkx9iexrRHv/Ui9gvUL4ROrKgUIyI36Ad8FNUHowhg2/OI8zlB
	R0gMzUmwakIEaumOvi63OqAKm+7KEXoO9Q+xvkywA+7NbeqBt+vaoulGAJvpDyvrc8dZ
	dqqzTy5mDdQgj8N3NwUmlQFOQlYVyU7PNEs0CQS3MQTRjjuhzZaEmkfR96zzQP3pjbMD
	Olkncp9utC64N4QViKkmWxwvSOfYdYzeYISs2WWAE2NkLtLi3rGxScj7MWWgvZq02RHf
	oHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=JUZGbiiSfwtgG6+C+pk4U0bdDVaD9HvtYKCMbozyaBc=;
	b=IIsDadp6k5WOiPXBhaPyOjXpT/WPtYevW5Wt50/bxwfsKV6yZjKJ1+fNCFQ70Oiu+z
	13/AY80/mPmEaiFvrz1Ompg+IhpltAIqfCqQCME0rHiDjhlCJUZtxrwjPX25eMMjLJnv
	jkFEc15Vi8vK14dRNFNEEUnzaNtM1qub+BtMYuB+32yWGgCj5d/6eyIlRVPvR9Fdi3uV
	flNxzR2F7UpusBZZM6lJgy5v0ohmuu4guRMcVNPhWqMC0YiM+xRWq6fZftiWLk/FBs6a
	0b753dQmQaQw00hJ9QJT5o3KT+MfBKjQLU7hYD1k8cVmDc1bIMfmqOe8gu5G2DwwsU4P
	vBLg==
X-Gm-Message-State: APjAAAVjFkNl4ZMMLwHmX8jfZC0DLSiJk3zImN0/fYmoOAUqd08O3vIA
	MdoeLSa7jR6VaIwU4qCGuyQ=
X-Google-Smtp-Source: APXvYqwg1nKuJgYbKwH8oTF1LIjtQX6dSCMFlz/hfAIbZg/4vkTnQJeEzCrLoFgy+zTKs7z6mnidXw==
X-Received: by 2002:a17:902:e40a:: with SMTP id
	ci10mr92503927plb.195.1559113850254; 
	Wed, 29 May 2019 00:10:50 -0700 (PDT)
Received: from localhost ([116.247.112.152]) by smtp.gmail.com with ESMTPSA id
	g17sm24212474pfk.55.2019.05.29.00.10.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 29 May 2019 00:10:49 -0700 (PDT)
From: elohimes@gmail.com
X-Google-Original-From: xieyongji@baidu.com
To: mst@redhat.com,
	groug@kaod.org,
	dgilbert@redhat.com
Date: Wed, 29 May 2019 15:09:50 +0800
Message-Id: <20190529070955.25565-1-xieyongji@baidu.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH 0/5] virtio: fix some issues of "started" and
 "start_on_kick" flag
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
Cc: Xie Yongji <xieyongji@baidu.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

We introduced two flags "started" and "start_on_kick" to indicate virtio
device's state before. But there still are some problems with them. So
we try to fixup them in this patchset.

The patch 1 fixes a regression bug that old guest is not able to boot with
vhost-user-blk device.

The patch 2,3,4 fix some problems with "started" and "start_on_kick" flag.

The patch 5 introduces a "use-started" property to avoid a migration
issue under Greg Kurz's suggestion [1].

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06247.html

Xie Yongji (5):
  virtio: Set "start_on_kick" on virtio_set_features()
  virtio: Migrate the "start_on_kick" flag
  virtio: Make sure we get correct state of device on
    handle_aio_output()
  virtio: Don't change "started" flag on virtio_vmstate_change()
  virtio: add "use-started" property

 hw/block/vhost-user-blk.c  |  8 +++--
 hw/core/machine.c          |  4 ++-
 hw/virtio/virtio.c         | 67 +++++++++++++++++++++++++++-----------
 include/hw/virtio/virtio.h | 10 ++++++
 4 files changed, 67 insertions(+), 22 deletions(-)

-- 
2.17.1


