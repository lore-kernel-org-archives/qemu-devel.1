Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F3AC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C66206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 21:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jQlV5Efb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C66206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSoov-0007Qk-Nm
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 17:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSog5-0004Dp-Tj
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jSog5-0005kg-HL
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:05 -0400
Received: from mout.web.de ([217.72.192.78]:38289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jSog4-0005fS-W9
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 17:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587935930;
 bh=NSu8R6ZArrzXlpc/YQzMnC4LGGAot9bFFDtDweoB8DM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jQlV5Efb5XeABlgz3+G/xMcRlmb0rWJRxrJrdIZqrJbuovN4ZHZpBAcqlRdFmVO85
 Dptlyc0A+XjZkQre1yYzXxWwXhqNiHaEudEntWUiAhTOI5yQiyKJJ010l+WSHCn+jn
 NfQx0AVTSh4IHCa828zIl8ZAQLk3twcn6a56kU/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.69]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbQOe-1jjFd81LGO-00IkEX; Sun, 26
 Apr 2020 23:18:50 +0200
Date: Sun, 26 Apr 2020 23:18:47 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 2/6] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
Message-ID: <be38e52e55c46e7de8ec23924e4f1a0071969f6f.1587935686.git.lukasstraub2@web.de>
In-Reply-To: <cover.1587935686.git.lukasstraub2@web.de>
References: <cover.1587935686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=8VwPYK/tsNbWET8TdWnrga";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:TWcJqsNDhHaXFF3bGcMiCZL6a7b89w6jWKkxntDSDR57yfyTP9Q
 /Jx0UBWCRj1Tg7/JSi7QNTwnjl5dkwGGLVAdP/WicIYKZSaS9zoIxiMpgaUGaSksa57rrXt
 tQAXwjqgu2zE8g4sKWB32X5I2rkFSnZZRyjhat9Pu66udi3Ugu2JW6rtOzDWHeCQgcIPhN2
 O00mY14bOAGyT5O78haCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P1M7rcbPO9I=:OYWJasBOQgAyquCnJPVacW
 iN1ivLI3uDlipIr+O3y70hPsb63to3h7AKYWibPH7u4Mt1P2Phj/vGCNUCGJVQG/zYJh+2Ndm
 XLssiD0RQCtMwAjrRNXBhs9UjqIB+WIYRw41iaElA29bm/Dgm25lw5bYD1YAOXZ6D/G5i/hyy
 BSzcQyaPDZDQt3WWDjnAQh/Xr7XIkZfUhZ8anQ6VPcijg0X/xtQDIxDciasHI3wCA6UgXQPmC
 atxRNxP1LqA9ftkCf8Gvv1ncXObs1CAfI5qMWjRoB/5Gnb6jhtu0oH+LV41jQoY84L88uYDCs
 cpXjIA+o+d1G/8C+JnKGV38UAtsiDnFl9Cb9L+4SHHeIxvDQSWSH+bxKfQpNDLBJaYGG/XWFK
 Q6+q5Co3bzDBN8vjqx44vTe+WbFibcnLUHUeXxy6ZBrWgc3gl6pnW0zQXRQPsaYwUvoJkhQ2v
 XmpxwboYZ2XcYBSly1IBGICpp5OwIW++R1TeWHePmfRPwL5uQj8El3ZdDjVQSr5EWmJ2uw0ze
 0GskmoQy37xjG/klld1a4ouCz8hRonQdP/1SO/D4DkS64wzCmSnR505/6YihFAwKC953Qfd1y
 b3TZUwMXWIztZCrrqMIHO7P4XLyWbUCb8wAUwLCsw5hscEYw+EXPdOxI5bo5QPL/dkXqfWuG6
 B82rQSlB4qKmJl+QEvaaYOYdf1rMELYhz69fYxjkFFbVflikX4Me59RyzX6XFBchXjE85dDFH
 Ae4e0Dhg4LeZvgOEnN70hnvbou/qEsxcs8xfWOUcTMQuhu8hMoa66+Fb9ZSx4uKGvz1NY9Ec7
 F0BH+yQsf3tU1Ke2W1wJU8JVoqL54hnSWpOber8lk6l4fx5zajlgV0fAmcnVM5TxskBgTu8cc
 IZ0KpZh3VKn7mUoH1Eq6its/z0n1HetOvTEPb6poKahvh62yBA67YH2UT+gcFRGbUX3bINKdb
 7zOGTmHmfY6I0n8jcW6BumR5jqUCAItwpmIf0wl546Ywm0SHh/0Z4C7gzhDdi0jbemt+8YNtB
 w/flBRVT1o+KPeQBoft4NVPHedVWa8iL95FjqZAggxPfFT70iU7y2BcEsp32NjGkunfKUOWkr
 BkeqWYbDsM61vMFG5X6a/qvcJFQdjhbx/Ai5SmwYi6VhkeqIC4bLceaTZCrypWgER1b8TdYLv
 Gz2haI3Y3tbSVECGvTiMm8sMjNBo+6OAfeob5B6h+MOGwud1utD1CmpxbArO1QUebLghDNhk1
 rYPN8xqE/j2Odai8/
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 15:25:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/=8VwPYK/tsNbWET8TdWnrga
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This will be needed in the next patch.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 chardev/char.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..5c8014199f 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -38,6 +38,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/id.h"
+#include "qemu/coroutine.h"
=20
 #include "chardev/char-mux.h"
