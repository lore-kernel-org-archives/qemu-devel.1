Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A6C5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D834521A49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk1r5/M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D834521A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKzq-00037N-UC
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1iSKyQ-0001pz-9A
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:03:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1iSKyL-0001X9-7q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:03:46 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37993)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1iSKyL-0001WX-31
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:03:41 -0500
Received: by mail-qk1-x742.google.com with SMTP id e2so24466765qkn.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z0lyHcnS0EVDURy+IIuUmuU++lXzvYKDrGxWjzRkTCc=;
 b=lk1r5/M7pudql+7UEURxGofX9MNZVeuOzyk2aD3E0FBqOyAldLLeuaeOkXclIH/oE7
 JZMXilf1nIqPNVGSmerwSgYEuKZaOWzlJY0xajDB1W4g91NZJ9kggNSZU430bz8MFHlg
 G/Z2JDU/m/ZrlPHJQXHNivrtqtOh+3KnDboCuI8VKp7PNTi+jGjbFmVBdlOCTX2HjlH1
 My1b4Cy5jrhKCfxN5kBY+cvb9JtOcs6HK17C9TUK88LxoofenaefT+9eBtnXVNH1s+Nf
 7ujEeOtq58IKVO+m2zecIZDMXlfJiZw7QYSynk85/adFpVOekvoWCU9vpDSWLNIYPtgD
 8b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z0lyHcnS0EVDURy+IIuUmuU++lXzvYKDrGxWjzRkTCc=;
 b=JOdzCrW1FtdaT+tGonblmq9hOhIniY7fXuvwN6co2o3GyFWOFhsbpRvt5iSdxIaDwQ
 utX+rFU/RgDe/TaSJ41EQDZeIO0hYwdDL+of9TtpexCZSBsQYHnQ7SmJNs1sRgSAq2xv
 DhFjpaI5RGYSxravGlS+SfMkiLI5ESWfAJPXaCVL4VvODZlGYNBIdJawBkod0mieEuqX
 xZlnuYrLEJtLQhzsz+LYkaNgpcc04bQacwy2Nl837N/g6kcNPJryT4QZ/dCQOjIhNpaM
 m81mVROpyBdPqmIYqYgQ2fAy+ofITXi9rlll38gruYOP516oCMmgRPXwZWsXtUzl7eLW
 bq7Q==
X-Gm-Message-State: APjAAAXeem/7mo3I8gCoa7pWi/Bnhd4YhaOiwq8MnNwTdqOpyxAxqhmS
 dcErrBmcK/CacsA3Rd3LySIpVWYG
X-Google-Smtp-Source: APXvYqz8gDsStPI3HEu6lYF73ecv1wEJwllvTRxOtK+cwesKKyg7ZWE+fmPdUkSPTznk4DTK8IeOMQ==
X-Received: by 2002:a05:620a:12f8:: with SMTP id
 f24mr1781486qkl.255.1573045419491; 
 Wed, 06 Nov 2019 05:03:39 -0800 (PST)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
 by smtp.gmail.com with ESMTPSA id
 a19sm14434328qtk.56.2019.11.06.05.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 05:03:38 -0800 (PST)
From: Jason Andryuk <jandryuk@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qmp: Reset mon->commands on CHR_EVENT_CLOSED
Date: Wed,  6 Nov 2019 08:03:09 -0500
Message-Id: <20191106130309.6737-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Markus Armbruster <armbru@redhat.com>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, mon->commands is uninitialized until CHR_EVENT_OPENED where
it is set to &qmp_cap_negotiation_commands.  After capability
negotiation, it is set to &qmp_commands.  If the chardev is closed,
CHR_EVENT_CLOSED, mon->commands remains as &qmp_commands.  Only once the
chardev is re-opened with CHR_EVENT_OPENED, is it reset to
&qmp_cap_negotiation_commands.

monitor_qapi_event_emit compares mon->commands to
&qmp_cap_negotiation_commands, and skips sending events when they are
equal.  In the case of a closed chardev, QMP events are still sent down
to the closed chardev which needs to drop them.

Set mon->commands to &qmp_cap_negotiation_commands for CHR_EVENT_CLOSED
to stop sending events.  Setting for the CHR_EVENT_OPENED case remains
since that is how mon->commands is set for a newly opened connections.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 monitor/qmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 9d9e5d8b27..5e2073c5eb 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -333,6 +333,7 @@ static void monitor_qmp_event(void *opaque, int event)
          * is closed.
          */
         monitor_qmp_cleanup_queues(mon);
+        mon->commands = &qmp_cap_negotiation_commands;
         json_message_parser_destroy(&mon->parser);
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
-- 
2.21.0


