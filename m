Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE9C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3965E22240
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpAUttVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3965E22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6SK-0008Fu-6Y
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6NL-0004Lx-3T
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22690)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kT6NI-0000Tj-9q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ieNGRzJXZMmGX78KrPngoN8zOUKAEvnJwNa2od2IgGY=;
 b=QpAUttVjeaocOrXPETRFrJGZ/mya4ek2KPdaDub4yTqVC8lRZ2VzN1uuDEEjYfhWfn9abe
 Dn8qpz2GxTcQOgmSmI8F9K2Tnvinnp5xa8zY/W19Q7sEViBxksZ93f/pK6q83tcqsnakY9
 4hyxmM9cyJiw7174YBirQdSVz6/eS1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-TL24v3ZnPwm7D8Ox3A4UJg-1; Thu, 15 Oct 2020 12:45:04 -0400
X-MC-Unique: TL24v3ZnPwm7D8Ox3A4UJg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFBCB57089;
 Thu, 15 Oct 2020 16:45:02 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E1BD19C4F;
 Thu, 15 Oct 2020 16:45:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/9] x86 queue, 2020-10-15
Date: Thu, 15 Oct 2020 12:44:52 -0400
Message-Id: <20201015164501.462775-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-reques=
t' into staging (2020-10-14 13:56:06 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request=0D
=0D
for you to fetch changes up to 3e6a015cbd0f61c19cdc02d5ce74a3e60235cb9a:=0D
=0D
  i386: Mark Icelake-Client CPU models deprecated (2020-10-14 15:28:55 -040=
0)=0D
=0D
----------------------------------------------------------------=0D
x86 queue, 2020-10-15=0D
=0D
Cleanups:=0D
* Drop x86_cpu_get_supported_feature_word() forward declaration=0D
  (Vitaly Kuznetsov)=0D
* Delete kvm_allows_irq0_override() (Eduardo Habkost)=0D
* Correct documentation of kvm_irqchip_*() (Eduardo Habkost)=0D
* Fix FEATURE_HYPERV_EDX value in hyperv_passthrough case (Zhenyu Wang)=0D
=0D
Deprecation:=0D
* CPU model deprecation API (Robert Hoo)=0D
* Mark Icelake-Client CPU models deprecated (Robert Hoo)=0D
=0D
Bug fixes:=0D
* Remove core_id assert check in CPUID 0x8000001E (Babu Moger)=0D
=0D
----------------------------------------------------------------=0D
=0D
Babu Moger (1):=0D
  target/i386: Remove core_id assert check in CPUID 0x8000001E=0D
=0D
Eduardo Habkost (4):=0D
  i386/kvm: Require KVM_CAP_IRQ_ROUTING=0D
  i386/kvm: Remove IRQ routing support checks=0D
  i386/kvm: Delete kvm_allows_irq0_override()=0D
  kvm: Correct documentation of kvm_irqchip_*()=0D
=0D
Robert Hoo (2):=0D
  cpu: Introduce CPU model deprecation API=0D
  i386: Mark Icelake-Client CPU models deprecated=0D
=0D
Vitaly Kuznetsov (1):=0D
  i386: drop x86_cpu_get_supported_feature_word() forward declaration=0D
=0D
Zhenyu Wang (1):=0D
  i386/kvm: fix FEATURE_HYPERV_EDX value in hyperv_passthrough case=0D
=0D
 docs/system/deprecated.rst |  6 ++++++=0D
 qapi/machine-target.json   |  7 ++++++-=0D
 include/hw/core/cpu.h      |  3 +++=0D
 include/sysemu/kvm.h       | 19 +++++++++----------=0D
 target/i386/kvm_i386.h     |  1 -=0D
 hw/core/machine.c          | 12 ++++++++++--=0D
 hw/i386/fw_cfg.c           |  2 +-=0D
 hw/i386/kvm/apic.c         |  5 ++---=0D
 hw/i386/kvm/ioapic.c       | 33 ++++++++++++++++-----------------=0D
 hw/i386/microvm.c          |  2 +-=0D
 hw/i386/pc.c               |  2 +-=0D
 target/i386/cpu.c          | 32 +++++++++++++++++++++++---------=0D
 target/i386/kvm-stub.c     |  5 -----=0D
 target/i386/kvm.c          | 19 ++++++-------------=0D
 14 files changed, 84 insertions(+), 64 deletions(-)=0D
=0D
--=20=0D
2.28.0=0D
=0D


