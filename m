Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04862C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1263206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e95Slw22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1263206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5W2K-0007b3-Ti
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1E-0005xq-Ml
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5W1C-0000bD-Nm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597159008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KfV6MlMMv/Z9hpG/beg9L0P5B3H+p/ZNuociKVfN5U4=;
 b=e95Slw22TDTHoZ5eBEVSFeLvO7DBpF3hE0k0Cmywy84lwY5Kl5+cH0vTBj6ESEQXqwuLiw
 6eKdI3k/l6dsy8n2m/IjOF7BqlBi2BZuLSAPEOpwxugKgaye/gnhKhwfbju/lusO+as8I9
 rHTcVIQYRfd8qghgCpwBow36xD//Rv4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419--ILFEXBxMqydZxgLiM1WMQ-1; Tue, 11 Aug 2020 11:16:47 -0400
X-MC-Unique: -ILFEXBxMqydZxgLiM1WMQ-1
Received: by mail-wm1-f69.google.com with SMTP id u144so918583wmu.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 08:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KfV6MlMMv/Z9hpG/beg9L0P5B3H+p/ZNuociKVfN5U4=;
 b=ivsnKgnbAkk24IhAZtzM/eRXNEE5fu8k60hxBOTpmeVVOJgLR7EzexjVv6N1HEhAKB
 mUhPrRH8Km1ijwYhr4NW3JlG6c404GGezFqhR+W5ugKyXX7rqWJruUKx+xtQ/VGHAJtJ
 3UVVsrELFUJSOg2w+esRh5MojCUBnA4ydpzFQZbbHRxpridgyPnymjmck0GDEIUppv7L
 7UtdB/dp97o6fWRXLJXLO065x3aWZq4M1jVqbCGqd8ikhaL1XKA0a3US8mzC9886RFhs
 uINeO0411wIRpovs2icbpIynmD+LcHlKnOsH8Ay7KyA2E4tQhAMmnlHrMh+it2OaB3XU
 8/Fw==
X-Gm-Message-State: AOAM532LF5KLSbOctHb0nanbs5jSUs5BaDYLDEv7nA/AQ0n5bbcsuKzY
 SN2S5oFAFRrC80Qgzcja18JR29fYshGPuJuF577H6zxy+QThiyuatYnxaeq3qDqLct9BFXEgBOE
 JAlBtjKG9r5I/Oo4=
X-Received: by 2002:a1c:984d:: with SMTP id a74mr4689824wme.140.1597159005732; 
 Tue, 11 Aug 2020 08:16:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUKhJwRU8DQJUdvJ23weH1I+VDGDrybtGCUxRVV0jgtqCCmvTHGp09ka1aY3aEln2ZhbCpQg==
X-Received: by 2002:a1c:984d:: with SMTP id a74mr4689800wme.140.1597159005451; 
 Tue, 11 Aug 2020 08:16:45 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b2sm5550421wmj.47.2020.08.11.08.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 08:16:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 0/3] trivial: Remove 'and and' in descriptions
Date: Tue, 11 Aug 2020 17:16:40 +0200
Message-Id: <20200811151643.21293-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:49:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Corey Minyard <cminyard@mvista.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove duplicated 'and' in comments.

Philippe Mathieu-Daudé (3):
  hw/i2c: Fix typo in description
  util/qemu-timer: Fix typo in description
  util/vfio-helpers: Fix typo in description

 include/hw/i2c/i2c.h | 2 +-
 util/qemu-timer.c    | 2 +-
 util/vfio-helpers.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.21.3


