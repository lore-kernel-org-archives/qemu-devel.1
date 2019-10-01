Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B2AECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC57A20700
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="BhG6j6UI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC57A20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFILZ-0006oD-Fm
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFH7D-0008MC-SO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFH74-0004jd-Ri
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:18:47 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:38666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iFH74-0004gq-DT
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:18:42 -0400
Received: by mail-ed1-x541.google.com with SMTP id l21so11685364edr.5
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=YNCWREwiGxQBHgr/aPSD/yc/nfLH4iHYe8Ca8B7xsjs=;
 b=BhG6j6UIFywJBWYqVxKxLCuekSRerawjr82yGvvXSy9zJBvrJlDrMWLb5myHl6zPJC
 QtdHsSeTosbJWbwmYE/OpB89hWIB5qkojtpjoFMVMkyOatPjtgisJCn9AYJhV+2Y9KLZ
 2bVg4t2sJohGtA6DK3E7yR6LKzxgs9UdB75dsQRmPqdY9wOxXZV8EbHzJ4eR5Mts7ZNg
 nMhfhEap/amyjK9mQyf2qfZVh/vVoUrl0ASaEcw5db06mLlR3V6RW/PP3C/C7V2pO4/f
 /x9TpUorCNeGbMvyhCSCDAib3F5me4slGwAuz8e9SCrCK3sm381IvKjO4Vy5COxXgsy0
 9YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=YNCWREwiGxQBHgr/aPSD/yc/nfLH4iHYe8Ca8B7xsjs=;
 b=M01wjpT2Gv86xsu0UugtYdHooTg6L8ee+970AZU91RJ9NsYpWh9EX6QgBMBf/iFHZB
 JjjfCCdSO+FyyYYrG24WDLlQyRkIbHzdTrGxY2f+mbBFf4R9FFJYl16ikFg/a2+iqQ95
 jT7hnIw3yIqM7eM/1kZTPuadoabMuexRtRoEWofUi98x7nk2swhGuD0IP4tsOlAGHmTQ
 zzUouK1qOFTpi4Qe2L3pEh4+fEbZ6zrLrd39a0yku63MbTu2bixfdcimcRASdWT4uEDc
 Ig2BRwrfmTGDROo4IYIIl8sNpOxk8Y4GMQ1ClQDhaiQ0JRnumx0nHV/exTlC3ROauW3E
 Zhfw==
X-Gm-Message-State: APjAAAV9vTg8ct9QOtaeRqLwzg2fPoYnB1x0cOA0RvbMnR/tRyvSLxXS
 sxwmPs3eeK0qrao/SicYYoKiNKoCy/U=
X-Google-Smtp-Source: APXvYqwQJhmO5FaBvHyAOv+o5JCoH/ofQ1UdiFT+7CIEPAY1MNkWI0ij+L+AL1i8XFMEE5Lvf7scVw==
X-Received: by 2002:a17:906:5c07:: with SMTP id
 e7mr19557613ejq.127.1569932319452; 
 Tue, 01 Oct 2019 05:18:39 -0700 (PDT)
Received: from msennikovskii2.pb.local
 ([2001:1438:4010:2558:d098:3701:97c4:7b4e])
 by smtp.googlemail.com with ESMTPSA id u22sm1824156eja.23.2019.10.01.05.18.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 01 Oct 2019 05:18:38 -0700 (PDT)
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtio-net: prevent offloads reset on migration
Date: Tue,  1 Oct 2019 14:18:27 +0200
Message-Id: <1569932308-30478-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::541
X-Mailman-Approved-At: Tue, 01 Oct 2019 09:36:01 -0400
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
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

I've recently faced an issue that the offloads settings of my Windows VM's
tap devices reported with "ethtool -k" get changed after the VM migration.

After a quick look it appears that the offloads always get resent
to the complete set of features the guest has reported.

Here I'm sending a small patch which fixes this with all the detail
in the commit description.

Perhaps a cleaner approach would've been to actually restore the
curr_guest_offloads after the virtio guest device features.
This approach is much less invasive though, and more intended
to illustrate the problem and potentially initiate a further
discussion on the best way of fixing it.


Thanks & Regards,
Mikhail


Mikhail Sennikovsky (1):
  virtio-net: prevent offloads reset on migration

 hw/display/virtio-gpu-base.c |  3 ++-
 hw/net/virtio-net.c          |  5 +++--
 hw/virtio/virtio.c           | 10 +++++-----
 include/hw/virtio/virtio.h   |  2 +-
 4 files changed, 11 insertions(+), 9 deletions(-)

-- 
2.7.4


