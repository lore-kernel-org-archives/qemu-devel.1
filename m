Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC372C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5412074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="PzbtkjGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5412074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZ5I-0001gv-6A
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYyj-0003Gp-Lz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:53 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:34743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kNYye-0005C7-Uz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:04:53 -0400
Received: by mail-pj1-x1036.google.com with SMTP id s14so701887pju.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=HSq+Ir9vUAcFclVGpXTnRULSP4HkjTw+bUu7CMUflZU=;
 b=PzbtkjGs9t8Pyq9XLCyftyREQy2i3bGBFnVRUZKyF82AYh6p9QiphwY9AK81gJ3sXV
 DRH8iwjzttKUSj7A107g/eYXwJfq7XKnVX+myaJmCvqufOivRMubemX8SPeEfRhxLVTn
 FmDzMWWgjbZ2bvWUDJXdhOxReayZjd2DTK75W0NMOGjrjoO5TL5Dm05HSKa1v4UT57mF
 IEXXXuJB5PLUBEPg+PKX2OHrKHu9a2aNGzcew7XIOshB9BkrUqD0bV005h6O/8hYsmlr
 UOks7MZsSHnusBMPcWETYCB/HgDJV8T/MHBKDkAsei4oSSt/5qzEaPd33KcdL0kEYrQv
 mbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HSq+Ir9vUAcFclVGpXTnRULSP4HkjTw+bUu7CMUflZU=;
 b=ox2+JSybVnxrYpGK1xmp2nFJaqe0DHMoiiHwxKhLkZBiQZM5O0mlexrbzGIOgUVu8S
 8/tzeUOQIRASr9hFHKmkk3Ob4Q1sd8IbNhlXBRLdkKVqgRsQvcyJOS6KaAChqgMAwNYC
 FDmzmvtdIMRBQ0B8SsySOHStdxtKbYUwAKckJbj2LgncmEmE5m3+NffsBhzhJkRJmbFl
 bq7LNlCF7cr8LWAmrTsY+OiEKRbJoNHM65mjmNtyVAXBe4SHr8k7U1uO15DiLweNKRoq
 UUuvEyJNcYU6et8THoRzKh8CDlX0nwGM6TaanEgDkbYk+9Ec2f9KJSB52LMHEs+UpgCF
 mqlg==
X-Gm-Message-State: AOAM532Lz35gzEbyK8chjjOL0HwIvvBvHRM2Yzm7+ZNOYG7mPlnV9Eg8
 yvSXcbQ+4aPcziIv3IlZ2jmR2g==
X-Google-Smtp-Source: ABdhPJz1NardNIVq1pDN9hMOCqnKet+7NbsjDYzhHqPLJ1zUuBY5TsZ9ZjqKs9lbUeTVo5oXT4DjlQ==
X-Received: by 2002:a17:902:a50b:b029:d1:e5e7:bdd2 with SMTP id
 s11-20020a170902a50bb02900d1e5e7bdd2mr1808770plq.50.1601460286045; 
 Wed, 30 Sep 2020 03:04:46 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c185sm1884230pfb.123.2020.09.30.03.04.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:04:45 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com,
	peter.maydell@linaro.org
Subject: [PATCH v3 0/3] add MEMORY_FAILURE event
Date: Wed, 30 Sep 2020 18:04:37 +0800
Message-Id: <20200930100440.1060708-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pj1-x1036.google.com
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
Cc: qemu-devel@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2->v3:
Use g_strdup_printf instead of snprintf.
Declear memory failure event as 3 parts: 'recipient', 'action', 'flags'.
Wrapper function emit_guest_memory_failure&emit_hypervisor_memory_failure.

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

 qapi/run-state.json  | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/helper.c | 47 ++++++++++++++++++++++-------
 target/i386/kvm.c    | 13 +++++++-
 3 files changed, 134 insertions(+), 11 deletions(-)

-- 
2.11.0


