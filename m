Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F249FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08EF20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfub69z3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08EF20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilFt-0003L4-UM
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEs-0001cx-KO
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEr-0005az-L3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wV389bp+0XmQUSDIPp0rWJBCuV+Pze0xM+ii1HSOYaU=;
 b=dfub69z3zKfs4kH1y0E9tA1wrGhw968Xy1QQrtMAVpVt1fFVujHr68uiIt7tlAC3MMXZ4q
 8YfHdDYHfog7/x7BAkM0gvSLviYmvQrv7vDjq97CJb8DEiNiRgErhAjYoN6+g0sOWzFSHp
 HGTR6kwcrjYqgi0yFQutgGFfh3EMe6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-n2iz3uAuMfmEPtEfU-99Zg-1; Tue, 09 Jun 2020 16:52:48 -0400
X-MC-Unique: n2iz3uAuMfmEPtEfU-99Zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E27F107ACCA
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 20:52:47 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C96E60C80
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 20:52:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] bitmaps patches for 2020-06-09
Date: Tue,  9 Jun 2020 15:52:30 -0500
Message-Id: <20200609205245.3548257-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 31d321c2b3574dcc74e9f6411af06bca6b5d10f4:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sparc-next-20200609' into staging (2020-06-09 17:29:47 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-06-09

for you to fetch changes up to adf92f4645ba46726368735916fed763d3e5a09b:

  iotests: Fix 291 across more file systems (2020-06-09 15:48:00 -0500)

----------------------------------------------------------------
bitmaps patches for 2020-06-09

- documenation fix
- various improvements to qcow2.py program used in iotests

----------------------------------------------------------------
Eric Blake (2):
      qemu-img: Fix doc typo for 'bitmap' subcommand
      iotests: Fix 291 across more file systems

Vladimir Sementsov-Ogievskiy (13):
      qcow2.py: python style fixes
      qcow2.py: add licensing blurb
      qcow2.py: move qcow2 format classes to separate module
      qcow2_format.py: drop new line printing at end of dump()
      qcow2_format.py: use tuples instead of lists for fields
      qcow2_format.py: use modern string formatting
      qcow2_format.py: use strings to specify c-type of struct fields
      qcow2_format.py: separate generic functionality of structure classes
      qcow2_format.py: add field-formatting class
      qcow2_format.py: QcowHeaderExtension: add dump method
      qcow2_format: refactor QcowHeaderExtension as a subclass of Qcow2Struct
      qcow2: QcowHeaderExtension print names for extension magics
      qcow2_format.py: dump bitmaps header extension

 docs/tools/qemu-img.rst            |   2 +-
 tests/qemu-iotests/031.out         |  22 +--
 tests/qemu-iotests/036.out         |   4 +-
 tests/qemu-iotests/061.out         |  14 +-
 tests/qemu-iotests/291             |   8 +-
 tests/qemu-iotests/291.out         |  37 ++++-
 tests/qemu-iotests/qcow2.py        | 218 +++++++---------------------
 tests/qemu-iotests/qcow2_format.py | 286 +++++++++++++++++++++++++++++++++++++
 8 files changed, 398 insertions(+), 193 deletions(-)
 create mode 100644 tests/qemu-iotests/qcow2_format.py

-- 
2.27.0


