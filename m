Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BBFC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4672082C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4672082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6Yr-0001b6-Ix
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb6UI-0007Pb-Pv
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb6UE-0006Bg-Oz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hb6UC-00069Y-OY
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43BB430872CC
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1568160CCD;
 Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BEC81138660; Wed, 12 Jun 2019 18:52:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 18:52:19 +0200
Message-Id: <20190612165229.26976-2-armbru@redhat.com>
In-Reply-To: <20190612165229.26976-1-armbru@redhat.com>
References: <20190612165229.26976-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 12 Jun 2019 16:52:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/11] qdev: Delete unused LostTickPolicy "merge"
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

Commit 4e4fa398db6 "qdev: Introduce lost tick policy property"
(v1.1.0) created PropertyType PROP_TYPE_LOSTTICKPOLICY with values
"discard", "delay", "merge", and "slew".  Value "merge" has never been
used.  Delete it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190401150140.29151-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/misc.json | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..dc4cf9da20 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -172,17 +172,13 @@
 # @delay: continue to deliver ticks at the normal rate.  Guest time will=
 be
 #         delayed due to the late tick
 #
-# @merge: merge the missed tick(s) into one tick and inject.  Guest time
-#         may be delayed, depending on how the OS reacts to the merging
-#         of ticks
-#
 # @slew: deliver ticks at a higher rate to catch up with the missed tick=
. The
 #        guest time should not be delayed once catchup is complete.
 #
 # Since: 2.0
 ##
 { 'enum': 'LostTickPolicy',
-  'data': ['discard', 'delay', 'merge', 'slew' ] }
+  'data': ['discard', 'delay', 'slew' ] }
=20
 ##
 # @add_client:
--=20
2.21.0


