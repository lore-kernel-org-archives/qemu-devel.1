Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D960DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A03C422522
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcnwYCra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03C422522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itadK-0005Hv-H0
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1itaWV-0005rM-O1
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001gs-G6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:35 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1itaWU-0001gT-B3
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:07:34 -0500
Received: by mail-oi1-x242.google.com with SMTP id l9so620oii.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fKibVKMTN/g3RLg3BnsPK7GTis/dJbeQ9XnVDxmBdhk=;
 b=TcnwYCraeLFfl770q05H+Hm2/x1E/1fHnFGPoZrRpSYq7JKW2upXzsDjZplVuRflL2
 UqabHFYodJ6KTPNo82UQT1XQhhFg2ojeCV7XJJGxcyX9KJAyvQEpoRONnzOXkXK+6dAb
 mhzA7N8N8wl/Jn6P2uGHqfsGB7HPGeqLFZD1mcD4Bi1B7hxFM18CFyRBY8x7g55A4vFc
 6jhytqGBWp+82Sx6o0yDe5ZJtD5Woula54JQcJg5NKvi8QHjOTSZBJhiIGZizli90lm6
 ruliwLS/cnqdZJg2wXDPvLhA8ufVKCEy+ftayV0PL2CfP520o9nmJCJ2RkZBLXoMlUPF
 UvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=fKibVKMTN/g3RLg3BnsPK7GTis/dJbeQ9XnVDxmBdhk=;
 b=uCa5v0Wl64GXZbzN7rDZ5IRe7M9nYM4AJcBpQJ9ej0dOToEBAuETAe2SxwfBG4c7k9
 m94lgqWkiJg7pDIUihsMLKaNeX3LdXzq/sD+oP4+d2Eo5czDrJNfHFzCmZxEphFcSbVE
 dTWRADoE4uwWbjbGxK73YZ3m28heTXPGNNxCaWr3+QHRrlsoe358Y86hhXKkCdpP7OFn
 BU6LJgQZd8xP/CvvXj475nARDURpCdSrmWMo+DjPo1n5csrSBANvyVWh6iseeCbQhBLP
 pQjrbAn/zO9d2xfAxy3Ba5WQaujiny0mnvzu2ZhQ4T8krQ1rXwLQK9pswt/Xy838DfSu
 6M+w==
X-Gm-Message-State: APjAAAVlUgHWltAe1FYAuFjXc4d9nNW0Jm50AGmr7huNkVkI2NK25yJD
 cmnba+Ngcgf9VpBke/gVin5aptk=
X-Google-Smtp-Source: APXvYqynhyIZoyPzbJUNIFxy1l7V6SECORPmwpwP3aNFSAG8s05j4qNEsuQKDnXLYthsZAdX0GpQAA==
X-Received: by 2002:aca:b703:: with SMTP id h3mr219056oif.148.1579540052777;
 Mon, 20 Jan 2020 09:07:32 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id i8sm4158747oto.9.2020.01.20.09.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 09:07:32 -0800 (PST)
Received: from t560.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:9c9c:d583:ce3d:f87a])
 by serve.minyard.net (Postfix) with ESMTPA id 68924180051;
 Mon, 20 Jan 2020 17:07:31 +0000 (UTC)
From: minyard@acm.org
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [PATCH 1/5] ipmi: Add man page pieces for the IPMI PCI devices
Date: Mon, 20 Jan 2020 11:07:21 -0600
Message-Id: <20200120170725.24935-2-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120170725.24935-1-minyard@acm.org>
References: <20200120170725.24935-1-minyard@acm.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Corey Minyard <cminyard@mvista.com>

This was forgotten when the devices were added.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 qemu-options.hx | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index e9d6231438..2417a1305f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -795,6 +795,19 @@ set this to 0.
 Like the KCS interface, but defines a BT interface.  The default port is
 0xe4 and the default interrupt is 5.
 
+@item -device pci-ipmi-kcs,bmc=@var{id}
+
+Add a KCS IPMI interafce on the PCI bus.
+
+@table @option
+@item bmc=@var{id}
+The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
+@end table
+
+@item -device pci-ipmi-bt,bmc=@var{id}
+
+Like the KCS interface, but defines a BT interface on the PCI bus.
+
 ETEXI
 
 DEF("name", HAS_ARG, QEMU_OPTION_name,
-- 
2.17.1


