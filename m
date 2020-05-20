Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE56C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE78207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+uN/DuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE78207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOO8-00078I-0U
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbOL8-0002TJ-0O
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38053
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbOL6-0004rw-Gz
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589979651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dLWXXK5D2cCfyRXM12I6ZrLTs40rufR7J0sLVVY5nEk=;
 b=D+uN/DuTzetJ620VlsIncJLknEtRygMaAXPfFALGDyVMrHIbAGCrffG7cEel+f+J12da3w
 cckLFqP32YB3tMmipmCNuSY/RsZhgTgMHSXJmP4xLSv+2c6L4WZHv/Cqa7X2dKTUP5mMYz
 m4UUuqIv1Zghc4g9CzcBvwv0t/+52ug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-apW-InItMkCcpkon8bzPcQ-1; Wed, 20 May 2020 09:00:35 -0400
X-MC-Unique: apW-InItMkCcpkon8bzPcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF0CB18FE870
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 13:00:34 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4994101E678;
 Wed, 20 May 2020 13:00:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Socket next patches
Date: Wed, 20 May 2020 14:00:22 +0100
Message-Id: <20200520130025.2201467-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f2465433b43fb87766d79f42191607dac4aed5b4=
:=0D
=0D
  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' i=
nto staging (2020-05-19 13:42:58 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://github.com/berrange/qemu tags/socket-next-pull-request=0D
=0D
for you to fetch changes up to e339273bfc514824410a49837e4f16dd4e51ae8e:=0D
=0D
  qemu-options: updates for abstract unix sockets (2020-05-20 10:34:53 +010=
0)=0D
=0D
----------------------------------------------------------------=0D
Add support for UNIX sockets in the abstract namespace=0D
=0D
----------------------------------------------------------------=0D
=0D
Xiaoqiang Zhao (3):=0D
  qemu-sockets: add abstract UNIX domain socket support=0D
  tests/util-sockets: add abstract unix socket cases=0D
  qemu-options: updates for abstract unix sockets=0D
=0D
 chardev/char-socket.c     |  4 ++=0D
 chardev/char.c            |  7 +++=0D
 qapi/sockets.json         |  8 +++-=0D
 qemu-options.hx           |  8 +++-=0D
 tests/test-util-sockets.c | 92 +++++++++++++++++++++++++++++++++++++++=0D
 util/qemu-sockets.c       | 39 ++++++++++++++---=0D
 6 files changed, 148 insertions(+), 10 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


