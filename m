Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D17C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8135221707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 20:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt7MiWWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8135221707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJN0h-0007rf-DM
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 16:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJMzC-0006TL-Gx
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37177)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kJMz9-0003p6-F8
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 16:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600460878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vK2g5r+C+F4wrPWuK9qYoigf2noB+00M1zfYcqFoTLg=;
 b=gt7MiWWwt1WfO7+VYpl5Jcx/64v7J9FEZ5tJMSslyrOwFNa/WSHU7XSH4MgmasD59nUtOp
 oyVKSCr5fW4pXc6aUMj8iyILmZX2SKcJ2CG4xlTAFLyxDHB7uPcLC6/qROxRcJHr2A1YEq
 YXRcX4NJT3hY+Om0QrZ5Plz4AASaoyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-aomeyOThP8KkxZ2eXPntlQ-1; Fri, 18 Sep 2020 16:27:56 -0400
X-MC-Unique: aomeyOThP8KkxZ2eXPntlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B372988EF19;
 Fri, 18 Sep 2020 20:27:54 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97DFD9CBA;
 Fri, 18 Sep 2020 20:27:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] x86 queue, 2020-09-18
Date: Fri, 18 Sep 2020 16:27:46 -0400
Message-Id: <20200918202750.10358-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 053a4177817db307ec854356e95b5b350800a216:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918' into staging (2020-09-18 16:34:26 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 31ada106d891f56f54d4234ce58c552bc2e734af:

  i386: Simplify CPUID_8000_001E for AMD (2020-09-18 13:50:31 -0400)

----------------------------------------------------------------
x86 queue, 2020-09-18

Cleanups:
* Correct the meaning of '0xffffffff' value for hv-spinlocks (Vitaly Kuznetsov)
* vmport: Drop superfluous parenthesis (Philippe Mathieu-Daudé)

Fixes:
* Use generic APIC ID encoding code for EPYC (Babu Moger)

----------------------------------------------------------------

Babu Moger (2):
  i386: Simplify CPUID_8000_001d for AMD
  i386: Simplify CPUID_8000_001E for AMD

Philippe Mathieu-Daudé (1):
  hw/i386/vmport: Drop superfluous parenthesis around function typedef

Vitaly Kuznetsov (1):
  i386/kvm: correct the meaning of '0xffffffff' value for hv-spinlocks

 docs/hyperv.txt          |   2 +-
 include/hw/i386/vmport.h |   2 +-
 target/i386/cpu.h        |   4 +-
 target/i386/cpu.c        | 228 +++++++++++----------------------------
 target/i386/kvm.c        |   4 +-
 5 files changed, 68 insertions(+), 172 deletions(-)

-- 
2.26.2


