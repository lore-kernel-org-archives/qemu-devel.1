Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F81C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256AF206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6UenMrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256AF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP7pS-0005QF-7u
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 13:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7me-0002eA-Cc
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:26:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7mc-0004GA-TZ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:26:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id n15so1275988wrq.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mYENGgL9RYJX0a3iYRodYEV+ef5cVUsRUt0cYrppZXw=;
 b=m6UenMrhLuxZYn8/kJe+FDGqlDAj9WQpH8MW+ciu3a7v/7DPAHWN04IrTG575RlsT6
 TwvRQP8bH9Mc30efeO+67YquB3/40EwRCgZ1+ab88zq2c5MjErjOtIl8L6UwueGs8W9O
 UtyOLY/GUM5J9hOKroN8DhVWkS78e8gSFhLhTgrKDal2LuEzSuN8KwQLzUX3ETHGqZHk
 52xZY8iPNjoo4e3RSuv4ubg6SrRM9Sf9Jm+uKitmFvIFiMyWEPmtB74o100QptIysGWp
 /i4WrJXF5q5gKfpYXJThejsRuU809ffggGBF9ahtBSEwnMHTOXpPVTY0fQE50kOHlHQF
 6X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=mYENGgL9RYJX0a3iYRodYEV+ef5cVUsRUt0cYrppZXw=;
 b=bQ4MILftwY3erDE+Pm99mPGr5ouxuEqmFCOgS4ljwyBycYdifkeQDjeiHtB6YJIVgu
 9XS8gO8wECtzo7dIp6E3fItZ4GZ1OGmyDvmrGFjKOFbRFOJhsMSMF1h0KEBtq3yuF7Ln
 Bw8amUFOsUP0pK2TxFn48r/RGxC/7ZfwZmP90zRYD/YZgpoHUl5qCDv5abPWjy7MTmtJ
 EGr/+R786hMkWMo8RCbk4yks6reVTBd1Je6d35SYaAG6J9QSS8KOcdzmu6Sm9zzqvEDJ
 xwHwW5SdFyktmK1aNkX4UzGPvnMcvUeipgB+8KvpDSVrRS3axA7VaCxlMrgDyxO5X4zP
 MRnw==
X-Gm-Message-State: AOAM532hBinH2vK/jfYoV1+gKqS4HvzIzfqQbHgLwZ/IkB0Jmwk+4WvL
 gQG3VZFMQ1sbUfoU9oAKLlD4scl3mwc=
X-Google-Smtp-Source: ABdhPJwrUsbMcR0KnDSiVo1bBPQL/13+TaTvtoKp2+JDVvEoIP4XnAFg+gtNav6/rDpxSPXbvxyKNw==
X-Received: by 2002:adf:f3c4:: with SMTP id g4mr13453746wrp.168.1601832409377; 
 Sun, 04 Oct 2020 10:26:49 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n2sm2709423wrt.82.2020.10.04.10.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 10:26:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] .mailmap: Fix more contributor entries
Date: Sun,  4 Oct 2020 19:26:44 +0200
Message-Id: <20201004172644.2027440-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004172644.2027440-1-f4bug@amsat.org>
References: <20201004172644.2027440-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Melnychenko <andrew@daynix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Anup Patel <anup.patel@wdc.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, David Carlier <devnexen@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Erik Smit <erik.lucas.smit@gmail.com>, Marek Dolata <mkdolata@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These authors have some incorrect author email field.
For each of them, there is one commit with the replaced
entry.

Cc: Anup Patel <anup.patel@wdc.com>
Cc: Andrew Melnychenko <andrew@daynix.com>
Cc: David Carlier <devnexen@gmail.com>
Cc: Erik Smit <erik.lucas.smit@gmail.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Pan Nengyuan <pannengyuan@huawei.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
To the developers Cc'ed: If you agree with your entry, please
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
care, please either reply with Nack-by or ignore this patch.
I'll repost in 2 weeks as formal patch (not RFC) with only the
entries acked by their author.
---
 .mailmap | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.mailmap b/.mailmap
index 2b9f3b4aa5..dea358ea7d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -62,9 +62,11 @@ Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
 # Also list preferred name forms where people have changed their
 # git author config, or had utf8/latin1 encoding issues.
 Aaron Lindsay <aaron@os.amperecomputing.com>
+Anup Patel <anup.patel@wdc.com>
 Alexey Gerasimenko <x1917x@gmail.com>
 Alex Ivanov <void@aleksoft.net>
 Andreas Färber <afaerber@suse.de>
+Andrew Melnychenko <andrew@daynix.com>
 Bandan Das <bsd@redhat.com>
 Benjamin MARSILI <mlspirat42@gmail.com>
 Benoît Canet <benoit.canet@gmail.com>
@@ -84,7 +86,9 @@ Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
 Christophe Lyon <christophe.lyon@st.com>
 Collin L. Walling <walling@linux.ibm.com>
 Daniel P. Berrangé <berrange@redhat.com>
+David Carlier <devnexen@gmail.com>
 Eduardo Otubo <otubo@redhat.com>
+Erik Smit <erik.lucas.smit@gmail.com>
 Fabrice Desclaux <fabrice.desclaux@cea.fr>
 Fernando Luis Vázquez Cao <fernando_b1@lab.ntt.co.jp>
 Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp>
@@ -119,6 +123,7 @@ Luc Michel <luc.michel@git.antfield.fr>
 Luc Michel <luc.michel@greensocs.com>
 Marc Marí <marc.mari.barcelo@gmail.com>
 Marc Marí <markmb@redhat.com>
+Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 Marek Dolata <mkdolata@us.ibm.com>
 Michael Avdienko <whitearchey@gmail.com>
 Michael S. Tsirkin <mst@redhat.com>
@@ -128,6 +133,7 @@ Nicholas Thomas <nick@bytemark.co.uk>
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
 Orit Wasserman <owasserm@redhat.com>
 Paolo Bonzini <pbonzini@redhat.com>
+Pan Nengyuan <pannengyuan@huawei.com>
 Pavel Dovgaluk <dovgaluk@ispras.ru>
 Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
 Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>
@@ -143,6 +149,7 @@ Roger Pau Monné <roger.pau@citrix.com>
 Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
 Sochin Jiang <sochin.jiang@huawei.com>
+Stefan Berger <stefanb@linux.vnet.ibm.com> <stefanb@linux.ibm.com>
 Takashi Yoshii <takasi-y@ops.dti.ne.jp>
 Thomas Huth <thuth@redhat.com>
 Thomas Knych <thomaswk@google.com>
-- 
2.26.2


