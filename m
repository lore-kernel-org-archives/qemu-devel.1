Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DEC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1E3206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="peeFCkgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1E3206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEED4-0000OZ-RY
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxm-0002rE-D9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxj-0001Wb-2N
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:02 -0400
Received: from mail-he1eur04on0718.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::718]:38692
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxi-0001CE-PS; Tue, 17 Mar 2020 11:16:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoRVe5yWsI0JoBibvswHouKPw9+JZg56hc50pBJs0oPdjCKr/z9xTR/0VKHThcULbvm4BTQ8DTQkFfoZUEPsUyOV7Oq0h28Cua8U0pNOoY9M7y3ei/aIhr5n5lglyQWW98ZsAZ3D2J5PISqmTvFun9vi+o7+AVpa/4YLmlDQ0aRgR/kPmmpXoeOi4Iwn8e8ajTC29lhFUQPIW9SwnqMUyNs3e9PWOgGdXTDUXm7Z/sLLTmn199+ax9EY8sxvSIilndj7j4X6cnNH0rkVcGM5pLIYdK3hbFbQCgF6xN2lHkDfJTCYdKwLnQe8qCVokEH7tNhBfDlbLX4/4ze5fAUVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBpOUg1L6a4tJiQ+PypsUzQGtaFTSszE5WC1/prYbRo=;
 b=l71byK/fe4+tk5L+JgCuuymELynrT8/ivRX1rB2fvvu5AHjeWrxakA2Bdve53/J5fypGZQR1wjnX9+nhH6QhHiyWAErDXWYzrFO82ajgtQQhWneqYRsYW67h5K/QOBmngYS/KVPaOFwOe+c0qB3CA6uyi7CvrTwqfKZ0YgPvJKP0CHrNX+s+ce2i98824k8x1Bh0SYEEszXhNXxeArI7K4yeWVKqKXTXtT6JYtSVkFr8v+Id+IRO4/EecISGxB7n5Og3yXVB7HXvZ1uGJq1+g3G1J3GbA3HrPtbDnYoyDUjCXSa5y99joQ8vWIJYOHrXj7M6Lr8bN6kVaywh1IufUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBpOUg1L6a4tJiQ+PypsUzQGtaFTSszE5WC1/prYbRo=;
 b=peeFCkgAmf9BePJY96MBHERs9XRRdAymVAw3jBuXY3mm24DOBOg/kv0G/VZMjPiXa/uDuyKDTnFCAbcpM+CMG5Mpliu2gglDVN8DyMISxDBHRJD7ai8oPEOWyOOEE6Cq7oclbgAVpnlFKUizgChxfPGtlB6n4G/ofFho0sleQzs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:16:56 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:16:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 2/9] scripts: Coccinelle script to use
 ERRP_AUTO_PROPAGATE()
