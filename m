Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EE6FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B57207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B57207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKk0K-0004oY-MX
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 10:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iKjzb-0004H0-1J
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iKjzY-0006fA-H8
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iKjzY-0006de-8E
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:09:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 55E0588384C;
 Wed, 16 Oct 2019 14:09:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78649601AF;
 Wed, 16 Oct 2019 14:09:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E10DF1138619; Wed, 16 Oct 2019 16:09:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 6/7] qapi: Split up scripts/qapi/common.py
References: <20191001191514.11208-1-armbru@redhat.com>
 <20191001191514.11208-7-armbru@redhat.com>
 <20191016130537.GB4940@localhost.localdomain>
Date: Wed, 16 Oct 2019 16:09:22 +0200
In-Reply-To: <20191016130537.GB4940@localhost.localdomain> (Kevin Wolf's
 message of "Wed, 16 Oct 2019 15:05:37 +0200")
Message-ID: <87mue0srxp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 16 Oct 2019 14:09:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 01.10.2019 um 21:15 hat Markus Armbruster geschrieben:
>> The QAPI code generator clocks in at some 3100 SLOC in 8 source files.
>> Almost 60% of the code is in qapi/common.py.  Split it into more
>> focused modules:
>> 
>> * Move QAPISchemaPragma and QAPISourceInfo to qapi/source.py.
>> 
>> * Move QAPIError and its sub-classes to qapi/error.py.
>> 
>> * Move QAPISchemaParser and QAPIDoc to parser.py.  Use the opportunity
>>   to put QAPISchemaParser first.
>> 
>> * Move check_expr() & friends to qapi/expr.py.  Use the opportunity to
>>   put the code into a more sensible order.
>> 
>> * Move QAPISchema & friends to qapi/schema.py
>> 
>> * Move QAPIGen and its sub-classes, ifcontext,
>>   QAPISchemaModularCVisitor, and QAPISchemaModularCVisitor to qapi/gen.py
>> 
>> A number of helper functions remain in qapi/common.py.  I considered
>> moving the code generator helpers to qapi/gen.py, but decided not to.
>> Perhaps we should rewrite them as methods of QAPIGen some day.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> This patch seems to forget to change qapi-py in the Makefile, so that
> when you change one of the new source files, the generator won't run
> again.

You're right.  Fixups in my tree now:

From ab5f45bbf58060441c8881f290273e93a56b47d5 Mon Sep 17 00:00:00 2001
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 11 Oct 2019 16:58:07 +0200
Subject: [PATCH] fixup! qapi: Split up scripts/qapi/common.py

---
 Makefile                   | 13 ++++++++++---
 scripts/qapi/introspect.py |  2 ++
 scripts/qapi/source.py     |  1 +
 tests/Makefile.include     | 13 ++++++++++---
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 30f0abfb42..991c8884d4 100644
--- a/Makefile
+++ b/Makefile
@@ -582,13 +582,20 @@ qemu-ga$(EXESUF): QEMU_CFLAGS += -I qga/qapi-generated
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-qapi-py = $(SRC_PATH)/scripts/qapi/commands.py \
+qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
+$(SRC_PATH)/scripts/qapi/commands.py \
+$(SRC_PATH)/scripts/qapi/common.py \
+$(SRC_PATH)/scripts/qapi/doc.py \
+$(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
+$(SRC_PATH)/scripts/qapi/expr.py \
+$(SRC_PATH)/scripts/qapi/gen.py \
 $(SRC_PATH)/scripts/qapi/introspect.py \
+$(SRC_PATH)/scripts/qapi/parser.py \
+$(SRC_PATH)/scripts/qapi/schema.py \
+$(SRC_PATH)/scripts/qapi/source.py \
 $(SRC_PATH)/scripts/qapi/types.py \
 $(SRC_PATH)/scripts/qapi/visit.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi-gen.py
 
 qga/qapi-generated/qga-qapi-types.c qga/qapi-generated/qga-qapi-types.h \
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 739b35ae8f..b3a463dd8b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -10,6 +10,8 @@ This work is licensed under the terms of the GNU GPL, version 2.
 See the COPYING file in the top-level directory.
 """
 
+import string
+
 from qapi.common import *
 from qapi.gen import QAPISchemaMonolithicCVisitor
 from qapi.schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index a5da8af17a..8956885033 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -10,6 +10,7 @@
 # See the COPYING file in the top-level directory.
 
 import copy
+import sys
 
 
 class QAPISchemaPragma(object):
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 1b24b8ba10..09e5b410dc 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -31,13 +31,20 @@ ifneq ($(wildcard config-host.mak),)
 export SRC_PATH
 
 # TODO don't duplicate $(SRC_PATH)/Makefile's qapi-py here
-qapi-py = $(SRC_PATH)/scripts/qapi/commands.py \
+qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
+$(SRC_PATH)/scripts/qapi/commands.py \
+$(SRC_PATH)/scripts/qapi/common.py \
+$(SRC_PATH)/scripts/qapi/doc.py \
+$(SRC_PATH)/scripts/qapi/error.py \
 $(SRC_PATH)/scripts/qapi/events.py \
+$(SRC_PATH)/scripts/qapi/expr.py \
+$(SRC_PATH)/scripts/qapi/gen.py \
 $(SRC_PATH)/scripts/qapi/introspect.py \
+$(SRC_PATH)/scripts/qapi/parser.py \
+$(SRC_PATH)/scripts/qapi/schema.py \
+$(SRC_PATH)/scripts/qapi/source.py \
 $(SRC_PATH)/scripts/qapi/types.py \
 $(SRC_PATH)/scripts/qapi/visit.py \
-$(SRC_PATH)/scripts/qapi/common.py \
-$(SRC_PATH)/scripts/qapi/doc.py \
 $(SRC_PATH)/scripts/qapi-gen.py
 
 # Get the list of all supported sysemu targets
-- 
2.21.0


