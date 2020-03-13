Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF0CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6DE20749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQMb23M2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6DE20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCpCc-0001ws-1X
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCpBB-0007iy-1D
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCpBA-0002La-06
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCpB9-0002Kw-S0
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584124623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLgNrlwyJy7v8dAuschP4PozhwWEQ5HJ4QmdriYy9Wk=;
 b=bQMb23M207hIcpVi5QiqHVvpE0xEBc7ll30X/Rcq36qj+a1YFIaRoppEIlRxaB8IktYjIl
 HP8NHthelRkMBeJdQVbE/A0gscKbRsDAnNkz1SRU9d3Z5uMWCJ5JT5Um+VwyYIUmq8TyK/
 U7W+JzBmrY+vwOaJPoQ5O0n9ohV98nY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-PDyaD2xXPeKshdZ-N_d6Hw-1; Fri, 13 Mar 2020 14:37:02 -0400
X-MC-Unique: PDyaD2xXPeKshdZ-N_d6Hw-1
Received: by mail-wm1-f71.google.com with SMTP id n188so3800907wmf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 11:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=moZeqK0xvieWMnbLXAu30p4QSLVxENxO9B1zIYBPdN0=;
 b=Ftk8Jg25SywyhvczlKAckLJ+ejzu1qwuuPp7qZxTQ5Zs/fylVHtzEXnQKG3bMrsOTH
 Qy71B9Lf8X/k9Jaz9qzlzwOHjds8MP5wOBxmrLmPicOIEC0QQI6zGKKlmzlU0KYcsurq
 PtGluQD/Dn1RJq4J/pUrDw8SVZM8giOqi+sl7Wrr4QX7f/pcw1ZZa0dUI5+uDzLDgTA9
 GLQ+QkLE1bF2/wFUCsU/V2UmMLTt+xfoblCaBK4gG2JMXfPzwKlKMfmLT/7NB+iNOqTy
 L9E+cAiw60xzro3aqkmm2EwLxh2NmqRuAecnxHfS67nMIQxp4NNhT5RFYU8GXcgpvB53
 Tu8Q==
X-Gm-Message-State: ANhLgQ3NF7/5yaOC9bdIFcBPgBmj6UMTl6NGpPblldKPCwbDb+gF6Xig
 HJaImi1MXjApD3DcY80+Tu7MF72gtUg54YCrvHXlbyN2C2smwV9BaLxIIt8sj1DRQjNEpzf+Vhn
 c2KYPw04At+tS98k=
X-Received: by 2002:adf:9364:: with SMTP id 91mr18691350wro.223.1584124620540; 
 Fri, 13 Mar 2020 11:37:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvLDAdBf5CysHXDLa59Zq3LkeNJxBty6UOuXhAtFGkATum/4g3WahoH0bLSPvYFQI4SzHF95Q==
X-Received: by 2002:adf:9364:: with SMTP id 91mr18691318wro.223.1584124620383; 
 Fri, 13 Mar 2020 11:37:00 -0700 (PDT)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g12sm6334174wrm.87.2020.03.13.11.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 11:36:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/14] Makefile: Only build virtiofsd if system-mode is enabled
Date: Fri, 13 Mar 2020 19:36:39 +0100
Message-Id: <20200313183652.10258-2-philmd@redhat.com>
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

Do not build the virtiofsd helper when configured with
--disable-system.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7df22fcc5d..ed77b6e50b 100644
--- a/Makefile
+++ b/Makefile
@@ -346,8 +346,8 @@ vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-g=
pu.json
 endif
=20
 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
-HELPERS-y +=3D virtiofsd$(EXESUF)
-vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
+HELPERS-$(CONFIG_SOFTMMU) +=3D virtiofsd$(EXESUF)
+vhost-user-json-$(CONFIG_SOFTMMU) +=3D tools/virtiofsd/50-qemu-virtiofsd.j=
son
 endif
=20
 # Sphinx does not allow building manuals into the same directory as
--=20
2.21.1


