Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A53AC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB3B20757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwxDWgVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB3B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZy3T-0003iJ-Gn
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZy1V-0002ED-IS
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:15:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kZy1S-0002ug-IZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604416496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oqb6QWS2kkjTdebh4AMB/NIQII5Wu6cFG22e0ujUnQU=;
 b=hwxDWgVVuYZetd9urBaY1nNwS9wLV4OoFXU4sAOTL92sS79puHxWJerOqThERQlNm+umqM
 5Z+Thb9eoZRufHTA+TKHJDBgEBfnrvsJbv0pDR1y5UPBMu4sTIa9wwt2kud8OF241O9AvB
 u11IsfU0uzL6JJ5/jbQEDNkDFQ7sUpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-XJUfW1E3P9O0YIedVgeiqQ-1; Tue, 03 Nov 2020 10:14:54 -0500
X-MC-Unique: XJUfW1E3P9O0YIedVgeiqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F0111018F63
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 15:14:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EC4010016DA;
 Tue,  3 Nov 2020 15:14:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 0/4] deprecate short-form boolean options
Date: Tue,  3 Nov 2020 10:14:48 -0500
Message-Id: <20201103151452.416784-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QemuOpts lets you write boolean options in "short form"
where "abc" means "abc=on" and "noabc" means "abc=off".
This is confusing, since it is not done for the first
key=value pair but only if there is an implied key;
it can also be grossly misused, for example "-device
e1000,noid" will create a device with id equal to "off".

Unfortunately, this idiom has found wide use with
-chardev (think "server,nowait") and to a lesser extent
-spice.

Patch 4 in this series deprecates it for all other option
groups.  The first three patches avoid emitting the warning
in tests (which in one case were buggy, see patch 3) or
for the "help" option.

Paolo Bonzini (4):
  ivshmem-test: do not use short-form boolean option
  qemu-option: move help handling to get_opt_name_value
  qtest: escape device name in device-introspect-test
  qemu-option: warn for short-form boolean options

 chardev/char.c                       |  1 +
 docs/system/deprecated.rst           |  7 ++++
 include/qemu/option.h                |  1 +
 tests/qtest/device-introspect-test.c |  9 +++--
 tests/qtest/ivshmem-test.c           |  2 +-
 tests/test-qemu-opts.c               |  1 +
 ui/spice-core.c                      |  1 +
 util/qemu-option.c                   | 51 ++++++++++++++++------------
 8 files changed, 48 insertions(+), 25 deletions(-)

-- 
2.26.2


