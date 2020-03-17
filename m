Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E89AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A2F20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HhOwkesu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A2F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEGF-0004lQ-QY
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxr-00031M-IR
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxp-00026b-9w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:07 -0400
Received: from mail-he1eur04on071f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::71f]:1794
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxo-0001d5-W2; Tue, 17 Mar 2020 11:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0ZcAaXrXGmMovhF7rw/HK/NbPgSFaajvYMlK+ZepegGmLa67yIFzyKnig6eU5HVjIvZySkjYeKdGRrJQmcxWJJM6mmfvEWvcwwPpd/qZe3kjfr0HAeMVJ+qkAu872beqcBDFvb2W33lgj8VgNhxGEbZDQUEcbiQWLkJz53UySW1lKRUCliipdRm5WC9yhAqwpNAJgwN3BxIDuvDnGcfwrrXYQL80tdahwfjA7wdVwQovJwS3Y47/PHQlEkyLeeHVJFJGAIEjUr95BMET8deFaynss+vlGnC/3TxHmPNJFD1J8ec13CUZI9GKg92svFpXJg9SYCQaVenYFjTGtWOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7uKuyhOaN/R2LP3MIYa/l3K/LuWZKfyTBTfXvt6ofs=;
 b=n8yqpw0U07opdHNmo44eWEiURhtKw84l84FcD10lnnn7okoOCnZSF/Me+wfM51RqQoLeh++S3BxcC6DbGl7yWXpbpWQVGl9iO6FheSYEUnnTQgGHgW3MLDuv9RY9SOYfrh+GHfIhQNNjVe0OBi3b4kSQBMNkOITNgMJjVBP6BzXALYGtU8uKDVTlYGgYwNC67LUpHkKZ2oG+iz4sHNDdaObxNax1QmxO0cBWjjnqO79Drcm5Pv0hci5NiRrxmGQMs6ikWDgSJUUGvFp8h17/nK33ihCFo9Sda/iZFHVhgej0hZM4D8Wrx9/0qXEKzP2R+78W91Vc6ZwxnyHjwZfu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7uKuyhOaN/R2LP3MIYa/l3K/LuWZKfyTBTfXvt6ofs=;
 b=HhOwkesuPK9bGgy02+t69wII3NRZRT6vjYCXZrSVUNj0jcGb8Hd7C4ougpakTknyQfeZUT+y4hIkkAKEHLvoqG1WqGWGQvwnBia8bcsSfEHtEV/LROki9NNg7XwzpcWzK/jNEQr7teSaCgmyMX+I+V3LCaCXUMrlpMUdKoEJzRQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:17:04 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:17:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 8/9] nbd: introduce ERRP_AUTO_PROPAGATE
Date: Tue, 17 Mar 2020 18:16:24 +0300
Message-ID: <20200317151625.20797-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151625.20797-1-vsementsov@virtuozzo.com>
References: <20200317151625.20797-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 15:17:03 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e130296-abd6-4113-74fc-08d7ca863f96
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2620900DECF5F4BF38FA85D2C1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(69590400007)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(2906002)(26005)(478600001)(956004)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOp3IvYIPeBC3VXovrATsOylD6EL3sBr19SKIuTis5mV2AP+nB8p64SUc2oJPTRlbF+rZDCR0WOaItKgfPFahQ2KZfllxRJDzD7UwweRkeLj8sjXja1MsetLMVsKSdHoF0WAYteM992a08CjIHlFggo6B/aI5c9nYYx49P0wtTSciCQiwKnCHgQGykA64OPzhgq2VzSea2bqh6L/wXBIgzhnhJJDJxMQRvilyyal7uCoPDCRDHqOykDPP2/+e8Zv08X8JWo+CEW871Uaw5zMGDrMT+s3DI/nLBasm6gWCYXdHPTjZd4wWTSGo4vL4Z/lPWd5qvoED41qRtQE36U8JCoNVesKvV70FxHv9w/+mM5JhuUglnMgiqdhMNuO4/gRzJ/ASuM2QvYlMvKMSrsbJApm59oyK621gF+bM7VYDtGL9tNlgf1Nl5yVeM7igfcWu3B4UGIHBEGs6IhW/usp+p25plOYAqEPRVonJJMStCTaLOzVS+YH6DwrRZLOV8D0
X-MS-Exchange-AntiSpam-MessageData: t0KoMwRoljyQVQ771eSFaCxggFM8dM2zlXz87xzpioT4G3mQphIFFvVO1GZn8Dv1rWQmnoww+bQaJk+sR4Ydp8TIrYBBCYTj6fId2aSrlQCzjDGGeEJMqcor8nRjiwpa4pqm2CfhkhIBGDQ+79ZDEA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e130296-abd6-4113-74fc-08d7ca863f96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:17:03.9906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHP6MddRN9gQfXGnZFcMAEQ7uHYY1PsJFJHgczelq6EIqf/6mqWWVjWKCsQaJ7sIVkjP9DkrzKmup9dsuFQzV/64CKFEbmqTriSe/R/00VA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2620
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::71f
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp =3D=3D &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit is generated by command

    sed -n '/^Network Block Device (NBD)$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  1 +
 block/nbd.c         | 21 +++++++++------------
 nbd/client.c        |  5 +++++
 nbd/server.c        |  5 +++++
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 20363280ae..f7d87636d3 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -361,6 +361,7 @@ void nbd_server_start_options(NbdServerOptions *arg, Er=
ror **errp);
 static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
                            const char *desc, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int ret =3D qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO :=
 0;
