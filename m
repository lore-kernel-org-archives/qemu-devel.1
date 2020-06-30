Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D94C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9996F20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qgpFLEYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9996F20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBPT-0002ga-Rn
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOW-0001N5-13
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:32 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:46229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBOQ-0003B7-Te
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:13:31 -0400
Received: by mail-ed1-x543.google.com with SMTP id dm19so9048683edb.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6v8AVIUwAWuzZ9kONnyLs51zve9lRFtUpCF/WsnkbuY=;
 b=qgpFLEYd3TyODn1gJ9SY1G3xsycPY9qOAaVbip26fud6xN2xkNWwphWzDSTA3A1pOU
 HLoo7DDukS6alK2RQA/RUd8pePzJVV/5W/DNYuXq7CRdVU90f+AjPEiBL9V9jA+VwZPG
 jU783qYUYJftF41aVFBEsXDS8rARydWo6ryzR7Ho1kgHrVHBYTPQuUmVvX9c4AF5hCIw
 J/O7P1NzocuSxjMGEIjS1ZhBBLaKVlIE+druCcg8CRTmNIdwmo7O37rR+bpehIDCiZMP
 swOxe052LfRiveEJhctVcWwELVCcYhhGg4aFkK3lucMyfiabkLT0V3TI7xi0qXL2voeO
 tJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=6v8AVIUwAWuzZ9kONnyLs51zve9lRFtUpCF/WsnkbuY=;
 b=Iw6ROx5wZ7ZAArvClfXkH+6ujgMD6qBhS5GlBMfeMkqOKdjtAGr+SeVR10lr/yOOx5
 uRtFYLN13/rrdkEcqm24z0yk40m1SLnw1fYcXcwIGYCUerwOb74NTw0HOg+hFcoFu7KA
 +OpQZp9bY4gyJx6FQNHPGLTOXhCcH8MZUDyJBZkK7UpHnCOEz6vwZ1ZPHjCvhMnSKi1W
 f45JaGoqzUH5wKGsvnper08hZs/guRb4Wfi4/ArQ0XgLTmvKe69X+EeOZYHTxl01BNku
 S6e5qWXAAeSFfjF0er4voRN/Hdr9nJXf5meSijLc5YqibLUO8ILgzgKTUTQ6SoZvawcI
 BfeA==
X-Gm-Message-State: AOAM533gLvh6OlzdHscnba3fzIMX3m1Bv4OIy3fPYIe5k4e0SihOM3MZ
 4iNxROX+PajA6l54b+tlHFs=
X-Google-Smtp-Source: ABdhPJzoMqtFqc6/u5KRARaeA0kr82hc8fyVj2lzT4HVucvI6JknimL1Whvchrv5y5t2BdCbX+J0Ug==
X-Received: by 2002:aa7:cd50:: with SMTP id v16mr15171048edw.252.1593504804527; 
 Tue, 30 Jun 2020 01:13:24 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm1425948ejb.41.2020.06.30.01.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 01:13:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Yunqiang Su <ysu@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/7] hw/mips/malta: Rework to allow more than 2GB of RAM on
 64-bit
Date: Tue, 30 Jun 2020 10:13:15 +0200
Message-Id: <20200630081322.19146-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Following Jiaxun Yang's patch and discussion:
https://patchwork.kernel.org/patch/11416915/

- Rename the current machine as 'malta-virt' (keeping 'malta' aliased)
  Suggestions for better names are welcome, maybe 'malta-unreal' or
  'malta-unleashed' instead?
- Add 'malta-phys' which respects hardware restrictions (on RAM so far)
- Unleash 'malta-virt' to allow more than 2GB on 64-bit

Philippe Mathieu-Daudé (7):
  hw/mips/malta: Trivial code movement
  hw/mips/malta: Register the machine as a TypeInfo
  hw/mips/malta: Rename 'malta' machine as 'malta-virt'
  hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
  hw/mips/malta: Introduce the 'malta-phys' machine
  hw/mips/malta: Verify malta-phys machine uses correct DIMM sizes
  hw/mips/malta: Allow more than 2GB on 64-bit malta-virt

 hw/mips/malta.c | 121 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 99 insertions(+), 22 deletions(-)

-- 
2.21.3


