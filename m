Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B001C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FCD20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIAId30/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FCD20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJxO-0005Tw-GI
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jFJvb-0003Nb-LR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1jFJva-0000vo-9r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:51:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jFJva-0000ve-6o
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584719477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tjfwy0zQIFd92Hgjcu30RBsDKtXEL26zeTOS4Dj7RCM=;
 b=QIAId30//YIhFjUejyDj7iMJhX+/sgz/PSO7AV/fleHoxeD1LDPLNhzdA6K1TvEoJogVKY
 /6vgpT6EFTE4gaatPiXBEAdkBBhsl18H4sISWo5qlXJdJuoPu/wdDnxs3KBNIJ0XMn8fmR
 ycklg8f+gfTdvjShhg+4RrK4VOVaR4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-I67aMMvtOvOsTIBuIaX0sQ-1; Fri, 20 Mar 2020 11:51:14 -0400
X-MC-Unique: I67aMMvtOvOsTIBuIaX0sQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2399800D4E;
 Fri, 20 Mar 2020 15:51:12 +0000 (UTC)
Received: from localhost (unknown [10.36.110.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76C698AC30;
 Fri, 20 Mar 2020 15:51:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/1] Slirp patches
Date: Fri, 20 Mar 2020 16:51:05 +0100
Message-Id: <20200320155106.549514-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 samuel.thibault@ens-lyon.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f57587c7d47b35b2d9b31def3a74d81bdb5475d7=
:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-03-17' i=
nto staging (2020-03-19 10:18:07 +0000)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/slirp-pull-request

for you to fetch changes up to aa63573a84c92b14c23f557fcc93a12b1a93c187:

  slirp: update submodule to v4.2.0+ (2020-03-20 16:50:12 +0100)

----------------------------------------------------------------

----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
  slirp: update submodule to v4.2.0+

 slirp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.25.0.rc2.1.g09a9a1a997


