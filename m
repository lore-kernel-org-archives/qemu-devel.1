Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE3FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBB922D2B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 17:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBB922D2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3NLA-0007iW-Jl
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 13:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3NK3-0006Kr-2U
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 13:35:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34484
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3NK1-0001SB-AM
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 13:35:26 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-uaemYdm7MiWbf74TqwcP6A-1; Wed, 05 Aug 2020 13:35:18 -0400
X-MC-Unique: uaemYdm7MiWbf74TqwcP6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8897758;
 Wed,  5 Aug 2020 17:35:17 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1923610023A0;
 Wed,  5 Aug 2020 17:35:13 +0000 (UTC)
Subject: [PATCH for-5.2 0/5] spapr: Cleanups for XIVE and PHB
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 05 Aug 2020 19:35:13 +0200
Message-ID: <159664891296.638781.18417631893299150932.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.81; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recent cleanup patch "spapr: Simplify error handling in spapr_phb_realize"
had to be dropped from ppc-for-5.2 because it would cause QEMU to crash
at init time on some POWER9 setups (eg. Boston systems), as reported by
Daniel.

The crash was happening because the kvmppc_xive_source_reset_one() function
would get called at some point (eg. initializing the LSI table of PHB0) and
fail (because XIVE KVM isn't supported on Bostons) without calling
error_setg(), which the caller doesn't expect when the patch above is appli=
ed.

The issue isn't really about a missing call to error_setg() but why do
we end up trying to claim an IRQ number in a XIVE KVM device that doesn't
exist ? The root cause for this is that we guard calls to the XIVE KVM
code with kvm_irqchip_in_kernel(), which might return true when the XICS
KVM device is active, even though the XIVE one is not. This series
upgrade the guarding code to also check if the device is actually open.

A similar cleanup could be performed on XICS.

---

Greg Kurz (5):
      spapr/xive: Fix xive->fd if kvm_create_device() fails
      spapr/xive: Simplify kvmppc_xive_disconnect()
      ppc/xive: Introduce dedicated kvm_irqchip_in_kernel() wrappers
      spapr/xive: Convert KVM device fd checks to assert()
      spapr: Simplify error handling in spapr_phb_realize()


 hw/intc/spapr_xive.c        |   39 +++++++++++++++++---------
 hw/intc/spapr_xive_kvm.c    |   64 +++++++++++++++++++--------------------=
----
 hw/intc/xive.c              |   30 +++++++++++++++-----
 hw/ppc/spapr_pci.c          |   16 +++++------
 include/hw/ppc/spapr_xive.h |    1 +
 include/hw/ppc/xive.h       |    2 +
 6 files changed, 87 insertions(+), 65 deletions(-)

--
Greg


