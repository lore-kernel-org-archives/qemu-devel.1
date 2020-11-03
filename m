Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1638EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8832022243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/zT+AVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8832022243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwvC-0007wU-Ht
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:04:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZwtY-0006XH-RK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:02:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZwtW-0003HH-BL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604412160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bGoynj2XMdE89dDR9VN9JF4SODXCTgeMSjhuutth8sE=;
 b=Z/zT+AVYdVyssEcmDnBYiaMDFFSsNmbobFGLTmNsxnmY/IsMldJNlpuYa5G7OUVlDgrWuf
 hJ1AXEO4Ds3u4sSYB5WG/7xYSv6AqFyZJFreSbFw1tPYYqlALRlMAGIfd14q/5Z2B0vkDc
 H93WfqK/aMH1NWIC9lFe/yTZqREcdlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-IaLkZwaLPGmwPAPfmZdZqQ-1; Tue, 03 Nov 2020 09:02:38 -0500
X-MC-Unique: IaLkZwaLPGmwPAPfmZdZqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB8AA107465A
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 14:02:37 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 969D15B4C7;
 Tue,  3 Nov 2020 14:02:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/11] Sock next patches
Date: Tue,  3 Nov 2020 14:02:14 +0000
Message-Id: <20201103140225.496776-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c7a7a877b716cf14848f1fd5c754d293e2f8d852=
:=0D
=0D
  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201=
10=3D=0D
2' into staging (2020-11-03 10:38:05 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/berrange/qemu tags/sock-next-pull-request=0D
=0D
for you to fetch changes up to 8acefc79deaab1c7ee2ab07b540b0e3edf0f9f47:=0D
=0D
  sockets: Make abstract UnixSocketAddress depend on CONFIG_LINUX (2020-11-=
03=3D=0D
 13:17:25 +0000)=0D
=0D
----------------------------------------------------------------=0D
 - Fix inverted logic in abstract socket QAPI support=0D
 - Only report abstract socket support in QAPI on Linux hosts=0D
 - Expand test coverage=0D
 - Misc other code cleanups=0D
=0D
----------------------------------------------------------------=0D
=0D
Markus Armbruster (11):=0D
  test-util-sockets: Plug file descriptor leak=0D
  test-util-sockets: Correct to set has_abstract, has_tight=0D
  test-util-sockets: Clean up SocketAddress construction=0D
  test-util-sockets: Factor out test_socket_unix_abstract_one()=0D
  test-util-sockets: Synchronize properly, don't sleep(1)=0D
  test-util-sockets: Test the complete abstract socket matrix=0D
  sockets: Fix default of UnixSocketAddress member @tight=0D
  sockets: Fix socket_sockaddr_to_address_unix() for abstract sockets=0D
  char-socket: Fix qemu_chr_socket_address() for abstract sockets=0D
  sockets: Bypass "replace empty @path" for abstract unix sockets=0D
  sockets: Make abstract UnixSocketAddress depend on CONFIG_LINUX=0D
=0D
 chardev/char-socket.c     |  24 ++++++-=0D
 chardev/char.c            |   2 +=0D
 qapi/sockets.json         |  14 ++--=0D
 tests/test-util-sockets.c | 145 ++++++++++++++++++++------------------=0D
 util/qemu-sockets.c       |  54 ++++++++++----=0D
 5 files changed, 152 insertions(+), 87 deletions(-)=0D
=0D
--=3D20=0D
2.28.0=0D
=0D


