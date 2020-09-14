Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B1FC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4797E20756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="vKoAkzcS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4797E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHonj-0007qC-E7
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHolb-0004Iz-EX
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:35 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1kHolW-0003Ch-VW
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:43:32 -0400
Received: by mail-pf1-x443.google.com with SMTP id x123so12670218pfc.7
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=9Cm593oY7v0wxdfQSa2Js0D9ZDTltrGQ0DOqraPYiLg=;
 b=vKoAkzcS203CFtpSCMYm8TccaYh1n4Z/fz4RXLGRD8hM0cZJIcHoRzcqirxw2YjpXv
 g2P+MFh70BtN1QVA0ej50ulOqwsVnonW9qYgxkS9qK3asWx8BwgwfCp10WzMJTcj+XyJ
 UomsYCcDndj0T6+0C0ik/gYAsS07v5/xQJMC6lG5zQLwWxAgo5W4pPb4Rc5Vum71IVe5
 Sjij7xfTKFqYJXH6Q9eOYhDezaGmgpJdfa+wWh+yFgW2be6zEXIWaGqv85tYI9b18P6w
 f5s/W4JULhZ/C+cUt631IF5qSLeVtAGmQ94YhqtYcn20fEbyNggYuIgWN2s9Nv+A16RF
 jkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9Cm593oY7v0wxdfQSa2Js0D9ZDTltrGQ0DOqraPYiLg=;
 b=BAYM9QwkCEcxm3XYeg20edCQMkQWXEfTlnSTwr2K1N9pzZ9A5yTG6bXADf8exqai8B
 3SmJ/ya1PsuYgS4wOe0y3/sEB28ZTPHHpWXBgcOBkopbEIA5yOMmzFFjtjhSEBQ7ogKA
 hrEKaw41QHgzOMDZQX/rpEVOirKKP9My7aE+f0l1KaSTCY85Lj28ncoLX3+AP0x0fkJI
 VQ0G6tCIPm7udjVVoQZ2SADx7CoWtifqjenKdvZ9j1TZ5/z9wjpBIPgGac3Ej2fkxBxE
 6ywm+2hkuSt34PbYd9T31G6uVEQvSJ7Rj3wO8aCYFRmNGJ9ENyztDkQbUBwCAS3eClVU
 s8fQ==
X-Gm-Message-State: AOAM533LhOGveuGPcwogHUT9NCeudUi0eVFspI5nm2kL51Ld1iko06dp
 vArOK3iyxUXV+R4SRJYwOB2h/g==
X-Google-Smtp-Source: ABdhPJyGr9fGZzALF2K3n36rZwYYhFqgc3WwH5g9jS6ZXbUBpEDsNOHXnYqt1dxJYRiu2SbWDAC5Lw==
X-Received: by 2002:a17:902:6bc1:b029:d0:cbe1:e73d with SMTP id
 m1-20020a1709026bc1b02900d0cbe1e73dmr14390309plt.24.1600091007963; 
 Mon, 14 Sep 2020 06:43:27 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id c4sm7626378pjq.7.2020.09.14.06.43.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Sep 2020 06:43:27 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: armbru@redhat.com,
	pbonzini@redhat.com,
	mtosatti@redhat.com
Subject: [PATCH 0/3] add MEMORY_FAILURE event
Date: Mon, 14 Sep 2020 21:43:18 +0800
Message-Id: <20200914134321.958079-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x443.google.com
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
Cc: qemu-devel@nongnu.org, pizhenwei@bytedance.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although QEMU could catch signal BUS to handle hardware memory
corrupted event, sadly, QEMU just prints a little log and try to fix
it silently.

In these patches, introduce a 'MEMORY_FAILURE' event with 4 detailed
actions of QEMU, then uplayer could know what situaction QEMU hit and
did. And further step we can do: if a host server hits a 'hypervisor-ignore'
or 'guest-mce', scheduler could migrate VM to another host; if hitting
'hypervisor-stop' or 'guest-triple-fault', scheduler could select other
healthy servers to launch VM.

zhenwei pi (3):
  target-i386: seperate MCIP & MCE_MASK error reason
  iqapi/run-state.json: introduce memory failure event
  target-i386: post memory failure event to uplayer

 qapi/run-state.json  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/helper.c | 30 +++++++++++++++++++++++-------
 target/i386/kvm.c    |  5 ++++-
 3 files changed, 73 insertions(+), 8 deletions(-)

-- 
2.11.0


