Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD1C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F2220724
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf6gxiG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F2220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDo5c-0004aD-0s
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jDnwu-00021Q-7b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jDnws-0000sV-Tb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46988
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jDnws-0000hn-O1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 07:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584358221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n8/IFya9kwmc+kpirht2pSmWzCtBEHbLSZCKB/kO+TI=;
 b=Nf6gxiG+NOMV0jC2yrsZ9KvEGQMXo/EPszE4wEJ4bQOpFrWM76cp+jXne+bFpxlJzi9GIt
 FRpzxe5sFQS/GGQMcAuWj0FEQcJOsSh5UnZMw1sGbk5uQ3iMZUALNsFeJiyVJKV6Dgrngy
 qoYEHaKCXBSoFnr8Vq4prc0dbLm4wsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-jJfgXUMlMuabmLTPa6Megw-1; Mon, 16 Mar 2020 07:30:20 -0400
X-MC-Unique: jJfgXUMlMuabmLTPa6Megw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B7C018A6EC0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:30:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-117.ams2.redhat.com
 [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66F621001DF0;
 Mon, 16 Mar 2020 11:30:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8475717444; Mon, 16 Mar 2020 12:30:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Audio 20200316 patches
Date: Mon, 16 Mar 2020 12:30:09 +0100
Message-Id: <20200316113015.28013-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 61c265f0660ee476985808c8aa7915617c44fd53=
:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-202003=
13a' into staging (2020-03-13 10:33:04 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20200316-pull-request

for you to fetch changes up to 49f77e6faf36cddd84417f9080462413acdbcc27:

  audio: add audiodev format=3Df32 option documentation (2020-03-16 10:18:0=
7 +0100)

----------------------------------------------------------------
audio: float fixes

----------------------------------------------------------------

Volker R=C3=BCmelin (6):
  qapi/audio: add documentation for AudioFormat
  audio: change naming scheme of FLOAT_CONV macros
  audio: consistency changes
  audio: change mixing engine float range to [-1.f, 1.f]
  audio: fix saturation nonlinearity in clip_* functions
  audio: add audiodev format=3Df32 option documentation

 audio/mixeng_template.h | 22 ++++++++++------------
 audio/mixeng.c          | 26 +++++++++++++-------------
 qapi/audio.json         | 14 ++++++++++++++
 qemu-options.hx         |  4 ++--
 4 files changed, 39 insertions(+), 27 deletions(-)

--=20
2.18.2


