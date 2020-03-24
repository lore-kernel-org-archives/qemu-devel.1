Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FACC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955D720774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 17:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYxcqrw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955D720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGnJq-0004Vj-Pu
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 13:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jGmiY-0003TK-1X
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jGmiW-0007xo-Vl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:53 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:33531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jGmiW-0007xT-RL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 12:47:52 -0400
Received: by mail-ot1-x331.google.com with SMTP id 22so12193770otf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 09:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=owCPdBSgizhMBzRMck0T51S2ugcJLP6z/VMj7IFHglk=;
 b=GYxcqrw9oB3yjZCTP16OUiPYAW3DFXcAIdvVD2TltS5TMhy8PY10i8I1ETlksRtqEV
 tBvmJho/EjHzMqqaccV2FuvhVHpONSyRz4roi7BdGTarJvXqUvFW0si/Qj0jSuqw9AGy
 ovKV0bm5pyAY34CrZocJSsI/m8Q7PmgVKBh5DwWrv5uhhTd5/zNyRcqLF6sn/6Sr6JkT
 GiQfUxN8OOw8dr0ESG2fzlFPLSfCcn1Edzq9LBdZFY0Yw68ytn3IdvwdBUxXe5Flqsov
 e5S5HuQKGvsPuwMmQ5apXWlG7fA8Cx8tRc2fmFF6x0pX3+Lc0k/8aJINmCQn/68wPQym
 FIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=owCPdBSgizhMBzRMck0T51S2ugcJLP6z/VMj7IFHglk=;
 b=uGAHOCBsHTC8NDiMX+COd5PJdWxW6IIkCwCthnCCF16MKY6rx1Pwgl/aeH6wbalRTD
 FvGUJM9ZnkjLhhWs07kg2dGrgOGFjRoWE9Jddav5ODFDNHjwBYtKjMYgGMifz5BRzdCW
 9U0GqH4tgKhmVgQhZTKKSAdwBJP8KWxXiAqC39D6f4jP3peczG0vqk/rnVSobMRJSAik
 DYJz3hXW5lCAvz/fngkwOuzptZQDa1VSbJGW7ncR82id54psAZDBqDJBC/6+KmQ4CR41
 8lGVyn5M9YcZL/e67nZGp/eP7lwmp/blu4o5bhpc9wJ/lPHf1eerjEMyvgkhQ4/2jpdb
 uKkg==
X-Gm-Message-State: ANhLgQ3cPq2YMFSGm5jHRoCfKViZ9jjRLQhT5i7vZjh/zOMGcaAj0i8O
 mnuw2uQmVw+UaMxlUdGV3z+k9jO8m5g=
X-Google-Smtp-Source: ADFU+vsYBTQrc1QwvboGp5iABRH2cCDbx6+tNhNsf6uAE1Hl4/x4r5IrdtE0Ca0V2xSa0HA+Rln9GA==
X-Received: by 2002:a9d:63c9:: with SMTP id e9mr9687490otl.65.1585068471192;
 Tue, 24 Mar 2020 09:47:51 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id h2sm6017455otm.44.2020.03.24.09.47.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 09:47:49 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 5/5] qemu-ga: document vsock-listen in the man page
Date: Tue, 24 Mar 2020 11:46:53 -0500
Message-Id: <20200324164653.19449-6-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
References: <20200324164653.19449-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
X-Mailman-Approved-At: Tue, 24 Mar 2020 13:24:21 -0400
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
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Although qemu-ga has supported vsock since 2016 it was not documented on
the man page.

Also add the socket address representation to the qga --help output.

Fixes: 586ef5dee77180fc32e33bc08051600030630239
       ("qga: add vsock-listen method")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/interop/qemu-ga.rst | 5 +++--
 qga/main.c               | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 1313a4ae1c..3063357bb5 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -36,13 +36,14 @@ Options
 .. option:: -m, --method=METHOD
 
   Transport method: one of ``unix-listen``, ``virtio-serial``, or
-  ``isa-serial`` (``virtio-serial`` is the default).
+  ``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the default).
 
 .. option:: -p, --path=PATH
 
   Device/socket path (the default for virtio-serial is
   ``/dev/virtio-ports/org.qemu.guest_agent.0``,
-  the default for isa-serial is ``/dev/ttyS0``)
+  the default for isa-serial is ``/dev/ttyS0``). Socket addresses for
+  vsock-listen are written as ``<cid>:<port>``.
 
 .. option:: -l, --logfile=PATH
 
diff --git a/qga/main.c b/qga/main.c
index 8ee2736f8e..f0e454f28d 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -234,7 +234,9 @@ QEMU_COPYRIGHT "\n"
 "  -p, --path        device/socket path (the default for virtio-serial is:\n"
 "                    %s,\n"
 "                    the default for isa-serial is:\n"
-"                    %s)\n"
+"                    %s).\n"
+"                    Socket addresses for vsock-listen are written as\n"
+"                    <cid>:<port>.\n"
 "  -l, --logfile     set logfile path, logs to stderr by default\n"
 "  -f, --pidfile     specify pidfile (default is %s)\n"
 #ifdef CONFIG_FSFREEZE
-- 
2.17.1


