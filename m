Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9821BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 05:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6178320829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 05:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZuzxNXED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6178320829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1NIe-0002iC-Fv
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 01:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1NFc-0002BL-14
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 01:06:36 -0400
Received: from mout.web.de ([212.227.17.11]:42735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1NFa-0005zC-4q
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 01:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596171981;
 bh=+HpgZT0db2KwCA/cG8ID80eu7YViB6cgJ/ExPSqDfQ4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=ZuzxNXEDDzPTqoIQnGtSi3NrS+jDWzf56wppOapVRRNeDM8LDQdXr805QQYBwSAHb
 DantqPAgZARs8DQTAxnlwcOqi+ruuX3stLscKsfuZqX23G372MDosggARu0njPYPvO
 ti0gQVHWgN+O7df3W/6V0PIFs/K/5jYx/k82vTf0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoecF-1kXx3M1g8f-00ogxM; Fri, 31
 Jul 2020 07:06:21 +0200
Date: Fri, 31 Jul 2020 07:06:04 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH] colo-compare: Remove superfluous NULL-pointer checks for
 s->iothread
Message-ID: <20200731070604.0c981f41@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h36TNXkZlwjXUQPaZHiUnKL";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:cCLqMmN0rGoBjfJsVABXnmzYwbaioEBwfSp41Vk/OJsUED3TRAZ
 pC1MUWo+L+IE2Hg9tRU7zJ1HMws4D8wLiUypM8YoEv55D4u6nKu5rmGtdrl4HWr1KMVkGwh
 wTGZ/hCi2J3QincuYU4mbVq1FNA64ePUWSSv4Foj71kLi3Iz06Q1VYJb4AsxdJrhbo/PXTJ
 BRSd2UuL+4v3hnJWf22kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gCQBrjvsl8g=:z8mH4c7VQgYEQltfmLfAU0
 xD1XOVeb6NP7YN2ZsQ7BzQWg0OMlJlX16+wnBkFjh4XQAEFwXADobMlPY+1moj/RuSCNq6Hv4
 s3PlA9FDyDFzRoPvpenzIbk55fzwHL1dYyfL3getWu9VqBPBbe9gdv+gGMRhXD/WQjlTAiQ5u
 RnMHa4V9nZYS6qPFQ/LEvC0NCOKk/dFSt7aoIGv4cOFKKrsQsrBM8XXuKy6CUtIjJtSiV7lVb
 SafcAXl8A7i0NA1NeQUKjRf/i0RanWz5yMHJR2BGsHrP6fx9aQ/uIS+5umUNTJU/u/EqE3+Nt
 lI4APsE3rfEecaaIPvriLKduKS+oWnxbbWu4FxpB88OUZSF620xX5+fZN57AEJfuDqHfkLd8j
 AjqxmB3vTMdlJ7Lvq+OQkSkuyRFzIew/rC/REyNrksd0xW/JIANf6nHUM7+q0RCBoce7ZWgUX
 ayj90NLxrMVi3oXS19FWkDbL64cQ1M6SO7fInBKgNkWtw8AVjN6hTC3bSXMqrByrpYI92w5Mm
 tPjBoy7oLE5T36Ce8dzgiN2jpvZIoolK4MhF9eyZOC5jbC6QtA3KqmwXrM2Umr9K20HnY/ZJX
 OXCBdawNRLlTqSs7FhOL2gFQZ6++mXj6JnHfXlDy7UEl/r7RD8fXiAW0fR/3LA5nB32mPAPde
 4m93Yf8BGZ/qiidQuGzG6r/Iovb9a2fNgnQDY/T375xIeBjpITF9hO9FFh+8TRaQ+FlOBGwNP
 +rTudtEumwy1WRTkhP7honPmXaBU9d90iwIt8jLd7CZbZAtw4ONmMVSkjAl++AQns/JUIr/7k
 koms6il3vh4AGX4eL7p9bb2UjP4nTk2R1s4P89gglq4P17tIbZsveuka1p148QDtLdOvzM+Lp
 IUwVxd7Pj14JsJMVwfGwWfUERTBwzpt2CKcTGYHtPbNBrfwaQS5lBencMATuIvTZIC4VoFrKS
 6+mP2lfD7EzqyxV2sWJ5Egm0dQem7T0ArstAwSU7Au9yck/mxXsxDIDAf+CiMbUly6W9lRwuS
 mHS5LfvcCoRWBbRQZF6EnUuW7eFxLeTj5RiHtyPnpCCssw/skt9m4VawgUzwfxPXnJ/5LwlWG
 TE+XHTGJVkQXLBS02l1+VV/cmJCFHeCexcR2DdA1Ltsr9djBoMoR6kvrEFhKubxVIAylspPm3
 GuYrnxLvwsy4I0Z44eBTDXe9M7cdOFuRUDFyZh26QoxXMAIxt7xeScZjWo/vOQviYCeaAH7eg
 vutfsRajXlEu4JWo/S7q0kdUplHLB/QWYSNF3wg==
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 01:06:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/h36TNXkZlwjXUQPaZHiUnKL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