=20
@@ -119,7 +120,11 @@ static int qemu_chr_write_buffer(Chardev *s,
     retry:
         res =3D cc->chr_write(s, buf + *offset, len - *offset);
         if (res < 0 && errno =3D=3D EAGAIN && write_all) {
-            g_usleep(100);
+            if (qemu_in_coroutine()) {
+                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
+            } else {
+                g_usleep(100);
+            }
             goto retry;
         }
=20
--=20
2.20.1


--Sig_/=8VwPYK/tsNbWET8TdWnrga
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6l+rcACgkQNasLKJxd
slhAShAArUGQSBoZtVD5kB7XfoW5phmn6XjgHTUIu31w/TKVSHFqReg4yRl6nGFX
gaY/3bQBM912G6v/CUhFfZvVDCEk+B0lUpLVM0F1D9K6CyjSJ3BnDbZIbkxJWk5r
se4mgC3QCEx5O/NkeQGUI9bswrRrKx2h7NmTHkJiosJQoO1IFat0EHHHakmLOHiC
Ubafx9LFaEDRG+I5hDQZE2HNXaRbU65wr8Icxkigj/+7DUg53ANzobp9T8FLPxhw
EcoO9exqOmZhkQ+toHqfP6PhUFwgRpeR4YuBe2QppeoMVLgzv/Cwc97kS9P0qZ0q
3mSQ3x6Q64sO2lRW6eCGyaCOEtqzXQ9sxmJ+5+WGzRYHGfjJkNRTPD7QyQXaDSc3
uCtmY7SrK8n3BmKrHgxUpgAzqjvehkLsAPm5b0DYGYqt0v4IpVw8ClIvQSUl3RKq
TVvuOPjIdvFS5oCLmBgGWtxYsqkafthgLPKZ20GxQxIZAoTZhjoRqqwJAQB9GxCQ
p7t4x6yeGs/YyzaiF6/jUiHdyOCGPetGGSmG9c3uj6FrxOBXYZ9EBbTBDjvPxqC2
PQCrYjdc0egUzYvKrktbdkaatmdrPU0WPYvs5deZkOz3yVdixthNqSAdGdz7ePNG
XDAXXeb8OWNLbb3zK/NmpZdXpOVXvwkIZzc5G8LQ1Bd7tRVDaIU=
=1UGQ
-----END PGP SIGNATURE-----

--Sig_/=8VwPYK/tsNbWET8TdWnrga--

