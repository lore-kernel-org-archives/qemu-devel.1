Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52FDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887FF20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 20:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887FF20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcaZi-0003pS-Pf
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 16:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jcaZ5-00031P-Eo
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:16:15 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:44884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1jcaZ3-0001zV-T6
 for qemu-devel@nongnu.org; Sat, 23 May 2020 16:16:15 -0400
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])
 by mailout11.t-online.de (Postfix) with SMTP id 9CF5542355D2;
 Sat, 23 May 2020 22:16:09 +0200 (CEST)
Received: from [192.168.211.200]
 (bLd3MEZFYhPUZRtajn6CFnih9vAJ3TdRFR22glqQ6MNKiHKnxu0nJ6IsEtoggnlQhs@[79.208.25.125])
 by fwd06.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jcaYt-3x4hTU0; Sat, 23 May 2020 22:16:03 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: [PATCH 0/1] audio/mixeng: fix clang 10+ warning
To: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <6231bee7-8d72-fe5c-9b73-cf27f57ff379@t-online.de>
Date: Sat, 23 May 2020 22:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: bLd3MEZFYhPUZRtajn6CFnih9vAJ3TdRFR22glqQ6MNKiHKnxu0nJ6IsEtoggnlQhs
X-TOI-EXPURGATEID: 150726::1590264963-00003102-F03E4D3B/0/0 CLEAN NORMAL
X-TOI-MSGID: 3405b358-4b74-4739-80d8-cc9f6554fc4b
Received-SPF: none client-ip=194.25.134.85; envelope-from=vr_qemu@t-online.de;
 helo=mailout11.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 16:16:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is another attempt to silence the clang 10 warning in
audio/mixeng.c.

The problem was first reported here:
https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg02270.html

This is Philippe's RFC patch and a discussion:
https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg00264.html
In that discussion I suggested an explicit type cast, but I changed
my mind.

Volker Rümelin (1):
  audio/mixeng: fix clang 10+ warning

 audio/mixeng.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.26.1

