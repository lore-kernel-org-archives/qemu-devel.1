Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9795EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2B320760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 13:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2B320760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjNSQ-0005pv-Jz
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 09:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjNRF-00047w-I9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:40:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53287
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjNRE-0005lg-Oi
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 09:40:13 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-MnhOSny6MQa47NQFl6NZ6Q-1; Thu, 11 Jun 2020 09:40:07 -0400
X-MC-Unique: MnhOSny6MQa47NQFl6NZ6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9C2D8018A6;
 Thu, 11 Jun 2020 13:40:05 +0000 (UTC)
Received: from bahia.lan (ovpn-114-202.ams2.redhat.com [10.36.114.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1F960BF3;
 Thu, 11 Jun 2020 13:40:04 +0000 (UTC)
Subject: [PATCH v3 0/4] spapr: Improve error reporting in spapr_caps.c
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Jun 2020 15:40:03 +0200
Message-ID: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Spapr capabilities are checked at machine init. If a capability cannot
be used, an error message is printed and QEMU exits. In most places,
the error message also contains an hint for the user. But we should
use error_append_hint() for that, as explained in the "qapi/error.h"
header.

This is already the case for cap_fwnmi_apply() and we now want to add=20
a similar check for nested KVM-HV. Unfortunately, spapr_caps_apply()
passes &error_fatal to all apply hooks and error_append_hint() is
never called.=20

So this reuses previous work from Vladimir Sementsov-Ogievskiy to
address that.

v3: - Add preliminary patch to use warn_report() instead of
      a convoluted error_setg()+warn_report_err() sequence
v2: - Fix indentation and add some missing \n in patch 2
    - Add ERRP_AUTO_PROPAGATE() to cap_nested_kvm_hv_apply() in
      patch 2 instead of patch 3

---

Greg Kurz (3):
      spapr: Simplify some warning printing paths in spapr_caps.c
      spapr: Use error_append_hint() in spapr_caps.c
      spapr: Forbid nested KVM-HV in pre-power9 compat mode

Vladimir Sementsov-Ogievskiy (1):
      error: auto propagated local_err


 hw/ppc/spapr_caps.c  |  127 ++++++++++++++++---------------
 include/qapi/error.h |  205 ++++++++++++++++++++++++++++++++++++++++++----=
----
 2 files changed, 239 insertions(+), 93 deletions(-)

--
Greg


