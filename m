Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332DAC47426
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD99A206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jI1Qp3NS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD99A206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLJG-0000Qj-Qu
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHZ-0007Mw-Sm
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHX-0005OG-6a
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601645969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gJa6lLjujz4Z6eodBHhDkQDnUdrQBiirVQpBE1f30O0=;
 b=jI1Qp3NSAg5mIkSR+LFYc60ABOHs570gXQRDW19u7oOFbWo6dc1mTLPNHlyE6CpZz5BoZ1
 /prq3xjomuOpGFXNgXhSJbZ41V1JgNVilznBxvg4i2K97T8xqzGuDljO/Mm8Bvx2Z8K7RD
 IFnFmVdqaCgOSoyom9DAQUmWOwV0+Hc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Ie205VaLNe-2bTQyaBIGiQ-1; Fri, 02 Oct 2020 09:39:28 -0400
X-MC-Unique: Ie205VaLNe-2bTQyaBIGiQ-1
Received: by mail-wm1-f72.google.com with SMTP id x6so540385wmi.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gJa6lLjujz4Z6eodBHhDkQDnUdrQBiirVQpBE1f30O0=;
 b=B6z2802CEg8J77eUY0SvGg+x8v53wn9/bU4m+3bJSw3v1CmB4ZAqSjeI2gjWQcXmzV
 NSpcfo6DoI5ZXFvBE2SUIEoYuWjg88/LSxR8bPswD4ZsA9lkoi1pmZUMSESjXrmxUkPH
 aKDix1TPkdSRLS2YaTGueJb2Qn+1I0ik6i+Fhj8n4N8C+zNDUs8QFLKbjJaX35Ox+ywg
 xHmrWt+IbZL08KoIDtZLj8vA4h6fpTkgRmSDLPaRRulS/VJA4O+yKT4ekmNZnBSoFSDM
 V6KgCrJrRv19R+pzxSynnvV5xqtpHlmg1GFEp/5+XvTJDajmZ7caJRDpU11FLUyKPSM2
 3HeA==
X-Gm-Message-State: AOAM531yKs+jczK0iQsdt4lOZzw9pxBE7dYHUvwtKCu8CYJUJ2ah2ecP
 c1YeW+Jbmq5c4YvS8fY4FplrGxmQRjSQ+me5EGexIat6BagokOlkmH4zrrPjQQNSV7GLh15/4zj
 kFlj25Lr4Pbi0A1M=
X-Received: by 2002:adf:a418:: with SMTP id d24mr3198326wra.80.1601645966822; 
 Fri, 02 Oct 2020 06:39:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtxtNy6fW+4PHTbuPzJPXeHOxCiDquXwGv5njMeErxQZK42D+who95M+frGMmK92H78CfTVA==
X-Received: by 2002:adf:a418:: with SMTP id d24mr3198294wra.80.1601645966623; 
 Fri, 02 Oct 2020 06:39:26 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k8sm1632520wrl.42.2020.10.02.06.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:39:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] qapi: Restrict machine (and migration) specific commands
Date: Fri,  2 Oct 2020 15:39:18 +0200
Message-Id: <20201002133923.1716645-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reduce the machine code pulled into qemu-storage-daemon.

Philippe Mathieu-Daudé (5):
  qapi: Restrict 'inject-nmi' command to machine code
  qapi: Restrict 'system wakeup/reset/powerdown' commands to
    machine.json
  qapi: Restrict '(p)memsave' command to machine code
  qapi: Restrict 'query-kvm' command to machine code
  qapi: Restrict Xen migration commands to migration.json

 qapi/machine.json      | 168 +++++++++++++++++++++++++++++++++
 qapi/migration.json    |  41 ++++++++
 qapi/misc.json         | 209 -----------------------------------------
 accel/stubs/xen-stub.c |   2 +-
 hw/i386/xen/xen-hvm.c  |   2 +-
 migration/savevm.c     |   1 -
 softmmu/cpus.c         |   1 +
 ui/gtk.c               |   1 +
 ui/cocoa.m             |   1 +
 9 files changed, 214 insertions(+), 212 deletions(-)

-- 
2.26.2


