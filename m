Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD67C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4578E207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMn0P2Ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4578E207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qf4-0006OZ-Fh
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5qeI-0005RN-E8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:18:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60085
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5qeF-0001xX-3Q
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597238309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Lt2To2RiNGelydSI1tmmzCLqPqg1BXigaDsdlog9yCY=;
 b=GMn0P2UlespAFKTyxWuxAcOazQ0og42ndRHTB+r6O1fFEm3uwnbmZWbAnsxiLSar1j2T+7
 0N0Smms2fF1SR+GOSeyA3L0/xelyo9A7XBL/RqX6Kq5j9ry1une+tQrMP6BcfiBPcmQgqC
 36hcPjoQLqZyJw+2B/SNcF/kMCpaOHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-QN7vnX7AOkSNBX1DPV9KKg-1; Wed, 12 Aug 2020 09:18:26 -0400
X-MC-Unique: QN7vnX7AOkSNBX1DPV9KKg-1
Received: by mail-wm1-f71.google.com with SMTP id p184so693509wmp.7
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 06:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Lt2To2RiNGelydSI1tmmzCLqPqg1BXigaDsdlog9yCY=;
 b=NkZNYIy99Pfu/7dC3qF+d+fIw8u9N7TvSdeC/jCDXPOcgzKlf1MWV3iuf2Ft1NxbJo
 2k9LLEo1SJKE7P/p8uJKEwQipwEXUCRhCpEHOFzLfFxmRCMESgTq/aS6HdTXUvkFVTEd
 Iv3mRMbs2vPbS5I6fQblPKuascq5zChfjdy9CvakqiohhAPKBbXm5NXy/AwJJDnaE+y8
 CcpQjBAUOjOAkeMhC+WDGTA8QjsgxROTJCaSzEiKTRjzFxIWaLOTlhuD0rAt/xxBsgpv
 /h8BfUXJTVP1279L9fWSFQvpSZbx5Df0PprV6rqrikDlt0hT5KwDKggB3h90q4EVDf38
 aWlQ==
X-Gm-Message-State: AOAM533Y+VKvSlKxdHtnOSe254l0kgGCxBt6C3bRpFYAg4G72/neJQNi
 MQ31dOUU6zkZeY9P2b11P3hKvmWV2uQvsXD0Wvz39M/CUOAOp+QyMRgzVAp6bD2LtZlxSal34z+
 t+34HKElsr8lo+rM=
X-Received: by 2002:adf:efcc:: with SMTP id i12mr10800427wrp.308.1597238304410; 
 Wed, 12 Aug 2020 06:18:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzX1+4VqlkkZMiS0zN/re3An9KVYAXEOt2F7UdIdsS2aR1cgSexaaLvO2rfG7vqUjjDPetCyQ==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr10800404wrp.308.1597238304142; 
 Wed, 12 Aug 2020 06:18:24 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 128sm3815218wmz.43.2020.08.12.06.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 06:18:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Acceptance testing patches for 2020-08-12
Date: Wed, 12 Aug 2020 15:18:20 +0200
Message-Id: <20200812131822.28162-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:

  Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/acceptance-testing-20200812

for you to fetch changes up to 0eca1f4b5c1a6cf8f05ff7da72a4e97b41894e84:

  acceptance: use stable URLs for the Debian and Ubuntu installer (2020-08-12=
 14:14:28 +0200)

----------------------------------------------------------------
Acceptance tests patches

- Use stable URLs for the Debian and Ubuntu installer
  (Ubuntu has been updated last Wednesday, August 5, 2020).

CI jobs results:
. https://cirrus-ci.com/build/6385815351721984
. https://gitlab.com/philmd/qemu/-/pipelines/177054604

----------------------------------------------------------------

Paolo Bonzini (1):
  acceptance: use stable URLs for the Debian and Ubuntu installer

Philippe Mathieu-Daud=C3=A9 (1):
  tests/acceptance/boot_linux: Extract common URL from xlnx-versal test

 tests/acceptance/boot_linux_console.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--=20
2.21.3


