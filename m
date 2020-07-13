Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FDCC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF5120758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLTSPX9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF5120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwFi-0002bF-1a
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7t-0000Xo-Mj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:56:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39724
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7r-0003yy-Rb
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594637759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=mtAKyKj4rxqoT8KX0v2Jvrpk9qyXMNvt3ihC3ynTpM8=;
 b=WLTSPX9pBdUFVIpmKC1meDweChcBj9PQkTHBqO4RdSPbakOHyWcdy0OWgAEWay5ELH8qQC
 pCK8hHre0TchEeR+2Smxnm2Vvwwse74xO9yuFF4tZjmNo/kI+VuDlW56llnBxdOah76qZt
 /mMFnSSUXiiMuyw/8T1atEOZqwLqyUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-YD5R1vjUPduW04if1fS4UA-1; Mon, 13 Jul 2020 06:55:52 -0400
X-MC-Unique: YD5R1vjUPduW04if1fS4UA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 875B41083E80;
 Mon, 13 Jul 2020 10:55:49 +0000 (UTC)
Received: from thuth.com (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEA8827CCC;
 Mon, 13 Jul 2020 10:55:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 9/9] docs/system/s390x: Improve the 3270 documentation
Date: Mon, 13 Jul 2020 12:55:34 +0200
Message-Id: <20200713105534.10872-10-thuth@redhat.com>
In-Reply-To: <20200713105534.10872-1-thuth@redhat.com>
References: <20200713105534.10872-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is some additional information about the 3270 support in our Wiki
at https://wiki.qemu.org/Features/3270 - so let's include this information
into the main documentation now to have one single source of information
(the Wiki page could later be removed).

While at it, I also shortened the lines of the first example a little bit.
Otherwise they showed up with a horizontal scrollbar in my Firefox browser.

Message-Id: <20200713075112.442-1-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/s390x/3270.rst | 43 ++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/docs/system/s390x/3270.rst b/docs/system/s390x/3270.rst
index 1774cdcadf..0554a70a9f 100644
--- a/docs/system/s390x/3270.rst
+++ b/docs/system/s390x/3270.rst
@@ -1,9 +1,15 @@
 3270 devices
 ============
 
-QEMU supports connecting an external 3270 terminal emulator (such as
-``x3270``) to make a single 3270 device available to a guest. Note that this
-supports basic features only.
+The 3270 is the classic 'green-screen' console of the mainframes (see the
+`IBM 3270 Wikipedia article <https://en.wikipedia.org/wiki/IBM_3270>`__).
+
+The 3270 data stream is not implemented within QEMU; the device only provides
+TN3270 (a telnet extension; see `RFC 854 <https://tools.ietf.org/html/rfc854>`__
+and `RFC 1576 <https://tools.ietf.org/html/rfc1576>`__) and leaves the heavy
+lifting to an external 3270 terminal emulator (such as ``x3270``) to make a
+single 3270 device available to a guest. Note that this supports basic
+features only.
 
 To provide a 3270 device to a guest, create a ``x-terminal3270`` linked to
 a ``tn3270`` chardev. The guest will see a 3270 channel device. In order
@@ -12,10 +18,14 @@ to actually be able to use it, attach the ``x3270`` emulator to the chardev.
 Example configuration
 ---------------------
 
+* Make sure that 3270 support is enabled in the guest's Linux kernel. You need
+  ``CONFIG_TN3270`` and at least one of ``CONFIG_TN3270_TTY`` (for additional
+  ttys) or ``CONFIG_TN3270_CONSOLE`` (for a 3270 console).
+
 * Add a ``tn3270`` chardev and a ``x-terminal3270`` to the QEMU command line::
 
-    -chardev socket,id=char_0,host=0.0.0.0,port=2300,nowait,server,tn3270
-    -device x-terminal3270,chardev=char_0,devno=fe.0.000a,id=terminal_0
+   -chardev socket,id=ch0,host=0.0.0.0,port=2300,nowait,server,tn3270
+   -device x-terminal3270,chardev=ch0,devno=fe.0.000a,id=terminal0
 
 * Start the guest. In the guest, use ``chccwdev -e 0.0.000a`` to enable
   the device.
@@ -29,4 +39,25 @@ Example configuration
 
     systemctl start serial-getty@3270-tty1.service
 
-This should get you an addtional tty for logging into the guest.
+  This should get you an additional tty for logging into the guest.
+
+* If you want to use the 3270 device as the Linux kernel console instead of
+  an additional tty, you can also append ``conmode=3270 condev=000a`` to
+  the guest's kernel command line. The kernel then should use the 3270 as
+  console after the next boot.
+
+Restrictions
+------------
+
+3270 support is very basic. In particular:
+
+* Only one 3270 device is supported.
+
+* It has only been tested with Linux guests and the x3270 emulator.
+
+* TLS/SSL is not supported.
+
+* Resizing on reattach is not supported.
+
+* Multiple commands in one inbound buffer (for example, when the reset key
+  is pressed while the network is slow) are not supported.
-- 
2.18.1


