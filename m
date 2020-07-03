Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC165C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FF620826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eXurS1XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FF620826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI0y-0003JJ-LG
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHge-0000le-2c; Fri, 03 Jul 2020 05:08:48 -0400
Received: from mail-eopbgr140133.outbound.protection.outlook.com
 ([40.107.14.133]:62071 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jrHgb-0005Bb-Q1; Fri, 03 Jul 2020 05:08:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkbvQ/e4ha4YPsKMwzMKSecTzGhmKEPGFw35EGEOF6Ia04aJDseR2wEQu65k9lnX3FHuyQyzgxG3UNOGeclSPABSZiQfORZ/xPMXBw0mY3ujeB8SSdxi9a0UnbkLmMOLXoabIy7TzPSnZ+SN+ODXLsvdLFPIiTBsDSxdeBnyJ/Ajtc+zI0+ThtXBi0DdOZOXgkUMqKkyaY3hztZny5Sm1CUcjzFJFeKdXMmkdPupNoUQ6rMekW4NW91KmralgQp8Zkp4LAr3HOYftFFObozJO7B2em31fIygj76NlRLJ4rM1uBGYB9QVqGq71GBLXB0D1mKN9FWGJ9bVu5B4Bku2wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUTVdZHmF0gntwzLj0aHW2xdsF3Kr8nM6kQDszPWEuc=;
 b=l04OMdgkT3BLygnSRUmAj5q9S3T0UHjoU0daZT0Lyiwzqz+Lm/cmdwcjoLd/or8qXXZgeqi1jy7rPf7N3Mw9elA3BVpfFkvqD0S/PGTyg/JeBQf3vPcqIV+tT4WiikmnKM4Sw4UWm2McK+7a+hatM07uc77rcw8Iax1REu1T8p3Mmt2NOkf8XV578bj0TjKDuUs6B3Q7EfZy5wRSTCtm34lw7HLeyvCa1nVW3MhYo/b7HtyFIUoLSx7y3K6DXnynt4Qo8gtfNpjXtPe9iRoHsdG7SV5heWos9NsZouCLFkQfHQHCIQvrlf5mUEEv5yWk3etY5nKkEJUFcMvVR9+uNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUTVdZHmF0gntwzLj0aHW2xdsF3Kr8nM6kQDszPWEuc=;
 b=eXurS1XGz35iP7z090wb4T3WXe4FrsWwwmykYlQcUNfX/lRUbvn+drPzCC7fg2mAt7z/js7gEtojXA0ib/yVBujaiQiT8GGY7XGTvsDfV2VdxB/+MvefmCwtUacMrtqyEJhl6bA54wOMGtPHeuVDX43v2NhvGV4pEtD0ZlvQClM=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5448.eurprd08.prod.outlook.com (2603:10a6:20b:106::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Fri, 3 Jul
 2020 09:08:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Fri, 3 Jul 2020
 09:08:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 7/8] nbd: introduce ERRP_AUTO_PROPAGATE
Date: Fri,  3 Jul 2020 12:08:15 +0300
Message-Id: <20200703090816.3295-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200703090816.3295-1-vsementsov@virtuozzo.com>
References: <20200703090816.3295-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.15) by
 AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Fri, 3 Jul 2020 09:08:35 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f7f61a3-f783-4f58-8895-08d81f30ab12
