Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC59C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1139207FC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLroXpcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1139207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GJ6-0004kR-14
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1k3GGX-0000Ra-UG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:03:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1k3GGW-0000g3-1N
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596621799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MJRWeHC3x8EoLCj1Ajq4OxdqrZrNkiz6n/EGwCnTICw=;
 b=WLroXpcMynLwn4z9uplzbkH7j+0RUL9yivKWcSpQFbbGd+y+29TRK1CUuIYGkmB5oMqdB3
 r/8mbiddDiobqLsbH5BhW1PxZT3SoE5JU6k6/dtAP0zIuvZVg2LNRkwZuBlEyXwhYo4AWM
 hp0k/Q4uHxWdcEJezCx/KSyUU25LpFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-M-7W3XvVO2WHqo61SXs-pg-1; Wed, 05 Aug 2020 06:02:02 -0400
X-MC-Unique: M-7W3XvVO2WHqo61SXs-pg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF87479EC8
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2020 10:02:01 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-114-75.ams2.redhat.com [10.36.114.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C415C67138;
 Wed,  5 Aug 2020 10:01:59 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qapi/block-core.json: Remove stale description of
 'blockdev-add'
Date: Wed,  5 Aug 2020 12:01:58 +0200
Message-Id: <20200805100158.1239390-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kchamart@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On a 'qemu-discuss' thread[1], Kevin identifies that the current doc
blurb for @blockdev-add is stale:

    This is actually a documentation bug. @id doesn't exist,
    blockdev-add never creates a BlockBackend. This was different in the
    very first versions of the patches to add blockdev-add and we
    probably just forgot to update the documentation after removing it.

So remove the stale bits.

And the requirement for 'node-name' is already mentioned in the
documentation of @BlockdevOptions:

    [...]
    # @node-name: the node name of the new node (Since 2.0).
    #             This option is required on the top level of blockdev-add.
    #             Valid node names start with an alphabetic character and may
    #             contain only alphanumeric characters, '-', '.' and '_'. Their
    #             maximum length is 31 characters.
    [...]

[1] https://lists.nongnu.org/archive/html/qemu-discuss/2020-07/msg00071.html
    -- equivalent to "-drive if=ide,id=disk0....."

Fixes: be4b67bc7d ("blockdev: Allow creation of BDS trees without BB")

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
---
v2: Address Eric Blake's feedback --
    https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg08081.html
---
 qapi/block-core.json | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 463ffd83da..3575d73ebf 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4049,9 +4049,7 @@
 ##
 # @blockdev-add:
 #
-# Creates a new block device. If the @id option is given at the top level, a
-# BlockBackend will be created; otherwise, @node-name is mandatory at the top
-# level and no BlockBackend will be created.
+# Creates a new block device.
 #
 # Since: 2.9
 #
-- 
2.26.2


