Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98193C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9FC207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9YE+rOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9FC207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFguz-0000x2-Cd
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgu1-0007QF-FK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45971
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFgtz-0004Gt-LN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599584127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRGvBAH+dKo4eQmW709G3GxhMXaX4ecI/lRwbDTiydg=;
 b=c9YE+rOK4E+eEbl0itOAMZqssScG7iCra4jKEr2ldqKsuMLdOvc5xyEQCll7U+FcfvIt5r
 TdDfzAtm8fOKe7Gz+gzSZxd3qjwcQdYA1pdFiI03flHPcB6OAQRC+bIiK7qFotPjwcg4/A
 VXO0RYyDmMZ9/XICmQW7PX57zlCnh7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-CXGMf-EwPvS8ncmQ2_ERKQ-1; Tue, 08 Sep 2020 12:55:12 -0400
X-MC-Unique: CXGMf-EwPvS8ncmQ2_ERKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828751DDEF;
 Tue,  8 Sep 2020 16:55:11 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-154.ams2.redhat.com
 [10.36.113.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9D4660C0F;
 Tue,  8 Sep 2020 16:54:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] qemu-options: document SMBIOS type 11 settings
Date: Tue,  8 Sep 2020 17:54:36 +0100
Message-Id: <20200908165438.1008942-4-berrange@redhat.com>
In-Reply-To: <20200908165438.1008942-1-berrange@redhat.com>
References: <20200908165438.1008942-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NUMERIC_HTTP_ADDR=1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-options.hx | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index b0f020594e..0cd231b164 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2296,6 +2296,8 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
     "-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str]\n"
     "              [,asset=str][,part=str][,max-speed=%d][,current-speed=%d]\n"
     "                specify SMBIOS type 4 fields\n"
+    "-smbios type=11[,value=str][,path=filename]\n"
+    "                specify SMBIOS type 11 fields\n"
     "-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str]\n"
     "               [,asset=str][,part=str][,speed=%d]\n"
     "                specify SMBIOS type 17 fields\n",
@@ -2319,6 +2321,45 @@ SRST
 ``-smbios type=4[,sock_pfx=str][,manufacturer=str][,version=str][,serial=str][,asset=str][,part=str]``
     Specify SMBIOS type 4 fields
 
+``-smbios type=11[,value=str][,path=filename]``
+    Specify SMBIOS type 11 fields inline
+
+    This argument can be repeated multiple times, and values are added in the order they are parsed.
+    Applications intending to use OEM strings data are encouraged to use their application name as
+    a prefix for the value string. This facilitates passing information for multiple applications
+    concurrently.
+
+    The ``value=str`` syntax provides the string data inline, while the ``path=filename`` syntax
+    loads data from a file on disk. Note that the file is not permitted to contain any NUL bytes.
+
+    Both the ``value`` and ``path`` options can be repeated multiple times and will be added to
+    the SMBIOS table in the order in which they appear.
+
+    Note that on the x86 architecture, the total size of all SMBIOS tables is limited to 65535
+    bytes. Thus the OEM strings data is not suitable for passing large amounts of data into the
+    guest. Instead it should be used as a indicator to inform the guest where to locate the real
+    data set, for example, by specifying the serial ID of a block device.
+
+    An example passing three strings is
+
+    .. parsed-literal::
+
+        -smbios type=11,value=cloud-init:ds=nocloud-net;s=http://10.10.0.1:8000/,\\
+                        value=anaconda:method=http://dl.fedoraproject.org/pub/fedora/linux/releases/25/x86_64/os,\\
+                        path=/some/file/with/oemstringsdata.txt
+
+    In the guest OS this is visible with the ``dmidecode`` command
+
+     .. parsed-literal::
+
+         $ dmidecode -t 11
+         Handle 0x0E00, DMI type 11, 5 bytes
+         OEM Strings
+              String 1: cloud-init:ds=nocloud-net;s=http://10.10.0.1:8000/
+              String 2: anaconda:method=http://dl.fedoraproject.org/pub/fedora/linux/releases/25/x86_64/os
+              String 3: myapp:some extra data
+
+
 ``-smbios type=17[,loc_pfx=str][,bank=str][,manufacturer=str][,serial=str][,asset=str][,part=str][,speed=%d]``
     Specify SMBIOS type 17 fields
 ERST
-- 
2.26.2