Date: Tue, 17 Mar 2020 18:16:18 +0300
Message-ID: <20200317151625.20797-3-vsementsov@virtuozzo.com>
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
 Transport; Tue, 17 Mar 2020 15:16:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6006fcf3-fcee-4671-53e9-08d7ca863b28
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2620F81177B1EC458B69E644C1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(30864003)(66574012)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(7416002)(2906002)(26005)(478600001)(956004)(36756003)(2616005)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KU3SJpugKWWWNIU4lR3eEpZ2RJOwk1nshcUCpF2WqDooZPyf5pavG8s3fkZl1wUFBQ4AMfGXAYwR182DAfpUR0KbT6MM7WO5N1Ay4Zy4xShrgiBR2S4MC/gXjop2fOu6ctUPjdpdEgxKaBNpHDUZeLWy2sex1gTDdVcLF8ikAfXSDWeKT3DiTXifGvGYIc+GgcDZueP2pqLPr7N81FQCD+4oLkq7Yh/7Tuf5bgjpgvIWpojhBOopmNgo/T82LyB6O/sQ294YIexDyVjYVyZAKJEpdylw+PpQt29Jfv4Wo9y1HzTmfaRM9KJo8p207oW8wcutDpT/emtruScRvEt1W/7dcnLDI/o8lf/rjXUI2A5pn14X+BMRbpQT/un7bKCVavReyZZNvNp3ydqO42Wy0bzhF4RY74jhzDpxReXZ0Vomeg5T/WNySnTlFs2BNp13PBBMyP6AE+5Hg6j97cIJBh24EKygrg5COYF9dyu3roMzWnfqrNSijh4l2JUgw4MNFq+BzHMxjnMc8r1sSdJ01C5hZFx/AGc6w5FGLhQLpj2KZphpam87NIcAQBuS+GP
X-MS-Exchange-AntiSpam-MessageData: qoIDpXuMxC1AAbH86jVLti36QzchSH0J4phAZUUp6zELIjCxyg1xdiVwftoifvI++wo6bSHlVFhEVV8eRTXk/kqBg7gS4gn61l6sOEI2ATv+tLzmlAhf6zSgzlS9DOiP2iajUalStxnLHkx/LyOhcQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6006fcf3-fcee-4671-53e9-08d7ca863b28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:16:56.6690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJAyrkSGokSYeGh7NWdGJn3susPfP/PUI1IXxCxam9neK+zEIqbSIX1hbiKWqxDdDxczhVv9B7imPA6ci+w61M1+YLXS6J+VNm3GN9MQd60=
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

Script adds ERRP_AUTO_PROPAGATE macro invocation where appropriate and
does corresponding changes in code (look for details in
include/qapi/error.h)

Usage example:
spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
 --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff \
 --max-width 80 FILES...

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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

 scripts/coccinelle/auto-propagated-errp.cocci | 336 ++++++++++++++++++
 include/qapi/error.h                          |   3 +
 MAINTAINERS                                   |   1 +
 3 files changed, 340 insertions(+)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

