Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573F6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF71F208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdLVr2xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF71F208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtTr-0002cI-QQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4A-0000ZM-QG
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21559)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt49-0002md-10
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:19:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+FPpktj5THBEK2/QYdCd2kiR5oibLPS/OVWFHv6de4o=;
 b=JdLVr2xGG9GpkVZc1oNRGuI309D7ehgnFvj9KYQpaLYn4D75blGUJ6l25D5Y7IPq3WtGlY
 WnJr0CWYbVVK/rA4IYceXoSq7cjuU6voZpv03Ux6jpLtg3FgjivrRYDd+SERIFVxcqnpCy
 RZG7uWCn9hX7JBgByHnP5IidcT7FRdk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-VOo2GQmHOtKkBTg8kKdTIQ-1; Mon, 28 Sep 2020 09:19:38 -0400
X-MC-Unique: VOo2GQmHOtKkBTg8kKdTIQ-1
Received: by mail-wm1-f69.google.com with SMTP id b14so345463wmj.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+FPpktj5THBEK2/QYdCd2kiR5oibLPS/OVWFHv6de4o=;
 b=CfG7WjaqNcp07uYH27Vf5t42IERQhO9LxhiD+8nPsV7pq8yF1e4JpnSb/RjmAYqi86
 /fNFdyuEb2qHENUKPbwj+kj52zh0D03WHPMlbxKJqiI9F3GroaZjlVOuOPk+4vOmSPnk
 r+yopB20aDbqE3M52yN6N0ZKOFP+Ucriaf43d2L7hxpTP5sabpncaExARBfYM7E2IQDI
 Q4dloaza1eu7i11Ja52wd0GUIcTW5d7PX2sPCqraZ0aMHDBYyROeT0JZrVn7Vvv1gSv+
 7ncvqWesrWlDnYHBKgSIFm4etxtIpG9nt4s6/L1NUDF4qOYmemG41DPWizy6maFyuR2e
 Kj/g==
X-Gm-Message-State: AOAM532NCca7qrWO1vAoTMO+hID1eRAvALfo0tJEPSxPJ0bO9aUrX5hW
 bcqNFwI6m9sZuOeTm/t5UIK8HdJGvMGUBLSn1pnT7vVOdSer+U0QTKOq5I6hrayGpSYOXL+cJNd
 KDJH8GeLTikmEvAc=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr1720360wmc.154.1601299177406; 
 Mon, 28 Sep 2020 06:19:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdMqjqkMzycwHv7g2uqjOhInjyuyFkPZe57OXnWZZ4SLLwHTMl2i+2Oqr9ydys7nGcitUV0w==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr1720340wmc.154.1601299177219; 
 Mon, 28 Sep 2020 06:19:37 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k8sm1549945wrl.42.2020.09.28.06.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:19:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] qemu/bswap: Use compiler __builtin_bswap()
Date: Mon, 28 Sep 2020 15:19:26 +0200
Message-Id: <20200928131934.739451-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement Richard's suggestion to use __builtin_bswap().

const_XX() not updated. We could use le_bswap() definitions
but they are undefined, not sure yet what is the best way.
Meanwhile I figure this out, these patches are ready for review.

Since v1:
- Remove the Haiku/BSD ifdef'ry (Peter)
- Include the Haiku VM image from Alexander

Alexander von Gluck IV (1):
  tests/vm: Add Haiku test based on their vagrant images

Philippe Mathieu-Daudé (7):
  qemu/bswap: Remove unused qemu_bswap_len()
  qemu/bswap: Replace bswapXX() by compiler __builtin_bswap()
  qemu/bswap: Replace bswapXXs() by compiler __builtin_bswap()
  qemu/bswap: Remove <byteswap.h> dependency
  qemu/bswap: Use compiler __builtin_bswap() on Haiku
  qemu/bswap: Use compiler __builtin_bswap() on FreeBSD
  qemu/bswap: Use compiler __builtin_bswap() on NetBSD

 configure                 |  28 ---------
 include/qemu/bswap.h      |  79 +++++---------------------
 tests/keys/vagrant        |  27 +++++++++
 tests/keys/vagrant.pub    |   1 +
 tests/vm/Makefile.include |   3 +-
 tests/vm/basevm.py        |   5 +-
 tests/vm/haiku.x86_64     | 116 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 164 insertions(+), 95 deletions(-)
 create mode 100644 tests/keys/vagrant
 create mode 100644 tests/keys/vagrant.pub
 create mode 100755 tests/vm/haiku.x86_64

-- 
2.26.2


