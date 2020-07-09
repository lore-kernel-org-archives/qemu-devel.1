Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37496C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 23:04:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40AB20672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 23:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9mRiL7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40AB20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtfb5-00058F-2D
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 19:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtfaN-0004M8-Rn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 19:04:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jtfaL-00031T-Do
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 19:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594335847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Xm3dgM/+erDdvwy2Hdlbh8qRJ8uNWDFtuVUoIx3dVO0=;
 b=F9mRiL7KO927M0iKCjp/qx3nrNZAHo5+SASeVV2sFPaoPxncAusCmTRIBzYOPqpYX3rpcy
 11KrmZDyZGADUfI9GSPn5nczswJP4EJXGSTh5Sy2UYInIsXTwuapGW2vm9r9USWwNsotqT
 HmS3WQkWbBVOnudjQ8nU+wmnLON+yhs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-m9gmniMTMZSAc8TQhVO5TQ-1; Thu, 09 Jul 2020 19:04:05 -0400
X-MC-Unique: m9gmniMTMZSAc8TQhVO5TQ-1
Received: by mail-wr1-f69.google.com with SMTP id v3so3456879wrq.10
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 16:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Xm3dgM/+erDdvwy2Hdlbh8qRJ8uNWDFtuVUoIx3dVO0=;
 b=rKMS1qlR4XGaktutG2LcgFwHZq6FZVo1o1WwDeVm54qqAwiroZnVksINjuuRcM7y9g
 1gNoj8z6NDFYd2DVWu+uric55zhVjutMmF+gCmXtJnkDP1FgPePbG/oFIxNFVbuxbdqt
 xAOhMQ2i+3ouiuPI2Cm0XO0dVu3qURODx2sTdl3uGd+uvgDv8jF8jSjH9SdqK70MfuXc
 8geH7S8t+k/jN/tA0wpztw+GA94Gpu6rxmnpHbRIVkKb6/HhgM4mv3cTsS1e2+41/rAB
 p71sK3u/vCCcnHm+vYq0u9xgHOLeLXS0+6074BvryMEXsqlXcNfXa8wGug0z8jrNB6Qf
 ONzg==
X-Gm-Message-State: AOAM530OzpJxyB2hTKcpPo/cLVCLyBKh+THmOsxdtHBOX+3nidZi+D1q
 ifO/uju5klbT1IWOmKSoFQGSJXV4OyfvWFnGknVJyKJDx59bIXEIbkzKckyCwkigkafAzxeN8m/
 9xUJpsugzNNBKb/4=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr2250104wml.95.1594335843940; 
 Thu, 09 Jul 2020 16:04:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLosvVU0YDxMfl4agYUgAgzj5smWJdN5RL7vTv9gZkuKUgRnqIUifUzRBpihHkOTU6xeF+sw==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr2250085wml.95.1594335843741; 
 Thu, 09 Jul 2020 16:04:03 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 z132sm7315807wmb.21.2020.07.09.16.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 16:04:02 -0700 (PDT)
Date: Thu, 9 Jul 2020 19:04:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] virtio: bugfix
Message-ID: <20200709230330.236699-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 19:04:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes a single bug in vdpa.

The following changes since commit eb2c66b10efd2b914b56b20ae90655914310c925:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-07-06' into staging (2020-07-07 19:47:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 4dc5acc07e88b2776513db75944f2e240116ebda:

  vhost-vdpa: fix the compile issue without kvm (2020-07-08 06:16:48 -0400)

----------------------------------------------------------------
virtio: bugfix

fixes vdpa on non-kvm platforms

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (1):
      vhost-vdpa: fix the compile issue without kvm

 hw/virtio/vhost-vdpa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


