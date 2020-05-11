Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B65C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701C920708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PM+Mi41X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701C920708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6ek-0004HH-C6
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Og-0000m5-EX; Mon, 11 May 2020 07:14:58 -0400
Received: from mout.web.de ([212.227.17.12]:60721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Of-0006u7-9d; Mon, 11 May 2020 07:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195692;
 bh=u51BuTx1QED54eOkdNUZ6No9sGilpZkM0a/cyn0RLZM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=PM+Mi41XqyRf0Mps1tW2ppBNGDsAgGX92BhYf2Js1Kc4aIRxmSgxqkNIJmZJYAU4X
 OjI53QGkgiLFOJy7x2VJfXrWyQdrM1jsdtHibOwbXKRjAHFbrSmal46uBiiyIOcGqj
 /7/jOSBjdYTcGGQwMojHgRgJAg6tNrHqLg1EvAxQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7usy-1jUEW13kIM-0053Tb; Mon, 11
 May 2020 13:14:51 +0200
Date: Mon, 11 May 2020 13:14:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 5/5] migration: Add yank feature
Message-ID: <df44e4789b50a0c4982bd233bf87b3276a73f967.1589193717.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193717.git.lukasstraub2@web.de>
References: <cover.1589193717.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3_s4nB_LcOHq/=piffqMOyR";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:sIDB7egPqlktd6cyGQsLqIj8ClOqxAx17eEkKE3zjei82usYfD1
 +WBv4ULQs3DpmxPGRZQQkf/cLHA7AUkkpWeWOzxTwfM6nkWOekIA5LiHXyjo8LofVwUgpDK
 Hxamufb+8yhkqMDcCJJIX1KPWBAAHXKsEzXt8vzFJDrydb4bh59WRgCF5UQoMyqGK8NfPHc
 eWG2QoTenQBMjn40TGc7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EGNflHftLwg=:i9EhMFoTqqy4jctjVzPTlI
 3oBgTPfyTSuDSs1Jt1RL0R2/5ZJUmSmNOjgRFHia07FNE2Wpo1+GwaRvza0wnbp8oeChSlkUV
 RIPJI3mWzL3G4jwdm0DROY4KbG8lNDxecqeWvQcRPhPRLecXUriwsQsqYw/CgipqMmUHMVl19
 8O/yO/Qy7OH+LJftVIAqd8jfwAmfs5q9U2Ot7eSdV9GBf6jbMzsaOwfM+woHu5sK7FpzQk3ax
 HFdUjFKk9vas47DYUhAXiBX0aFG41e45aCPE/BA8aCNqcku6CBp534zgtdn2A+RYVgFwz3eNU
 RODIZrKgPU+msNxjU7IV4E9VhgJWP3hwAOcHs4xWOsDjMkTq9Npkly27y6lR3d/O3hD81Pt0e
 K0RlH3K7/obh8BTcXC/p74cBnH0O/DA+QZVoCJI5sn6U4i101d5Oa5k7/VnLEUmsN26jN9QYr
 mgH/xDAAWhGaUSZ73qmB/ZBxuo6sngW6Lf/cSjraU9K9nKwueS/fQ66Xu5fYdPiBnyi0yYuRm
 mSKvAhOZCGnS1NsJxHNwjjWq2Gbmhh5bWH75UKiRv9cgKbUkhOiV3VUJ80NpNGPAnK1vrUIWm
 /9HiZZLn+L8fsZ2Pck1zY3Aa9UKVO88Aipaq/aq/3tksjmPUSs6pGZshpiAKWFlDLCrdRMHkF
 Sm/1n7Yjp9x39KiGEYxOsWKTbkZw7IgSqlPXIG1Ecyo7764BOChZQkiOyA4iH4bNwKV51jVur
 E2kyAW8v+wgWvp8kj4Nl0Ll2OeoAUqZCf5k/WzOC+tqe3mWQmb9N83URu6epO7z1wMhsRY9oW
 +1UHuTzFspnttjWYjBfZbYjuz46s3RHpGx18U5t5W0c/ODakj94gI0EBKaIaqZdYP3FgQGmsx
 BhE1hCG+yaex90DhOeyIcwiKgRj6VKy3WD7A8DTbxiUM+Al/9YchAVA1WevhK8KK2SMSw79x6
 kEe+0S/NqoMKOILXHinirJ2Koxfj3SPSIbImZCPBvYXmbClQ4IUomwywO7XE9Rd1lzHrr/eL/
 qARAbrhcF5kBjSE9wNH2nSJttNtHOoDJ1eZcgJwaBsT/bG3IMlNvBgVDA5QtvoimfVVYIqjIl
 gyFEND1tmtDEA7nYr6S/ES0FWm0m+T3TbDWpy5pQCTNw66YxEV6i+Z/Qz71xjIn2ltZvtmmia
 q8yvznPMm1W/Ln/uwW4+qJttsV5RXKRMCq2j/hN/otg0i6QDQJZOy924e43iJyqASlsNWwCaK
 ONtxUX5iqQnmads6W
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
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

