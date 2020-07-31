Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA4CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:45:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EE220829
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="c7Oezxlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EE220829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1RbE-0003iI-9c
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJk-0007oJ-Jd; Fri, 31 Jul 2020 05:27:08 -0400
Received: from mout.web.de ([212.227.15.3]:36171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k1RJi-0003Iv-Um; Fri, 31 Jul 2020 05:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596187622;
 bh=EuJZnhDdT/XNOaCKZvdlajlxeYo8brk4aoRtdHhMqZw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=c7Oezxlb0shLuK2NvAs1GhGQPamxnyINjMtGmy9O5I8U+z8IdIue9OA2XdoTa03DO
 TDtsaFXcuq3iq5ruB/jXk7PUFFayjwnaw/TnIyQAU/AYMzmT5IaCw0jzbQ7FPnsNSA
 5zdfUmWnmyYMFfMrbnYlW/669UZfKY8Kc/YMUb+o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.42]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVaYi-1kBEvK0QjM-00RWVu; Fri, 31
 Jul 2020 11:27:02 +0200
Date: Fri, 31 Jul 2020 11:27:00 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 7/9] MAINTAINERS: Add myself as maintainer for yank feature
Message-ID: <14a7a25d32cb021d9b4f03318dd7ef9bb47133f3.1596184200.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596184200.git.lukasstraub2@web.de>
References: <cover.1596184200.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xN8STn.HjHO7F6UZmoX9Ii+";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:psJT6U/QISliVQvFy7CpWW6m4Rr19kTOMdoNMIYEexy3xvELOYS
 +O/FHqzaiFgvHKx+w5IbTAP3EHN9cxOlGuWQtPbUhft/cEbXCXNPEYHDW0fX2/aBCmKsJVm
 D01SMRfV3ZWtPDG30bPug1asUa10kzYmMOkIID0XcbuOl8nV6znzSYxUGrEMyZ6YWQIEaId
 jyi8P31Qe4nOwJZAENfCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RU5pCBk1Sow=:OaAO1nLHWxnFEXnSuuSSbn
 v/0qNAIpAyhIg+VzS8QK/Ho40IPpg/rRej8MHSUzR6x6S/+v9URMnKBqAGULYaGdNtun9sR15
 9L/Nj32wnxzrlkKx0JJOjfHXit64NZinBbnk+hmGbm/cxEhga5NkYLfD3rhwIwMjVpIIkJl8+
 I3r0v8ka5znqQKeeGxXhXVBhzeg7rMYbc0jqRuydfYgLKzH/3skgkkF1IHDzLL+Y/bg1AR1SN
 wfrto5SfrJYkha4q/9F1d+i/gouLmoS5eWoc2UALZeShzbo6rsqymDlcboToHZQ9iH3k7q1ua
 4RLWxjWORlb3pgC0abdY0ADFN+objj2ld/F28r0e3maLTTkULs4BNsfAtx/HRRneC4Ix9ZMuB
 Xaohm7q7MAvH2+NRco+gpaIrj5nnSkbHsv8pw5pqGnUJkziR/YsszWfG1/WIv+7bw6z7pRjJo
 aklsC24OLthXPsSYZrmpRmYv5ECabkyGLKwlWMGenI4DhI7q2X+TaiY3uj6EvxG8MZdrx8DYw
 U495zjYcOXqv/RQHY6HPrCeUzUnWZgYhHJ28W+X/GNktMEzcUdNds2NGfqXMCeknruJ31NyXU
 0d6yTZIsz2BXVnqcCS7ZJ5yjNA9eGWjbN18vetNp/oNpKhK+J8xqECydDfajhoWpHRETI0yxK
 tflUj9SL00QCr+deF5dyCO7/K66FEs0NuHqCam8bZ4a0OXGP2t0XhaeyWEevcNLmdBv30/+bw
 rHlLbm9p4wvSfjOJmL36Bnqj5kbkwfLH9eLi6YPq6mfUhrWUlgQnsZw/u1qdX3ay2Y2kEF7R+
 gfBA8nZ6k78WLDJJYHS0dHuc7sBsgu97cUYLkPo+a94g93mVKvamTlPfQlxNgKoZwruGKhUVx
 fktaqVXtsc0SzFg2WnUDETApzhu2I5GlOpwC5SyPLPl/PJGZXtpwOjZR4JPM6NVNikl+C+AP4
 7LEgjqGuRTsXTZytzeXfZcZvunCro+q2fGiHJHGlM2bwuNfWdK1We09MMl26F7YkXE1kQiFoM
 TFbOFGzROQt1cVksKIio/yQHMbhvzmbor+zPLqOTVo72tLlcjZQOjv2eFCluCfpYcbPUUrimT
 vNNscuRcX+FvawObtF7FQ1Vrx6MGZO/EQ6gWo8pcpl29JRwcc/PibsWbQdbk16Bdo7YtT6wT4
 sFZZtAw3JTrKM80IYuGS55xDnUnBDW54zQKAhLfXImNqoUPHtn6hb8jjIDV9NOcpBsVFL6lYy
 3myGjY7J+DNiE/UAZaCwganD7YGi+JvgD03MpWw==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 05:10:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/xN8STn.HjHO7F6UZmoX9Ii+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I'll maintain this for now as the colo usecase is the first user
of this functionality.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..bf5075a637 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2614,6 +2614,12 @@ F: util/uuid.c
 F: include/qemu/uuid.h
 F: tests/test-uuid.c

+Yank feature
+M: Lukas Straub <lukasstraub2@web.de>
+S: Odd fixes
+F: util/yank.c
+F: include/qemu/yank.h
+
 COLO Framework
 M: zhanghailiang <zhang.zhanghailiang@huawei.com>
 S: Maintained
--
2.20.1


--Sig_/xN8STn.HjHO7F6UZmoX9Ii+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8j4+QACgkQNasLKJxd
sljG+xAAhAPOcf3+wf04M1DWIMsmL5BIJD13x3fuRbvM9axS91ZSgs13LgtU9NWR
KJlUrRTUZzs1iDi62r4TlFV7PPssFTaf2X2B8NiK0V7rin3jZJ15wW33tX+VWrIh
BowjN/J7KeN4eNHAaM5cy0xCbMq7d7AcP49nB05K7b4P16uDZULC6X9w4X1z7Rk/
6GSblFVe8vBaYZj0eyMqB9LFVJTBWxtfq1XosLeYAvosruuTtT9ihjdo/k/Hb03c
SuQBGaWttIng7fee4/N+ez7SHLPAfZXCsYDfsoKfRJuAId/IuAsHK0rfm9NzjusL
vvT2xcXTlfaYIz9kC6scLn1k6lcnHb0F4td1WD9z/6hPwA4zD3TXrqxfC+RnjlNj
3eJ+SYnbngWtMhDoH+l0B/dyC8nEVvouSj1v3wCq4sb4o/4x6TMOzHQN832jlE2s
6XMrQZ5QOI/1lgWVB3DJ8GQQyM7WEMwuD7anEMvKTMy2CILO/kFp9IEFONZOpDyh
ekQZ5eXX9XeYcUN2lSEWtWQZFBWlJtxNg+gTRsBSN3BMBjBYYubePOjJiv5fgQJ2
uUtlu3gIkOPA+XRl5MkmX1tiwkPu6D6Hq6D9/1NhAELcHIDdjRilX0o23h94nm3z
NfmtPK52PSZZs/8+5hDiv8xcy/MGSY6XPG9Kd6sVj/E/S3vwywg=
=w1DH
-----END PGP SIGNATURE-----

--Sig_/xN8STn.HjHO7F6UZmoX9Ii+--

