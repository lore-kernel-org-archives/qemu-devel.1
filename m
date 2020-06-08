Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E9DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86A6206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/IUoDve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86A6206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiNHs-0004U7-SI
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiNGl-0003xD-Dm
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:17:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jiNGi-0008GQ-6Q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591643830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2StKkTMYiL4/H88fK0GuWoMsL5Pdd49NMd8/Tx/p+o=;
 b=h/IUoDveSV+pMSISeMqQxXwtjOnX4WAdDyaLcQP4nXL6PLy9prVVD4yXrWy+SxpbZuLERf
 IThYcoSSrt4sSOZfyFbTMw5vhOE3ndLJ5ema2kuTWMXqG+ptewYh7ITD+ftzwFdHsWvn6k
 zEiDL+m9kTKov805H2FIn/mDH4FZZl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-eaoIXq4hO0O7gnjkAJt_4g-1; Mon, 08 Jun 2020 15:17:08 -0400
X-MC-Unique: eaoIXq4hO0O7gnjkAJt_4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 737ED107ACCD;
 Mon,  8 Jun 2020 19:17:07 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-244.ams2.redhat.com [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAA0610098A3;
 Mon,  8 Jun 2020 19:17:05 +0000 (UTC)
Date: Mon, 8 Jun 2020 21:17:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 5/5] iotests: Add test 291 to for qemu-img bitmap
 coverage
Message-ID: <20200608191704.GJ6419@linux.fritz.box>
References: <20200521192137.1120211-1-eblake@redhat.com>
 <20200521192137.1120211-6-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200521192137.1120211-6-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.05.2020 um 21:21 hat Eric Blake geschrieben:
> Add a new test covering the 'qemu-img bitmap' subcommand, as well as
> 'qemu-img convert --bitmaps', both added in recent patches.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This one fails for me. We need to filter out "disk size" because it
depends on the filesystem.

Kevin

291      fail       [21:10:19] [21:10:21]                    output mismatch (see 291.out.bad)
--- /home/kwolf/source/qemu/tests/qemu-iotests/291.out  2020-06-08 21:04:38.967014949 +0200
+++ /home/kwolf/source/qemu/tests/qemu-iotests/291.out.bad      2020-06-08 21:10:21.043763527 +0200
@@ -24,7 +24,7 @@
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
-disk size: 4.39 MiB
+disk size: 4.51 MiB
 Format specific information:
     compat: 1.1
     compression type: zlib
@@ -44,7 +44,7 @@
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 10 MiB (10485760 bytes)
-disk size: 4.48 MiB
+disk size: 5.08 MiB
 Format specific information:
     compat: 1.1
     compression type: zlib
Failures: 291
Failed 1 of 1 iotests


