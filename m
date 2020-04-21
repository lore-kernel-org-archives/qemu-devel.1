Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E83C54FCC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D91206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BV37/YtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D91206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvgt-0004ac-Gm
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveF-0000lC-Ol
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveA-00045T-Qt
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveA-00043t-Dc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dytfVvl8cVtUWQSCTnW2pyLGwH37x9vBssVjcyN1zFg=;
 b=BV37/YtIG8thVgq9DyD9kXwjhsZQQskH6TSioF0Rl9JkDgsfLppEU56ji/60w6BmSQLK/5
 9TRVm7WsT+Ca7ka0G2Z/zwLUXSI+gXwBE2Tf0rOAv4HJ0SFtjL3D1T/kgbLUZrlYuT+m3N
 oNqtlERKEi5FDnA4CvFjxa6jSkIrSVI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-SzFgKnNRPm23dd8ZxNORUQ-1; Tue, 21 Apr 2020 12:21:11 -0400
X-MC-Unique: SzFgKnNRPm23dd8ZxNORUQ-1
Received: by mail-qk1-f200.google.com with SMTP id d15so14656200qkg.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hsoqA2dLDfxYMxPVALk1kTnKU72E+7GRAZddtBNh06o=;
 b=dPdqm8Nfs0vYGQ538l/TzhPNgB+7RjHTapf682GDThNtZj3qMj0X/+MJNdaezMu2uh
 GnZb7VXWQzdfSf8WCqEbnP7QvyuObxHR596zZ7lTYVbWEQnY30giU1Bsi3Qw2J++ts8Z
 fZ8kY8iowjTGZSvh6aiTx/qBVg9ptpNO/j1ELd7LlUHCshEMlWhsSp755Sqj9YVHxNDx
 345DsueJ2iabw1WLyr4bCdFfGmMVvyckBvuReCZRoiPephPj6dtvAbjDB6sySG94/4//
 kASkOszXPuD/zySG9lcW1Uv83Ka+PoN5DQJqW1qO8epC5yjzcvKUTMeSRlzM9v+bDVxW
 aAbw==
X-Gm-Message-State: AGi0PuZLyhk4dmBNDakQHlWKvcN9dgINjqNjPKzcjezyYSyaWc+fU555
 5osIpecBZc7yid1oPkIyVXxy3lhh6CFMmYU8yuukZbbjBRXlk5MSLlEE31hS7m8WFPd6ZFE+b8i
 u4b+MZ+QfOj+rZcs=
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr22020810qtn.174.1587486070885; 
 Tue, 21 Apr 2020 09:21:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypKoMv4pRnTMUTOHP15hrRags4Hbgg/9WL8RgzlRX4709/5HfFLXqiAU0d5bUVfEHuTyPd+apw==
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr22020788qtn.174.1587486070599; 
 Tue, 21 Apr 2020 09:21:10 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u5sm2034393qkm.116.2020.04.21.09.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/8] memory: Sanity checks memory transaction when releasing
 BQL
Date: Tue, 21 Apr 2020 12:21:00 -0400
Message-Id: <20200421162108.594796-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 11:47:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a continuous work of previous discussion on memory transactions [1]=
.
It should be helpful to fail QEMU far earlier if there's misuse of BQL agai=
nst
the QEMU memory model.

One example is run_on_cpu() during memory commit.  That'll work previously,=
 but
it'll fail with very strange errors (like KVM ioctl failure due to memslot
already existed, and it's not guaranteed to trigger constantly).  Now it'll
directly fail when run_on_cpu() is called.

Please have a look, thanks.

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03205.html

Peter Xu (8):
  memory: Introduce memory_region_transaction_{push|pop}()
  memory: Don't do topology update in memory finalize()
  cpus: Use qemu_cond_wait_iothread() where proper
  cpus: Introduce qemu_cond_timedwait_iothread()
  cpus: Remove the mutex parameter from do_run_on_cpu()
  cpus: Introduce qemu_mutex_unlock_iothread_prepare()
  memory: Assert on no ongoing memory transaction before release BQL
  memory: Delay the transaction pop() until commit completed

 cpus-common.c                  |  5 ++--
 cpus.c                         | 32 ++++++++++++++------
 include/exec/memory-internal.h |  1 +
 include/hw/core/cpu.h          |  4 +--
 include/qemu/main-loop.h       |  7 +++++
 memory.c                       | 53 ++++++++++++++++++++++++++++++----
 6 files changed, 81 insertions(+), 21 deletions(-)

--=20
2.24.1


