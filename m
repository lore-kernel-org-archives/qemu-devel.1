Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B2AC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4062F2137B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxLHIeXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4062F2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0ol-00011W-7M
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0mz-0007jE-WD
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kL0my-00021B-Aa
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tu7N8vipvmMMSaDi7LomFjMupsbCS2xNYXi9daD77Lc=;
 b=CxLHIeXkRvIXbXt1KSFOvIABa2cjEiQocKyR24wwqoEhJyelJUlczCmHuX6jrfpuC8dpLU
 W/ZVx0WJO1JnqidofmenEDtE5g5yJe5M1jm5UL+xE7gansVyVCrNWClwgsE2IYLJh7ThoB
 YCrAmzk8+nUvltnZkAfDP35mJG/eeiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-DKtfycOoNh6lBtAWWNSE6A-1; Wed, 23 Sep 2020 05:10:09 -0400
X-MC-Unique: DKtfycOoNh6lBtAWWNSE6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09CF784635D
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 09:10:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AEBE73690;
 Wed, 23 Sep 2020 09:10:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B69C11750A; Wed, 23 Sep 2020 11:10:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Audio 20200923 patches
Date: Wed, 23 Sep 2020 11:09:52 +0200
Message-Id: <20200923091001.20814-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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

The following changes since commit 0fc0142828b5bc965790a1c5c6e241897d3387cb=
:=0D
=0D
  Merge remote-tracking branch 'remotes/kraxel/tags/input-20200921-pull-req=
ue=3D=0D
st' into staging (2020-09-22 21:11:10 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://git.kraxel.org/qemu tags/audio-20200923-pull-request=0D
=0D
for you to fetch changes up to 5e626fa7364bc2d7db5f6c8e59150dee1689b98a:=0D
=0D
  audio: build spiceaudio as module (2020-09-23 08:36:50 +0200)=0D
=0D
----------------------------------------------------------------=0D
audio: various buffering fixes.=0D
audio: build spiceaudio as module.=0D
=0D
----------------------------------------------------------------=0D
=0D
Gerd Hoffmann (2):=0D
  audio: remove qemu_spice_audio_init()=0D
  audio: build spiceaudio as module=0D
=0D
Volker R=3DC3=3DBCmelin (7):=0D
  audio: handle buf =3D3D=3D3D NULL in put_buffer_out()=0D
  audio/audio: fix video playback slowdown with spiceaudio=0D
  audio/spiceaudio: always rate limit playback stream=0D
  audio: align audio_generic_read with audio_pcm_hw_run_in=0D
  audio: remove unnecessary calls to put_buffer_in=0D
  audio: align audio_generic_write with audio_pcm_hw_run_out=0D
  audio: run downstream playback queue unconditionally=0D
=0D
 include/ui/qemu-spice.h |  1 -=0D
 audio/audio.c           | 80 ++++++++++++++++++++++++++++++++++-------=0D
 audio/spiceaudio.c      | 26 ++++++--------=0D
 ui/spice-core.c         |  1 -=0D
 audio/meson.build       |  4 +--=0D
 5 files changed, 80 insertions(+), 32 deletions(-)=0D
=0D
--=3D20=0D
2.27.0=0D
=0D


