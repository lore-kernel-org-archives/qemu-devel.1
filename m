Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A9EC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF4D20737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX3Z74Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF4D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQGd-0001py-Ks
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ94-0000C5-8R
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ93-0007FZ-0W
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ92-0007F0-SD
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585935016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbfl8o13DzBPrY5EilVoi9iUGJebFFDNwXZZwzDmirk=;
 b=WX3Z74Lv2hAF3P+7zwaQOyC2UQnhYDq4bO5ob+DCPzROiaYbg+X96CnBpszrAgLV26Aggr
 DzXTOGQAX5euRIqMGl67JfHqKCRZpUle+vqd+ryXMA8GlqHeUplMadHQqKfiTJx4TkNM60
 Gte5VUaf7fTUTSVmCLMlIDbSPCKPJkg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-Dbeud51CNPu0mGL0-fCnYA-1; Fri, 03 Apr 2020 13:30:13 -0400
X-MC-Unique: Dbeud51CNPu0mGL0-fCnYA-1
Received: by mail-wm1-f72.google.com with SMTP id s15so2362205wmc.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MP4WKd472qe39iLYnvNgwwSGSAWZeFWSQ2XzRTk1W0g=;
 b=gf4RmEZ8YiQsN/mVunNO4iRdhO/EBRe2KoY/W6q2X9NpHmZ/71/komPSKvhpT+yaWe
 YPoOeSSLT5CeSHVssACp9t9BZIAA6BVtBYYRwAbWDSvyEUYyXQXyUYlPz2NoKMD9aGjr
 H3lSwIofNKehOmAGyqI5tRt9SlsV94C77kaEkPbbNDRpO09c4PzKrvqaGULZR0QEy5Vb
 GcVLE4jLZ90lmaA4DL1Mnc5Yjhrv/zPRv2gyxpwCyL91nvLcG9aLMWLS9JqZ10E61FPH
 /Gqw/PB9nj3RrESNozGSeNHPbxUL4cfpuC2s7ot+VXjF6RZYnad/MojVNqnmgOfhQqU8
 44oQ==
X-Gm-Message-State: AGi0PuYrBMGK+Uz8jM2HL3nMLjwQGgd2noAY0tj7ZNzsF7BheJYCPE9M
 +ULYDfMfoVPYJUVRUXO439/zNc+bS1/+jY33+mVz++np+Wgvg4YODRbBvFC1t3/gk71uFW6/Wz/
 HfO2UsWDzaHr35tc=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr9815775wrw.93.1585935011888;
 Fri, 03 Apr 2020 10:30:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypJEXPojlWWMEP02qw87wGH9dOMY1WtyywmbfJnAbtqjWkb0lmuZTWLm48Zgcjq8TxcyjrcCGw==
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr9815757wrw.93.1585935011712;
 Fri, 03 Apr 2020 10:30:11 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f62sm11860854wmf.44.2020.04.03.10.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:30:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH 8/8] Kludge for Avocado issue #3661
Date: Fri,  3 Apr 2020 19:29:19 +0200
Message-Id: <20200403172919.24621-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a feature from unreleased Avocado v78.0.
See https://github.com/avocado-framework/avocado/issues/3661

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/requirements.txt b/tests/requirements.txt
index f9c84b4ba1..d625b32dbb 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,5 +1,5 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D76.0
+-e git+https://github.com/avocado-framework/avocado.git@f9b4dc7c58a6424eb8=
d0ed6781a1d76ae3a5ab06#egg=3Davocado-framework
 pycdlib=3D=3D1.9.0
--=20
2.21.1


