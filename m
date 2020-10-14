Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBE5212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKrjclpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBE5212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiAk-0006UC-Ak
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrD-00019e-Rb
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrA-00062L-Ag
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602686058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YlDTGJCdcE2aBQBeoH5MxHN8ntqHufnRJv4kEbrBYms=;
 b=LKrjclpNI9dzCfTkr6uHVFYnVvvhY+JHPpN06D4/u4uf91g9rxNaiZ/Z5p6Gow/kOEKMA+
 Ex1tmizpz1YOFKy1jGy4dUzK1vY7q6+qObLl5HfYPNZWSbNMZKVdkCqw+l35nrx9keu5Co
 KpDH0+Y4Vugl04tgjc1lVYNHaiCXLxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-s37DGvPYMsuSowVjX-XJQg-1; Wed, 14 Oct 2020 10:34:17 -0400
X-MC-Unique: s37DGvPYMsuSowVjX-XJQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B0D4802B6A;
 Wed, 14 Oct 2020 14:34:16 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB7A66EF7B;
 Wed, 14 Oct 2020 14:34:15 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/10] machine + QOM queue, 2020-10-14
Date: Wed, 14 Oct 2020 10:34:05 -0400
Message-Id: <20201014143415.240472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 96292515c07e3a99f5a29540ed2f257b1ff75111=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2=
-pull-request' into staging (2020-10-13 14:06:22 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request=0D
=0D
for you to fetch changes up to d9753cca6b0db724bc6d15e60cfad1705f800b96:=0D
=0D
  can-host-socketcan: Fix crash when 'if' option is not set (2020-10-13 15:=
56:30 -0400)=0D
=0D
----------------------------------------------------------------=0D
machine + QOM queue, 2020-10-14=0D
=0D
* Register some properties as class properties (Eduardo Habkost)=0D
* authz-list-file: Fix crash when filename is not set (Eduardo Habkost)=0D
* can-host-socketcan: Fix crash when 'if' option is not set (Eduardo Habkos=
t)=0D
=0D
----------------------------------------------------------------=0D
=0D
Eduardo Habkost (10):=0D
  rng-egd: Register "chardev" as class property=0D
  rng-random: register "filename" as class property=0D
  rng: Register "opened" as class property=0D
  input-linux: Register properties as class properties=0D
  input-barrier: Register properties as class properties=0D
  i386: Register most CPU properties as class properties=0D
  vga-pci: Register "big-endian-framebuffer" as class property=0D
  vhost-user: Register "chardev" as class property=0D
  authz-list-file: Fix crash when filename is not set=0D
  can-host-socketcan: Fix crash when 'if' option is not set=0D
=0D
 authz/listfile.c        |  5 ++++=0D
 backends/rng-egd.c      |  9 ++----=0D
 backends/rng-random.c   |  8 ++---=0D
 backends/rng.c          |  8 ++---=0D
 backends/vhost-user.c   |  6 ++--=0D
 hw/display/vga-pci.c    | 12 +++-----=0D
 net/can/can_socketcan.c |  5 ++++=0D
 target/i386/cpu.c       | 66 +++++++++++++++++++++--------------------=0D
 ui/input-barrier.c      | 44 +++++++++++++--------------=0D
 ui/input-linux.c        | 27 +++++++++--------=0D
 10 files changed, 97 insertions(+), 93 deletions(-)=0D
=0D
--=20=0D
2.28.0=0D
=0D


