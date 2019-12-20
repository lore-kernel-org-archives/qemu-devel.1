Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65828C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348F0206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gp74AoZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348F0206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiNqr-0000Ar-Pz
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpN-00072t-7k
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpK-0005ZH-IG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30969
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiNpJ-0005P3-UV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576869638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d2vTMfR4E7yWfrxQkKKpcYriQWv1QDai/DgNgMjAEiM=;
 b=gp74AoZ+QntNlhVE/L2E1V3BhelTC2Urgqvn4OD0wqTWpjsq4IfCi0JVJGteaRSYXVIVHO
 JRDWxI5RxcovlA7UDqSMVL4mraMLhMFpk+mC4Mz5/oA88wsxxWQiE6fXT3p6SckMEd1YZD
 gZLeNTf0pm2pVMpVyDA9cjkt8iWDW34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-f2gNktTlNIeov6dn_AOVLA-1; Fri, 20 Dec 2019 14:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47F83801E6D;
 Fri, 20 Dec 2019 19:20:36 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CCE710013A7;
 Fri, 20 Dec 2019 19:20:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/3] x86 and machine queue, 2019-12-20
Date: Fri, 20 Dec 2019 16:20:28 -0300
Message-Id: <20191220192031.2226378-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: f2gNktTlNIeov6dn_AOVLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681=
:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-=
12-17' into staging (2019-12-17 15:55:20 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to fcd3f2cc124600385dba46c69a80626985c15b50:

  numa: properly check if numa is supported (2019-12-19 14:57:14 -0300)

----------------------------------------------------------------
x86 and machine queue, 2019-12-20

Bug fix:
* Resolve CPU models to v1 by default (Eduardo Habkost)

Cleanup:
* Remove incorrect numa_mem_supported checks (Igor Mammedov)

----------------------------------------------------------------

Eduardo Habkost (1):
  i386: Resolve CPU models to v1 by default

Igor Mammedov (2):
  numa: remove not needed check
  numa: properly check if numa is supported

 hw/arm/sbsa-ref.c    | 1 -
 hw/core/machine.c    | 4 ++--
 hw/core/numa.c       | 7 +------
 qemu-deprecated.texi | 8 ++++++++
 target/i386/cpu.c    | 8 +++++++-
 5 files changed, 18 insertions(+), 10 deletions(-)

--=20
2.23.0


