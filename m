Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D21320746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RToi7df7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D21320746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7bu-0008Lo-2E
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7Wo-0006BP-1M
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:26 -0400
Received: from mout.web.de ([212.227.17.11]:35071)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7Wn-0005xt-6W
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589200017;
 bh=D/TPeLNov0t6rmkFP3E5KzxL/A8EmZiUQlUmOgNwPxk=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=RToi7df7ENuhfEuHE+5ZtG+4Aa3g1p/xmJ730tewZIYz6lrkBYPkIjvCnZjbOht40
 eDWFuVPH2B+DaM1n4xUs4ae50zT4kdLN3c6LntxSEC3NsPrfjwO2c+Wie5uYlTKsTk
 eDGfPPq2olTQ3aqq7b9UB8av09po/OTZ7H0tPEPo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lj2QM-1iyW3a3W8s-00dFOX; Mon, 11
 May 2020 14:26:56 +0200
Date: Mon, 11 May 2020 14:26:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 1/5] block/quorum.c: stable children names
Message-ID: <9df6b3723ec30cb749ceaa555d82a29a6d79496d.1589199922.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589199922.git.lukasstraub2@web.de>
References: <cover.1589199922.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZDbrF3WtSLAYs8zlKZizAiT";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:TIVVxpWm1nKnNCw1LaVnWP+BopzU4pmXBGarktqhyf4VbL2PC1h
 fX0lSGW74sPyoioVMcuboJRiUuwmLGtga/dGV+fvAvSAlqTFvuamSSCsMI/rECblSUgda0m
 HWIHAkEoFD9QxzTyMmLa3jmLRAY+NB06XIjLJ3DA5XGQPTpqkfhHyoacpmWQH4XRvyqDCTP
 QlAGwS5V7paOlx7lvDDWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jMQYuGskO74=:QsZjYQRoZhUU8ABPzPUtec
 omlYvTjl8TPNKEwLXvN6EhEaeKoQdPsAUwqzYgnWB1/4mUMJYG5CGhThDNLNyEpGFqErr9cEZ
 IDM9vqG4sWFmXyCltSRycVEppt7eK69k/ZfkUIvXdbn8Jq8FFitRW5NGLrW9qkXkkRdwXsos9
 Uaq9ygBp9W5bpju5vmHMSbUHaB1m/FZXOZyS5JdesYw2PUcm7i/5gCDw4LsLoi9oIYEtHqtvD
 kD92rmqJxNn/aDGWzDw6MqdRfv8YnYAC5jmI/zPH0Qj7tVYpw2HcJBjj1oOyF3qA0cF91DAPY
 U9AJhfDQmzereH3OaO0MDyZfLp0mswV4e8GqOjNsJEK4Q9t+8OD+vKCfXWxYBQLI1au17PATz
 cNJH1Ln2X65a+YHyYZsts2xMODCTUeOXuoAqul/gy2I8BrQ0zjZV4ulg/JHVQBGE8AzqAeULQ
 NNky8E7MJP0wKpMoWfnzMuixjkAOpkONgWu4NtpZznXGbmDTJHzsZxyrENqUXJ88sUXhsynTY
 V2WGJ2UnKY+j6huoTq8fn38VvEUMk+RyON2tHY8plcJTUQeCPfP9zu250DDD8GdgLsfJxZ9UD
 /9Kaw4y20uJGI/1xba0zhLOtdwAVoMBvGGxuKYQYcNsJy6Ws0MMdbGFpYkFpO+baX24ZOBDFs
 Rx3QciJ7DfaJeVw8rXcPgq94tDjqxFRASIbJM2Fe8xyS0O2pibgTcbGRLcLIPdVBC5eCZBkoj
 kwhGqvsNutYoT/c6SSlTcI8o4T2T/jHrd1wuTcIi142A3h3D8OSkljabcyrCbElD4DdyrQ+qP
 vH7acm3HNnwExF+tfsQnzTG/rkX2YG8ntB5Tq78o/W9FAWVVVPVv2m2Ro/jWuzhO1DgsXmFqN
 tZRnpXpqRK9CGDA24B7wTv1aZB3h/RkYZ2HKzPXkelio5TXrR67wk6PRlS+w39X/3qGbFDFP7
 295SHdXqgYOA2QNi83GCMNEiI1V9snRtUPc1WL2+BxhsHlvHiqBY4KhrcmgvcPmk8Cm/sB3or
 UTUuiiGdcL4+63eds020bsN649lA4QLj6BI0k3uOYf8iPH/nMAaVIzPYoqJNx1HQ/k30bxjVn
 YhdjuTAZDmtx18uLy7bBTkwak7zH78JjTGU9pWUrcHbdpgp/2c3xYfRKYvTZxPbOfp+m/NwOz
 Ejkf9LxQGQx0MdBLGzbvtsXBXFj3QFGAMtln2yUmihCalH5zDhbnOtccevbGublD4rAdL3/YN
 PE2J8UK+PBO3sW//s
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:14:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Zhang Chen <chen.zhang@intel.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ZDbrF3WtSLAYs8zlKZizAiT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If we remove the child with the highest index from the quorum,
decrement s->next_child_index. This way we get stable children
names as long as we only remove the last child.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 block/quorum.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 6d7a56bd93..acfa09c2cc 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -29,6 +29,8 @@
=20
 #define HASH_LENGTH 32