s->iothread is checked for NULL on object creation in colo_compare_complete,
so it's guaranteed not to be NULL.
This resolves a false alert from Coverity (CID 1429969).

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 net/colo-compare.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index cc15f23dea..2c20de1537 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1442,9 +1442,7 @@ static void colo_compare_finalize(Object *obj)
         qemu_chr_fe_deinit(&s->chr_notify_dev, false);
     }
=20
-    if (s->iothread) {
-        colo_compare_timer_del(s);
-    }
+    colo_compare_timer_del(s);
=20
     qemu_bh_delete(s->event_bh);
=20
@@ -1470,9 +1468,7 @@ static void colo_compare_finalize(Object *obj)
         g_hash_table_destroy(s->connection_track_table);
     }
=20
-    if (s->iothread) {
-        object_unref(OBJECT(s->iothread));
-    }
+    object_unref(OBJECT(s->iothread));
=20
     g_free(s->pri_indev);
     g_free(s->sec_indev);
--=20
2.20.1

--Sig_/h36TNXkZlwjXUQPaZHiUnKL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8jprwACgkQNasLKJxd
slhY8xAApywTCsSuSGkf9c7MrzOIK4KSZDGohwMR6n9+1+kQrwsr2uB7YF7Ugavu
lFY5ZM/R4TvsDI/3Y9uVuKfFwn5j2OEY/iOj1ZiTb7vyUwT4FY49ElPEG0StesxZ
Uf1Y/9vD+F68TWuTkKlcgT2aRVJ90vD8tO6/ZCDueioEQmPs3qrq/jZtA2VqXYIO
7hAuCaa7Py+i+h3Gcimn6Wj6hZhBDqSq0ZQhg+VGifWdoCpdvH3TiePi2HPKyxjT
f5hx8t0w5gq9laiv/NvamPkCbpsnJSLlhrfy1MK5XaOPPFp2Ed/P2Nyv/AxtEMdI
h7aY2OZGdZoXQxCsPj/2lk7EbLMF+5TWKWZPSDWSj9WGrl7+6fHsK/Ms0KIVeP0M
Xp9hTaFJMOmrJR8UOmmoj97kOqf6lYdroa+g+BjCxYy6vzsTzYqT0IGVCAVys7nV
gOZVt7JbNo3OgRvX5LDxZwNeoqT8TTQ25ajcQ32pu8nqEr9e7hl7JRFBiajpK0NB
DEnA8X1T/9gprHSSf+YTx1ads2iXgulEAVp/0ePewZfFaPYd6a0wM74VyUcIhB9t
OZAwluD5+v+LGvL1Qe+nvjMYokKnEuZLrG6SqQ5kQxHn9wyD0N+/N44HJxIFKSou
/KKQSt455MbpAo5i2ZnyeyE8wjaTBpM26xOUomSHwZGhFZjKj9c=
=MJs4
-----END PGP SIGNATURE-----

--Sig_/h36TNXkZlwjXUQPaZHiUnKL--

