Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9481AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BD920671
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BD920671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZr6b-0005fj-HX
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jZr64-0005El-6j
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:19:00 -0400
Received: from mailout07.t-online.de ([194.25.134.83]:57312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jZr62-0003sp-VS
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:18:59 -0400
Received: from fwd11.aul.t-online.de (fwd11.aul.t-online.de [172.20.27.152])
 by mailout07.t-online.de (Postfix) with SMTP id 903B94261B62;
 Sat, 16 May 2020 09:18:54 +0200 (CEST)
Received: from [192.168.211.200]
 (Ee3yXGZBghK5s3VakbBTCwA+h5l8MDDMShLzinEb9KqxrVp-wGhHuPAPe9aksDFZZf@[46.86.59.135])
 by fwd11.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr5y-0Sjbs00; Sat, 16 May 2020 09:18:54 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: [PATCH v2 00/11] Patches for ui/gtk and ui/sdl
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
Date: Sat, 16 May 2020 09:18:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: Ee3yXGZBghK5s3VakbBTCwA+h5l8MDDMShLzinEb9KqxrVp-wGhHuPAPe9aksDFZZf
X-TOI-EXPURGATEID: 150726::1589613534-0000FD5D-85DC67AC/0/0 CLEAN NORMAL
X-TOI-MSGID: fa2d16d8-a779-4c59-992a-1fbea668ac79
Received-SPF: none client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:18:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's rather difficult to test qemu patches in guests on Windows with important keys missing. These patches mainly fix the guest keyboard on Windows.

With best regards,
Volker

v2:
- ui/win32-kbd-hook: handle AltGr in a hook procedure
  The boilerplate now mentions where the code comes from.
  Stub functions added for non Windows platforms.

- ui/gtk: fix handling of AltGr key on Windows
- ui/sdl2: fix handling of AltGr key on Windows
  Nearly all #ifdefs were removed.

- ui/gkt: release all keys on grab-broken-event
  Comment added.

- ui/gtk: remove unused variable ignore_keys
- ui/sdl2: start in full screen with grab enabled
- ui/gtk: don't pass on win keys without keyboard grab
  Improved commit message.

- ui: increase min required GTK version to 3.22.0
  New patch. Slightly different compared to Daniel's suggestion.

Volker Rümelin (11):
  ui/win32-kbd-hook: handle AltGr in a hook procedure
  ui/gtk: fix handling of AltGr key on Windows
  ui/gkt: release all keys on grab-broken-event
  ui/gtk: remove unused code
  ui/gtk: remove unused variable ignore_keys
  ui/sdl2: fix handling of AltGr key on Windows
  ui/sdl2: start in full screen with grab enabled
  ui/sdl2-input: use trace-events to debug key events
  ui/gtk: don't pass on win keys without keyboard grab
  ui/gtk: use native keyboard scancodes on Windows
  ui: increase min required GTK version to 3.22.0

 configure                   |   2 +-
 include/ui/win32-kbd-hook.h |  14 +++
 stubs/Makefile.objs         |   1 +
 stubs/win32-kbd-hook.c      |  18 ++++
 ui/Makefile.objs            |   3 +
 ui/gtk.c                    | 194 +++++++++++++++++-------------------
 ui/sdl2-input.c             |   3 +
 ui/sdl2.c                   |  33 +++++-
 ui/trace-events             |   3 +
 ui/win32-kbd-hook.c         | 102 +++++++++++++++++++
 10 files changed, 264 insertions(+), 109 deletions(-)
 create mode 100644 include/ui/win32-kbd-hook.h
 create mode 100644 stubs/win32-kbd-hook.c
 create mode 100644 ui/win32-kbd-hook.c

-- 
2.26.1


