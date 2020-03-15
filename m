Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0C9C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9D3205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 00:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN0Z5ELc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9D3205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDdQz-0000jN-5i
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 20:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDd8L-0003CW-Jc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDd8K-0007tM-KW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDd8K-0007sX-DO
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 19:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584316648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mc73kkkbOR6YMvJfnjUOW/p+/YyXlGafTx0fi06KcgA=;
 b=MN0Z5ELcZ5P6ZL6cSHqTCGlpeCpulmimb5mj/u/MDOLhA8UTwl2DYVztq4CNl+6T9dgsf7
 x5V21lh8awiTmK2PnjSaOaJilZvjaFOGCqZxHTaYIcm4y72PuB0hlWd+vXs9BW3pYKs6oZ
 KooVVWexjKXOmpQPBb3rDz1gLdhXus4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-KonpXpMvNhWbm0uvXz_Vlw-1; Sun, 15 Mar 2020 19:57:26 -0400
X-MC-Unique: KonpXpMvNhWbm0uvXz_Vlw-1
Received: by mail-wr1-f72.google.com with SMTP id s4so2715993wrb.19
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 16:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fn55PSBk8YLuKq9+Y8DFn9L+hED9pijxFTNzc+2l8xw=;
 b=bwAXRvIgGqczTuajGszzUgVtCc/qAIypklngYJCn91cYLsGIkAPxy/Uqq3LuVQZ8ie
 egN3XRU/CDzkgeywjmUb5I64v/en5YdzhP3BFNpa6ltbXi1cunJLW07IffJsXpkYNjt7
 RCcBi/cnBnOO/VSW0CPCU95t3zNmZXVN7kIpX9Ugd4FzevXGeybQS3esanhYIAvWDRmS
 H8wf5BepbStRPRMa0B0K6OEczkfVrEhUlO810g2djSyhbVZhoLcz7Rsq/pNL6L6Ysmeb
 1+2b8Y9KSVU71Q3vJAfg3OwqoFt5ftKbz2hSLcSK41OgwwfRleVmdBkvBhofCkKPjpZP
 0F8g==
X-Gm-Message-State: ANhLgQ3pnAITkFif7JjN9szjAptPqFiEle+DZar8G814QoMiN5AjlQAS
 rok9JSKb6yA1aBBoj6lVbKA72+ZQyEbGTE76nVBMNzdV1IfylzmItAoVb+IDR7C7LddcNDrUHu9
 5HY+3K+xzUTYJCws=
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr24570793wmf.85.1584316645415; 
 Sun, 15 Mar 2020 16:57:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vueXWUSDZtIM4Etl4SleWf0BKqRnitJJvE3PHI2uA30HEbdSpVd4uREFq+3MJHyxFaV5N5GPw==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr24570765wmf.85.1584316645210; 
 Sun, 15 Mar 2020 16:57:25 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm89647978wrp.37.2020.03.15.16.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 16:57:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/12] Makefile: Only build virtiofsd if system-mode is
 enabled
Date: Mon, 16 Mar 2020 00:57:05 +0100
Message-Id: <20200315235716.28448-2-philmd@redhat.com>
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
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not build the virtiofsd helper when configured with
--disable-system.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Use single line with ifeq=3D'yyyy' (lvivier, rth)
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7df22fcc5d..7d27941803 100644
--- a/Makefile
+++ b/Makefile
@@ -345,7 +345,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
 vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
 endif
=20
-ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
+ifeq ($(CONFIG_SOFTMMU)$(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)=
,yyyy)
 HELPERS-y +=3D virtiofsd$(EXESUF)
 vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
 endif
--=20
2.21.1


