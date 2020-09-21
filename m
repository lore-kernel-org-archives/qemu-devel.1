Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ACCC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB5720739
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6F9RRaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB5720739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHfn-0006H4-UH
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKHeb-0005N0-8b
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKHeZ-0005zF-Nj
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600678710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LyxbDykaUwRCL3ZshT1/yX0cR+yXZtUxGhR96WAhuVU=;
 b=W6F9RRaEom1tfyO3+LreeO38Vm4G6TBb1THDYxdm4e3HnZpcEflkzqij+iZFnsCZWrj2o8
 3bukSLhNLNKpWVxIA40kkA930hxlCZkx2jH7+tiegWQEhlYvPAlSccxpC7HD1cJAL4Mv1T
 eXfAFe/LCbyGbtSOfHWzLl4XK5KrVvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-_iPrcOgPNmC-IyYDazoCYw-1; Mon, 21 Sep 2020 04:58:28 -0400
X-MC-Unique: _iPrcOgPNmC-IyYDazoCYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0829F6414A
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:58:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2EE83782;
 Mon, 21 Sep 2020 08:58:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F3AC616E0A; Mon, 21 Sep 2020 10:58:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Usb 20200921 patches
Date: Mon, 21 Sep 2020 10:58:20 +0200
Message-Id: <20200921085823.980-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 053a4177817db307ec854356e95b5b350800a216=
:=0D
=0D
  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-20200918'=
 into staging (2020-09-18 16:34:26 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/usb-20200921-pull-request=0D
=0D
for you to fetch changes up to 1be90ebecc95b09a2ee5af3f60c412b45a766c4f:=0D
=0D
  hw: usb: hcd-ohci: check for processed TD before retire (2020-09-21 09:44=
:54 +0200)=0D
=0D
----------------------------------------------------------------=0D
usb: fix u2f build=0D
usb: fix ohci oob access and loop issues=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (1):=0D
  usb: fix u2f build=0D
=0D
Prasad J Pandit (2):=0D
  hw: usb: hcd-ohci: check len and frame_number variables=0D
  hw: usb: hcd-ohci: check for processed TD before retire=0D
=0D
 hw/usb/hcd-ohci.c     | 28 ++++++++++++++++++++++++++--=0D
 hw/usb/u2f-emulated.c |  4 ++--=0D
 2 files changed, 28 insertions(+), 4 deletions(-)=0D
=0D
--=20=0D
2.27.0=0D
=0D


