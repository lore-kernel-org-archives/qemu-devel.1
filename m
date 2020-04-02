Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B59C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0562B206F8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 22:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKlQ8oKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0562B206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK8Dt-0002du-8c
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 18:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jK8Cu-0001W7-GM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1jK8Cs-0007Me-Ep
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1jK8Cs-0007Kg-95
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 18:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585866061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5YucMUxX5LPiIpTBrsiIhNgFc6a5S/kRUfEGoDl5NFU=;
 b=GKlQ8oKW5nlgFijBnuoOA5CW/EW74YETySYOrTWPUXf/e2BFkltQl0/6yWRoqV/ZHZTMNW
 LnG3fKK01ENKJwYR229A0/kCpkHWUleRyxPS4rWQ+0em9YtP54lXGTML0WnEtWI/N0Ssbi
 MCcgbgAPO4izeloEqGw6wnIUT/bz+rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-FtrN3n8JNTuMTIcFOAT1vw-1; Thu, 02 Apr 2020 18:20:57 -0400
X-MC-Unique: FtrN3n8JNTuMTIcFOAT1vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C83A18A6EC2;
 Thu,  2 Apr 2020 22:20:56 +0000 (UTC)
Received: from localhost (ovpn-116-71.gru2.redhat.com [10.97.116.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A538E5C57B;
 Thu,  2 Apr 2020 22:20:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/9] x86 queue for -rc2
Date: Thu,  2 Apr 2020 19:20:42 -0300
Message-Id: <20200402222051.523093-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This was supposed to be submitted before -rc1, but I've dropped=0D
the ball (sorry).=0D
=0D
The following changes since commit 2833ad487cfff7dc33703e4731b75facde1c561e=
:=0D
=0D
  Update version for v5.0.0-rc1 release (2020-03-31 18:02:47 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request=0D
=0D
for you to fetch changes up to d965dc35592d24c0c1519f1c566223c6277cb80e:=0D
=0D
  target/i386: Add ARCH_CAPABILITIES related bits into Icelake-Server CPU m=
odel (2020-03-31 19:13:32 -0300)=0D
=0D
----------------------------------------------------------------=0D
x86 queue for -rc2=0D
=0D
Fixes:=0D
* EPYC CPU model APIC ID topology fixes (Babu Moger)=0D
* Fix crash when enabling intel-pt on older machine types=0D
  (Luwei Kang)=0D
* Add missing ARCH_CAPABILITIES bits to Icelake-Server CPU model=0D
  (Xiaoyao Li)=0D
=0D
----------------------------------------------------------------=0D
=0D
Babu Moger (7):=0D
  hw/386: Add EPYC mode topology decoding functions=0D
  target/i386: Cleanup and use the EPYC mode topology functions=0D
  hw/i386: Introduce apicid functions inside X86MachineState=0D
  i386: Introduce use_epyc_apic_id_encoding in X86CPUDefinition=0D
  hw/i386: Move arch_id decode inside x86_cpus_init=0D
  target/i386: Enable new apic id encoding for EPYC based cpus models=0D
  i386: Fix pkg_id offset for EPYC cpu models=0D
=0D
Luwei Kang (1):=0D
  target/i386: set the CPUID level to 0x14 on old machine-type=0D
=0D
Xiaoyao Li (1):=0D
  target/i386: Add ARCH_CAPABILITIES related bits into Icelake-Server=0D
    CPU model=0D
=0D
 hw/i386/pc.c               |   7 +-=0D
 hw/i386/x86.c              |  42 ++++++--=0D
 include/hw/i386/topology.h | 100 ++++++++++++++++++=0D
 include/hw/i386/x86.h      |   9 ++=0D
 target/i386/cpu.c          | 207 ++++++++++++++-----------------------=0D
 target/i386/cpu.h          |   2 +=0D
 6 files changed, 225 insertions(+), 142 deletions(-)=0D
=0D
--=20=0D
2.24.1=0D
=0D