--Sig_/3_s4nB_LcOHq/=piffqMOyR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Add yank option which is passed to the socket-channel.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/channel.c   |  2 ++
 migration/migration.c | 11 +++++++++++
 qapi/migration.json   | 17 ++++++++++++++---
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 20e4c8e2dc..498af99104 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -35,6 +35,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
     trace_migration_set_incoming_channel(
         ioc, object_get_typename(OBJECT(ioc)));
=20
+    qio_channel_set_yank(ioc, s->parameters.yank);
     if (s->parameters.tls_creds &&
         *s->parameters.tls_creds &&
         !object_dynamic_cast(OBJECT(ioc),
@@ -67,6 +68,7 @@ void migration_channel_connect(MigrationState *s,
         ioc, object_get_typename(OBJECT(ioc)), hostname, error);
=20
     if (!error) {
+        qio_channel_set_yank(ioc, s->parameters.yank);
         if (s->parameters.tls_creds &&
             *s->parameters.tls_creds &&
             !object_dynamic_cast(OBJECT(ioc),
diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..b6f2f82dfb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -814,6 +814,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error=
 **errp)
     params->max_postcopy_bandwidth =3D s->parameters.max_postcopy_bandwidt=
h;
     params->has_max_cpu_throttle =3D true;
     params->max_cpu_throttle =3D s->parameters.max_cpu_throttle;
+    params->has_yank =3D true;
+    params->yank =3D s->parameters.yank;
     params->has_announce_initial =3D true;
     params->announce_initial =3D s->parameters.announce_initial;
     params->has_announce_max =3D true;
@@ -1364,6 +1366,9 @@ static void migrate_params_test_apply(MigrateSetParam=
eters *params,
     if (params->has_max_cpu_throttle) {
         dest->max_cpu_throttle =3D params->max_cpu_throttle;
     }
+    if (params->has_yank) {
+        dest->yank =3D params->yank;
+    }
     if (params->has_announce_initial) {
         dest->announce_initial =3D params->announce_initial;
     }
@@ -1472,6 +1477,9 @@ static void migrate_params_apply(MigrateSetParameters=
 *params, Error **errp)
     if (params->has_max_cpu_throttle) {
         s->parameters.max_cpu_throttle =3D params->max_cpu_throttle;
     }
+    if (params->has_yank) {
+        s->parameters.yank =3D params->yank;
+    }
     if (params->has_announce_initial) {
         s->parameters.announce_initial =3D params->announce_initial;
     }
@@ -3623,6 +3631,8 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_UINT8("max-cpu-throttle", MigrationState,
                       parameters.max_cpu_throttle,
                       DEFAULT_MIGRATE_MAX_CPU_THROTTLE),
+    DEFINE_PROP_BOOL("yank", MigrationState,
+                      parameters.yank, false),
     DEFINE_PROP_SIZE("announce-initial", MigrationState,
                       parameters.announce_initial,
                       DEFAULT_MIGRATE_ANNOUNCE_INITIAL),
@@ -3711,6 +3721,7 @@ static void migration_instance_init(Object *obj)
     params->has_xbzrle_cache_size =3D true;
     params->has_max_postcopy_bandwidth =3D true;
     params->has_max_cpu_throttle =3D true;
+    params->has_yank =3D true;
     params->has_announce_initial =3D true;
     params->has_announce_max =3D true;
     params->has_announce_rounds =3D true;
diff --git a/qapi/migration.json b/qapi/migration.json
index eca2981d0a..ad9e431a8f 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -623,6 +623,9 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @yank: Shutdown the migration socket when the 'yank' qmp command is
+#        executed. (Since: 5.1)
+#
 # Since: 2.4
 ##
 { 'enum': 'MigrationParameter',
@@ -636,7 +639,7 @@
            'multifd-channels',
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
-           'multifd-zlib-level' ,'multifd-zstd-level' ] }
+           'multifd-zlib-level' ,'multifd-zstd-level', 'yank' ] }
=20
 ##
 # @MigrateSetParameters:
@@ -747,6 +750,9 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @yank: Shutdown the migration socket when the 'yank' qmp command is
+#        executed. (Since: 5.1)
+#
 # Since: 2.4
 ##
 # TODO either fuse back into MigrationParameters, or make
@@ -776,7 +782,8 @@
             '*max-cpu-throttle': 'int',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'int',
-            '*multifd-zstd-level': 'int' } }
+            '*multifd-zstd-level': 'int',
+            '*yank': 'bool'} }
=20
 ##
 # @migrate-set-parameters:
