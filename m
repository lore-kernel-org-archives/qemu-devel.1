Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F7C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47AC322280
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP5jOsRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47AC322280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJFs-0000UI-9k
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaJEw-0007iK-3c
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:54:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaJEs-0004NL-92
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604498052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ljDRU4zBNDtmjEhvnBsiGngP1sd+6KsHxO1LaUd4Rs8=;
 b=iP5jOsRYC6jtXtnrvYaQlE2MG5NdzeubL6lEoncUSYtTsC18Mut/MhiqbAvPI+oGXv/fVD
 VblXL9hD5gyIcZoibFECnjNFD4GlkYoCi6bZO3H5ScHZ1zGo0wPN2aba52oc4LmJLyP6Sm
 IDPoojHDIoxtQXatvqk5x3tqqBp48dg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-V8UuGhKdOmO1SZHMB3pwlA-1; Wed, 04 Nov 2020 08:54:10 -0500
X-MC-Unique: V8UuGhKdOmO1SZHMB3pwlA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A04907E4F
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 13:54:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1567821E73;
 Wed,  4 Nov 2020 13:54:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F0C8716E31; Wed,  4 Nov 2020 14:54:00 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Ui 20201104 patches
Date: Wed,  4 Nov 2020 14:53:57 +0100
Message-Id: <20201104135400.3938-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3d6e32347a3b57dac7f469a07c5f520e69bd070a=
:=0D
=0D
  Update version for v5.2.0-rc0 release (2020-11-03 21:11:57 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/ui-20201104-pull-request=0D
=0D
for you to fetch changes up to 0d9b90ce5c73505648909a89bcd5272081b9c348:=0D
=0D
  console: make QMP/HMP screendump run in coroutine (2020-11-04 08:02:25 +0=
10=3D=0D
0)=0D
=0D
----------------------------------------------------------------=0D
ui: run screendump in coroutine=0D
=0D
----------------------------------------------------------------=0D
=0D
Marc-Andr=3DC3=3DA9 Lureau (3):=0D
  coroutine: let CoQueue wake up outside a coroutine=0D
  console: modify ppm_save to take a pixman image ref=0D
  console: make QMP/HMP screendump run in coroutine=0D
=0D
 monitor/hmp-cmds.c         |  3 ++-=0D
 ui/console.c               | 47 ++++++++++++++++++++++++++++++--------=0D
 util/qemu-coroutine-lock.c |  6 ++---=0D
 hmp-commands.hx            |  1 +=0D
 qapi/ui.json               |  3 ++-=0D
 ui/trace-events            |  2 +-=0D
 6 files changed, 45 insertions(+), 17 deletions(-)=0D
=0D
--=3D20=0D
2.27.0=0D
=0D


