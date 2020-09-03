Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7A0C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD35420767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8RM3JOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD35420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoN4-0001En-Sr
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLe-0007nl-KA
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLa-0007n4-Mi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wJPwuKPHSl2PpOMF8M+0S9M0THbbMbG1b8kPhUv3hF0=;
 b=K8RM3JOI9ep2SasociqQ4fXSnO+GqzfpCHyRpiOFp1GQt+JRdVrw0pO4zQ5dSdjQNHcjUW
 baYw5Qliwa67d6dYxqqx4fkAdjKHSlFkZ+HtOs52R2w2SRVBLX8UySFd4gwl+lCfiCZXQ0
 FaJ8nj8sxTiFXnwMCVvdZvBMzTYdVJs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-5fttTgZbNmaQwFNOL1MUQw-1; Thu, 03 Sep 2020 08:28:07 -0400
X-MC-Unique: 5fttTgZbNmaQwFNOL1MUQw-1
Received: by mail-wr1-f70.google.com with SMTP id f18so1010965wrv.19
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wJPwuKPHSl2PpOMF8M+0S9M0THbbMbG1b8kPhUv3hF0=;
 b=jKHh3dIcvpFbD5LSXlP06U2GXT8RjsR4cT+dSEz4VS4MlCsqBTUb72iORk5sY1mAXl
 FJdO+kK+QFLdaaevRM/EUSsep9LmPIZdQj55lfhWzdcsfeDvzRJb1LDz0hVG/EquF2r7
 ZnxGuvycjP9YDSp7wNArM9qs4qy2HkPgF8UO+M1B6tSZnyWiYbMQ5RoFPWdyFmD24ygl
 mVGTQWt5yq+26djHEMT8LWg2m4Xxvi6QlPwVOjAt0SochmnkVqWtTjiRirnUOfeHeoEZ
 N0DaUA9iRIjyo9eOzJcKXjcx5ZCuiZIahdiYkjWaL3GXv15QLnTyIRsR5GH70H4RBer/
 59/Q==
X-Gm-Message-State: AOAM530Lr7F4T39N7TN991LnweKbHuGZjMXxoIIbV6vmUq8+tC/N9r6j
 4k+z6ooO/4DkjI60VLR8BhFPIdajH2IiiSPkW73eC+wBtwkyQYEWZ/rikibV5+1Oky9ks6pUiRr
 5mUFGi4X3iCKHN2Y=
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr2210986wmr.105.1599136085644; 
 Thu, 03 Sep 2020 05:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfu9Kv7QP9jN+cusuOeZGLtKbH1aHraGZZaqamZfQ5HLPnU618+65PzBufxjlHysXqK5EnhA==
X-Received: by 2002:a1c:2b43:: with SMTP id r64mr2210950wmr.105.1599136085374; 
 Thu, 03 Sep 2020 05:28:05 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id k24sm4025357wmj.19.2020.09.03.05.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/15] block/nvme: Various cleanups required to use multiple
 queues
Date: Thu,  3 Sep 2020 14:27:48 +0200
Message-Id: <20200903122803.405265-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

You already queued v6, but 2 patches from Klaus modified
block/nvme.c so the series needed a rebase... Sorry for
the extra work :/

Since v6: rebased on top of:
- c26f2173704 ("hw/block/nvme: bump spec data structures to v1.3")
- 69265150aa5 ("hw/block/nvme: be consistent about zeros vs zeroes")

Thanks,

Phil.

Philippe Mathieu-Daudé (15):
  block/nvme: Replace magic value by SCALE_MS definition
  block/nvme: Avoid further processing if trace event not enabled
  block/nvme: Let nvme_create_queue_pair() fail gracefully
  block/nvme: Define INDEX macros to ease code review
  block/nvme: Improve error message when IO queue creation failed
  block/nvme: Use common error path in nvme_add_io_queue()
  block/nvme: Rename local variable
  block/nvme: Use union of NvmeIdCtrl / NvmeIdNs structures
  block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset
  block/nvme: Replace qemu_try_blockalign(bs) by
    qemu_try_memalign(pg_sz)
  block/nvme: Simplify nvme_init_queue() arguments
  block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
  block/nvme: Simplify nvme_create_queue_pair() arguments
  block/nvme: Extract nvme_poll_queue()
  block/nvme: Use an array of EventNotifier

 block/nvme.c | 211 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 125 insertions(+), 86 deletions(-)

-- 
2.26.2


