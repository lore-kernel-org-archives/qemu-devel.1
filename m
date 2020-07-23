Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9160B206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt2te5Kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9160B206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyYec-00088J-Os
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYdf-00070r-9y
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:39:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54013
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyYdd-0006O8-L3
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 06:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595500784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e6A6gaYfs33J3eN/Z+lLETLAt30hNZUM6K3oFcrYAIY=;
 b=Xt2te5KlrwEqXgKS46+XuSUOXJd7rQbYGfMGtbrdUVsOwvSXheQLs2nj4Tzk7zrH6XLOLg
 0J7WHFjl2EcNy6S98zDyXZcfBlkbIpQllpbv+fWaCtzUDCaBfWI8xbBQT6AegA+ViJmK2G
 NJBycyUmHcZlPmD7vFl1ixas14kWMkA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-75QfnEKlML6Eh07ZGhMyBg-1; Thu, 23 Jul 2020 06:39:43 -0400
X-MC-Unique: 75QfnEKlML6Eh07ZGhMyBg-1
Received: by mail-wm1-f72.google.com with SMTP id h205so2377836wmf.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 03:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=e6A6gaYfs33J3eN/Z+lLETLAt30hNZUM6K3oFcrYAIY=;
 b=dg3sphR4hBBCLYphQufVmwysIy7THaD1ktMovGsai+mFW6Xvm6u/+LQNagNNmp9umj
 FiYZGH+c+uFCPbcfmPYL+psd90I4n4x20rd92+hpnjLEfvf8ExADid5I+FzjGQJ4KUtK
 MalHuYqU3+bDCgPCnsQEeGo2LZwbKZfLeCL6m82uO2aCC/T5ymjq4AY+nwk/oxVDcf5T
 7HEcnvzniwY4Hiz2tL6Io7ccjVieNircbKZUqAnC1Mbq+aKD5ZrT+4ul7BFqc0P1sYfm
 xmpTu57H3haolJGr3CTkR9wea98DWdAJvZxgqba5E2uskgBwDWh6MrNaDuE7dNDDZ6lK
 sdKw==
X-Gm-Message-State: AOAM530En2F2pU61XgDHHI9+k2VAspj8En4GRs1ME0kFD2Z4bGKOjznA
 fvlCUB7UBY228cS8XMmHvBXtE1LIesyfPxzWeUg3c6lBqBblzWVSTlZT5Juajkl34ptTA1VSbOJ
 j3w55xJ6IsFQkW3U=
X-Received: by 2002:a1c:e910:: with SMTP id q16mr3637701wmc.188.1595500781632; 
 Thu, 23 Jul 2020 03:39:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuPH7gkD/YBqusaEl4fYCWNCZXFZUfdszzrTTkPEsQ+cgg6MJph6Pvrw1dFgFNhUhkYqK/Rg==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr3637686wmc.188.1595500781441; 
 Thu, 23 Jul 2020 03:39:41 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t13sm3113860wru.65.2020.07.23.03.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 03:39:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v2 0/2] tpm: Improve error reporting
Date: Thu, 23 Jul 2020 12:39:37 +0200
Message-Id: <20200723103939.19624-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve error reporting by listing TPM backends.

Philippe Mathieu-Daudé (2):
  tpm: Display when no backend is available
  tpm: List the available TPM backends

 tpm.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

-- 
2.21.3


