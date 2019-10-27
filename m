Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063BCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF12E20679
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQzO8Jrx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF12E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45403 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOj6y-00007X-RX
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 10:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bielski.maciek@gmail.com>) id 1iOi62-0000vE-F8
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 08:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bielski.maciek@gmail.com>) id 1iOi61-0002Pl-Aq
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 08:56:38 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bielski.maciek@gmail.com>)
 id 1iOi61-0002Oy-3j; Sun, 27 Oct 2019 08:56:37 -0400
Received: by mail-lj1-x244.google.com with SMTP id w8so3952057lji.13;
 Sun, 27 Oct 2019 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sqQW11yV65dqBxWkI4jZZWkqFOXqPOPHZKxOKfM6qDI=;
 b=LQzO8JrxA7XaK1clI3uBjTy2JnrEl5qcIn2qLwnjEcLF2a/TLt60LqPSn+RbnMW6g8
 U6EilIncAnXxOz2tdO8LuiqX0MP74PV4ebQCqjf5GJECqufj8dXtXH0Ofnt2E0G4o6QY
 DeCNG+sLXh67FfglFqSFviFkXn7rkR2iDDQDGGrmAcy1N+BWBc4Vzm8DIT+jdV6fbT3d
 Tz/L3V3ew5HyhZ51G/jK9fSsaSRSsdZjxbF4VxZyppzG1QQu9dS/x2FzVLpkoAFwrqxG
 d8z3OWv0rjn3xHCmFq0x2GYJ6lBft6HTdJvSWJZyUw1T/McTXNMgRMJNqFCJjIy8h5j7
 oiqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sqQW11yV65dqBxWkI4jZZWkqFOXqPOPHZKxOKfM6qDI=;
 b=i1gfdRHDBX+4zrCwT90OKjwjHpBaXocB4CQKtc/uJofD9VWdk1vX5wfBcpv/wyYMwd
 L/P8bKpzImQqFNq13RUwM1TcpRuIkf3xjAmXibMYKnD624zv3xzUftSxr8WEwQZA5pNC
 31TMyJ5ZJIng12m1C/FYI0hEbzhN346Dx3qwoOs/R3yNTcUCla/BKu4WDgqNt2x9/tVB
 WRvOVY0o9YUwiVJFEullfEftzyjq/wmisOvrfTMoqT/WAbiQYMjtqSWTt+yla/RtiyDC
 mhBDTKks4Fnv94O/+mhg0DqQuqaYq+xGCCMd5w0jG5TwMrWNc4W9BYqhh3kG0Bfp75hT
 n/0A==
X-Gm-Message-State: APjAAAUTODBMQoyme5PQXpATFElRl3hmWixHN3qF2UsdG6LH4g1j+pUs
 I/fWhUqcBycSwNXbG7fW8da0E7oM
X-Google-Smtp-Source: APXvYqxcEd76Nd5GE5PmC4fdKi6VZHCY6UILWpsLST3eTWw4aIbCvai6FwpZIqs3JmzYw6DI18N6CQ==
X-Received: by 2002:a2e:9ec2:: with SMTP id h2mr6338141ljk.85.1572180994607;
 Sun, 27 Oct 2019 05:56:34 -0700 (PDT)
Received: from localhost.localdomain ([91.90.160.140])
 by smtp.googlemail.com with ESMTPSA id j2sm3772698lfb.77.2019.10.27.05.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 05:56:33 -0700 (PDT)
From: Maciej Bielski <bielski.maciek@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qom/type_initialize_interface: inherit .class_data from the
 template TypeInfo
Date: Sun, 27 Oct 2019 13:56:27 +0100
Message-Id: <20191027125627.4921-1-bielski.maciek@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
X-Mailman-Approved-At: Sun, 27 Oct 2019 10:00:10 -0400
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Maciej Bielski <bielski.maciek@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The `TypeInfo::class_data` value of an interface is never properly
propagated for initializations of all types implementing the interface.
Although interfaces are rarely used, IMHO their functionality is
currently a bit incomplete.

A `TypeInfo fooable_info` of an interface "fooable" may have the
`.class_base_init` callback and the `.class_data` field defined. Let's
assume that `.class_data = 0xdeadbeef`. Additionally, the `fooable_info`
is only used to allocate one associated instance of `TypeImpl`, let's
say `fooable_impl`.

Then, for each type `TypeInfo xyz_info`, that implements the interface
"fooable", there is another `TypeInfo info` (and associated TypeImpl)
automatically created within `type_initialize_interface()`. The
automatic `info` reflects the fact that the interface "fooable" is
implemented by `xyz_info` (for example by having
`.name="xyz::fooable"`). In a way, the `info` inherits from
`fooable_impl`, for example it sets `.parent` field accordingly.

The problem is that this inheritance is fixed by the implementation of
`type_initialize_interface` and the `info.class_data` is always `NULL`.
Further, this NULL value is passed to `fooable_info::class_base_init()`,
where actually a common-sense expectation would be to have the
`0xdeadbeef` from the interface definition.

The fix below seems to be the easiest solution. Another option would be
to dereference `klass->type->parent_type->...->parent_type->class_data`
but the `TypeImpl` definition is (perhaps on purpose) private to
`qom/object.c`.

Signed-off-by: Maciej Bielski <bielski.maciek@gmail.com>
---
 qom/object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/object.c b/qom/object.c
index aac08351b7..dc305e14b0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -248,6 +248,7 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
     TypeImpl *iface_impl;
 
     info.parent = parent_type->name;
+    info.class_data = parent_type->class_data;
     info.name = g_strdup_printf("%s::%s", ti->name, interface_type->name);
     info.abstract = true;
 
-- 
2.21.0


