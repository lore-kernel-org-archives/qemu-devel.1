Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405CAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CB52076C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CB52076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uFq-0004Mg-5a
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5uFB-0003Zt-ES
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:08:53 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:49930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5uF9-00087X-Nl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:08:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-Ohzv5scsMoO6xPKv7ph-cA-1; Wed, 12 Aug 2020 13:08:46 -0400
X-MC-Unique: Ohzv5scsMoO6xPKv7ph-cA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA6180183C;
 Wed, 12 Aug 2020 17:08:44 +0000 (UTC)
Received: from bahia.lan (ovpn-112-216.ams2.redhat.com [10.36.112.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B71FF1014160;
 Wed, 12 Aug 2020 17:08:42 +0000 (UTC)
Subject: [PATCH v2 0/2] spapr/nvram: Fix QEMU crash
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Aug 2020 19:08:41 +0200
Message-ID: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 13:08:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes the following crash:

$ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
  echo -n " -prom-env "$(for ((y=3D0;y<1024;y++)); do echo -n x ; done) ; \
  done) # this requires ~128 Kib
malloc(): corrupted top size
Aborted (core dumped)

This also affects g3beige and mac99 machine types, and probably some
sparc/sparc64 machine types as well, but I prefer to leave the fixing
to knowledgeable people.

v2: - error out instead of increasing the partition size for the
      sake of migration (Laurent)
    - Cc'ing John Snow who reported the issue

---

Greg Kurz (2):
      nvram: Add dry_run argument to chrp_nvram_create_system_partition()
      spapr/nvram: Error out if NVRAM cannot contain all -prom-env data


 hw/nvram/chrp_nvram.c         |   34 +++++++++++++++++++++++-----------
 hw/nvram/mac_nvram.c          |    2 +-
 hw/nvram/spapr_nvram.c        |   18 +++++++++++++++++-
 hw/sparc/sun4m.c              |    2 +-
 hw/sparc64/sun4u.c            |    2 +-
 include/hw/nvram/chrp_nvram.h |    3 ++-
 6 files changed, 45 insertions(+), 16 deletions(-)

--
Greg


