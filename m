Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D4C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A431620753
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Iy0n92Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A431620753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEE2x-0002Lc-Nc
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxl-0002oh-1M
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxi-0001R0-Iv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:00 -0400
Received: from mail-he1eur04on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::718]:38692
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxi-0001CE-5x; Tue, 17 Mar 2020 11:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyMBz/z+lRqNJ9btlpLsD2wOb8995wDG3lE7W81l8g2r+NJsn4dXR1bueGUWwDoAea1nIC6elrQpRP6dEuQiZSI0TLZtCpF4mdknNr6dqCmAuHLFhyBPesHxlxNIuka/5yAoCOleFmBhLop8Qup8gNlipG68qoEe8tSz8uaUh5h1RYUq7U3mMVLuCInU/WnYeuguujHyQYgUgLQXLIiLiwBg9xq3n+rgtdQxzXIwWvU7fkX7lO8N4s2mXJvTjejCqLiP2zg7WgPMPe721VyE4LNK6XUaIcDQGjGqTyIQGf1zMX409lUPL7tI6tS39QY29OO5P81m3q9Rui+8c//apw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geidpRKznJ30A50ug7yvS4fUAC8Dpy0mf3kSy7C5GVs=;
 b=hxMSNjCK1wGDGdanCCh0VNB764ETs1Cwenq8PysP6FIPTQ5xq2GreWLAcAuFjORnyt9gom5jGWTbBJt163WRg0k46rBEehjdgf/yBRmMIR+jTmnbFrss0iGmKR9gCOakxOUVJCd9jtdNwr1wBI5cM3ViPbDCEtMdZd/58E6l5y37EzlXdUwJkfaG2nOiv1DgDh/oYy6k2h6tHuRItO8dwuG307NIgQQnBWDvj7IvQ+XLhC8ePfjM1bomPrkmBxfHIsALvVy+sdL7vMLvYa0gqsP1NxMRY+nYwKAhVh1Z9Od/4ljKe+2VsBzw5tRT2xpCIUhWmi4cxfw0qy+RsxkIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geidpRKznJ30A50ug7yvS4fUAC8Dpy0mf3kSy7C5GVs=;
 b=Iy0n92SfLDaQUVzGY2hOwh65ImidroKCBeCkP+6T3lojQiyOv94NX8yxFuLerLzWPdu6gBUUdA795Nabx+v4Tf5P2GkmDWmb2lFzVdDXEck04Ci3V+vu02UN3EFktvktIQKN3QHGFB6jwrQaqXnvVl6YWQbJg8YA4aTjRPbcRfQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:16:54 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:16:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 1/9] error: auto propagated local_err
Date: Tue, 17 Mar 2020 18:16:17 +0300
Message-ID: <20200317151625.20797-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200317151625.20797-1-vsementsov@virtuozzo.com>
References: <20200317151625.20797-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 15:16:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 539ae3f3-a216-4b90-693d-08d7ca8639e9
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB26200C63B207329CAAF0D472C1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(30864003)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(7416002)(2906002)(26005)(478600001)(956004)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi4EwamTi7mTr4MNREbSTJwyhTXFoK86BJstsgcPhCOz/WWrQBXEvNHDoAISIsF0M5ZhBjYFDs/A++NTI/Pc98H5j4TjrfcvO8ax888RqEKYtEHB64TBJ6+48keudRlVz/n1VWeTv3CALAzg26/FEHpFeF9jWoImSNeW/dGCs+B+jUnNwhUamnoQmOQt00C4mG2C9eOxVtv/S2/StDQTWGG5UJlkyzDpKxGzfdmljLrgEvXA3vpBiON2lAlTGuOiZx/P1UoQ0sUGmwG2PA3HbEHCI+0q7n10NPx6mW5Dv9uLfz3i96/ryhDJnUdjd+QJ1b5aVZ53VFY1xcS5/j0S4GabyDLfvQd/Td6jAxriomTOiZdiuEB7H/yYzuJyo3H5ZIgejpIER5ATaMM2qDRdRNNEKRE2ZE2UJpmQedbykWWb9iIK2D5CmonLatI5OxgM
X-MS-Exchange-AntiSpam-MessageData: 5ntmn/kSFPsbLUL6ZhtmUbU2ysCHbCv415PB6w5/YOnFXbtWAoGt2l9BRRTUlNXHZRAP9Fsg7WtT20WbL5W8D6y/1ZIJmTm7H+kgYBvFln3LG1Hb7n0icpKDfdT343g9MQ+MkooO3obpEKB8idFaDA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539ae3f3-a216-4b90-693d-08d7ca8639e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:16:54.5349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZ50MhjOFu7oxN8ZM8fyztsbUtWxxi9Sg1SOb+k8GduYFai9QtXBc7FUFE8gBRUVs83RrBkkerKu6kmRyPSjQ+tK1azepHoDhaM+CdcFmdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2620
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::718
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
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
functions with an errp OUT parameter.

