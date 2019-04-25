Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6634C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F97620685
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F97620685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJiuF-0004N6-Pd
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:15:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisb-0003Ho-Oe
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJisX-000249-UD
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJisX-0001wu-7q
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:13:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 83FBC31676A7;
	Thu, 25 Apr 2019 18:13:46 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C3A2260C8E;
	Thu, 25 Apr 2019 18:13:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 15:13:38 -0300
Message-Id: <20190425181342.15360-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 18:13:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] x86 queue, 2019-04-25
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425181338.EJL91xsy-ZPvMB2DDIk26T8ZEWehqPruaLl_PHbBMmU@z>

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999=
b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22'=
 into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to a4e0b436f44a4bb47ed4a75b0c05d2547cf12b1c:

  Pass through cache information for TOPOEXT CPUs (2019-04-25 14:52:28 -0=
300)

----------------------------------------------------------------
x86 queue, 2019-04-25

* Hygon Dhyana CPU model (Pu Wen)
* Categorize a few devices in hw/i386 (Ernest Esene)
* Support host-cache-info on TOPOEXT CPUID leaf (Stanislav Lanci)

----------------------------------------------------------------

Ernest Esene (2):
  Categorize devices: IGD passthrough ISA bridge
  Categorize devices: iommu

Pu Wen (1):
  i386: Add new Hygon 'Dhyana' CPU model

Stanislav Lanci (1):
  Pass through cache information for TOPOEXT CPUs

 target/i386/cpu.h     |  2 ++
 hw/i386/amd_iommu.c   |  2 ++
 hw/i386/intel_iommu.c |  2 ++
 hw/i386/pc_piix.c     |  1 +
 target/i386/cpu.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)

--=20
2.18.0.rc1.1.g3f1ff2140


