Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CB0C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E1E2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ib61XPxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E1E2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIKn-0007qk-Qx
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJIDY-00009a-2w
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:22:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJIDV-0003U4-OK
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600442547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+WpV+5OlE38Is3mgHDtSU/aY1fuGcKE9NdGMb8EzmzY=;
 b=Ib61XPxyxVORvAhaUCVcgUvHnwY2rQ8ZCcmqkJsRqjtrkwr4Bfwf2fGjLQsuPe2aMp6sfq
 ZneXw+zAEsc+YFNBBbquCOXUTfGSxTFyJh/0ZPJKGk+eHMsgar3qOwMMHgILerVvPiDqI5
 PxEueqiv5wyutdrJwvT3YNKHMEvWp/o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-9bEzvZvCNMq8CUY5q0Rr6g-1; Fri, 18 Sep 2020 11:22:11 -0400
X-MC-Unique: 9bEzvZvCNMq8CUY5q0Rr6g-1
Received: by mail-wr1-f70.google.com with SMTP id h4so2269195wrb.4
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+WpV+5OlE38Is3mgHDtSU/aY1fuGcKE9NdGMb8EzmzY=;
 b=U9JHjP18pwwTD855fSSb4JNpJGUQlKTKfVhfrok4PYUipOk1SgX70ZF2WDWezFTEWs
 7Qj83uoRBJFcI0GEiRoLxDFLFETWMkh+i4aRmeUob87PHPiHmElAZ/oxTHmRP2ULfSTs
 OwjraGuFDj/IAYPHLPvrES0Ho9uVWDGuuMBpmQK0x6Fm+PmYul7qErSRLCJCpV5jm62E
 lPgW2+Dsi3cCJ7akLzB5snWfiNyf+/c5OBVHfElfNXi06g2WaunArKDEW0Q7NUaLK6WU
 b33ILQfTmj78MJx2K08GYyUmHAUNwoqg4yRlmsKBuXu8ybXonekfJA3rcC7VnPMzjyua
 y9YQ==
X-Gm-Message-State: AOAM532rqTGIghqLueCrlhYLe3PRk2/EQM8fx4hIzy/zI++wj4rzjiDU
 fBmJgTWwVlPTfCC5OG5kFh16aR3s52ZqVs0On5z15n/7rYFocXjHSz7779U9sPIdo2CGgk9PkLX
 FkmRvMb5clp+Cews=
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr38110520wrw.223.1600442529583; 
 Fri, 18 Sep 2020 08:22:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw/tLUD6fNEzveXkZOPHCgdl3nX0BOz4OwpgXhaAED0Da8BnzDavLj+hZAbA18O21zkiBuOA==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr38110494wrw.223.1600442529328; 
 Fri, 18 Sep 2020 08:22:09 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h16sm6530446wre.87.2020.09.18.08.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:22:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] fw-cfg patches for 2020-09-18
Date: Fri, 18 Sep 2020 17:22:06 +0200
Message-Id: <20200918152207.157589-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e883b492c221241d28aaa322c61536436090538a:

  Merge remote-tracking branch 'remotes/legoater/tags/pull-aspeed-20200918' into staging (2020-09-18 13:36:42 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/fw_cfg-20200918

for you to fetch changes up to 4318432ccd3f7fb69b7169f39dcae3d4ee04f5ea:

  hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data() consumption (2020-09-18 17:18:18 +0200)

----------------------------------------------------------------
fw_cfg patches

Fixes a bug in the recently introduced fw_cfg_add_from_generator().

CI jobs results:
. https://gitlab.com/philmd/qemu/-/pipelines/191714875
. https://travis-ci.org/github/philmd/qemu/builds/728288784
. https://app.shippable.com/github/philmd/qemu/runs/869/1/console
----------------------------------------------------------------

Laszlo Ersek (1):
  hw/nvram/fw_cfg: fix FWCfgDataGeneratorClass::get_data() consumption

 hw/nvram/fw_cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.26.2


