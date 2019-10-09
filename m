Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CF4ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D35612054F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35612054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIGLb-0008VW-9P
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iIBvp-0002n9-6w
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iIBvn-0001Kb-5l
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:23:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39458)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iIBvn-0001KN-0X
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:23:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0E883018FC5;
 Wed,  9 Oct 2019 13:23:04 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EAB85C1D6;
 Wed,  9 Oct 2019 13:22:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu hotplug
 MMIO interface
Date: Wed,  9 Oct 2019 09:22:49 -0400
Message-Id: <20191009132252.17860-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 09 Oct 2019 13:23:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As an alternative to passing to firmware topology info via new fwcfg file=
s
so it could recreate APIC IDs based on it and order CPUs are enumerated,

extend CPU hotplug interface to return APIC ID as response to the new com=
mand
CPHP_GET_CPU_ID_CMD.


CC: Laszlo Ersek <lersek@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
=20
Igor Mammedov (3):
  acpi: cpuhp: fix 'Command data' description is spec
  acpi: cpuhp: add typical usecases into spec
  acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command

 docs/specs/acpi_cpu_hotplug.txt | 37 ++++++++++++++++++++++++++++++---
 hw/acpi/cpu.c                   | 15 +++++++++++++
 hw/acpi/trace-events            |  1 +
 3 files changed, 50 insertions(+), 3 deletions(-)

--=20
2.18.1


