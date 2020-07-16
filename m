Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9910C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AE420760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZART+Tl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AE420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwBA5-0005xA-OE
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 17:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1jwB9K-0005R5-Kp
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:10:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40945
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1jwB9I-0002mm-AU
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594933834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2I/XJlgbziqhoZEwNHimsaK6o1vz57NyyApXFNIycRA=;
 b=VZART+TlB7pzU+xZn8aSa5dKtl0XUm1EHrJo24sSSsYgXxHZ4mCiPdBfxrM4XWdkFnaT/c
 yyXbOufDJg6ujEryzwj93oaSUAfM2eBytvedCPcM8pbuqJbSUgz/Pl1BDLufdmKpaRs9k5
 VgRa7HpNjR/2VlDyMBoUMg+gDGaJPhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-EGISHTTmOkyGyOZ8Xzp1xw-1; Thu, 16 Jul 2020 17:10:31 -0400
X-MC-Unique: EGISHTTmOkyGyOZ8Xzp1xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8F6107ACCA
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 21:10:30 +0000 (UTC)
Received: from [10.10.116.132] (ovpn-116-132.rdu2.redhat.com [10.10.116.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8CEA724B8;
 Thu, 16 Jul 2020 21:10:27 +0000 (UTC)
To: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Subject: hw-display-qxl.so: undefined symbol: qemu_qxl_io_log_semaphore
Message-ID: <3a19e8c0-215a-bc18-9817-450affec7f08@redhat.com>
Date: Thu, 16 Jul 2020 17:10:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 16:27:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Hi Gerd,

I'm trying to build qemu 5.1.0-rc0 in Fedora. I'm hitting some issues.

Using this configure line:

./configure --prefix=/usr --libdir=/usr/lib64 --sysconfdir=/etc
--localstatedir=/var --libexecdir=/usr/libexec
--interp-prefix=/usr/qemu-%M --with-pkgversion=qemu-5.1.0-0.1.rc0.fc33
'--extra-ldflags=-Wl,--build-id -Wl,-z,relro -Wl,-z,now'
'--extra-cflags=-O2 -g -pipe -Wall -Werror=format-security
-Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions
-fstack-protector-strong -grecord-gcc-switches
-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection'
--enable-trace-backend=dtrace --audio-drv-list=pa,sdl,alsa,oss
--enable-kvm --target-list=x86_64-softmmu --enable-pie --enable-modules
--enable-spice

Build and then run:

$ ./x86_64-softmmu/qemu-system-x86_64 -device \? | grep qxl
Failed to open module:
/home/crobinso/src/qemu/x86_64-softmmu/../hw-display-qxl.so: undefined
symbol: qemu_qxl_io_log_semaphore


That error breaks iotests 127:

--- /home/crobinso/src/qemu/tests/qemu-iotests/127.out	2020-07-15
04:00:10.589138586 -0400
+++ /home/crobinso/src/qemu/tests/qemu-iotests/127.out.bad	2020-07-16
16:44:37.717248172 -0400
@@ -1,4 +1,5 @@
 QA output created by 127
+Failed to open module:
/home/crobinso/src/qemu/x86_64-softmmu/../hw-display-qxl.so: undefined
symbol: qemu_qxl_io_log_semaphore
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
 Formatting 'TEST_DIR/t.IMGFMT.overlay0', fmt=IMGFMT size=65536
backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
 Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=IMGFMT size=65536
backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT


Doing a build with every target and running 'make check' will show
undefined symbol errors for other targets with hw-display-qxl too. Most
reference the qxl_io_log call but some are like:

Failed to open module:
/home/crobinso/src/qemu/microblaze-softmmu/../hw-display-qxl.so:
undefined symbol: vga_ioport_read


Also as a side note though I think it's pre-existing: running the test
suite with --enable-modules while there are host installed modules is
very noisy with lots of repetitive warnings like:

Failed to initialize module: /usr/lib64/qemu/audio-oss.so
Note: only modules from the same build can be loaded.
Failed to initialize module: /usr/lib64/qemu/audio-pa.so
Note: only modules from the same build can be loaded.
Failed to initialize module: /usr/lib64/qemu/audio-sdl.so
Note: only modules from the same build can be loaded.
Failed to initialize module: /usr/lib64/qemu/ui-curses.so
Note: only modules from the same build can be loaded.
Failed to initialize module: /usr/lib64/qemu/ui-gtk.so
Note: only modules from the same build can be loaded.

It would be nice if those could be avoided somehow. Maybe
QEMU_MODULE_DIR can help?

Thanks,
Cole


