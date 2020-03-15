Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53C0C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A769205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jjwx1BcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A769205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdbm-00055U-Ht
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd91-0003Ve-L8
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8z-0001I8-Nq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8z-0001Gy-60
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoFwUUdQ5j1EQcvi/TMETwZCa5YeqTdP32DVGkKl6I8=;
 b=Jjwx1BcUceJBbKGWK7suEk/X8b2RnOq0NT6kBBcMihhIMl6IzCed5ckd7Iwv1iWdSQcF9g
 ysj5Nt63IN9e2GRy2lQnIyzF5sT2Md7DEzScruqo7VpGDNwq6zYU66lg5U7SEYxnNl0NV/
 UZmrCCAEfKoEFh2f24y7WMUlb1tqTOc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-XS3mKewBMySfgAv9DQP1eg-1; Sun, 15 Mar 2020 19:58:04 -0400
X-MC-Unique: XS3mKewBMySfgAv9DQP1eg-1
Received: by mail-wm1-f70.google.com with SMTP id s20so4195462wmj.2
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vu4EsyWe31R7f19y4Eac1OzPvJ4o6ShFaBpa7vf8bFI=;
 b=BEkF2EoIVGX2xquzDmORFX3Ha8HeR5FXo9pf0x8vePBAmEbN/MWfQ/QaPYvQuXn4k6
 GZ/DxeCVjuhOmB1wYBE5BDhUFZ0q5FJsMENTxERyy7kMFHNeenY1BFFnCjDTRZ4FmsAk
 f09ucpoeLCqZofyn5PpjmCxeD5TJjVBzMTtoTTanm7kJ+e9f0c8QdSyXD5v8RJSoezjk
 oCDHOfnQJxgk9Ema7GhZ9qNUABoXRgDWIrQdUu8gL3o3fOoSj2bJBHdec/qPTrMLD767
 ZuVhjn7ziGRsWjfB9W0gr75fOMtiIA0UDwlWfMmBUcbP5TzWxiny9TmzioRQ52mcpMSG
 RBeA==
X-Gm-Message-State: ANhLgQ1RJGF1IrLvM0rpQTfiG3RyOULadYDkkrgiu2dCgXM/inNEi2/X
 AIlcsXZTez5RZWpIkugnAN0cvgiABelOrzk/SZnoRgxCHbVBd6c3ZRcwcFwWXqBiBc2EDoa2OUA
 M/LE1l2jSdeBjQYE=
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr31545187wrt.123.1584316683643; 
 Sun, 15 Mar 2020 16:58:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtXRGt3aM+Dv6XbBe5xG74x7acjtCAtR575/jcNCYjcRNQfT7deqHlwP1il4DXLJBrdmO2kTg==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr31545172wrt.123.1584316683507; 
 Sun, 15 Mar 2020 16:58:03 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id v10sm18018481wmh.17.2020.03.15.16.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:58:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/12] exec: Assert CPU migration is not used on user-only
 build
Date: Mon, 16 Mar 2020 00:57:12 +0100
Message-Id: <20200315235716.28448-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315235716.28448-1-philmd@redhat.com>
References: <20200315235716.28448-1-philmd@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


