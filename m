Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC1C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700B32178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 08:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTro5kst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700B32178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSGez-0002GR-Lr
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 03:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSGdw-0001ok-8R
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSGdq-0007gW-H0
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:26:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47295
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSGdo-0007Wh-BM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 03:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573028771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/FQma2nWL5RfWNXkQ2/tE7vHgHVqPF5jhForbsGLtao=;
 b=hTro5kstGjIlyziKgq2ek5qba6ixzrPFERn94tnRkmgE97sWDx25wG7pR62kjVtCcLkAfH
 VTpcQn4pRMTDWcfKMiYGVq4aXaGGxGe0L9unixJKIX/xuSoUCGVJuhy7UErk32ZoXJtknN
 o6xG2tkUk9GwYXeRXk1kncdUnuStLwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-6e_OKZ7BPUmdUOoAVvIWXw-1; Wed, 06 Nov 2019 03:26:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B037C107ACC3
 for <qemu-devel@nongnu.org>; Wed,  6 Nov 2019 08:26:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D490E600CD;
 Wed,  6 Nov 2019 08:26:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D474E11AAA; Wed,  6 Nov 2019 09:26:04 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Audio 20191106 patches
Date: Wed,  6 Nov 2019 09:26:03 +0100
Message-Id: <20191106082604.9548-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6e_OKZ7BPUmdUOoAVvIWXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408=
:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-s=
f1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20191106-pull-request

for you to fetch changes up to 14d4f01191354e9520c47c692007344c30ab358b:

  audio: add -audiodev pa,in|out.latency=3D to documentation (2019-11-06 08=
:08:10 +0100)

----------------------------------------------------------------
audio: documentation update

----------------------------------------------------------------

Stefan Hajnoczi (1):
  audio: add -audiodev pa,in|out.latency=3D to documentation

 qemu-options.hx | 5 +++++
 1 file changed, 5 insertions(+)

--=20
2.18.1


