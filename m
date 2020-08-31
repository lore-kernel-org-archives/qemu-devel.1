Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915FEC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4852072D
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpXjqvLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4852072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChcl-0002hM-BM
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kChbt-0001Bu-Of
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:04:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40196
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kChbr-0008MA-PN
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598871862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D0Yuy83q/wo7rfJghD2wJ+hUN6xvIXFl4WJukWCNH00=;
 b=WpXjqvLoDpQ8/b0ae0fSV8/Ghnbz+h8E6XWCddY96iWHlZCv3H/PisSZo500KUNMbs0OLk
 w/aZrHodSTvRRSNe8F6/QQTgYMTt53WyQpPYGrlJZ60HP4WRSfRoPglC8nIPbELgaV+HNi
 7k0endEwo82NWtwM9ZwvxE25BevX5AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-3IcjChIpP1GNpimUTBmk3Q-1; Mon, 31 Aug 2020 07:04:20 -0400
X-MC-Unique: 3IcjChIpP1GNpimUTBmk3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14C73801AC3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:04:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A4261002D40;
 Mon, 31 Aug 2020 11:04:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0F311ED9; Mon, 31 Aug 2020 13:04:16 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Ui 20200831 patches
Date: Mon, 31 Aug 2020 13:04:11 +0200
Message-Id: <20200831110416.15176-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 02:13:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pul=
l-=3D=0D
request' into staging (2020-08-28 22:30:11 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/ui-20200831-pull-request=0D
=0D
for you to fetch changes up to e54635710f1cf667191a0a1d9df9a37d1c9b0ad0:=0D
=0D
  ui/gtk: Update refresh interval after widget is realized (2020-08-31 10:4=
1:=3D=0D
43 +0200)=0D
=0D
----------------------------------------------------------------=0D
ui: memleak fixes.=0D
gtk: refresh interval fix.=0D
keymaps: don't require qemu-keymap (fix gitlab ci).=0D
spice: add mouse buttons.=0D
=0D
----------------------------------------------------------------=0D
=0D
Frediano Ziglio (1):=0D
  ui: Add more mouse buttons to SPICE=0D
=0D
Gerd Hoffmann (1):=0D
  meson: fix keymaps witout qemu-keymap=0D
=0D
Pan Nengyuan (2):=0D
  ui/gtk-gl-area: Plug memleak in gd_gl_area_create_context()=0D
  vnc-auth-sasl: Plug memleak in vnc_socket_ip_addr_string=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (1):=0D
  ui/gtk: Update refresh interval after widget is realized=0D
=0D
 ui/gtk-gl-area.c            | 11 ++++++++=0D
 ui/gtk.c                    | 52 ++++++++++++++++++-------------------=0D
 ui/spice-input.c            |  2 ++=0D
 ui/vnc-auth-sasl.c          |  1 +=0D
 pc-bios/keymaps/meson.build | 28 +++++++++++++-------=0D
 5 files changed, 59 insertions(+), 35 deletions(-)=0D
=0D
--=3D20=0D
2.27.0=0D
=0D