diff --git a/scripts/coccinelle/auto-propagated-errp.cocci b/scripts/coccin=
elle/auto-propagated-errp.cocci
new file mode 100644
index 0000000000..5188b07006
--- /dev/null
+++ b/scripts/coccinelle/auto-propagated-errp.cocci
@@ -0,0 +1,336 @@
+// Use ERRP_AUTO_PROPAGATE (see include/qapi/error.h)
+//
+// Copyright (c) 2020 Virtuozzo International GmbH.
+//
+// This program is free software; you can redistribute it and/or
+// modify it under the terms of the GNU General Public License as
+// published by the Free Software Foundation; either version 2 of the
+// License, or (at your option) any later version.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License
+// along with this program.  If not, see
+// <http://www.gnu.org/licenses/>.
+//
+// Usage example:
+// spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
+//  --macro-file scripts/cocci-macro-file.h --in-place \
+//  --no-show-diff --max-width 80 FILES...
+//
+// Note: --max-width 80 is needed because coccinelle default is less
+// than 80, and without this parameter coccinelle may reindent some
+// lines which fit into 80 characters but not to coccinelle default,
+// which in turn produces extra patch hunks for no reason.
+
+// Switch unusual Error ** parameter names to errp
+// (this is necessary to use ERRP_AUTO_PROPAGATE).
+//
+// Disable optional_qualifier to skip functions with
+// "Error *const *errp" parameter.
+//
+// Skip functions with "assert(_errp && *_errp)" statement, because
+// that signals unusual semantics, and the parameter name may well
+// serve a purpose. (like nbd_iter_channel_error()).
+//
+// Skip util/error.c to not touch, for example, error_propagate() and
+// error_propagate_prepend().
+@ depends on !(file in "util/error.c") disable optional_qualifier@
+identifier fn;
+identifier _errp !=3D errp;
+@@
+
+ fn(...,
+-   Error **_errp
++   Error **errp
+    ,...)
+ {
+(
+     ... when !=3D assert(_errp && *_errp)
+&
+     <...
+-    _errp
++    errp
+     ...>
+)
+ }
+
+// Add invocation of ERRP_AUTO_PROPAGATE to errp-functions where
+// necessary
+//
+// Note, that without "when any" the final "..." does not mach
+// something matched by previous pattern, i.e. the rule will not match
+// double error_prepend in control flow like in
+// vfio_set_irq_signaling().
+//
+// Note, "exists" says that we want apply rule even if it does not
+// match on all possible control flows (otherwise, it will not match
+// standard pattern when error_propagate() call is in if branch).
+@ disable optional_qualifier exists@
+identifier fn, local_err;
+symbol errp;
+@@
+
+ fn(..., Error **errp, ...)
+ {
++   ERRP_AUTO_PROPAGATE();
+    ...  when !=3D ERRP_AUTO_PROPAGATE();
+(
+(
+    error_append_hint(errp, ...);
+|
+    error_prepend(errp, ...);
+|
+    error_vprepend(errp, ...);
+)
+    ... when any
+|
+    Error *local_err =3D NULL;
+    ...
+(
+    error_propagate_prepend(errp, local_err, ...);
+|
+    error_propagate(errp, local_err);
+)
+    ...
+)
+ }
+
+// Warn when several Error * definitions are in the control flow.
+// This rule is not chained to rule1 and less restrictive, to cover more
+// functions to warn (even those we are not going to convert).
+//
+// Note, that even with one (or zero) Error * definition in the each
+// control flow we may have several (in total) Error * definitions in
+// the function. This case deserves attention too, but I don't see
+// simple way to match with help of coccinelle.
+@check1 disable optional_qualifier exists@
+identifier fn, _errp, local_err, local_err2;
+position p1, p2;
+@@
+
+ fn(..., Error **_errp, ...)
+ {
+     ...
+     Error *local_err =3D NULL;@p1
+     ... when any
+     Error *local_err2 =3D NULL;@p2
+     ... when any
+ }
+
+@ script:python @
+fn << check1.fn;
+p1 << check1.p1;
+p2 << check1.p2;
+@@
+
+print('Warning: function {} has several definitions of '
+      'Error * local variable: at {}:{} and then at {}:{}'.format(
+          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
+
+// Warn when several propagations are in the control flow.
+@check2 disable optional_qualifier exists@
+identifier fn, _errp;
+position p1, p2;
+@@
+
+ fn(..., Error **_errp, ...)
+ {
+     ...
+(
+     error_propagate_prepend(_errp, ...);@p1
+|
+     error_propagate(_errp, ...);@p1
+)
+     ...
+(
+     error_propagate_prepend(_errp, ...);@p2
+|
+     error_propagate(_errp, ...);@p2
+)
+     ... when any
+ }
+
+@ script:python @
+fn << check2.fn;
+p1 << check2.p1;
+p2 << check2.p2;
+@@
+
+print('Warning: function {} propagates to errp several times in '
+      'one control flow: at {}:{} and then at {}:{}'.format(
+          fn, p1[0].file, p1[0].line, p2[0].file, p2[0].line))
+
+// Match functions with propagation of local error to errp.
+// We want to refer these functions in several following rules, but I
+// don't know a proper way to inherit a function, not just its name
+// (to not match another functions with same name in following rules).
+// Not-proper way is as follows: rename errp parameter in functions
+// header and match it in following rules. Rename it back after all
+// transformations.
+//
+// The common case is a single definition of local_err with at most one
+// error_propagate_prepend() or error_propagate() on each control-flow
+// path. Functions with multiple definitions or propagates we want to
+// examine manually. Later rules emit warnings to guide us to them.
+//
+// Note that we match not only this "common case", but any function,
+// which has the "common cose" on at least one control-flow path.
+@rule1 disable optional_qualifier exists@
+identifier fn, local_err;
+symbol errp;
+@@
+
+ fn(..., Error **
+-    errp
++    ____
+    , ...)
+ {
+     ...
+     Error *local_err =3D NULL;
+     ...
+(
+     error_propagate_prepend(errp, local_err, ...);
+|
+     error_propagate(errp, local_err);
+)
+     ...
+ }
+
+// Convert special case with goto separately.
+// I tried merging this into the following rule the obvious way, but
+// it made Coccinelle hang on block.c
+//
+// Note interesting thing: if we don't do it here, and try to fixup
+// "out: }" things later after all transformations (the rule will be
+// the same, just without error_propagate() call), coccinelle fails to
+// match this "out: }".
+@ disable optional_qualifier@
+identifier rule1.fn, rule1.local_err, out;
+symbol errp;
+@@
+
+ fn(..., Error ** ____, ...)
+ {
+     <...
+-    goto out;
++    return;
+     ...>
+- out:
+-    error_propagate(errp, local_err);
+ }
+
+// Convert most of local_err related stuff.
+//
+// Note, that we inherit rule1.fn and rule1.local_err names, not
+// objects themselves. We may match something not related to the
+// pattern matched by rule1. For example, local_err may be defined with
+// the same name in different blocks inside one function, and in one
+// block follow the propagation pattern and in other block doesn't.
+//
+// Note also that errp-cleaning functions
+//   error_free_errp
+//   error_report_errp
+//   error_reportf_errp
+//   warn_report_errp
+//   warn_reportf_errp
+// are not yet implemented. They must call corresponding Error* -
+// freeing function and then set *errp to NULL, to avoid further
+// propagation to original errp (consider ERRP_AUTO_PROPAGATE in use).
+// For example, error_free_errp may look like this:
+//
+//    void error_free_errp(Error **errp)
+//    {
+//        error_free(*errp);
+//        *errp =3D NULL;
+//    }
+@ disable optional_qualifier exists@
+identifier rule1.fn, rule1.local_err;
+expression list args;
+symbol errp;
+@@
+
+ fn(..., Error ** ____, ...)
+ {
+     <...
+(
+-    Error *local_err =3D NULL;
+|
+
+// Convert error clearing functions
+(
+-    error_free(local_err);
++    error_free_errp(errp);
+|
+-    error_report_err(local_err);
++    error_report_errp(errp);
+|
+-    error_reportf_err(local_err, args);
++    error_reportf_errp(errp, args);
+|
+-    warn_report_err(local_err);
++    warn_report_errp(errp);
+|
+-    warn_reportf_err(local_err, args);
++    warn_reportf_errp(errp, args);
+)
+?-    local_err =3D NULL;
+
+|
+-    error_propagate_prepend(errp, local_err, args);
++    error_prepend(errp, args);
+|
+-    error_propagate(errp, local_err);
+|
+-    &local_err
++    errp
+)
+     ...>
+ }
+
+// Convert remaining local_err usage. For example, different kinds of
+// error checking in if conditionals. We can't merge this into
+// previous hunk, as this conflicts with other substitutions in it (at
+// least with "- local_err =3D NULL").
+@ disable optional_qualifier@
+identifier rule1.fn, rule1.local_err;
+symbol errp;
+@@
+
+ fn(..., Error ** ____, ...)
+ {
+     <...
+-    local_err
++    *errp
+     ...>
+ }
+
+// Always use the same pattern for checking error
+@ disable optional_qualifier@
+identifier rule1.fn;
+symbol errp;
+@@
+
+ fn(..., Error ** ____, ...)
+ {
+     <...
+-    *errp !=3D NULL
++    *errp
+     ...>
+ }
+
+// Revert temporary ___ identifier.
+@ disable optional_qualifier@
+identifier rule1.fn;
+@@
+
+ fn(..., Error **
+-   ____
++   errp
+    , ...)
+ {
+     ...
+ }
diff --git a/include/qapi/error.h b/include/qapi/error.h
index 30140d9bfe..56c133520d 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -214,6 +214,9 @@
  *         }
  *         ...
  *     }
+ *
+ * For mass-conversion use script
+ *   scripts/coccinelle/auto-propagated-errp.cocci
  */
=20
 #ifndef ERROR_H
diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..8b77127c35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2016,6 +2016,7 @@ F: include/qemu/error-report.h
 F: qapi/error.json
 F: util/error.c
 F: util/qemu-error.c
+F: scripts/coccinelle/*err*.cocci
=20
 GDB stub
 M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
--=20
2.21.0


