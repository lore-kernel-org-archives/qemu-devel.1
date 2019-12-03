Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B595C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B092068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAB/++fc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B092068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic7xs-0003mh-By
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55977)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3jFzmXQYKCtMHzB3725DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--sameid.bounces.google.com>)
 id 1ic7nt-0006Db-PB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3jFzmXQYKCtMHzB3725DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--sameid.bounces.google.com>)
 id 1ic7ng-0002rM-Qv
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:01:19 -0500
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a]:58090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3jFzmXQYKCtMHzB3725DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--sameid.bounces.google.com>)
 id 1ic7ng-0002jS-AT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:01:08 -0500
Received: by mail-wm1-x34a.google.com with SMTP id n4so939624wmd.7
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 05:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=d4Sz8Dkeh+ils5IVw6IUBPXrNMkixXLWMtS/aw+/KdY=;
 b=vAB/++fcE2jRv2e0iNp/TkPO04LkoB/6g3oXHakty6ObMGw2nY+7Xhf6tTCAl0Yagv
 pXJKW0aQ207HfU0oGV2bh9fMfrIJ31FuBLEJntZb28Xj13vf4AVsE/fxVv8wf4f2Fbb3
 uO8SHAsA9N7S/1SeWgOcWUQht5p64wgZq2v0IvwslN+ppSBv8tDWktYB4aBVcnb2JVKh
 +30B1nJowJs8e40wQGYnNLtmZq2OeaME8SZmXB+0exbfLWkQchZCv5jqviRAWE5l03X5
 X0z0HnQgjA5LyAc85+919ScNTw3E7YbOJcfIhpddw3AZhj6/l9qRtxdmrWWfK3ZDvbHn
 Ei7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=d4Sz8Dkeh+ils5IVw6IUBPXrNMkixXLWMtS/aw+/KdY=;
 b=DYaJNRxOyLIWlnr6tMDrxv1B5oZSaZdX1cHe62cfnO6lztYTXMXRUMQIkIelLmQw+l
 KNQ/9THJmXaVxznooo8ipM9nabPD6pSFMiUwXnECWROWho1EBoQBDAtbeioBIi0flPvn
 n00CTRZ7dvHgOw3bVy89prOMEczqpJgGz9GsnnJ/5hEIIlQ3RdWrnfuuDyRGB0M3Aske
 J/ENR+9lObFJjjOP0rW8UBJR85TMk+qi/AXT3/jVbeKS4U2Awt5L84pPctjn9y/sEOE2
 EuQawmgv5JCY+ihLiWgHULGJW16cCPxiE9YcReADoG3lTH1+8uHTK9nIq0WBPgHjnkAA
 FhYQ==
X-Gm-Message-State: APjAAAU0cIF0Wum3nOFAnSyM5nTDg90XB60e1rgyCwvc9j+2ypRASBtG
 embKijPNz3OVNeHriESOqaSKmGUvMWM=
X-Google-Smtp-Source: APXvYqyKAB1BTDVJR77KzgsqfN2ZquOOp0n4Sg+gQ9DNfVvAhOT2OcWYAF6tnRjg/fY8pdngUNr8NWNwLT8=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr5126600wrn.5.1575378060940;
 Tue, 03 Dec 2019 05:01:00 -0800 (PST)
Date: Tue,  3 Dec 2019 15:00:43 +0200
In-Reply-To: <20191118142407.6040-3-kraxel@redhat.com>
Message-Id: <20191203130043.87913-1-sameid@google.com>
Mime-Version: 1.0
References: <20191118142407.6040-3-kraxel@redhat.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PULL 2/2] seabios: update to pre-1.13 snapshot again
From: Sam Eiderman <sameid@google.com>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org, Sam Eiderman <sameid@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::34a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Maybe we should add:

CONFIG_HOST_BIOS_GEOMETRY=n

to rom/config.seabios-128k and recreate the 128k image?

