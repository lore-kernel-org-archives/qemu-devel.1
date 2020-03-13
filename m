Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB7C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7130E206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMyDN7n3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7130E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpGw-0002P3-Jd
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBS-0008G3-3z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBQ-0002xo-Jr
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBQ-0002xC-G7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8aoJLCXCrlxs+uxn6Eno2ayGO83+rkYY4ustjsPF1ac=;
 b=ZMyDN7n31T2NarG4yj86Dv7yd18T4TR/qmbPZ9BmPYPMK7PVKMD6cYU/+SqOpQvf7ysCfz
 z02EtGhbXtSxHBSQhqbjXFDbw0pg1sNlBKqQc4hR1hSycqsujx6e0dYM/SptjA/6zSY3YO
 M5IMwC+KwFfQ40OHFvplNwDgx91HZcw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-uaRWfU3NM8KwtL9Hq5BOpQ-1; Fri, 13 Mar 2020 14:37:18 -0400
X-MC-Unique: uaRWfU3NM8KwtL9Hq5BOpQ-1
Received: by mail-wr1-f70.google.com with SMTP id p2so2183142wrw.8
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yX3/yxF6EHlmvUP2BbzjjZIQps3yYgRSbpFFIqc8F/E=;
 b=XEbuRm+OsaYMNWfLL1L1TuyBSquep4qI+VXc1DIV0LsQaOpxxp8jv5NoAUd1ul28Ku
 rllZtmWueDwlVhqC9Gb22h4Mpf/sma2qUkH6uzMPUaS5lRGCedTu5nP/xA0VlVeJiCCc
 G2mTbxhzjdoXGn9FW7WBWiEpK62cLXZaD8WpyrcXYJKGw1fGw26/LobiqlbKxSrQEGOD
 en1ZVz10TFDOeAAiKLPcJwxTfWBY2CURZthOhLAJvUfZLRCuvfVMeWEAqDcXXOurmObW
 UEl2lMl97uSAQueoC8SFyRHYu18ezbhpi2+Sn2Upr/P+GxhoGssotMEcnPr3O1ceQX1+
 42Iw==
X-Gm-Message-State: ANhLgQ0JqDpqTnPceoFDRwllyocf58NCchsEdo7sVczin5qgNhTFMzHZ
 VnEDZEosDV+WzSkUHwkkKyhjTEIwkFCSktKXL8O0iyZhaMSljnEkO9GtX0a03FLjaLYj+Q39kVO
 j/oQpqGqaB7THHtE=
X-Received: by 2002:adf:f58f:: with SMTP id f15mr20039034wro.16.1584124636775; 
 Fri, 13 Mar 2020 11:37:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs+YASwG+nS4kzBdGtTjiJzofimMO54RlgalOMRsiMkPw/ith6XkJN27+mO5FmTGtPyElY/Jg==
X-Received: by 2002:adf:f58f:: with SMTP id f15mr20038999wro.16.1584124636423; 
 Fri, 13 Mar 2020 11:37:16 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id m11sm33980849wrn.92.2020.03.13.11.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/14] tests/Makefile: Restrict some softmmu-only tests
Date: Fri, 13 Mar 2020 19:36:42 +0100
Message-Id: <20200313183652.10258-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200313183652.10258-1-philmd@redhat.com>
References: <20200313183652.10258-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These tests fails when configured with --disable-system.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 99db5eb3e0..bf11f765c3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -64,14 +64,14 @@ check-unit-y +=3D tests/check-qlit$(EXESUF)
 check-unit-y +=3D tests/test-qobject-output-visitor$(EXESUF)
 check-unit-y +=3D tests/test-clone-visitor$(EXESUF)
 check-unit-y +=3D tests/test-qobject-input-visitor$(EXESUF)
-check-unit-y +=3D tests/test-qmp-cmds$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-qmp-cmds$(EXESUF)
 check-unit-y +=3D tests/test-string-input-visitor$(EXESUF)
 check-unit-y +=3D tests/test-string-output-visitor$(EXESUF)
 check-unit-y +=3D tests/test-qmp-event$(EXESUF)
 check-unit-y +=3D tests/test-opts-visitor$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-coroutine$(EXESUF)
 check-unit-y +=3D tests/test-visitor-serialization$(EXESUF)
-check-unit-y +=3D tests/test-iov$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-iov$(EXESUF)
 check-unit-y +=3D tests/test-bitmap$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-aio-multithread$(EXESUF)
@@ -106,7 +106,7 @@ check-unit-y +=3D tests/test-qht$(EXESUF)
 check-unit-y +=3D tests/test-qht-par$(EXESUF)
 check-unit-y +=3D tests/test-bitops$(EXESUF)
 check-unit-y +=3D tests/test-bitcnt$(EXESUF)
-check-unit-y +=3D tests/test-qdev-global-props$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-qdev-global-props$(EXESUF)
 check-unit-y +=3D tests/check-qom-interface$(EXESUF)
 check-unit-y +=3D tests/check-qom-proplist$(EXESUF)
 check-unit-y +=3D tests/test-qemu-opts$(EXESUF)
@@ -124,9 +124,9 @@ check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)=
) +=3D tests/test-crypto-tl
 ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests=
/test-qga$(EXESUF)
 endif
-check-unit-y +=3D tests/test-timed-average$(EXESUF)
-check-unit-$(CONFIG_INOTIFY1) +=3D tests/test-util-filemonitor$(EXESUF)
-check-unit-y +=3D tests/test-util-sockets$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-timed-average$(EXESUF)
+check-unit-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_INOTIFY1)) +=3D tests/te=
st-util-filemonitor$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-util-sockets$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-simple$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-list$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-authz-listfile$(EXESUF)
@@ -137,7 +137,7 @@ check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-f=
ile$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_GNUTLS)) +=3D tests/test-i=
o-channel-tls$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-command$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-io-channel-buffer$(EXESUF)
-check-unit-y +=3D tests/test-base64$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-base64$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(if $(CONFIG_NETTLE),y,$(CONFIG_GC=
RYPT))) +=3D tests/test-crypto-pbkdf$(EXESUF)
 check-unit-$(CONFIG_BLOCK) +=3D tests/test-crypto-ivgen$(EXESUF)
 check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-afsplit$(EXESUF)
@@ -145,7 +145,7 @@ check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_QEMU_PR=
IVATE_XTS)) +=3D tests/test
 check-unit-$(CONFIG_BLOCK)  +=3D tests/test-crypto-block$(EXESUF)
 check-unit-y +=3D tests/test-logging$(EXESUF)
 check-unit-$(call land,$(CONFIG_BLOCK),$(CONFIG_REPLICATION)) +=3D tests/t=
est-replication$(EXESUF)
-check-unit-y +=3D tests/test-bufferiszero$(EXESUF)
+check-unit-$(CONFIG_SOFTMMU) +=3D tests/test-bufferiszero$(EXESUF)
 check-unit-y +=3D tests/test-uuid$(EXESUF)
 check-unit-y +=3D tests/ptimer-test$(EXESUF)
 check-unit-y +=3D tests/test-qapi-util$(EXESUF)
--=20
2.21.1


