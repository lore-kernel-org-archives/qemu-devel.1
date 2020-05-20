Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03C8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F21720829
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 21:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="d0FVuWdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F21720829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVwN-0003Qv-KE
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 17:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVY1-0005uR-Lf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:41 -0400
Received: from mout.web.de ([212.227.15.14]:38821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVY0-00079y-Rb
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590007353;
 bh=c2L3X4H7w/EoaLKNHwRFS99beuVs7O0gWwWmQO5Q7pQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=d0FVuWdx+Rru7Spb+JtjDo8GM10kgJjuZfqUCzW8BCQY/S2m3qeuBCl7OHHrIx26N
 rECdYCvQ/7CCo/AsHbODlRHs7w9ZD2NaTjynq9zSe+cRPTwCqmo14pLTWab2Cxsu6p
 aXWKConxVwiFrssqsdnnb4M+2U4GfdK5NVVp3Ta8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lj2Cs-1j3pDj0jio-00dGNo; Wed, 20
 May 2020 22:42:33 +0200
Date: Wed, 20 May 2020 22:42:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 6/6] migration/migration.c: Fix hang in ram_save_host_page
Message-ID: <e79085bbe2d46dfa007dd41820194d5e2d4fcd80.1590007004.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590007004.git.lukasstraub2@web.de>
References: <cover.1590007004.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U1b7XtRRxqmbM7aHsgBi/5O";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:FEH/aqH+YoSjHjWD+k0jCpanSaUTVOXNqQhtejSVbx26nrKA/WI
 top37b28OrYTQvNghaFlVP9Q2tyY/fK4tqB3ckW7vytHjBLCMbLkNvzWhc00w1gaqhrFL0s
 E9xn5sB7pLr4EUbDWOqXFudXv00hdStgbai80agWqW6eC8fMxEGNF9rV6vWxwqNPs9VhriJ
 OEmb7fSXHIA6oKx2P31RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qFJ1REFqSlk=:NLRU0EmffZPPsFFGSJPQYW
 zfJ3bro42FkzSrpDTXvn9l/gOD7Dgasvfz+AqS6gn/dpguvivTpk4RydQcnwrqmEux9HePXjc
 oz1Zu/1hJZjXZwpBATzMd/LZbF3FHZ1efACcKDDIRNSDx4w9r6uvv9a46wj8wMt9+s6Ab+Vnp
 sg2CONFEFefZ7HR0CWR9hAmiuUqxtxsihZTElzPSZ3j0TfBgyKvAnn+qu+xiKz/jhEdc5jXPn
 dLRwTmuLtCkYZteO6gd5KMcNDvWSzltimy3GNcYIRhJ591Yy7AaLJR/SF5jYujAdN5FKW3GkB
 r7JkfuRyRjm9Nss5tCjbRigjEruDLzjHnmHSwy+QwO1aPB9Hb6rPYIpfpZaC4EE8W5PKI6BMA
 Txe7px/bkkk1agRXaKjU4eHY0/m3iGYiBpZgv1ouVfv0v7Z98MeLvrIMBi/fXXkKfmbz25pXh
 uX08USFjw/xf7YfR8X9rWfsr1Q+GsUbuD+eoxCDAjGIchTw4smNSjBoKoF2fWOG681RnLe16X
 zl5DapvM6m8Ydemgz2usx5K3yyss6P6y6+aFdURwqTa8Hc72w4m9ESqSXmjo13df5EZJb3UBI
 sKnKvyDpe/mzz9C58JaMJdZooKtPK1N77dEOX49YCTgIxC5vGxSL9oDx/HKON3F0hPdfiDhGD
 MP+CemicD81CvrDJ3ZxwrgGDAnmGKfowybt5u8ksAFjYMtdgiyCuNMghzQe/giCRh3dgBQzEt
 kICL4o9RNv8L5vP12ZpD6i48KIqksMZSI+NjTA+3O1d9+J9u6RkICiHZqmOWhHc+gS3SZ7K8o
 QBxLKd+10Mgm8JbgOEd9kv/CuT6kXugO06DJQqhTJpaD63blVJkxwvpnuYYGW1tZRfyAwQrZ3
 TGoe+yNO3I80BefDn7gIX089dBXfFU5dxY+t1TdifK269BXgeujS3qo+EnQmGLHqmFYkBZ0Kj
 CBohr6SMrIxqJ2WrN/tvZvc/983w89HcnuUFACpmHJEHgDXYsPHkrtoD/A43vHz+HmPKHkdKy
 Fm8psHrpX1Om/Da56BRVgHmpXwwIRBdZGYpPLsybfBxzsjD6qFRDmOPwqXNFaYHJ0gK9K3Dgq
 3rWLN6Rya2Xq4os+zdzczluTiyb24828/F0xwG08970jDUiwW/LApQHey9LIOjQI+ySs44jp1
 71hXRxXJHkJxtvRbvBTyGhLXmMtDF1neA2wnhIkEA0gicWcPQ3n6sgEdTOQwAVBpx6cLc2VvI
 VAOae4qd5oLvPBIcp
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/U1b7XtRRxqmbM7aHsgBi/5O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