It has three goals:

1. Fix issue with error_fatal and error_prepend/error_append_hint: user
can't see this additional information, because exit() happens in
error_setg earlier than information is added. [Reported by Greg Kurz]

2. Fix issue with error_abort and error_propagate: when we wrap
error_abort by local_err+error_propagate, the resulting coredump will
refer to error_propagate and not to the place where error happened.
(the macro itself doesn't fix the issue, but it allows us to [3.] drop
the local_err+error_propagate pattern, which will definitely fix the
issue) [Reported by Kevin Wolf]

3. Drop local_err+error_propagate pattern, which is used to workaround
void functions with errp parameter, when caller wants to know resulting
status. (Note: actually these functions could be merely updated to
return int error code).

To achieve these goals, later patches will add invocations
of this macro at the start of functions with either use
error_prepend/error_append_hint (solving 1) or which use
local_err+error_propagate to check errors, switching those
functions to use *errp instead (solving 2 and 3).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---

Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Cc: xen-devel@lists.xenproject.org

 include/qapi/error.h | 205 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 173 insertions(+), 32 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index ad5b6e896d..30140d9bfe 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -15,6 +15,8 @@
 /*
  * Error reporting system loosely patterned after Glib's GError.
  *
+ * =3D Deal with Error object =3D
+ *
  * Create an error:
  *     error_setg(&err, "situation normal, all fouled up");
  *
@@ -47,28 +49,91 @@
  * reporting it (primarily useful in testsuites):
  *     error_free_or_abort(&err);
  *
- * Pass an existing error to the caller:
- *     error_propagate(errp, err);
- * where Error **errp is a parameter, by convention the last one.
+ * =3D Deal with Error ** function parameter =3D
  *
- * Pass an existing error to the caller with the message modified:
- *     error_propagate_prepend(errp, err);
+ * A function may use the error system to return errors. In this case, the
+ * function defines an Error **errp parameter, by convention the last one =
(with
+ * exceptions for functions using ... or va_list).
  *
- * Avoid
- *     error_propagate(errp, err);
- *     error_prepend(errp, "Could not frobnicate '%s': ", name);
- * because this fails to prepend when @errp is &error_fatal.
+ * The caller may then pass in the following errp values:
  *
- * Create a new error and pass it to the caller:
+ * 1. &error_abort
+ *    Any error will result in abort().
+ * 2. &error_fatal
+ *    Any error will result in exit() with a non-zero status.
+ * 3. NULL
+ *    No error reporting through errp parameter.
+ * 4. The address of a NULL-initialized Error *err
+ *    Any error will populate errp with an error object.
+ *
+ * The following rules then implement the correct semantics desired by the
+ * caller.
+ *
+ * Create a new error to pass to the caller:
  *     error_setg(errp, "situation normal, all fouled up");
  *
- * Call a function and receive an error from it:
+ * Calling another errp-based function:
+ *     f(..., errp);
+ *
+ * =3D=3D Checking success of subcall =3D=3D
+ *
+ * If a function returns a value indicating an error in addition to settin=
g
+ * errp (which is recommended), then you don't need any additional code, j=
ust
+ * do:
+ *
+ *     int ret =3D f(..., errp);
+ *     if (ret < 0) {
+ *         ... handle error ...
+ *         return ret;
+ *     }
+ *
+ * If a function returns nothing (not recommended for new code), the only =
way
+ * to check success is by consulting errp; doing this safely requires the =
use
+ * of the ERRP_AUTO_PROPAGATE macro, like this:
+ *
+ *     int our_func(..., Error **errp) {
+ *         ERRP_AUTO_PROPAGATE();
+ *         ...
+ *         subcall(..., errp);
+ *         if (*errp) {
+ *             ...
+ *             return -EINVAL;
+ *         }
+ *         ...
+ *     }
+ *
+ * ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as needed,=
 so
+ * that the rest of the function can directly use errp (including
+ * dereferencing), where any errors will then be propagated on to the orig=
inal
+ * errp when leaving the function.
+ *
+ * In some cases, we need to check result of subcall, but do not want to
+ * propagate the Error object to our caller. In such cases we don't need
+ * ERRP_AUTO_PROPAGATE, but just a local Error object:
+ *
+ * Receive an error and not pass it:
  *     Error *err =3D NULL;
- *     foo(arg, &err);
+ *     subcall(arg, &err);
  *     if (err) {
  *         handle the error...
+ *         error_free(err);
  *     }
  *
+ * Note that older code that did not use ERRP_AUTO_PROPAGATE would instead=
 need
+ * a local Error * variable and the use of error_propagate() to properly h=
andle
+ * all possible caller values of errp. Now this is DEPRECATED* (see below)=
.
+ *
+ * Note that any function that wants to modify an error object, such as by
+ * calling error_append_hint or error_prepend, must use ERRP_AUTO_PROPAGAT=
E, in
+ * order for a caller's use of &error_fatal to see the additional informat=
ion.
+ *
+ * In rare cases, we need to pass existing Error object to the caller by h=
and:
+ *     error_propagate(errp, err);
+ *
+ * Pass an existing error to the caller with the message modified:
+ *     error_propagate_prepend(errp, err);
+ *
+ *
  * Call a function ignoring errors:
  *     foo(arg, NULL);
  *
@@ -78,26 +143,6 @@
  * Call a function treating errors as fatal:
  *     foo(arg, &error_fatal);
  *
- * Receive an error and pass it on to the caller:
- *     Error *err =3D NULL;
- *     foo(arg, &err);
- *     if (err) {
- *         handle the error...
- *         error_propagate(errp, err);
- *     }
- * where Error **errp is a parameter, by convention the last one.
- *
- * Do *not* "optimize" this to
- *     foo(arg, errp);
- *     if (*errp) { // WRONG!
- *         handle the error...
- *     }
- * because errp may be NULL!
- *
- * But when all you do with the error is pass it on, please use
- *     foo(arg, errp);
- * for readability.
- *
  * Receive and accumulate multiple errors (first one wins):
  *     Error *err =3D NULL, *local_err =3D NULL;
  *     foo(arg, &err);
@@ -114,6 +159,61 @@
  *         handle the error...
  *     }
  * because this may pass a non-null err to bar().
+ *
+ * DEPRECATED*
+ *
+ * The following pattern of receiving, checking, and then forwarding an er=
ror
+ * to the caller by hand is now deprecated:
+ *
+ *     Error *err =3D NULL;
+ *     foo(arg, &err);
+ *     if (err) {
+ *         handle the error...
+ *         error_propagate(errp, err);
+ *     }
+ *
+ * Instead, use ERRP_AUTO_PROPAGATE macro.
+ *
+ * The old pattern is deprecated because of two things:
+ *
+ * 1. Issue with error_abort and error_propagate: when we wrap error_abort=
 by
+ * local_err+error_propagate, the resulting coredump will refer to
+ * error_propagate and not to the place where error happened.
+ *
+ * 2. A lot of extra code of the same pattern
+ *
+ * How to update old code to use ERRP_AUTO_PROPAGATE?
+ *
+ * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function sta=
rt,
+ * than you may safely dereference errp to check errors and do not need an=
y
+ * additional local Error variables or calls to error_propagate().
+ *
+ * Example:
+ *
+ * old code
+ *
+ *     void fn(..., Error **errp) {
+ *         Error *err =3D NULL;
+ *         foo(arg, &err);
+ *         if (err) {
+ *             handle the error...
+ *             error_propagate(errp, err);
+ *             return;
+ *         }
+ *         ...
+ *     }
+ *
+ * updated code
+ *
+ *     void fn(..., Error **errp) {
+ *         ERRP_AUTO_PROPAGATE();
+ *         foo(arg, errp);
+ *         if (*errp) {
+ *             handle the error...
+ *             return;
+ *         }
+ *         ...
+ *     }
  */
