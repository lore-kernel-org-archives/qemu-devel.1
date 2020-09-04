Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F58C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91FB206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxR2xuA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91FB206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE5lb-0005ZO-RY
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5iv-000264-Ib
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57409)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5is-0002Jt-BG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599202880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s98rvpdMwNMrux39vdbPG6J5K4TDLXD8qUFF0aCTr98=;
 b=SxR2xuA1lUSWAN26zEFRxPKIroOpa8MYO/LMXm8wzN9WuIRPqaVLuxm3PbBK6JhHcDVL/6
 LPSEef/ZPrcjPZCO0fVnQANIxWeJkAVmL7O3CIJV5D4PM0WvgqyzFka5yxtvUOJff7oWwn
 LGs6Y9lVoayhdyxwTcfmEPtgDRoZ418=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-yXPt01Q0NGOCbucuDPthLg-1; Fri, 04 Sep 2020 03:01:18 -0400
X-MC-Unique: yXPt01Q0NGOCbucuDPthLg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87A7110BBEC4
 for <qemu-devel@nongnu.org>; Fri,  4 Sep 2020 07:01:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06EC97E41A;
 Fri,  4 Sep 2020 07:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F1E7E9D5A; Fri,  4 Sep 2020 09:01:12 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Ui 20200904 patches
Date: Fri,  4 Sep 2020 09:01:08 +0200
Message-Id: <20200904070112.7315-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 02:03:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382=
:=0D
=0D
  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-=
09=3D=0D
-03' into staging (2020-09-03 16:58:25 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/ui-20200904-pull-request=0D
=0D
for you to fetch changes up to dc26435edb469ebdadf298dc3945b95d08f743d4:=0D
=0D
  ui/gtk: Update refresh interval after widget is realized (2020-09-04 07:3=
2:=3D=0D
28 +0200)=0D
=0D
----------------------------------------------------------------=0D
ui: memleak fixes.=0D
gtk: refresh interval fix.=0D
spice: add mouse buttons.=0D
=0D
----------------------------------------------------------------=0D
=0D
Frediano Ziglio (1):=0D
  ui: Add more mouse buttons to SPICE=0D
=0D
Pan Nengyuan (2):=0D
  ui/gtk-gl-area: Plug memleak in gd_gl_area_create_context()=0D
  vnc-auth-sasl: Plug memleak in vnc_socket_ip_addr_string=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (1):=0D
  ui/gtk: Update refresh interval after widget is realized=0D
=0D
 ui/gtk-gl-area.c   | 11 ++++++++++=0D
 ui/gtk.c           | 52 +++++++++++++++++++++++-----------------------=0D
 ui/spice-input.c   |  2 ++=0D
 ui/vnc-auth-sasl.c |  1 +=0D
 4 files changed, 40 insertions(+), 26 deletions(-)=0D
=0D
--=3D20=0D
2.27.0=0D
=0D


