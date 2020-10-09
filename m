Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D6C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E779E215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 20:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahJpwpHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E779E215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQymX-0006T2-UO
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 16:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQyfv-0000Ex-Od
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQyfq-0007Ot-7q
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 16:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602274048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iq+icZbHfFXgGXF+AbEFlQUm52tsHLDMMvOCHpfIP0k=;
 b=ahJpwpHh7CQk04zYDbvyHhufdZl07mu9UUqgFqwU08JI1IAbtivbcbQofSsRR94iUxvYWH
 qgzhQuX3y7wwrLbc6wuf12PxX765kLon5V7I/sg19mCTLq0mbESGg4MPi8+/2LdxNS+q24
 uplfv0PvqRz958NB+K5AxLQzY/tCGxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-1HSBvmFRMcWzBP7FS_wmug-1; Fri, 09 Oct 2020 16:07:26 -0400
X-MC-Unique: 1HSBvmFRMcWzBP7FS_wmug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 989CF3FD1
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 20:07:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 67AB91002382
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 20:07:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 0/8] NBD patches through 2020-10-08
Date: Fri,  9 Oct 2020 15:07:12 -0500
Message-Id: <20201009200720.1169904-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4a7c0bd9dcb08798c6f82e55b5a3423f7ee669f1:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.2-20201009' into staging (2020-10-09 15:48:04 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-08-v3

for you to fetch changes up to ebd57062a1957307a175a810441af87259d7dbe9:

  nbd: Simplify meta-context parsing (2020-10-09 15:05:08 -0500)

v2: fix BSD build
v3: fix mingw build (only the affected patch resent)

----------------------------------------------------------------
nbd patches for 2020-10-08

- silence compilation warnings
- more fixes to prevent reconnect hangs
- improve 'qemu-nbd' termination behavior
- cleaner NBD protocol compliance on string handling

----------------------------------------------------------------
Christian Borntraeger (1):
      nbd: silence maybe-uninitialized warnings

Eric Blake (3):
      qemu-nbd: Honor SIGINT and SIGHUP
      nbd/server: Reject embedded NUL in NBD strings
      nbd: Simplify meta-context parsing

Vladimir Sementsov-Ogievskiy (4):
      block/nbd: fix drain dead-lock because of nbd reconnect-delay
      block/nbd: correctly use qio_channel_detach_aio_context when needed
      block/nbd: fix reconnect-delay
      block/nbd: nbd_co_reconnect_loop(): don't connect if drained

 block/nbd.c  |  71 ++++++++++++++++---
 nbd/server.c | 221 ++++++++++++++++++++++++-----------------------------------
 qemu-nbd.c   |  15 ++--
 3 files changed, 157 insertions(+), 150 deletions(-)

-- 
2.28.0