X-MS-TrafficTypeDiagnostic: AM7PR08MB5448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54485A313BB1A627AFEE75F5C16A0@AM7PR08MB5448.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00LumWU39zkikrDznEnBW15Wuf5Bx11jrZmSClvLTt88nj9vtr6j65W7eatmdOImoo1ukah2l6B0lvt00n5nSNv6W4fvd76yQvMxEsuYV8cD9X1uVpDxjVm6SUv+j4/QmL+dLTzbVdOzi+YM84TuMLM23V4g2cmGOyBJBQ+tMJJC+5mgvx6RSbJUs6n/+wZVBF75BObpubhgUNfrYp8H0cSljrxGYvCNEeGdE6+sEsGqgISeu6VdeUSKru0P/a3vNq6AzfJWtXxerYYH6IQhlk4E2Su3Qy0RBOloomGyzGj5wvwMC/UwJpmBM1JIkFiWikDoehmkQu6QHRH857SYVeuWulvf0lnXpI4R4w3LZ1CkMAZRa5YYpw0Cj0rpn6pQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(376002)(136003)(396003)(346002)(69590400007)(66946007)(66476007)(66556008)(2906002)(86362001)(1076003)(8676002)(83380400001)(6512007)(5660300002)(8936002)(6666004)(186003)(36756003)(4326008)(6506007)(16526019)(6486002)(6916009)(26005)(478600001)(956004)(52116002)(316002)(54906003)(2616005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aXr/SSB5rGNzWNljYvYHq8zVYBwO7n0sLuMT5r2zO8ARzoydpgffPeeEVhhr0lWEgE0fs4miBl+BKTl6Fr7r5VpwrHHvP83AYdLoQ3iqcbonCAa0p4TTHk5RSwQ1TDQrfs/owoB6/lQE/O44JJuHz177XOj+p4qJKM+AFeiE62Ox6e4IqPOlvQN/gL2P2eJpwBWcB706HluAntu6pKuUX0A2YjD+uB0o9Bvnz7w19P2z78J9QxpV0TsHQ29E0rkdzp2V70jCWcGJHuc4o2eDvwfWQtqEgANY+Ckndfvn05ojGFOQ1LHLCH7ytnY5BMedbRDNovqoUQlctilFrfToF2UjHHQdQXcrNfgqa01PR3xFhAuNzHt1AIvzfXBiavrUoxDbLhQwVrgjQkT29kqvRBVQ4+MEFiJeubhPwcbLltLfNl4uoGsp4JFziOlMokTblFABy0FZPSNVMEQ3fd/CD+TAdR4E6v5SDZuT1//WIlQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7f61a3-f783-4f58-8895-08d81f30ab12
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 09:08:36.3468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcUcUWfawJgEs+1Cd9cbXtH2Cj4Pv/kGPCwJLXL7nT5+4AkTtlL+syZjEHE5CpLws12yg+Fhxp4q7DF6B6Yx3l5YiAaknxQWoXBN2Dp/PaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5448
Received-SPF: pass client-ip=40.107.14.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:08:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp == &error_fatal
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
---
 include/block/nbd.h | 1 +
 block/nbd.c         | 7 +++----
 nbd/client.c        | 5 +++++
 nbd/server.c        | 5 +++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 20363280ae..f7d87636d3 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -361,6 +361,7 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp);
 static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
                            const char *desc, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int ret = qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
 
     if (ret < 0) {
diff --git a/block/nbd.c b/block/nbd.c
index 6876da04a7..b7cea0f650 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1408,16 +1408,15 @@ static void nbd_client_close(BlockDriverState *bs)
 static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                                   Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     QIOChannelSocket *sioc;
-    Error *local_err = NULL;
 
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
 
-    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
-    if (local_err) {
+    qio_channel_socket_connect_sync(sioc, saddr, errp);
+    if (*errp) {
         object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
         return NULL;
     }
 
diff --git a/nbd/client.c b/nbd/client.c
index ba173108ba..e258ef3f7e 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -68,6 +68,7 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
                                    uint32_t len, const char *data,
                                    Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NBDOption req;
     QEMU_BUILD_BUG_ON(sizeof(req) != 16);
 
@@ -153,6 +154,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
 static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
                                 bool strict, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *msg = NULL;
 
     if (!(reply->type & (1 << 31))) {
@@ -337,6 +339,7 @@ static int nbd_receive_list(QIOChannel *ioc, char **name, char **description,
 static int nbd_opt_info_or_go(QIOChannel *ioc, uint32_t opt,
                               NBDExportInfo *info, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NBDOptionReply reply;
     uint32_t len = strlen(info->name);
     uint16_t type;
@@ -882,6 +885,7 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                                bool structured_reply, bool *zeroes,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     uint64_t magic;
 
     trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");
@@ -1017,6 +1021,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int result;
     bool zeroes;
     bool base_allocation = info->base_allocation;
diff --git a/nbd/server.c b/nbd/server.c
index 20754e9ebc..8a12e586d7 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -211,6 +211,7 @@ static int GCC_FMT_ATTR(4, 0)
 nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
                             Error **errp, const char *fmt, va_list va)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *msg = NULL;
     int ret;
     size_t len;
@@ -382,6 +383,7 @@ static int nbd_opt_read_name(NBDClient *client, char **name, uint32_t *length,
 static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
                                        Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     size_t name_len, desc_len;
     uint32_t len;
     const char *name = exp->name ? exp->name : "";
@@ -445,6 +447,7 @@ static void nbd_check_meta_export(NBDClient *client)
 static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
                                             Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *name = NULL;
     char buf[NBD_REPLY_EXPORT_NAME_SIZE] = "";
     size_t len;
@@ -1289,6 +1292,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
  */
 static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     char buf[NBD_OLDSTYLE_NEGOTIATE_SIZE] = "";
     int ret;
 
@@ -1663,6 +1667,7 @@ void nbd_export_close(NBDExport *exp)
 
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     if (mode == NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->clients)) {
         nbd_export_close(exp);
         return;
-- 
2.21.0


