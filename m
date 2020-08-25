Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C62C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83B42068E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq92ZSfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83B42068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAWZw-0003a2-Kj
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAWZG-0002mg-Mi
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAWZF-0000z0-4S
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598352760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OwL6TO8oPaNBRlhmq2U3w2sTA/U5wns21ZdgqDbdMzk=;
 b=Aq92ZSfrzJ6ECljrvnzCVwsxq46Mx8m40ND9gn2aLxiiEMx+1XuHqO5ZjIpNmeHQSRwwUU
 scSwVahXo+CDJMlJQQ99n+tQutxTCbw8JtqVb65d7cJf2HcAiw8lLUkPC++WM4EOUJafaK
 8g2fC6MJ0OdcOV+VL4nru01Zzsfk+sE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-uscT8t_DOn2j_vGlSAdvOg-1; Tue, 25 Aug 2020 06:52:37 -0400
X-MC-Unique: uscT8t_DOn2j_vGlSAdvOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4C1D186A577
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 10:52:36 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB2F460FC2;
 Tue, 25 Aug 2020 10:52:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Socket next patches
Date: Tue, 25 Aug 2020 11:52:33 +0100
Message-Id: <20200825105234.634767-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 06:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 44423107e7b5731ef40c5c8632a5bad8b49d0838=
:=0D
=0D
  Merge remote-tracking branch 'remotes/xtensa/tags/20200821-xtensa' into s=
taging (2020-08-24 19:55:23 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://github.com/berrange/qemu tags/socket-next-pull-request=0D
=0D
for you to fetch changes up to 74a57ddc02c41f8f4bb549cedb107c1086daba58:=0D
=0D
  tests: fix a memory in test_socket_unix_abstract_good (2020-08-25 11:49:4=
9 +0100)=0D
=0D
----------------------------------------------------------------=0D
Add support for UNIX sockets in the abstract namespace=0D
=0D
----------------------------------------------------------------=0D
=0D
Li Qiang (1):=0D
  tests: fix a memory in test_socket_unix_abstract_good=0D
=0D
 tests/test-util-sockets.c | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
--=20=0D
2.26.2=0D
=0D


