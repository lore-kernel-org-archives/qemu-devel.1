Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C869C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEFF20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C83cDGJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEFF20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUV6-000882-2g
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSD-0002zG-9W
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38507
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jdUSA-0002re-VA
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g4Bg/bEwdV4+qq44eIjdGIVmQdN+60cl67CP/RRyqyM=;
 b=C83cDGJi6AnPPGtahjQFirSSkgrPAjSLxXngq+2sdmzmC7XTY4KdY6Snh+hWSohBNeT9uX
 KamC2K/JozUvvao7Z2h5ugJe0HrdbCelmO51tNn7f9wLzCl+TB/TZN0Mw+4l59EvgxQ2YY
 GT4AQKWcgGGYEgk0B0R0CYBXfg/0RWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-4jMlUkL5M6iiohBA-njMJw-1; Tue, 26 May 2020 03:56:46 -0400
X-MC-Unique: 4jMlUkL5M6iiohBA-njMJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C1A218C35AC;
 Tue, 26 May 2020 07:56:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 517C910013D2;
 Tue, 26 May 2020 07:56:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DA61A16E2C; Tue, 26 May 2020 09:56:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Audio 20200526 patches
Date: Tue, 26 May 2020 09:56:31 +0200
Message-Id: <20200526075639.27949-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fea8f3ed739536fca027cf56af7f5576f37ef9cd=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-2020=
0522' into staging (2020-05-22 18:54:47 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20200526-pull-request

for you to fetch changes up to b3b8a1fea6ed5004bbad2f70833caee70402bf02:

  hw/mips/mips_fulong2e: Remove unused 'audio/audio.h' include (2020-05-26 =
08:46:14 +0200)

----------------------------------------------------------------
audio: add JACK client audiodev.
audio: bugfixes and cleanups.

----------------------------------------------------------------

Bruce Rogers (1):
  audio: fix wavcapture segfault

Geoffrey McRae (1):
  audio/jack: add JACK client audiodev

Philippe Mathieu-Daud=C3=A9 (4):
  hw/audio/gus: Use AUDIO_HOST_ENDIANNESS definition from
    'audio/audio.h'
  audio: Let audio_sample_to_uint64() use const samples argument
  audio: Let capture_callback handler use const buffer argument
  hw/mips/mips_fulong2e: Remove unused 'audio/audio.h' include

Prasad J Pandit (1):
  es1370: check total frame count against current frame

Volker R=C3=BCmelin (1):
  audio/mixeng: fix clang 10+ warning

 configure               |  17 +
 audio/audio.h           |   4 +-
 audio/audio_template.h  |   2 +
 audio/audio.c           |   5 +-
 audio/jackaudio.c       | 667 ++++++++++++++++++++++++++++++++++++++++
 audio/mixeng.c          |   9 +-
 audio/wavcapture.c      |   2 +-
 hw/audio/es1370.c       |   7 +-
 hw/audio/gus.c          |   8 +-
 hw/mips/mips_fulong2e.c |   1 -
 ui/vnc.c                |   2 +-
 audio/Makefile.objs     |   5 +
 qapi/audio.json         |  56 +++-
 13 files changed, 763 insertions(+), 22 deletions(-)
 create mode 100644 audio/jackaudio.c

--=20
2.18.4


