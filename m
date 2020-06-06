Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E806AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80CF2067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="YeVFkuTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80CF2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheOv-0006lI-SP
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheKu-0004Mi-Ta
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:32 -0400
Received: from mout.web.de ([212.227.15.3]:37187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheKo-0005aK-19
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591471074;
 bh=pEB8U8yNVa9GJCfnqrcey1P+mvKxuLB/fVnqTRIanMQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=YeVFkuTPJx6ohBJ8PDS7sMdL2aHf4A7+6JoWcGIfmDxcrXcDpqVYipaoxW7TtqY1h
 695QHiuhdIT/AtcIFjmXvecEnb4s9gTZpKVJIXUrZ5IVbpqvHP1/GaV41IQTH3EXZc
 qfPISEQPRJ0byXKIXSeATdWOX39Wh70HdzYGvkLg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lpyh5-1j4Cuc3RcF-00fgp5; Sat, 06
 Jun 2020 21:17:53 +0200
Date: Sat, 6 Jun 2020 21:17:51 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/7] block/quorum.c: stable children names
Message-ID: <6775a26cfe07bea3481ccf60ea7ce464d1b6c41d.1591456338.git.lukasstraub2@web.de>
In-Reply-To: <cover.1591456338.git.lukasstraub2@web.de>
References: <cover.1591456338.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M8mPOhybZk08f6K0+cdPz2Y";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:x+Bhnza/LWN/meoyccth2M9MnpWy6xVZrIkpATAr5iPR4A2ccMH
 szK4pmZJf4qQP8wksxSLFrWc5YnAZThkFHTn6Id9vCNpr3RTgkLox1Yn6lODO5pBhY3Xlps
 JXl/iiDvGX5GabJghk5MHG2vUqEIgyLYjVfLy+vBN9RPIIRRkIeib3sPZBD17wtCSUe5va3
 W0w3jrsGmaJ+KboN9RJVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uq+01L1sZdQ=:bFQsEj/u8Hom3WZHSJqWmm
 orWElE1+VFGrw3lfTvrCrsi1CukqFVbUTRkXkQn6vaWsWBO/ZPNXP2awuVaxt/kJykH0q6+pn
 1h4tDYgRjBa7SjSbv481rzyw7Of/IkaIoEE2V3hFsDk5+rkYlhrhJhjC6sqg2EvaM0raES88j
 vbticb6cUreTAqCtiTUz6JtjOMDoo9gTQwlHqvTcyiN9D4JUmvVKnioMfzf3ax5wm2cKWVvf2
 78mREKQbRVdQPUB/Lef60rXNyDW+KTfRGbKefVtQpWXGp9yHpaGOqypJvAB9c77eLaQ+iwbvD
 EmACK/bhu6s0HUam1xVLRx6tEpald7OjvkjcZ8rytkxrzUUO1K9il4VcMRL61reX//L0jyX5U
 UPTQFmB1bEkSA6ptpyKPsbOzySbY9fisaoSw9pq4Wdi64MNkRffzVIcLrIoTFtaHPHk0fw1pM
 6LxY2+Ppg6mMIYsxV2peuVFL8YZi5nuj3e9mWHDg7uJHaCix+N05Hk5I0FgtsoOQqrbpEGzzE
 +zTS8GeLe9yNUljlnkxFvCTmOalPXBXM7sJOq1hySNaYhRiM2kSXQ7+ym2abHn+IfD1K7a8un
 R3PKRKRgRkgieKPpIOT7S5Y/8glru8FbSArRlkuphtBpJEez4t4LI60qjoFnwYBLjDO1YkF11
 d7FvIWeermeqg7yQY3HIudRFlVjFVesFRv04cxo1VTaYH/cmjKd0I6cAD5EuP6Eth3DjmF43I
 T5APUe2qq6/KdGWujtm/HQHZbOzdEO8WVFyLl//0iviAqrAstdD30so1kz+jr8+lMLJ4u3QLY
 jzM+MvychTjWQRzTfC8pC3/WaEbZDkgJvqoRynGkt0oTrE2hiowp/377ABErfQqQILnef40lC
 85EFp1DjmDHEnxt0U3ChEEjb0zcXXCd3rtr+wcb6tcTGwusmzlP3L6VkUKBHLKlDsoaVXt00/
 LDHqEm6f3P8+CHYo2OF6vtDYudGbCNh0TkRpPpRpsFAqsf6zo5vyDJY4kPo6z9bUIxXbko1Yb
 TVQVu1mceWNyNySuQMb/m+jRrGkOsBmloZo8GJ8Mj1EXtGefXkO2Mbm1CE3PGV5X22kDLJWSP
 tJkoi8eZ1UBrdNHAiY37NC+g76PC+uHPrePRwwi2S7kF0Xcq5L3qW5L09woGFFo7xVDXg/11X
 NRP6yE+InvQr3UaICC8foigef6lOmPRnbNcMsPQRiBOzc0nlDlw/+7Hpt7/n5gB7pWq/j3yfN
 5ksQSBU4pbzkB/2vj
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:17:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/M8mPOhybZk08f6K0+cdPz2Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If we remove the child with the highest index from the quorum,
decrement s->next_child_index. This way we get stable children
names as long as we only remove the last child.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Fixes: https://bugs.launchpad.net/bugs/1881231
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 6d7a56bd93..acfa09c2cc 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -29,6 +29,8 @@

 #define HASH_LENGTH 32

