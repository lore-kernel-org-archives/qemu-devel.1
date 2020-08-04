Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58216C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F22D2075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GsWGlf/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F22D2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2uWR-0002vE-Ng
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTU-0000pu-PG
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:16 -0400
Received: from mout.web.de ([212.227.15.3]:52061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTS-0003Zi-PQ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596538005;
 bh=4+fu4YF7JnIr5t2XhnLwYWVOhDFdULGoP3KaQ0BaBYs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=GsWGlf/UMH1GQyEzvOyZuH13zh3zyGIA9ZCzeTYka/g4xO7P3blCrr5bbyEofCjeP
 yk3GKk/2GNBqAepwbwhUXMlBKoV1WP7elKCZZEdn1qAW9M1PY7QE11Rbec+dFzOctx
 MNue1RwJABzuYZdde9HtsEX8tkAMgjubVrYr0+BU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N62yi-1knFjJ15j6-016NQ7; Tue, 04
 Aug 2020 12:46:45 +0200
Date: Tue, 4 Aug 2020 12:46:42 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 1/7] block/quorum.c: stable children names
Message-ID: <5d5f930424c1c770754041aa8ad6421dc4e2b58e.1596536719.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596536719.git.lukasstraub2@web.de>
References: <cover.1596536719.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9FVHlSd+ztW880nGUir=JAT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:ZUIWubNMRMn3fQD4t3xE6/tLITlKvRmaOvCQQXcjzL/dxBzdaO5
 /EkrjbrX6o72wT0bChtH8UVyztSPyxwzI7PLpxqZ++o7Y7Q+fZq4IyATqjxNCZTUQrHDH6s
 NInDEEm9QY50PBRP7UAfCCpxyTAp/94i1+cQMdkQYq6uj4hqS+qkQ4FEBKMy3sz4l9H8a/T
 JspvVCppH2EDVxhNbnU1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dibcz/EU/NU=:MCNU3EN/nqqeHasMecoFFL
 uU0BJHXZ+rk+uoLfbqGRCkdri3r52S2x7ajupLWnSm3InsDGdFR+iGM9i32eeeaudBk9MEEDM
 EXkOeHoe4U5/IH6anLm5g4l/0NgxSEDIrXiULBBJHMT49ys1GL2OYSGX/zh9z9NYlVWc8VdbH
 tDnL9+t5zh1QpbDFOBgKVWzzzV22r6h9SQzOGbzrbTwjDNyksZ9MC54EptZ/GMA0VH02wxgLy
 /RrSHzLgqvM3+amD/du93qKBa7xNeOkVJG+8BljdlIw518RtD+jm7UMwrZREcXIHwNRieqoAi
 8uQ+bK9V7HBxOnV+AwLdgVFlbc6odoY0iVcHx2J5o59NXEy6pbamfWI4Ty2fmq2uWp9bcAYdQ
 aEuRMVxzcC0Rc1IIAEiRZIsPtV8W+Jizzz7zxsh1u23is73AfjNU3QkiL9HBC9J8ZjgfWW088
 0Wx5zLE2AnzQMAKvNCYdiWov04zmMHMLNsr7mrZjlpQWCRNJXrRnDVU3Bz0NxcC8K6htzdZqg
 +AHJ0fjW7tM425UqhCYXnuvY/JtNdS+mGmZ4ki3ieCYBzYXhb0c824mHS1MK7XDt6BO+93B0x
 Lx2bD8rBY2q15gYIomS9G6fPqrthg2DEhfMaJo1azi6XiTVoF9w46g1djcc7Pb6cqUSm/wTGC
 C8Fbhc9u0qajZhUZCLc1wbRLqNSsuo4NSaf8w4MO0pFubGDXS8csjOhd16xfv5Ca6M9s4yPCg
 3gaFnfHNqPuMtxzFub4zVcTbahbTqv4QbJdkZ6tuYJUYzTbA9+7Re+8f+CRnjZSDT5EFgFaDo
 k38+ibFiZd/N7cRFsDHRbmm9FerOl1yEWQLg5+hzVlOWQiZ00Dn/wGOCTf7CMYo9mB1Cmd5qV
 RZt9JLHw9NkjLzF4mq7sUS1UI/tPWUjEMBZ+vUUZ+1WC8Sk7HvJIQcIiB5BTm+5GgC3b3h4u/
 ai65BLY3CIKVnvoOK/yWXgSiUkBl4H4g3fW+hcbcO9DkE5pS3Xif5qZKzQM469G7t2gQ8aKSa
 Lr1QAQKMzU25+VlGE/ZhRmdojfhkGP9eJqYVRGa4sigCTSJsGVYMt7k+86b3EgCWoUbfwRS7z
 mkgDmF3HOMiLzvAnAlEYQpNhBKltztlBOM8hgY0myqjTdnqFzVBqfJR1mnL6uIelH38uY86UM
 88xz9QrvZctdu5qZQnoyGpYcQMdHV0Eu4cZeO5Cic+3ydmc51ZDRjDCi1wRsEe1reWqhM1fCF
 1VUjGNEYvMc2UMIkpF0U3wiNKdhEv5oHBLKwQ6A==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 06:47:13
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/9FVHlSd+ztW880nGUir=JAT
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
index 6df9449fc2..e846a7e892 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -29,6 +29,8 @@

 #define HASH_LENGTH 32

