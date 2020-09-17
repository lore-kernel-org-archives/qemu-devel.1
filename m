Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3900C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDC4214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB65CeFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDC4214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwqr-00026N-1s
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwoY-0000Ny-Oa
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIwoV-0000uR-0x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uwxps8oIX9dKcKq3StEakd13NmQlaaGs6GCn8YPbrko=;
 b=dB65CeFQ51GN8jdP+1x0axLk1B4+bf9+ssEZaweIQxBlykxfqueua1+XUA7N79jj3C1V0p
 LvZYB2gh3/YrThBnnkikIDDXOTDYrphZ8MNqIcNIy31qCzPGaxPBimv0ljjjSd2vdi18V0
 d6aIbeUA66J5w1AgHSyxIzFnBlDYz8Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-0riS3xp8NWKQyAQDsYbqnQ-1; Thu, 17 Sep 2020 12:31:09 -0400
X-MC-Unique: 0riS3xp8NWKQyAQDsYbqnQ-1
Received: by mail-wm1-f70.google.com with SMTP id t8so705515wmj.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uwxps8oIX9dKcKq3StEakd13NmQlaaGs6GCn8YPbrko=;
 b=jwxZQJ6dwdeewD7lAevbqhGLoac65dRGGfXprLWMZP1EWRIfE2OWX4AlTQ//inFrC9
 aSd4ggvxtPE+c4LVj8G2nPVPaw8x29t1XLG+6u5JE44RqK6UV9e1jYQF6gCRtmE4bMUw
 KdGXMEhICMCLbeSIMf+sfq0Km5uTK2pn5gIMDqMXOiK+ZhXGLZ98bCqxfvCrhJbSZxD9
 j5I5A4IVOm4cwytpjEwvcf3VM6KmgfG3aDQvONuqlsa3vzcaaE2++MTCsMu/QZSUNhkd
 kio/ksNQPq6z1zfzJa0nGgnyKRJBHjjIKYHOVa48T4cfkBVWCxvkAE/V8HhhoZJWUYJU
 HHmA==
X-Gm-Message-State: AOAM530Y2QLHgCm0OcIIHNfM8RaB+UKKoKsrrfXDiql64o5uHRF2aIF2
 6d+YOoLpzP2MC3rnKK40x+MAbRsQjDkOJhs3NDATc6kXb5TDA1SaRq0DD2ugwcHvJzj/gSHKLD/
 fKkT8td6PeygkzEc=
X-Received: by 2002:a1c:40a:: with SMTP id 10mr11243146wme.61.1600360268370;
 Thu, 17 Sep 2020 09:31:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgSzWGQ1Jg4TBl85RC4K4HWelj5fERKh+fUqcHA0V24m6HCnotk76vkRG+57r/oYOfnxegHg==
X-Received: by 2002:a1c:40a:: with SMTP id 10mr11243118wme.61.1600360268129;
 Thu, 17 Sep 2020 09:31:08 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b84sm103187wmd.0.2020.09.17.09.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 09:31:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] qemu/bswap: Let cpu_to_endian() functions handle constant
 expressions
Date: Thu, 17 Sep 2020 18:31:02 +0200
Message-Id: <20200917163106.49351-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi suggested we can use __builtin_constant_p()
in the cpu_to_ENDIAN()/ENDIAN_to_cpu() functions to check if
expression is constant, and if so use the const_ENDIAN() macros.

This series modifies cpu_to_ENDIAN() to use const_ENDIAN() when
possible.

Philippe Mathieu-Daudé (4):
  qemu/bswap: Move const_le() definitions around
  qemu/bswap: add const_be16() and const_be32()
  qemu/bswap: Add const_le64() and const_be64()
  qemu/bswap: Let cpu_to_endian() functions handle constant expressions

 include/qemu/bswap.h | 75 +++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 21 deletions(-)

-- 
2.26.2


