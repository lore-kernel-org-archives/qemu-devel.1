Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408DEC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:58:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916FA2388B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="iXzB1lMS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916FA2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKf3p-00044N-85
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2R-0002H5-I6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:43 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:35927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kKf2N-0001rv-JF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:56:41 -0400
Received: by mail-pg1-x52f.google.com with SMTP id f2so11527629pgd.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=JDU2AcPZ1+MSqexQWc21YlZesADVE3r68R7oZHwPlBI=;
 b=iXzB1lMSheIQCxqy1naXYZX0wEY4bpaGL/qBYo3NRXtJ3sG8sKN3leifI626YUPTTl
 AtMiSDqiY6VGjTI4cl+C3gRt4mAmzWSGjm3VbW6o2MsA4oRne7RB/fFk6Cr3QUvQ9z5X
 E2EWGZZPm22MBvFAlJW+CLd4t8MpMgIUPpgzh/IQQAsUPZyBAZZ1KHkbp19902+RBrUj
 4+NmZ89y+UruAG5f98Dw680GfYCf4HiwWFVi4EQfkWqwIAmXhEv0/zsS8St2/3fGrkzC
 jbzre/YsRpm2RN7onsJ2iKntdCNtRoernMX2HlSrVZUm+WvaKpmJJfY37aAMoqjFZsBv
 q8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=JDU2AcPZ1+MSqexQWc21YlZesADVE3r68R7oZHwPlBI=;
 b=kEr3f1yhCclvUmL+pHDP7vXQ7L3MwVAUrqJvJuk3k2HmxbB5REZO+g3GPOxmAYod14
 cIZWuaN6irZdd3HJ3LBEHDLVydc58cg2piFtHuMU/h8MfWBwY8NKMARyFNPMcYhoVBj5
 b2H90NfUCNESe1lSPHXANMRItZu+nWJfLdJj0TYOI7z8oVLNn9O2bksD96vnKTN60VlI
 x+adiZXbZgG2R66o4RpLpX+6V//BaGBmHszT9BLCzh7i0873Zsakx7xf3h4tl+ZUsxhw
 C4LzGjDhilVGssnnH2taP0h2qwiFEnIluGpVWscbpvn4dVJ94EAZkReM+oQdk+QO5cfZ
 hb8A==
X-Gm-Message-State: AOAM532UKgQ4gphHYDT/jaXsmKaBy7CGL4C45KUrZ/IOGwNm2/uz5Wok
 fXsXaFvH85SIZLmuvbGFPz5XOQ==
X-Google-Smtp-Source: ABdhPJxP3Nn/xzAnpMylz5723kIViZFsAhfb+5Dd+67YrFdmvFGpMkUQ6icc+hPmEHu1yNNtSq1IMw==
X-Received: by 2002:a17:902:8682:b029:d1:f289:1b8a with SMTP id
 g2-20020a1709028682b02900d1f2891b8amr3782686plo.69.1600768596833; 
 Tue, 22 Sep 2020 02:56:36 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id e2sm2013239pjm.27.2020.09.22.02.56.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:56:36 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v2 0/3] add MEMORY_FAILURE event
Date: Tue, 22 Sep 2020 17:56:27 +0800
Message-Id: <20200922095630.394893-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: mtosatti@redhat.com, armbru@redhat.com, pizhenwei@bytedance.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v1->v2:
Suggested by Peter Maydell, rename events to make them
architecture-neutral:
'PC-RAM' -> 'guest-memory'
'guest-triple-fault' -> 'guest-mce-fatal'

Suggested by Paolo, add more fields in event:
'action-required': boolean type to distinguish a guest-mce is AR/AO.
'recursive': boolean type. set true if: previous MCE in processing
             in guest, another AO MCE occurs.

v1:
Although QEMU could catch signal BUS to handle hardware memory
corrupted event, sadly, QEMU just prints a little log and try to fix
it silently.

In these patches, introduce a 'MEMORY_FAILURE' event with 4 detailed
actions of QEMU, then uplayer could know what situaction QEMU hit and
did. And further step we can do: if a host server hits a 'hypervisor-ignore'
or 'guest-mce', scheduler could migrate VM to another host; if hitting
'hypervisor-stop' or 'guest-triple-fault', scheduler could select other
healthy servers to launch VM.

Zhenwei Pi (3):
  target-i386: seperate MCIP & MCE_MASK error reason
  qapi/run-state.json: introduce memory failure event
  target-i386: post memory failure event to uplayer

 qapi/run-state.json  | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/helper.c | 40 +++++++++++++++++++++++++------
 target/i386/kvm.c    |  7 +++++-
 3 files changed, 106 insertions(+), 8 deletions(-)

-- 
2.11.0