=20
 #ifndef ERROR_H
@@ -322,6 +422,47 @@ void error_set_internal(Error **errp,
                         ErrorClass err_class, const char *fmt, ...)
     GCC_FMT_ATTR(6, 7);
=20
+typedef struct ErrorPropagator {
+    Error *local_err;
+    Error **errp;
+} ErrorPropagator;
+
+static inline void error_propagator_cleanup(ErrorPropagator *prop)
+{
+    error_propagate(prop->errp, prop->local_err);
+}
+
+G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup=
);
+
+/*
+ * ERRP_AUTO_PROPAGATE
+ *
+ * This macro exists to assist with proper error handling in a function wh=
ich
+ * uses an Error **errp parameter.  It must be used as the first line of a
+ * function which modifies an error (with error_prepend, error_append_hint=
, or
+ * similar) or which wants to dereference *errp.  It is still safe (but
+ * useless) to use in other functions.
+ *
+ * If errp is NULL or points to error_fatal, it is rewritten to point to a
+ * local Error object, which will be automatically propagated to the origi=
nal
+ * errp on function exit (see error_propagator_cleanup).
+ *
+ * After invocation of this macro it is always safe to dereference errp
+ * (as it's not NULL anymore) and to add information by error_prepend or
+ * error_append_hint (as, if it was error_fatal, we swapped it with a
+ * local_error to be propagated on cleanup).
+ *
+ * Note: we don't wrap the error_abort case, as we want resulting coredump
+ * to point to the place where the error happened, not to error_propagate.
+ */
+#define ERRP_AUTO_PROPAGATE() \
+    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp}; \
+    do { \
+        if (!errp || errp =3D=3D &error_fatal) { \
+            errp =3D &_auto_errp_prop.local_err; \
+        } \
+    } while (0)
+
 /*
  * Special error destination to abort on error.
  * See error_setg() and error_propagate() for details.
--=20
2.21.0