@@ -907,6 +914,9 @@
 #          will consume more CPU.
 #          Defaults to 1. (Since 5.0)
 #
+# @yank: Shutdown the migration socket when the 'yank' qmp command is
+#        executed. (Since: 5.1)
+#
 # Since: 2.4
 ##
 { 'struct': 'MigrationParameters',
@@ -934,7 +944,8 @@
             '*max-cpu-throttle': 'uint8',
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
-            '*multifd-zstd-level': 'uint8' } }
+            '*multifd-zstd-level': 'uint8',
+            '*yank': 'bool'} }
=20
 ##
 # @query-migrate-parameters:
--=20
2.20.1

--Sig_/3_s4nB_LcOHq/=piffqMOyR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65M6oACgkQNasLKJxd
sljUmQ//eM1QHLxHZzIriLeuwaXssLezo72VskdClbhHEiCi0lelZVAuHxsp6XMg
IX/qth5RBx2lsmQD3KBdxGUAwg8eLTDFtchhLt5Cm404Bs7Iwhngob5ZSGRXt1aS
5+W/77+j24f4sp8Kyzt229EqZKkJKHfpzrDlQbnZ39STVDpfkgb4qZJASxihtbdC
s2aMrhkku+wVJgkmLTJsij1Iv0mmHlR5qm+PUOpKhhtxRdJE/SZ3huGlLk2BT85u
viQ2xoTF3ra6hhgIbnUDNllfNMtdbnz1wi4jkvEHBbsTlbgnQCQ6FWu9kefoE7Bo
TTA5laFmE8Tz8Pzq7hUN/+wCtuGbAM38UTCwdygqYFl7sFw2qt9kgiRLiJflsbtt
L+wpdgRx62lNz6EhMgp+GxzrSPEZqdmYoE9ACLIVmS6YMiI1PysjGhrsqIrTwjte
b9trW+lAFWSCU5fPLYswyLo8bBFhkDMmbWDHCNyavazm3tP0iDxeOYVQc05MrHan
0pFQqakGUhxn9ushRH3ZIzn7RZ5ht9tBJtaPppr/92E0Was8ibvnbiND9tdvXQQy
WuDqG3eDwYJVs1UDkz7t0QT1jsVVDh8GQT5Ae1EiuVehXdd94dmQsA62qSNcL/z6
gn9m8ZJYey/0DJoDJrsirDh0M4GWhaZncSQjEa9TBVtU6v1bXvc=
=rzxV
-----END PGP SIGNATURE-----

--Sig_/3_s4nB_LcOHq/=piffqMOyR--

