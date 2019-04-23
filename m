Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F021C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B7C206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B7C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIrXP-0001w9-Mj
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 05:16:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIrWG-0001Fl-38
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hIrWF-0002i5-1p
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:15:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hIrWC-0002gf-Ql; Tue, 23 Apr 2019 05:15:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B413AC004BEF;
	Tue, 23 Apr 2019 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B13060143;
	Tue, 23 Apr 2019 09:15:06 +0000 (UTC)
Date: Tue, 23 Apr 2019 11:15:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190423091505.GE9041@localhost.localdomain>
References: <20190422152315.74361-1-vsementsov@virtuozzo.com>
	<20190422152315.74361-4-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190422152315.74361-4-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 23 Apr 2019 09:15:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/3] iotests: test big qcow2 shrink
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, den@virtuozzo.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423091505.3ITuJqM-e3gFR7jVujEVln1HvZx0_2so8Wk7DgIfmSk@z>

Am 22.04.2019 um 17:23 hat Vladimir Sementsov-Ogievskiy geschrieben:
> This test checks bug in qcow2_process_discards, fixed by previous
> commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>

Doesn't work for me (the exact value probably depends on the file
system, I'm testing on XFS):

--- /home/kwolf/source/qemu/tests/qemu-iotests/250.out  2019-04-23 10:41:27.972959135 +0200
+++ /home/kwolf/source/qemu/tests/qemu-iotests/250.out.bad      2019-04-23 11:09:48.035092870 +0200
@@ -12,10 +12,10 @@
 0               0xa00000        0x82f00000      TEST_DIR/t.qcow2
 0x82a00000      0xa00000        0x500000        TEST_DIR/t.qcow2
 virtual size: 2.05 GiB (2202009600 bytes)
-disk size: 24 MiB
+disk size: 25 MiB
 cluster_size: 1048576
 Image resized.
 virtual size: 5 MiB (5242880 bytes)
-disk size: 9 MiB
+disk size: 10 MiB
 cluster_size: 1048576
 *** done

Maybe the output of 'qemu-img map -f raw' would be more reliable?

Kevin

