Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E3C2D0FC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BC02064E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4amtBt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BC02064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYrxx-0001O4-0I
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jYrwX-0000NF-C4
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:01:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jYrwU-0002zP-T5
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589378461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WgWAfLfel99HW69OqyQWFuZf4yQpNJq4X3wr7eh1RDE=;
 b=d4amtBt4MCsb6PvufS+K+ZBAbU/UcNMqimX9DJF97oJdBmgf3iiJoOPXbslh1vWaJpAs2Q
 4cN4fp7a/yDNTMsLs5oBW774CaU5zAXM98c0kgJdJenUeZZDHVu+VfpPppMenQqhRaA43t
 xR9GRVQ4CJuC5HXpXbmVuPMMg8Niay4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-1UInPDWeNSCUOQPZZsjBKw-1; Wed, 13 May 2020 10:00:59 -0400
X-MC-Unique: 1UInPDWeNSCUOQPZZsjBKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E690107ACF6;
 Wed, 13 May 2020 14:00:58 +0000 (UTC)
Received: from localhost (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 256F35D9C5;
 Wed, 13 May 2020 14:00:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/1] machine queue, 2020-05-13
Date: Wed, 13 May 2020 10:00:56 -0400
Message-Id: <20200513140057.576234-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit de2f658b6bb422ec0e0fa94a49e476018602eeea=
:=0D
=0D
  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
511' into staging (2020-05-11 14:34:27 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request=0D
=0D
for you to fetch changes up to 70b6d525dfb51d5e523d568d1139fc051bc223c5:=0D
=0D
  hostmem: don't use mbind() if host-nodes is empty (2020-05-12 12:48:57 -0=
400)=0D
=0D
----------------------------------------------------------------=0D
machine queue, 2020-05-13=0D
=0D
Bug fixes:=0D
* hostmem: don't use mbind() if host-nodes is empty (Igor Mammedov)=0D
=0D
----------------------------------------------------------------=0D
=0D
Igor Mammedov (1):=0D
  hostmem: don't use mbind() if host-nodes is empty=0D
=0D
 backends/hostmem.c | 6 ++++--=0D
 1 file changed, 4 insertions(+), 2 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


