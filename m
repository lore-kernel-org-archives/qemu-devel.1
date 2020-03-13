Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E64CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6F3206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9gGj84U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6F3206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpGn-00022Y-Aa
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBl-0000YH-J8
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBk-00043x-MM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpBk-000426-I6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SuVECRO5K7Gvy7TFYYgJaxwMNPrKIUm0bQrl4kHjTk=;
 b=g9gGj84Ulvxt2KZyF2CkyZSWaV/fWRPQJFj755+pOqx6JOtdCUmh5YgEi6ksqyHNMuOsuU
 Nl+2zIi3gnw2cYoPO/GkfPQcYlT94OoxnKZwHpDSbFNulRRFR95Y6FmXJszxUATbx5zfqh
 dvpVDuvGtWS2rHnQqL37rQVvZMW9+ro=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-FalTuHuPMT-YcUp342WQuw-1; Fri, 13 Mar 2020 14:37:38 -0400
X-MC-Unique: FalTuHuPMT-YcUp342WQuw-1
Received: by mail-wr1-f72.google.com with SMTP id t4so1772159wrv.9
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7qrHY3POAwgPR/yw4WHGaOw9mwemlFbyLT5p0JEbbnw=;
 b=EfXFx7gxBJiuAct8zVykw55RVGC4k8p1hU0xZ9iETg+hUSZZ+Wt0wlwfYjUGqv3jAw
 dQIw3KmFCQDbunaFRCxk+Mjsc0w3++TDs/TjwSGjz9Ccl4iUH9ir0oto+V1nDIL+P4dl
 YfJs1X6avd/JSUcKs9WGSkyeL/KpDa1kTFYEQqq07Ma/NSb3HJK5HBUOkEM6tTmiPNb9
 Z/KtIyT6KAhu1TaRbhBJlmdgm454e+WRjZjvEfnhFbLQ2rflhqzYRoQ2hn4JbCgDIoSk
 PRzlkweSi8rqWSpugprqT77iHaeGE2LMiiBYJZ1vfX/EXNIxDWCVKS1X8CWB+q52Q88V
 En5Q==
X-Gm-Message-State: ANhLgQ2g6pjWoIN1WAHnsugFycFGMCYAZw/RHL25PzAatfJsPsbdjclA
 LFSpiLyWk5Vr/zK+T3x3PU7U6xP3fVdXTNgPI42dZX2zOWdCI3zywQROFV2u/r53FBbvby3N43h
 86EpEuJvFEhD4PqE=
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr10863171wme.80.1584124656631; 
 Fri, 13 Mar 2020 11:37:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvhA9+6w6SxST3JF6c4Ko2DAdhDZUQcupyXKHijFIIWpb7ZBMQOtnHcAwPsLhSqhwg+SoVqzw==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr10863153wme.80.1584124656402; 
 Fri, 13 Mar 2020 11:37:36 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id b6sm24047514wrv.43.2020.03.13.11.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:37:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/14] exec: Assert CPU migration is not used on user-only
 build
Date: Fri, 13 Mar 2020 19:36:46 +0100
Message-Id: <20200313183652.10258-9-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 207.211.31.81
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 exec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 0cc500d53a..7bc9828c5b 100644
--- a/exec.c
+++ b/exec.c
@@ -946,7 +946,9 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
=20
     qemu_plugin_vcpu_init_hook(cpu);
=20
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+    assert(cc->vmsd =3D=3D NULL);
+#else /* !CONFIG_USER_ONLY */
     if (qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
     }
--=20
2.21.1


