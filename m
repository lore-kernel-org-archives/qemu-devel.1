Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20161C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00282068F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NODxjq/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00282068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqek-00026h-UG
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iXqap-0000HW-ME
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iXqao-0007GW-Mb
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:11 -0500
Received: from mout.web.de ([212.227.17.11]:52839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iXqao-0007EP-Da
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574358586;
 bh=827P9uVe6YhRWzCuWJVs9esq/yZNcNZoevzRX72rGsM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=NODxjq/i393jMDSdIDVnlAXzuct3wPjub5XxwFPknAK6MTi694px4693v/oIcOZh2
 2LxTQIGUwXe9nCVOIulu1af0HAYuZDkPKg/PIsKYDuc90E4L+l2pwepVVL6stTQbj6
 //oR3iQwV1ryflZSMDUc7k0djhdShksy426fQoys=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.160]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMEmv-1iUpNP2M3R-0082Fl; Thu, 21
 Nov 2019 18:49:46 +0100
Date: Thu, 21 Nov 2019 18:49:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 4/4] MAINTAINERS: Add myself as maintainer for COLO resource
 agent
Message-ID: <56f06c61bfea6f36bbf190bcc6db8f0c3245e6c4.1574356137.git.lukasstraub2@web.de>
In-Reply-To: <cover.1574356137.git.lukasstraub2@web.de>
References: <cover.1574356137.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sHYHMKOSI21+Wr7kHh+QpkLudZo14bWDu3tKwV0QmHcyC6NEGgP
 WwxpCoCEVZS3Thy+tgJ8SeNMTo5HWwEXk9LcJoRxogB/PWlScWMemARtNz1/JtJx36+Awie
 oyPLd6t0G8BF/Q4Hc3OTa4F3BILDab6C5B3HYQ0z13+6bdxkXI9dgw+314U1fsIVwaiV4gL
 cILLPYNx1dGW9ituJTafA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uzQ+apF56xU=:JaHNpqWl9XQJ2zFx5ZmYQS
 sgc5kd8rjHm3kx86y3/mEzeUlbZRvWJiOLtacNsGAgztmYVRdi39E0lEsmg1Wm/Q2xtX4I8gi
 jIa3Gr4GeyfLgxi85mz5HDJiWcNXaWPecG9lX4OXAsnJ7fCcUtgFi3mXU5KEhBaJ8BjKbpx8g
 TqoTGEdJ0lbDgU+OpuEkZsEWP+MRUaTsC/VvlInl+qaSzt7hfLkn0yiz0QN1LIliYVP4N5juq
 LAV2pdi2UmDtcfHPxf0Z+rqQf5Atu/RkdGQk0jkDvJRTTV2zjwyhdqYxgWpOoiRSdw4HdsXD3
 PJrBn3vVVx7hVl0VCx25DjkCF9R10N9sKOXfPJdxw8v3oqtZ8uStmB4N8vxZzfodOGBJ4cdL3
 0y5gQlnCCvJsdzG6nA0UtoIhzX6UzRyATjpoLn4LiBaAnCyXfLdZtO4mScm0eTBoCPWBfCTYQ
 uEMKiKOYwGpX3Vd0bPZOIO7BWuzXWyrRSSM+djcW6YLtyQPZ4tlUUJSxeFeD958u6JwtHlxOw
 Ppm00kk+KouPGPqohvkdALOqtmsar7DXpsHZ/pZVjiz5+Sinyy8x/zynPCCN3kwcNMSSDT0o3
 p7OYpEf0rbLZU6/gsvy1T4AO60QpidPT7SbGHKbuKs8Zhn/29gUZ/EAWujn2QCKXDvWmUQkeR
 Fc/5fS0LOzDkDX9U7P3//bjR+lsP9cIzUdOKkess5etr1nUybWfA5kISBKcE6GwdUiSjSbtNU
 32G29DuImnm69hkb7SzaYNcrI/qoM5EEWNcKLxki78QvpCgZtWNvNuWQIAXavFhAemClvLPBA
 cnO82Bx4a/arOqqzu8AiMrcIyKefB8wWY0PMqKipAX+S67rSGLud22UwZ9zvLJ9UbUvABZjJo
 5a1D6C+DiqKWhQhtrggpKIPDL2bJCRgOao1ph1skwjupsVVhBeR7n/QVARZrJOpp4X4d9dMuP
 XXi/iy3d2GkUAjKHVTiu2QS/KcNdtDWRW7Y6Y0H6ql+H4g9R66r0lUfrN0f0Pbg41cANF1DqP
 vtoxRqUbGnJ5NhS69kv8K7te95Luah4IKFXwUAqcqhctxyex2SgpP8wo+cPKYmNTptpgwQ2Bn
 klxavovVZXGuR2E9DJMLaHDTLrV/m1vyPknhZcTGHuIU4ggl/V8bR7oy5SAH0LiE65Nok25RW
 HUsnMEj8/dpKX1+b0opZb4+SFuh5IJcz3s2JrohVZKCyievfkgEF788oUb3ScldmqpcUCtWfv
 zeG9I90Ctt4TQYBEr+nvmMaoKsCxi47pan3qy4DB8KebIC8+Q9zhZUSZaaIk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.11
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While I'm not going to have much time for this, I'll still
try to test and review patches.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6de200453..aad8356149 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2239,6 +2239,12 @@ F: net/colo*
 F: net/filter-rewriter.c
 F: net/filter-mirror.c

+COLO resource agent and testing
+M: Lukas Straub <lukasstraub2@web.de>
+S: Odd fixes
+F: scripts/colo-resource-agent/*
+F: tests/acceptance/colo.py
+
 Record/replay
 M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
=2D-
2.20.1