migration_rate_limit will erroneously ratelimit a shutdown socket,
which causes the migration thread to hang in ram_save_host_page
if the socket is shutdown.

Fix this by explicitly testing if the socket has errors or was
shutdown in migration_rate_limit.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/migration.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..e8bd32d48c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3347,6 +3347,10 @@ bool migration_rate_limit(void)
     bool urgent =3D false;
     migration_update_counters(s, now);
     if (qemu_file_rate_limit(s->to_dst_file)) {
+
+        if (qemu_file_get_error(s->to_dst_file)) {
+            return false;
+        }
         /*
          * Wait for a delay to do rate limiting OR
          * something urgent to post the semaphore.
--
2.20.1

--Sig_/U1b7XtRRxqmbM7aHsgBi/5O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7FljgACgkQNasLKJxd
slhOBA/+K3em0d63PZm7XnAcSM5NOGlk12ALxCZtDcY9YZ+ZCYOh39bPwgQox0CZ
Aa5G+73OBTXcg2k6y+jBxlXyLSN42Ir7hUUftUZH69fUW8h/ZEMKZalsK4UMquPD
M+9+E9iGHkk8PKy3iQTAumDQangMA8OQDfmOOtRTtHhct0aZ3SmNVFv9ynru6nBS
+lICkXJ/rjRMZVlNaj7dABEy9EfsuCZDjNrEatvYY6jUEgsi/cQ06PESwVA6S2Uv
g1wmvvvnj3uX5t5/f+KIWwgaZ8HSDBvceHlAJrGbBWvLbLdLnwHDcQilL4YOWc4d
5i8A/SEIfAbPozatn2fv8VmLPAL4RtENB4WXeIK9bc+GwI5iQ9Z9pTOdxAp/2eCz
BWzPON58/skMGRiJS8EYZ4gEuLUI7RY+MGJxKaL5hgiNirbHR2f0DCRZ9mZBn43I
njHu2bYTw+srAoim+ep7KxgZ8+CAoNEjhtGznu/L9yBzvjuJCitgaFGlZigQI6sC
esmU5s88jfr2ZxPZJywGKIFmO5bjYKsPDpKsedI8D+8eHF7AyNdYjiTcNwQ3JKrR
13gRe/uVdRvtOptGkL2kcU4SB7kbSQQWWN1+7rVkABltb5p46jLrjibLQm1a1fuO
XCjv2E6cJ+jLGCCCUhDkStLBf5xTeAKpwvGf/PXDgmiba+AzNrM=
=YTds
-----END PGP SIGNATURE-----

--Sig_/U1b7XtRRxqmbM7aHsgBi/5O--

