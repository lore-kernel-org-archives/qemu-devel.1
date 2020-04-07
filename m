Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370C3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DD620644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiSvDhZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DD620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlel-00084J-2a
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLldm-0006Lp-7q
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLldl-0003e9-9j
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36396
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLldl-0003dv-65
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586255972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IySQfSoliK7L1y64dc2+4knq4GDTJOqI5a2WNZld2yk=;
 b=HiSvDhZrKvR5BF0Rwmyc7+PZyEVLcZk+wXyEzPmrt30vKcYVbBY29+ntTKj7PJU3qyd9yp
 xM5MZe5Fs0n3V/u+NkiFskmJDHvZUdm/HhQRuqgolID8WTneqQUm1UvqUGjyn9Y569/aKk
 ADPBm+pNRLTO+7DvEBpF9mMgMByR+I0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-JW5Uz7_UP6KjM2nNzXTo1A-1; Tue, 07 Apr 2020 06:39:31 -0400
X-MC-Unique: JW5Uz7_UP6KjM2nNzXTo1A-1
Received: by mail-wm1-f72.google.com with SMTP id s22so529525wmh.8
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 03:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=efxzJklfdbLE5xyXDAw4RE+zYk98wFqYdSDot6mi/b0=;
 b=cZTs2XxCZHL+ctXfI5QS+K8C7izn7qaczli8WPm8QtfULn2uvPL3a3AAeXTiUvcL3+
 RJEiSBoDVoItFfUP9WXVpbiQbaVjCV3F7RcCfjcv/YkZfDqX6AuWqcnS4KR0+GQEJmE2
 SJ9u95fqgEspiuzU/t+JITHNKnu/yRuvjEnEFRmufgpH856R86ATlM0M+Giin4GGpwtv
 Vnl7yVMF3owm6T5QU+iRgnDJx7zKHVpe3Nv7yevO1DNetpAg+2j/+MaV4yWAtnI0iZoB
 yhurJIHvuyxwRO/B/gLWYRu1r+rYseIErTyTHhZskw8Dai6hAapaO1TVBlqIuHlSgB+K
 R7cA==
X-Gm-Message-State: AGi0PuaX5uzB8QvxNmwC8beEMF+WyKojESZ99TOVtpaejZ9MgDNsfmej
 LdJCOGFUK/adNJKTrwIiKdZWyJODUSGw8iHU4krwJvxxHukEYbxSGmJrD+dfTsxcjb151eYe/gT
 THTpUGILVuTNXthg=
X-Received: by 2002:a05:600c:22ca:: with SMTP id
 10mr1682126wmg.19.1586255969015; 
 Tue, 07 Apr 2020 03:39:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypL1CzTZdxEWeFMilCAFpaDtCTa9Ojg4kK85XRIatTttXyC5qIRevwqZKI9PfuuPSw0D+gXE9w==
X-Received: by 2002:a05:600c:22ca:: with SMTP id
 10mr1682118wmg.19.1586255968844; 
 Tue, 07 Apr 2020 03:39:28 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y189sm1875566wmb.26.2020.04.07.03.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 03:39:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] Acceptance test: Fix to EXEC migration
Date: Tue,  7 Apr 2020 12:39:16 +0200
Message-Id: <20200407103920.32558-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200407103920.32558-1-philmd@redhat.com>
References: <20200407103920.32558-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Oksana Vohchana <ovoshcha@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Oksana Vohchana <ovoshcha@redhat.com>

The exec migration test isn't run a whole test scenario.
This patch fixes it

Fixes: 2e768cb682bf
Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200325113138.20337-1-ovoshcha@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/migration.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a8367ca023..0365289cda 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -70,8 +70,8 @@ def test_migration_with_unix(self):
=20
     @skipUnless(find_command('nc', default=3DFalse), "'nc' command not fou=
nd")
     def test_migration_with_exec(self):
-        """
-        The test works for both netcat-traditional and netcat-openbsd pack=
ages
-        """
+        """The test works for both netcat-traditional and netcat-openbsd p=
ackages."""
         free_port =3D self._get_free_port()
         dest_uri =3D 'exec:nc -l localhost %u' % free_port
+        src_uri =3D 'exec:nc localhost %u' % free_port
+        self.do_migrate(dest_uri, src_uri)
--=20
2.21.1


