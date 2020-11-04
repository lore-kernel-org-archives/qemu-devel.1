Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89703C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:48:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC0C20735
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4of+7Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC0C20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaL1c-0006MZ-NQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaKzx-0003p7-FE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaKzu-0003Nk-Ff
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604504812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+u9kN+4GErVRAWkAOCxCa/fyv1NrYu6mzQrWSRppI3Q=;
 b=i4of+7YqMbeUHVqCr4AvbtF1pW7R4onW9pxN4qrrse/29ePqxvVpgxiVWrMDzl2zEzO2ic
 H+qmyeRxvchcFopyt/QGZIBJkJJvcfYBk6qNWZcLhXsL7ObENS/O7PQhmiCqhzjCwtd6MC
 Hnu9bMGov/Cv9dM9GvnBI3nv8Tv5i0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-jHPEpaxCMLq8slx_DZrLrg-1; Wed, 04 Nov 2020 10:46:51 -0500
X-MC-Unique: jHPEpaxCMLq8slx_DZrLrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA03803F44
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 15:46:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C99A2177F9;
 Wed,  4 Nov 2020 15:46:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E454416E31; Wed,  4 Nov 2020 16:46:45 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Fixes 20201104 patches
Date: Wed,  4 Nov 2020 16:46:42 +0100
Message-Id: <20201104154645.15877-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
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
  git://git.kraxel.org/qemu tags/fixes-20201104-pull-request=0D
=0D
for you to fetch changes up to 577b808b0974fa4af53131cdfece6e9de3c6e4fd:=0D
=0D
  roms/Makefile: Add qboot to .PHONY list (2020-11-04 08:25:17 +0100)=0D
=0D
----------------------------------------------------------------=0D
misc bugfixes for 5.2=0D
=0D
----------------------------------------------------------------=0D
=0D
Bruce Rogers (1):=0D
  roms/Makefile: Add qboot to .PHONY list=0D
=0D
Ding Hui (1):=0D
  vnc: fix resource leak when websocket channel error=0D
=0D
Prasad J Pandit (1):=0D
  ati: check x y display parameter values=0D
=0D
 hw/display/ati_2d.c    | 10 ++++++----=0D
 ui/vnc-auth-sasl.c     |  3 ++-=0D
 ui/vnc-auth-vencrypt.c |  3 ++-=0D
 ui/vnc-jobs.c          |  3 ++-=0D
 ui/vnc-ws.c            | 20 ++++++++++++++++----=0D
 ui/vnc.c               | 24 ++++++++++++++++++------=0D
 roms/Makefile          |  2 +-=0D
 7 files changed, 47 insertions(+), 18 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D


