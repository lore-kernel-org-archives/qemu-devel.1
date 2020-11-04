Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:59:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C8020709
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxQYS/35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C8020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaM82-0002CN-B9
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaM4B-0006aA-1J
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:55:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kaM49-00043h-8e
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604508918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KnozXQof4UYy6Yi3+xNoxUioVhVJzuBfXQ2lh1cdsWs=;
 b=OxQYS/35yG0YsB1bm3oXuS6UEew2J+xRNoosRURYE0uj+hkCwiFkFbcK8PBOzjE94DRSFh
 oHwCKG3/lUA2yj8MoBMristrnBRgXEKCvWAEJjbm1xsiXuF2obMHxKOGqF/bkXrlkZl6yp
 lJ9VZsSVQ4+OB8AagaLyM1E4gW8cWyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-w-1v6EwGME6tnofn6dl5WA-1; Wed, 04 Nov 2020 11:55:16 -0500
X-MC-Unique: w-1v6EwGME6tnofn6dl5WA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68EDF10866AD;
 Wed,  4 Nov 2020 16:55:15 +0000 (UTC)
Received: from localhost (unknown [10.40.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF8635C3E1;
 Wed,  4 Nov 2020 16:55:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 0/2] block: Remove unused BlockDeviceMapEntry
Date: Wed,  4 Nov 2020 17:55:11 +0100
Message-Id: <20201104165513.72720-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Markus has revived a rather old patch to remove an unused QAPI
structure:

https://lists.nongnu.org/archive/html/qemu-block/2020-10/msg01902.html

He quoted a response of mine to the original patch, where I noted that
removing this structure is OK because it is superseded by another
structure (MapEntry), but that other structure’s documentation is worse.
So we should merge some of BlockDeviceMapEntry’s documentation into
MapEntry before removing it.

This series combines said merge with Markus’s patch to drop
BlockDeviceMapEntry.


Markus Armbruster (1):
  block: Remove unused BlockDeviceMapEntry

Max Reitz (1):
  qapi/block-core: Improve MapEntry documentation

 qapi/block-core.json | 47 ++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

-- 
2.28.0


