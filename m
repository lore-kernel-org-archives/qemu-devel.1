Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F40C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4945206EB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 19:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4945206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJibA-0008R0-VR
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 15:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1jJia7-00076x-Uz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1jJia6-0000vH-PW
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:59:19 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:46142)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1jJia6-0000tv-IR
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:59:18 -0400
Received: from fwd10.aul.t-online.de (fwd10.aul.t-online.de [172.20.26.152])
 by mailout10.t-online.de (Postfix) with SMTP id 5B57A41FD947;
 Wed,  1 Apr 2020 20:59:15 +0200 (CEST)
Received: from [192.168.211.200]
 (SUL5zkZ6QhvkNpnMkn0rjWGfQuzZsFFxSBvq7RvoELH9+nlcSKQlAYXkqrA114FQc1@[93.236.147.242])
 by fwd10.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jJiZy-1a0Ykq0; Wed, 1 Apr 2020 20:59:10 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 0/3] DirectSound fixes for 5.0
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <19cd6a5a-97b7-b684-f026-11d82e34dab9@t-online.de>
Date: Wed, 1 Apr 2020 20:59:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------2B4BFFCFDBEDDACE0F43C76B"
Content-Language: en-US
X-ID: SUL5zkZ6QhvkNpnMkn0rjWGfQuzZsFFxSBvq7RvoELH9+nlcSKQlAYXkqrA114FQc1
X-TOI-MSGID: 7633788b-4545-4f94-bf53-4300d48fff7a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.21
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------2B4BFFCFDBEDDACE0F43C76B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Three audio fixes for DirectSound on Windows. They were tested
on a Windows 10 Home system with HAXM accelerator.

Volker R=C3=BCmelin (3):
  dsoundaudio: fix never-ending playback loop
  dsoundaudio: fix "Could not lock capture buffer" warning
  dsoundaudio: dsound_get_buffer_in should honor *size

 audio/audio.c       | 12 +++++-------
 audio/dsoundaudio.c | 13 ++++++++++---
 2 files changed, 15 insertions(+), 10 deletions(-)

--=20
2.16.4


--------------2B4BFFCFDBEDDACE0F43C76B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <pre>Three audio fixes for DirectSound on Windows. They were tested
on a Windows 10 Home system with HAXM accelerator.

Volker R=C3=BCmelin (3):
  dsoundaudio: fix never-ending playback loop
  dsoundaudio: fix "Could not lock capture buffer" warning
  dsoundaudio: dsound_get_buffer_in should honor *size

 audio/audio.c       | 12 +++++-------
 audio/dsoundaudio.c | 13 ++++++++++---
 2 files changed, 15 insertions(+), 10 deletions(-)

--=20
2.16.4
</pre>
  </body>
</html>

--------------2B4BFFCFDBEDDACE0F43C76B--