=20
+#define INDEXSTR_LEN 32
+
 #define QUORUM_OPT_VOTE_THRESHOLD "vote-threshold"
 #define QUORUM_OPT_BLKVERIFY      "blkverify"
 #define QUORUM_OPT_REWRITE        "rewrite-corrupted"
@@ -972,9 +974,9 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     opened =3D g_new0(bool, s->num_children);
=20
     for (i =3D 0; i < s->num_children; i++) {
-        char indexstr[32];
-        ret =3D snprintf(indexstr, 32, "children.%d", i);
-        assert(ret < 32);
+        char indexstr[INDEXSTR_LEN];
+        ret =3D snprintf(indexstr, INDEXSTR_LEN, "children.%d", i);
+        assert(ret < INDEXSTR_LEN);
=20
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
=20
     if (s->is_blkverify) {
@@ -1041,8 +1043,8 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
         return;
     }
=20
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
=20
     for (i =3D 0; i < s->num_children; i++) {
@@ -1090,6 +1093,11 @@ static void quorum_del_child(BlockDriverState *bs, B=
drvChild *child,
     /* We know now that num_children > threshold, so blkverify must be fal=
se */
     assert(!s->is_blkverify);
=20
+    snprintf(indexstr, INDEXSTR_LEN, "children.%u", s->next_child_index - =
1);
+    if (!strncmp(child->name, indexstr, INDEXSTR_LEN)) {
+        s->next_child_index--;
+    }
+
     bdrv_drained_begin(bs);
=20
     /* We can safely remove this child now */
--=20
2.20.1


--Sig_/ZDbrF3WtSLAYs8zlKZizAiT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65RI4ACgkQNasLKJxd
slif0A//eBbTHuzq4a3GtIT2Lid2N6ET3RA7RQTK2POcO9Iu96D9UHMNBZri0Zti
69kXkOO1ED7fVh0wIeviH+H+zl9+DZcMlN5zUYmaixlrdA0I7ycTA6qUpbktcwUW
rV+VDHVvBS1T4mtjmHezIz7knRpLhpQceis5RgG3xUogKcI1F3t7PqcijdVRoFOR
IbcW4Fe4xdr9jOah0/JpEv9uIbHsZXKBnLTwXJeEpMcZvbUzMMzCRJZ2Q5QNfcsC
WxCQrubUxXENuVKlMRA27M4MGUh1toWkolbTnYaiaOYiFrmwnhz70xCGAcDJhlt8
guqetZciH9f20fp+z/d0yINvU8G+XELFlh5JKpPpmA9ykcp4gvPj4zhpJ0ercg/J
GYRzyKWUJdF/vIdsnr2wR253DHmM9/8VK7gVPDyQSVS3TeSn0auX6F5YVFO5dcug
P56aPyFZ97Pz96OOjobpA6u/tUR3rpTgTPq8Sqx71xI0JBvJJZfwaddxGzz+yCQ8
etlp73DXCRCdga1PEQw5NXfk+QKws+tM1Gr1Pmuf6LZGe6i0LktwbDyvzfFwYYYg
g1mU8sY9EpA7r5DLHKMflaWcQy6P4G3O8OQiKl9VMdYzs+weA2nZJaFhnyTeRzrg
h94LjoNgUhPzKKtCkZ+iiw+bTU3wXceyZaCjw0+VUQCrI0XB+Bg=
=iZVd
-----END PGP SIGNATURE-----

--Sig_/ZDbrF3WtSLAYs8zlKZizAiT--

