Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A439C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08A322240
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5uOjAZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08A322240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpjQ-0001fv-FJ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpeM-0005ow-1C
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUpeK-0000HW-D2
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603192669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CsqA7zQOJxM+FW14jB2W0UpP6XSC4B4K5Dp8/DR20zw=;
 b=a5uOjAZG7FtTwX0b2Do7rzk4YzHobuTQfZRSiAHyykgb9/oMD3idh1CA8skfSkF/QJ4sns
 VxOPwQ1UwD2EkUcUKIg52O2Q6KIRcD41/qYSDbspEuk6oln2dHIVP8YQGoLFSTdprr1mww
 MH8oZ6cuxYBWyNjQAJ0f+o9Ek8VFP3U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-lkgToUNMNGef53L92DAVdQ-1; Tue, 20 Oct 2020 07:17:47 -0400
X-MC-Unique: lkgToUNMNGef53L92DAVdQ-1
Received: by mail-wm1-f71.google.com with SMTP id f2so283480wml.6
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 04:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+R4TradO2WVN2cBs03oCot5eoSt2C7kTM21x8rrYjp4=;
 b=K4trD6dqU31mMv3MyTrURNlXzboMzUb024mSnjA8unUmg32p9oda4H9J78I97ezsut
 1FV8uyByC/feypjPcXN2GMRidJLuRqeECxaPtqyhU8SvQe1Iqz7bKUWEVK3C2aLIVf0a
 jhfOtOpmJs4a9QaoDt5q9efaorv3jBAG2ShZXDDefL6Rm9G1Mri++5TTtI7mjGOb8fH2
 5uYdH2pXMuyPU76pCW7Bz9M5qZD76r/YcqyiCo2khfFJk72VYjrpeOBrNOY/YiCimRGG
 tEbVSY2aYzezicP7CaGZPZbAsf461wG8nTB0xEp6XgBIpkDpcj/ZebNAJeFJ57SRcBeZ
 lU2Q==
X-Gm-Message-State: AOAM532Y+WoAAmjHnWoKR2MvozV6v8NzPGuLkyM4kaBJDjP6SVZNUYss
 tTDJ63bZZox0yo5Up8jk3ghzbcKCKGgHJYsp9fg862F2uma8xlFFTkzDGKK/o+xfhB0DXER7ex6
 7n1Tnu9sELMroMZ0=
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr2323016wmc.164.1603192665871; 
 Tue, 20 Oct 2020 04:17:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiyvwZxSE6FCVDAJ9DwjNm4Wa5lv8ON5LCP9V7oPgux5gXDag6N/WQox1254nc7Xz6I7FyMw==
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr2322999wmc.164.1603192665675; 
 Tue, 20 Oct 2020 04:17:45 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e15sm2461388wro.13.2020.10.20.04.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 04:17:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 0/2] util/oslib: qemu_try_memalign() improvements
Date: Tue, 20 Oct 2020 13:17:41 +0200
Message-Id: <20201020111743.2074694-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Use _aligned_malloc for qemu_try_memalign on win32=0D
- Assert qemu_try_memalign() alignment is a power of 2=0D
=0D
Supersedes: <20201018164836.1149452-1-richard.henderson@linaro.org>=0D
=0D
Philippe Mathieu-Daud=C3=A9 (1):=0D
  util/oslib: Assert qemu_try_memalign() alignment is a power of 2=0D
=0D
Richard Henderson (1):=0D
  util/oslib-win32: Use _aligned_malloc for qemu_try_memalign=0D
=0D
 util/oslib-posix.c |  3 +++=0D
 util/oslib-win32.c | 12 +++++-------=0D
 2 files changed, 8 insertions(+), 7 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