=20
     if (ret < 0) {
diff --git a/block/nbd.c b/block/nbd.c
index 976be76647..70274c31de 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1410,16 +1410,15 @@ static void nbd_client_close(BlockDriverState *bs)
 static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                                   Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     QIOChannelSocket *sioc;
-    Error *local_err =3D NULL;
=20
     sioc =3D qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
=20
-    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
-    if (local_err) {
+    qio_channel_socket_connect_sync(sioc, saddr, errp);
+    if (*errp) {
         object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
         return NULL;
     }
=20
@@ -1725,10 +1724,10 @@ static bool nbd_process_legacy_socket_options(QDict=
 *output_options,
 static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options,
                                  Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SocketAddress *saddr =3D NULL;
     QDict *addr =3D NULL;
     Visitor *iv =3D NULL;
-    Error *local_err =3D NULL;
=20
     qdict_extract_subqdict(options, &addr, "server.");
     if (!qdict_size(addr)) {
@@ -1741,9 +1740,8 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDi=
ct *options,
         goto done;
     }
=20
-    visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_SocketAddress(iv, NULL, &saddr, errp);
+    if (*errp) {
         goto done;
     }
=20
@@ -1836,15 +1834,14 @@ static QemuOptsList nbd_runtime_opts =3D {
 static int nbd_process_options(BlockDriverState *bs, QDict *options,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     BDRVNBDState *s =3D bs->opaque;
     QemuOpts *opts;
-    Error *local_err =3D NULL;
     int ret =3D -EINVAL;
=20
     opts =3D qemu_opts_create(&nbd_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    qemu_opts_absorb_qdict(opts, options, errp);
+    if (*errp) {
         goto error;
     }
=20
diff --git a/nbd/client.c b/nbd/client.c
index ba173108ba..e258ef3f7e 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -68,6 +68,7 @@ static int nbd_send_option_request(QIOChannel *ioc, uint3=
2_t opt,
                                    uint32_t len, const char *data,
                                    Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NBDOption req;
     QEMU_BUILD_BUG_ON(sizeof(req) !=3D 16);
=20
@@ -153,6 +154,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, ui=
nt32_t opt,
 static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
                                 bool strict, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *msg =3D NULL;
=20
     if (!(reply->type & (1 << 31))) {
@@ -337,6 +339,7 @@ static int nbd_receive_list(QIOChannel *ioc, char **nam=
e, char **description,
 static int nbd_opt_info_or_go(QIOChannel *ioc, uint32_t opt,
                               NBDExportInfo *info, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NBDOptionReply reply;
     uint32_t len =3D strlen(info->name);
     uint16_t type;
@@ -882,6 +885,7 @@ static int nbd_start_negotiate(AioContext *aio_context,=
 QIOChannel *ioc,
                                bool structured_reply, bool *zeroes,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     uint64_t magic;
=20
     trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");
@@ -1017,6 +1021,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QI=
OChannel *ioc,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int result;
     bool zeroes;
     bool base_allocation =3D info->base_allocation;
diff --git a/nbd/server.c b/nbd/server.c
index 11a31094ff..ffc0cc69a7 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -211,6 +211,7 @@ static int GCC_FMT_ATTR(4, 0)
 nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
                             Error **errp, const char *fmt, va_list va)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *msg =3D NULL;
     int ret;
     size_t len;
@@ -369,6 +370,7 @@ static int nbd_opt_read_name(NBDClient *client, char **=
name, uint32_t *length,
 static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
                                        Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     size_t name_len, desc_len;
     uint32_t len;
     const char *name =3D exp->name ? exp->name : "";
@@ -432,6 +434,7 @@ static void nbd_check_meta_export(NBDClient *client)
 static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zer=
oes,
                                             Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *name =3D NULL;
     char buf[NBD_REPLY_EXPORT_NAME_SIZE] =3D "";
     size_t len;
@@ -1272,6 +1275,7 @@ static int nbd_negotiate_options(NBDClient *client, E=
rror **errp)
  */
 static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     char buf[NBD_OLDSTYLE_NEGOTIATE_SIZE] =3D "";
     int ret;
=20
@@ -1646,6 +1650,7 @@ void nbd_export_close(NBDExport *exp)
=20
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **e=
rrp)
 {
+    ERRP_AUTO_PROPAGATE();
     if (mode =3D=3D NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->clie=
nts)) {
         nbd_export_close(exp);
         return;
--=20
2.21.0


