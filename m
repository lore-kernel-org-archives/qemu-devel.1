Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53798C31E54
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5D320679
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 21:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5D320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hccrW-0000Ho-D0
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 17:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40965)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hccp1-0006fg-8I
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hccp0-0006ZW-1s
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:19 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:34172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hccoz-0006X5-3P
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 17:36:17 -0400
Received: by mail-qt1-f173.google.com with SMTP id m29so8605231qtu.1
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 14:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QY4dWRAt5iApLJtgqenrOvsHdZ81KhGQtQchniSVTd4=;
 b=hLwuX3anJ/qMSMPXhCEe/Q+5oTx4AFijinAvzaQ7vYs8wBCkALe/F+mUh9Erc9H/qY
 8eMqVdL8ZulrQy4SO81ANNosMppnGAlNf1lSXN5DKiu81Vc/tu24j3vUi388fEF4vz9+
 hqfZsZJBKo/VHWRLiYTlsxUUwZoJ3FfYhsj2CkZgKrYIe6P3XHh3r+xgeh+ohJRb7Bba
 DxoKboBPsSwpvK5ZJnfwkaFVgfV6YYmt2zwmQTXf1GeVwWb+YjGp6GL86q5+bulMRYbX
 4gD0ovOB8rZRWiXWOpIfwDTVId4kPzd5d5a1jhkTW5zCaRaw4z4T4mbO+tBCBP9mkgLH
 qa0A==
X-Gm-Message-State: APjAAAXinaMJX8S/yBsTavPFMVDM5hjiFTKJO0rYh8bhMb9yM828+6ha
 R0vTyMv/xWtig0ghc2eaPraAKhqvbA4=
X-Google-Smtp-Source: APXvYqwKaCQ+cSyjJs/iwu2wMth9jc7y2hEhDKMN4FO4HrLcmzrxtnnP2pZ4zkt6ZMFixixdPTA+Tw==
X-Received: by 2002:ac8:32e8:: with SMTP id a37mr15610021qtb.231.1560720976128; 
 Sun, 16 Jun 2019 14:36:16 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
 [100.0.197.103])
 by smtp.gmail.com with ESMTPSA id e66sm4838191qtb.55.2019.06.16.14.36.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 16 Jun 2019 14:36:15 -0700 (PDT)
Date: Sun, 16 Jun 2019 17:36:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190605131221.29432-1-marcandre.lureau@redhat.com>
References: <20190616213540.20430-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190616213540.20430-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.173
Subject: [Qemu-devel] [PULL 06/11] docs/vhost-user.json: some firmware.json
 copy leftovers
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190616213614.Zum55qHguzP0keVbSZP4fGYBVBc3KCYGfcD2fe1CHpQ@z>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190605131221.29432-1-marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index ae88c03117..da6aaf51c8 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -178,11 +178,11 @@
 #
 #   - /usr/share/qemu/vhost-user/50-crosvm-gpu.json
 #
-# then the sysadmin can prevent the default QEMU being used at all with
+# then the sysadmin can prevent the default QEMU GPU being used at all with
 #
 #   $ touch /etc/qemu/vhost-user/50-qemu-gpu.json
 #
-# The sysadmin can replace/alter the distro default OVMF with
+# The sysadmin can replace/alter the distro default QEMU GPU with
 #
 #   $ vim /etc/qemu/vhost-user/50-qemu-gpu.json
 #
@@ -190,7 +190,7 @@
 #
 #   $ vim /etc/qemu/vhost-user/10-qemu-gpu.json
 #
-# or they can provide a parallel OVMF with lower priority
+# or they can provide a parallel QEMU GPU with lower priority
 #
 #   $ vim /etc/qemu/vhost-user/99-qemu-gpu.json
 #
-- 
MST


