Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C33C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 01:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E9321924
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 01:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahI9qkW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E9321924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv9o2-0003uC-NW
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 21:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jv9mF-0002RB-DF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 21:30:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30493
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jv9mC-0006FS-OS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 21:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594690230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4vZoF+vkvBZ1xVv0yYOwLmdkaMbPKw0943QtSLyG6OI=;
 b=ahI9qkW28gPX5iPH2mDMIbTIKlTSXlDhGHgZjmha0G2HhImXLNk8jghbs2s27sObwgbaAU
 a99BzaKxFfQKrj289+gjkZlaYhZYkzWEGZLH+jBfIWgIVWvY4KxBd8qMBni6l5M4TDWWTz
 LYJDwzRWyd/IJXR2uAf8aaiiThad6k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-FYsJG2YxNYqqoe2QtpMVQg-1; Mon, 13 Jul 2020 21:30:28 -0400
X-MC-Unique: FYsJG2YxNYqqoe2QtpMVQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBD3A80040A
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 01:30:27 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-141.rdu2.redhat.com [10.10.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03FED2B6DD;
 Tue, 14 Jul 2020 01:30:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] python: add make check-python target
Date: Mon, 13 Jul 2020 21:30:25 -0400
Message-Id: <20200714013026.9019-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, John Snow <jsnow@redhat.com>, berrange@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quick try at getting the code quality analysis tools into a makefile
target.

Based-on: 20200710052220.3306-1-jsnow@redhat.com
Based-on: 20200710050649.32434-1-jsnow@redhat.com

There are other python patches pulled since that cause new errors to
show up, so this definitely can't be enforced just yet.

John Snow (1):
  python: add check-python target

 Makefile                    |  1 +
 python/{qemu => }/.flake8   |  0
 python/Makefile.include     | 33 +++++++++++++++++++++++++++++++++
 python/{qemu => }/pylintrc  |  1 +
 python/requirements.cqa.txt |  3 +++
 5 files changed, 38 insertions(+)
 rename python/{qemu => }/.flake8 (100%)
 create mode 100644 python/Makefile.include
 rename python/{qemu => }/pylintrc (99%)
 create mode 100644 python/requirements.cqa.txt

-- 
2.21.3


