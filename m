Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E359C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF8922281
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3Td2o2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF8922281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1Eh-0002RM-0Y
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX1DG-0000zs-GG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX1DD-0001qX-TT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603713775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=arde2Jr8bTOGeTZ33G6lgfyGb7halb9dVVS79XyPlgE=;
 b=G3Td2o2rktMXIUbVECqRUd5tPpdY8O1Rj5Pj+tu8XiHAqOfD5HCVQ+XFZLPu/yPhC77dQw
 wSgi4ZL9jVEejS7/tuZF/Q3yBNosSAIeREYjwbhsIhooUmjLuWdKmix8rTGtNyxZBp/wml
 9SA2/w+R1Jz+NiuaZHtg/7kC/1/ldEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-7ofcxUkXPbCuK2vxrDIAyg-1; Mon, 26 Oct 2020 08:02:48 -0400
X-MC-Unique: 7ofcxUkXPbCuK2vxrDIAyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AD5EA0BDE
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:02:47 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30A9910013D9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:02:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] bitmaps patches for 2020-10-26
Date: Mon, 26 Oct 2020 07:02:43 -0500
Message-Id: <20201026120245.25024-1-eblake@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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

The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:

  Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-10-26

for you to fetch changes up to a024890a64085d3d37ad7eda164775251285c14c:

  migration/block-dirty-bitmap: fix uninitialized variable warning (2020-10-26 06:56:24 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-10-26

- fix infloop on large bitmap granularity
- silence compiler warning

----------------------------------------------------------------
Chen Qun (1):
      migration/block-dirty-bitmap: fix uninitialized variable warning

Stefan Reiter (1):
      migration/block-dirty-bitmap: fix larger granularity bitmaps

 migration/block-dirty-bitmap.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)
-- 
2.29.0


