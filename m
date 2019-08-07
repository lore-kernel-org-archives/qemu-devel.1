Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689EC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A8A21E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAp/pZ5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A8A21E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLiK-0006BA-Om
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54163)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dalt74@gmail.com>) id 1hvLhX-00058e-BT
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dalt74@gmail.com>) id 1hvLhV-0002eT-Oa
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:09:59 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dalt74@gmail.com>) id 1hvLhV-0002dW-Ct
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:09:57 -0400
Received: by mail-lj1-x243.google.com with SMTP id k18so85395399ljc.11
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=+P7OjgSwDilwWjxEQ46/PWZVe6W4coBIKIK8cvqXiNE=;
 b=WAp/pZ5WyBVYBbC54HBOoV7o0mO2nV0NwXNzYjLZdCBAPL6WI6LeuTxt/pZj9SdKvW
 W7ufJWGmYEcduiyOVq0fBm6L8htWNhIbzQk8IXqYdZEBXEJXvyVt14m/7WTRIUMAL9xU
 vCBS4cHS/AqQWN0uuX421YYgRmdoNyVHzYNA5yaqueYMD6GvLTwQ4dXRemjYlDYl6apP
 QhrtLyR5bNpiTD1qu8a+YBEfyufqIPGInNwy8xpbkroFezami8ExEfFo35cf2qkgDgAY
 fpf2i8NXI49d2YgYGMpq6Nwd2q0QeAMjGfPyHp2rLsSCGO0x3qyfgyRYZgnBu4PWFDei
 NcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=+P7OjgSwDilwWjxEQ46/PWZVe6W4coBIKIK8cvqXiNE=;
 b=DBAYkDbLh25k8oI4BPwj1suOqHuyKzSpvS0+tcAdFud8YGo0MtBdEgyYktXcZVbWwo
 Rc6v2hEYCxMgVle3gfOYJNDVRgySq+J8xd7MLY5d9xa8M/gJMHTI4FzoKeKB/zofLe8x
 hxMtZPHB3F4NC8o7ndqrBPAE6sGa2sfgo52ZvCfkna78H8QaeU//shMalxocrywHb6LO
 yaLUzgGM3nRmvZQTL/YlO4AXFbw6C+dyQxvQY42q3VYEKAEQPZ1nb4UNqQ2uMEcwrZG1
 8jhcW7MamEqgiHIeWDgPpMp+14M0XhsW50FO8ZCR7acfQ+STekefhFI2q7FL8YOOMBYC
 t22w==
X-Gm-Message-State: APjAAAXpaJ7hDb/xJxx1q4pzfwhyqFMCODuoaNqQKL5VLHnHzVUH8q7t
 9DAnD7gAqw3jAbXGyaPd/O064U9D
X-Google-Smtp-Source: APXvYqyd4jrKZm2hby6M1qDwQMYoYjNTy4XsiFHqDk7N1BhiZU3dAMtbWwC+8s+kVx+PMPFgBj7aPg==
X-Received: by 2002:a2e:3008:: with SMTP id w8mr4938119ljw.13.1565183395506;
 Wed, 07 Aug 2019 06:09:55 -0700 (PDT)
Received: from ?IPv6:2a00:1148:b0ba:2116:1c73:a34:e53c:9718?
 ([2a00:1148:b0ba:2116:1c73:a34:e53c:9718])
 by smtp.gmail.com with ESMTPSA id c1sm16306495lfh.13.2019.08.07.06.09.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 06:09:54 -0700 (PDT)
To: qemu-devel@nongnu.org
From: Artemy Kapitula <dalt74@gmail.com>
Message-ID: <2c685097-1647-e2d3-8b8a-21f76551ce3c@gmail.com>
Date: Wed, 7 Aug 2019 16:09:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: [Qemu-devel] [PATCH v0] Implement new cache mode "target"
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

There is an issue with databases in VM that perform too slow
on generic SAN storages. The key point is fdatasync that flushes
disk on SCSI target.

The QEMU blockdev "target" cache mode intended to be used with
SAN storages and is a mix of "none" by using direct I/O and
"unsafe" that omit device flush.

Such storages has its own data integrity protection and can
be operated with direct I/O without additional fdatasyc().

With generic SCSI targets like LIO or SCST it boost performance
up to 100% on some profiles like database with transaction journal
(postrgesql/mssql/oracle etc) or virtualized SDS (ceph/rook inside
VMs) which performs block device cache flush on journal record.

Signed-off-by: Artemy Kapitula <dalt74@gmail.com>
---
  block.c                | 4 ++++
  qemu-options.hx        | 3 ++-
  tests/qemu-iotests/026 | 2 +-
  tests/qemu-iotests/091 | 2 +-
  4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index cbd8da5f3b..60919d82ff 100644
--- a/block.c
+++ b/block.c
@@ -884,6 +884,10 @@ int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough)
      } else if (!strcmp(mode, "unsafe")) {
          *writethrough = false;
          *flags |= BDRV_O_NO_FLUSH;
+    } else if (!strcmp(mode, "target")) {
+        *writethrough = false;
+        *flags |= BDRV_O_NOCACHE;
+        *flags |= BDRV_O_NO_FLUSH;
      } else if (!strcmp(mode, "writethrough")) {
          *writethrough = true;
      } else {
diff --git a/qemu-options.hx b/qemu-options.hx
index 9621e934c0..01f1f4ad34 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1065,7 +1065,7 @@ This option defines the type of the media: disk or cdrom.
  @var{snapshot} is "on" or "off" and controls snapshot mode for the given drive
  (see @option{-snapshot}).
  @item cache=@var{cache}
-@var{cache} is "none", "writeback", "unsafe", "directsync" or "writethrough"
+@var{cache} is "none", "writeback", "unsafe", "target", "directsync" or "writethrough"
  and controls how the host cache is used to access block data. This is a
  shortcut that sets the @option{cache.direct} and @option{cache.no-flush}
  options (as in @option{-blockdev}), and additionally @option{cache.writeback},
@@ -1084,6 +1084,7 @@ none         │ on                on             off
  writethrough │ off               off            off
  directsync   │ off               on             off
  unsafe       │ on                off            on
+target       │ on                on             on
  @end example
  
  The default mode is @option{cache=writeback}.
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index e30243608b..e7179b0de4 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -42,7 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
  _supported_fmt qcow2
  _supported_proto file
  _default_cache_mode "writethrough"
-_supported_cache_modes "writethrough" "none"
+_supported_cache_modes "writethrough" "none" "target"
  # The refcount table tests expect a certain minimum width for refcount entries
  # (so that the refcount table actually needs to grow); that minimum is 16 bits,
  # being the default refcount entry width.
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index d62ef18a02..2eaf258c8a 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -47,7 +47,7 @@ _supported_fmt qcow2
  _supported_proto file
  _supported_os Linux
  _default_cache_mode "none"
-_supported_cache_modes "writethrough" "none" "writeback"
+_supported_cache_modes "writethrough" "none" "writeback" "target"
  
  size=1G
  
-- 
2.21.0



