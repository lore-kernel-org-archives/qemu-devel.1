Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C47C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1321521773
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 03:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1321521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGapm-0003wD-Cf
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 23:02:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGanf-0002k4-Ir
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGane-0007hh-N0
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 22:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hGane-0007h1-F7; Tue, 16 Apr 2019 22:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B70EE36961;
	Wed, 17 Apr 2019 02:59:48 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BEE0D1001E65;
	Wed, 17 Apr 2019 02:59:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 23:59:39 -0300
Message-Id: <20190417025944.16154-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 17 Apr 2019 02:59:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] Remove qdev_get_machine() call from
 ppc_cpu_parse_featurestr()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Laurent Vivier <laurent@vivier.eu>,
	Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190417025939.PQusCJryu1mjj-a8QbzdDTOrShw_zFwJpqS4IGuByp8@z>

My initial goal was simple: removing the qdev_get_machine() call
from ppc_cpu_parse_featurestr() because I want to make
qdev_get_machine() available only to softmmu code.

Before doing this, I had to make *-user not call
CPUClass::parse_features() anymore (it was pointless to call it,
anyway).

While doing this, I decided to rename parse_cpu_model() to
something clearer (parse_cpu_option()).

As a nice side effect, now the dependency between machine object
creation and parse_cpu_option() is not hidden anymore.

Eduardo Habkost (5):
  cpu: Rename parse_cpu_model() to parse_cpu_option()
  cpu: Extract CPU class lookup from parse_cpu_option()
  linux-user: Use lookup_cpu_class()
  bsd-user: Use lookup_cpu_class()
  cpu: Add MachineState parameter to parse_features()

 include/qom/cpu.h               | 18 ++++++++++++++----
 target/ppc/cpu-qom.h            |  3 ++-
 bsd-user/main.c                 |  4 +++-
 exec.c                          | 28 +++++++++++++++-------------
 linux-user/main.c               |  4 +++-
 qom/cpu.c                       |  3 ++-
 target/i386/cpu.c               |  3 ++-
 target/ppc/translate_init.inc.c |  7 ++++---
 target/sparc/cpu.c              |  3 ++-
 vl.c                            | 19 ++++++++++---------
 10 files changed, 57 insertions(+), 35 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140


