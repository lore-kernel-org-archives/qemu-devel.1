Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E32BC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C1C214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqZf7dsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C1C214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT15C-0004J7-Ia
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iT13Y-0002z1-Pn
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iT13X-0002nb-Rr
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44165
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iT13X-0002nG-Mc
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573207191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RDnIzMakipXmM6yrMZUxTwS4buarpmiPqaoxhNKeFnQ=;
 b=dqZf7dsSHvCb3pKjZrSwO2taseTCY1trIIQ/+NmQz8M9FzQ6iU/Y4q9ym/DlMs9pAdAwbv
 R26vxqYUwB1cvuMmi99EcADheUUVEu7A9NHgkzAD01hhl5KZ+BOC4W2j/bywltiiy1I892
 VJCGyQ+FKSK8tVQWJLnGfvEXSSUHNTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-W26l6iZuO2SfuDN3POf1_w-1; Fri, 08 Nov 2019 04:59:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14D941800D7B;
 Fri,  8 Nov 2019 09:59:47 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3401600C9;
 Fri,  8 Nov 2019 09:59:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] docs: build an index page for the HTML docs
Date: Fri,  8 Nov 2019 10:59:39 +0100
Message-Id: <20191108095942.401225-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: W26l6iZuO2SfuDN3POf1_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series switches to a single invocation of sphinx that builds
docs/index.rst.  This global index page links to all HTML documentation
produced by "make html", even the non-rST manuals.

This index page will be used as the entrypoint for documentation published =
on
the qemu.org website.

Stefan Hajnoczi (3):
  docs: fix rst syntax errors in unbuilt docs
  docs: build a global index page
  docs: install CSS and Javascript files for HTML docs

 Makefile                     | 14 +++++---------
 docs/arm-cpu-features.rst    |  6 +++---
 docs/index.rst               | 27 ++++++++++++++++++++++++++-
 docs/virtio-net-failover.rst |  4 ++--
 docs/virtio-pmem.rst         | 19 ++++++++++---------
 5 files changed, 46 insertions(+), 24 deletions(-)

--=20
2.23.0


