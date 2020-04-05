Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E5C2BA19
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BF4206F5
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 07:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BF4206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL00j-00045i-5E
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 03:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1jL001-0003cm-6i
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1jKzzz-0007kO-FZ
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:47:20 -0400
Received: from mailout12.t-online.de ([194.25.134.22]:49792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1jKzzz-0007in-9m
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 03:47:19 -0400
Received: from fwd37.aul.t-online.de (fwd37.aul.t-online.de [172.20.27.137])
 by mailout12.t-online.de (Postfix) with SMTP id 132F841C9A88;
 Sun,  5 Apr 2020 09:47:17 +0200 (CEST)
Received: from [192.168.211.200]
 (Z4HjO-ZL8h1spQo18Wt4QYbEqxSDvrtEus2vCPmAOsJSbe81subsH9e9KSEUf80Qs7@[93.236.147.242])
 by fwd37.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jKzzs-23lgvI0; Sun, 5 Apr 2020 09:47:12 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: [PATCH v2 0/3] DirectSound fixes for 5.0
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <f28b8915-d9df-8de3-7298-cc4c74f0a8d1@t-online.de>
Date: Sun, 5 Apr 2020 09:47:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: Z4HjO-ZL8h1spQo18Wt4QYbEqxSDvrtEus2vCPmAOsJSbe81subsH9e9KSEUf80Qs7
X-TOI-MSGID: 8e50e4f9-e187-48be-abe8-639db43f3c71
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.22
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

Three audio fixes for DirectSound on Windows. They were tested
on a Windows 10 Home system with HAXM accelerator.

v2:
- "dsoundaudio: fix never-ending playback loop"
  The commit message and the changed code was wrong.

Volker R=C3=BCmelin (3):
  dsoundaudio: fix never-ending playback loop
  dsoundaudio: fix "Could not lock capture buffer" warning
  dsoundaudio: dsound_get_buffer_in should honor *size

 audio/audio.c       | 12 +++++-------
 audio/dsoundaudio.c |  9 +++++++--
 2 files changed, 12 insertions(+), 9 deletions(-)

--=20
2.16.4


