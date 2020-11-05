Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ADAC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98EE20786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yb37xgjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98EE20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagFj-0003xM-Dh
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:28:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kagEl-000360-4r
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:27:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53939)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kagEj-0003is-Jb
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604586456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HaqI3aTjBnthZvG/DOQIUIn94Yj437WSiD5u/KyRZjo=;
 b=Yb37xgjGw8b7dUtbH4BiyeGUmIfBhDUIJwFHJwZxUg0sindy/e6UjUtB0QkQlqhmHp/EL+
 rqBkCnozfU77a9Dp0gvj8xKVXnKjnE7n5GxU8WIXo6bXj2fo2dzZ0zW1/KnZ88My9rkgkv
 snJ7ypfB8E7ESKC1W4TCAIbdPjT36yU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-2_bIBnSLNMuihtLY10TeLw-1; Thu, 05 Nov 2020 09:27:33 -0500
X-MC-Unique: 2_bIBnSLNMuihtLY10TeLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61CED100C61D
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 14:27:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F16A5DAA2;
 Thu,  5 Nov 2020 14:27:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 0/2] deprecate short-form boolean options
Date: Thu,  5 Nov 2020 09:27:29 -0500
Message-Id: <20201105142731.623428-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, armbru@redhat.com
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

Patch 2 in this series deprecates it for all other option
groups.  The first patch avoids emitting the warning
for the "help" option.

Paolo

Paolo Bonzini (2):
  qemu-option: move help handling to get_opt_name_value
  qemu-option: warn for short-form boolean options

 chardev/char.c             |  1 +
 docs/system/deprecated.rst |  7 +++++
 include/qemu/option.h      |  1 +
 tests/test-qemu-opts.c     |  1 +
 ui/spice-core.c            |  1 +
 util/qemu-option.c         | 55 +++++++++++++++++++++-----------------
 6 files changed, 42 insertions(+), 24 deletions(-)

-- 
2.26.2


