Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0664FC33CB6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD772467A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="delZamLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD772467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJ58-00067k-Uf
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1irJ0v-0001aM-1E
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1irJ0t-0007x5-UL
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58583
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1irJ0t-0007wy-Q2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578996090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H4XUnOsATGi+8//7lk3NFGVBjg9LdOPQhVZpHgVFZ3I=;
 b=delZamLZCf9Gn1d06QmtzzJykfvTvvWalfavncJJK+pA5V8NaqpSU3ZenK5yJPw4uep7GF
 Y2w56shPcDFEQCEmJ4paqAW1cqJVVLjamGAlU0dJpAuRmlSq1vcYz4iU7Q0l1w4f+SpQOS
 3mmXJi0Z3eSvJFek1GZohwL0V5Q8JcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-dwYVR3vYNIOP62L6T2Ga2A-1; Tue, 14 Jan 2020 05:01:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A04EA1005510
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:01:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com
 [10.36.116.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E22A05C1BB;
 Tue, 14 Jan 2020 10:01:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1BA609B26; Tue, 14 Jan 2020 11:01:25 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Ui 20200114 patches
Date: Tue, 14 Jan 2020 11:01:23 +0100
Message-Id: <20200114100125.31604-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: dwYVR3vYNIOP62L6T2Ga2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642cfa0=
:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200113-pull-reque=
st' into staging (2020-01-13 14:19:57 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20200114-pull-request

for you to fetch changes up to c4c00922cc948bb5e879bfae60764eba1f8745f3:

  display/gtk: get proper refreshrate (2020-01-14 07:26:36 +0100)

----------------------------------------------------------------
ui: add "-display help", gtk refresh rate.

----------------------------------------------------------------

Nikola Pavlica (1):
  display/gtk: get proper refreshrate

Thomas Huth (1):
  ui: Print available display backends with '-display help'

 include/ui/console.h |  1 +
 include/ui/gtk.h     |  2 ++
 ui/console.c         | 15 +++++++++++++++
 ui/gtk.c             | 11 +++++++++++
 vl.c                 |  5 +++++
 qemu-options.hx      |  3 ++-
 6 files changed, 36 insertions(+), 1 deletion(-)

--=20
2.18.1


