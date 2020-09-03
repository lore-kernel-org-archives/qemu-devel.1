Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAD2C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC562071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fABJy+fO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC562071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpZ6-00013X-5X
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDpYA-0008GN-Qx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDpY9-00019V-E6
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599140712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P4jh2niYh7bJWP7dxPOPtR//yRKxWrNKnOiJly1cel4=;
 b=fABJy+fO6XrrKe2zgoYYBgMHYIbasmJQqs3RVEwVPQiaNUnYyLcPlBz5PWIR4MYiBpZad/
 AJvl5MjJdez/iay3wgSHmCuEfZhxB2qS8iPTzisFe+bNEFOVAGUmnvyMiLGTioMKIsyAsL
 FdCUr3ZGwYntHizXlIFHyz78zC15pck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-LqL-9eFOMbutYAUUeXMGFg-1; Thu, 03 Sep 2020 09:45:10 -0400
X-MC-Unique: LqL-9eFOMbutYAUUeXMGFg-1
Received: by mail-wr1-f71.google.com with SMTP id m7so1084966wrb.20
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=P4jh2niYh7bJWP7dxPOPtR//yRKxWrNKnOiJly1cel4=;
 b=dNeuQrQkAnBR3R32GFEpK9JcPKEEbcAbvHpN9R0jhG5XzRGazeiWLIMPIgq1t+uw3l
 8jZptxLCKcikaqauxC9kH/gqVJoMp+QpJJ4yCQvgqIcVnjRQME+VnZrCGN23UEqp5SJs
 j6LxAzja2eGoWMEvS5uiZjGE3zWxJUdqFL+IDxwC3lq/yL7OcOL7G1HmyNpOKNiFR6Wx
 2/zuYw6YoynzG3EOQ+MdBMaR0zbZiwC1eXMVbBHMiiIT1xOHDnYz2qIy3I4RLoA9e//i
 YH0AZqLCYh+xTTMr/Qy+V/WEg27OdGtccIJ1Yy1EIlof3THPZ/q4SlbTt/wr+vk4n+qA
 5M2A==
X-Gm-Message-State: AOAM5311Ma+3ZpvSWopqfvnTy6ykoGDtEIiQjRDtXF8sTYKZaeDF0m1X
 GqTUsuMMx7z2erkJbeWhLn7RVBHIviXnaiSg1hOqRwjNVPyiC12LkMfuFn9O1YppLmia9EczNZ5
 BISZz09PwNocvSCI=
X-Received: by 2002:adf:ed05:: with SMTP id a5mr2563807wro.364.1599140708660; 
 Thu, 03 Sep 2020 06:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCLFyihtNCmruEdp3nkX1omfPo9T8qqtH1353h2gVmdW7hsEwMPvmbajd3JlqWuuaiPkwpPg==
X-Received: by 2002:adf:ed05:: with SMTP id a5mr2563793wro.364.1599140708547; 
 Thu, 03 Sep 2020 06:45:08 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id y1sm4345972wma.36.2020.09.03.06.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 06:45:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/timer/hpet: Trivial format string fix
Date: Thu,  3 Sep 2020 15:45:04 +0200
Message-Id: <20200903134506.440082-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a format string and remove dead code.

Philippe Mathieu-Daudé (2):
  hw/timer/hpet: Remove dead code
  hw/timer/hpet: Fix DPRINTF format string

 hw/timer/hpet.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

-- 
2.26.2