+#define INDEXSTR_LEN 32
+
 #define QUORUM_OPT_VOTE_THRESHOLD "vote-threshold"
 #define QUORUM_OPT_BLKVERIFY      "blkverify"
 #define QUORUM_OPT_REWRITE        "rewrite-corrupted"
@@ -972,9 +974,9 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     opened =3D g_new0(bool, s->num_children);

     for (i =3D 0; i < s->num_children; i++) {
-        char indexstr[32];
-        ret =3D snprintf(indexstr, 32, "children.%d", i);
-        assert(ret < 32);
+        char indexstr[INDEXSTR_LEN];
+        ret =3D snprintf(indexstr, INDEXSTR_LEN, "children.%d", i);
+        assert(ret < INDEXSTR_LEN);

         s->children[i] =3D bdrv_open_child(NULL, options, indexstr, bs,
                                          &child_format, false, &local_err);
@@ -1026,7 +1028,7 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
 {
     BDRVQuorumState *s =3D bs->opaque;
     BdrvChild *child;
-    char indexstr[32];
+    char indexstr[INDEXSTR_LEN];
     int ret;

     if (s->is_blkverify) {
@@ -1041,8 +1043,8 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
         return;
     }

-    ret =3D snprintf(indexstr, 32, "children.%u", s->next_child_index);
-    if (ret < 0 || ret >=3D 32) {
+    ret =3D snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_=
index);
+    if (ret < 0 || ret >=3D INDEXSTR_LEN) {
         error_setg(errp, "cannot generate child name");
         return;
     }
@@ -1069,6 +1071,7 @@ static void quorum_del_child(BlockDriverState *bs, Bd=
rvChild *child,
                              Error **errp)
 {
     BDRVQuorumState *s =3D bs->opaque;
+    char indexstr[INDEXSTR_LEN];
     int i;

     for (i =3D 0; i < s->num_children; i++) {
@@ -1090,6 +1093,11 @@ static void quorum_del_child(BlockDriverState *bs, B=
drvChild *child,
     /* We know now that num_children > threshold, so blkverify must be fal=
se */
     assert(!s->is_blkverify);

+    snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_index - =
1);
+    if (!strncmp(child->name, indexstr, INDEXSTR_LEN)) {
+        s->next_child_index--;
+    }
+
     bdrv_drained_begin(bs);

     /* We can safely remove this child now */
--
2.20.1


--Sig_/M8mPOhybZk08f6K0+cdPz2Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b698ACgkQNasLKJxd
sljUIBAAm25oQ6tT5RXuR0padzEyjL99y5uBpFGTTwu+TpBLiJKXEaTcsUK0Pm8/
P1pWqk+0lArXb5Z30UC5yguy1xGjSkOJ2jre9q9dJSil0Xil0eWh8ZG9bgjOvSIk
b9+VK4NRYtryo1JAbd8yKLwq23V9FvqoUkAmrjRJTJbMLbrCSyNrY3qR3jYd9YWb
t6MbhnCAlA8qkt6uqGYhZWIKWfSXbshYdFxh/ayiIKQd3I20zknINOStDmDDa7Yb
RHM7KX4WvCagjLrcQKCYtpz8K9nWhX8idhvhlRQQDC9iRFn1ZKxiOaaE7+81PCWh
oAeCaBWWa7dHDNWd5GfMw+vx9+RI4WE5qM3ktB0ZJuxDlyXTPRLWly/+BuGUuJ5q
Lze2EN+KLFhuF9+0m1RWseKw5trgVpjIy1f6muP/PXmckQD24uQoJnDQ9P8jtWoN
a+Gjuf78irn1NELoaOT5QXFl9AdzTL3IUE36AAE8+zGNOYwOizW+8nf/MMl6kmJj
AqUR52CKIvjRzaXbIgF6q2O4sRW2KFc6EcuqxZni8hYZHhXPdL2ViNHIVAbq63OW
K08EXEhcYOHohPvk1nCaQlVFd8ZlKT9bqdBOZbXZeAnSYnPtGj6OsK1z6vXaCuMJ
hbl3SbQ62dWOl9DPkSagwLYP4HxBpViDVTKQuxgg1Xb8Aze7edg=
=3jkG
-----END PGP SIGNATURE-----

--Sig_/M8mPOhybZk08f6K0+cdPz2Y--

