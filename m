Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2095AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C33222B9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzcGoKRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C33222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQssg-0003lr-Dl
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQsr2-0002wC-DY
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQsr0-0002JC-Fq
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602251677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IFy6sglSIgljKlsPrjNpI7XiKDQVlKp9MNTUfIwZHSY=;
 b=KzcGoKRI8JmC5XB1TC45+se+3nwO7iNYGXcSCoO4TOKDyEb44fogGlbSs/8aOGSy6THlju
 tRgC/vxvib1qlrGdC4HSlX4bls6mR5C8j9s4aZYt/qC6C4zmjx2ioPILTZmEOY3FobZq26
 xvnIVeqk/mfMDZFrVSNStNHeA03YoiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-0VgYgCEmPVeSb6DMT2E6xA-1; Fri, 09 Oct 2020 09:54:34 -0400
X-MC-Unique: 0VgYgCEmPVeSb6DMT2E6xA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B7A764082
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 13:54:33 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 687A95C1DC
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 13:54:33 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/8] NBD patches through 2020-10-08
Date: Fri,  9 Oct 2020 08:54:21 -0500
Message-Id: <20201009135429.1122744-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df64e:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201008-1' into staging (2020-10-08 21:41:20 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-08-v2

for you to fetch changes up to 351a587410eff515ee28da619867030217b62457:

  nbd: Simplify meta-context parsing (2020-10-09 08:34:15 -0500)

v2: fix BSD compilation error

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