+#define INDEXSTR_LEN 32
+
 #define QUORUM_OPT_VOTE_THRESHOLD "vote-threshold"
 #define QUORUM_OPT_BLKVERIFY      "blkverify"
 #define QUORUM_OPT_REWRITE        "rewrite-corrupted"
@@ -970,9 +972,9 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
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
                                          &child_of_bds, BDRV_CHILD_DATA, f=
alse,
@@ -1024,7 +1026,7 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
 {
     BDRVQuorumState *s =3D bs->opaque;
     BdrvChild *child;
-    char indexstr[32];
+    char indexstr[INDEXSTR_LEN];
     int ret;

     if (s->is_blkverify) {
@@ -1039,8 +1041,8 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
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
@@ -1068,6 +1070,7 @@ static void quorum_del_child(BlockDriverState *bs, Bd=
rvChild *child,
                              Error **errp)
 {
     BDRVQuorumState *s =3D bs->opaque;
+    char indexstr[INDEXSTR_LEN];
     int i;

     for (i =3D 0; i < s->num_children; i++) {
@@ -1089,6 +1092,11 @@ static void quorum_del_child(BlockDriverState *bs, B=
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


--Sig_/9FVHlSd+ztW880nGUir=JAT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pPJIACgkQNasLKJxd
slgdSw//W2oYDyDLbU45jDNYrwMYXTAuUJSCDUVWMLEOsML3nl/LEc/6tVeRjBBm
grYlGRoVvE18dt0nQzc+S3z4l0896pxL23PCt86Ba5O4ReKwvPn07OkyIWAfRYyX
fwr28NQ+ohp5mAm8R6M+rCt+iVW9AXlBojvVMoBvo2a6y877RjqvtUPErxFVg3Xk
oF3OaP9cxdfy8gCN15aAM+J1kvxUkncpUTbWrl2cTcOqRkHkRxZSY6hIhJZ0/QRw
zmfD6gcgg+g9dbYIjBQnrdD8NGfWO7eT7nfMpvWm0hNF/JwepnChsBfjq/xTZSYW
jd61yaTOP0IDm1kX4etziXyM57Zq/BK7Gli77JtWImYCF416F4qz1OB97mMZfjKq
MNjACavRQLhSIvBAvH3ppgdQXpM1U5gZdRMs8+JBT3/B8j0h321k/jaGuYuZzwDV
7cNIPKvipbtTUk1iMWrYFlPi6RUKiBxpmBLrWlUj+IOAzucENJ3yOn0RvfSI5W6w
tC4VJLgsunOPcU2pWnNLQaDH3PbNnDHKwY8lovXlncmr3DvOx/Ni7z3kFLq4Xx3K
FXiMjFrY1eGcTEVjsnBwU2tzOTkslXJ7LbYAmSIx8JatbBIA8piwSsHzMBzXnUUL
TI0lrIlmnY3rkgOeEcYw4XUrl8nnLpB6Byhob9dtjus1HVlgoNw=
=g0jb
-----END PGP SIGNATURE-----

--Sig_/9FVHlSd+ztW880nGUir=JAT--

