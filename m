Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C33C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F1BE20936
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsbMFhUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1BE20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpkp-0004vR-H6
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbU-0001Gg-KN
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43756
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKpbS-000648-74
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600809213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wkfyJxPT7WMs+xQ5yhM6ldyq5c/1HHIx7xgHgPKhcc=;
 b=DsbMFhUXDE5V0lTDLpZC2vPRPMuOuiKIX4EcR2LeO63wB3PtKwxp08kZZOWbbRFdrsmhVA
 I5gbemwpPEVBJimJCppfHCsR9zNKMmzG/Cc8u8arnGPxJbmWDvHNvCWy7Yfa/p6M5ZP4a6
 MwM+JYIaxxgynxKtFoZeYFloa23sxFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-vE8sbY9yMF67YyODEZxguA-1; Tue, 22 Sep 2020 17:13:31 -0400
X-MC-Unique: vE8sbY9yMF67YyODEZxguA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AD3910BBEC3;
 Tue, 22 Sep 2020 21:13:30 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07B7973682;
 Tue, 22 Sep 2020 21:13:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 12/16] qapi/expr.py: Add docstrings
Date: Tue, 22 Sep 2020 17:13:09 -0400
Message-Id: <20200922211313.4082880-13-jsnow@redhat.com>
In-Reply-To: <20200922211313.4082880-1-jsnow@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:33:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/expr.py | 157 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index f244e9648c..4bba09f6e5 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -1,7 +1,5 @@
 # -*- coding: utf-8 -*-
 #
-# Check (context-free) QAPI schema expression structure
-#
 # Copyright IBM, Corp. 2011
 # Copyright (c) 2013-2019 Red Hat Inc.
 #
@@ -14,6 +12,25 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+"""
+Normalize and validate (context-free) QAPI schema expression structures.
+
+After QAPI expressions are parsed from disk, they are stored in
+recursively nested Python data structures using Dict, List, str, bool,
+and int. This module ensures that those nested structures have the
+correct type(s) and key(s) where appropriate for the QAPI context-free
+grammar.
+
+The QAPI schema expression language also allows for syntactic sugar;
+this module also handles the normalization process of these nested
+structures.
+
+See `check_exprs` for the main entry point.
+
+See `schema.QAPISchema` for processing into native Python data
+structures and contextual semantic validation.
+"""
+
 import re
 from typing import (
     Iterable,
@@ -46,6 +63,7 @@
 def check_name_is_str(name: object,
                       info: QAPISourceInfo,
                       source: str) -> None:
+    """Ensures that `name` is a string. [Const]"""
     if not isinstance(name, str):
         raise QAPISemError(info, "%s requires a string name" % source)
 
@@ -56,6 +74,24 @@ def check_name_str(name: str,
                    allow_optional: bool = False,
                    enum_member: bool = False,
                    permit_upper: bool = False) -> None:
+    """
+    Ensures a string is a legal name. [Const]
+
+    A name is legal in the default case when:
+    - It matches ``(__[a-z0-9.-]+_)?[a-z][a-z0-9_-]*``
+    - It does not start with ``q_`` or ``q-``
+
+    :param name:           Name to check.
+    :param info:           QAPI source file information.
+    :param source:         Human-readable str describing "what" this name is.
+    :param allow_optional: Allow the very first character to be ``*``.
+                           (Cannot be used with `enum_member`)
+    :param enum_member:    Allow the very first character to be a digit.
+                           (Cannot be used with `allow_optional`)
+    :param permit_upper:   Allows upper-case characters wherever
+                           lower-case characters are allowed.
+    """
+    assert not (allow_optional and enum_member)
     membername = name
 
     if allow_optional and name.startswith('*'):
@@ -76,6 +112,17 @@ def check_name_str(name: str,
 
 
 def check_defn_name_str(name: str, info: QAPISourceInfo, meta: str) -> None:
+    """
+    Ensures a name is a legal definition name. [Const]
+
+    A legal definition name:
+     - Adheres to the criteria in `check_name_str`, with uppercase permitted
+     - Does not end with ``Kind`` or ``List``.
+
+    :param name: Name to check.
+    :param info: QAPI source file information.
+    :param meta: Type name of the QAPI expression.
+    """
     check_name_str(name, info, meta, permit_upper=True)
     if name.endswith('Kind') or name.endswith('List'):
         raise QAPISemError(
@@ -87,6 +134,15 @@ def check_keys(value: _JSObject,
                source: str,
                required: List[str],
                optional: List[str]) -> None:
+    """
+    Ensures an object has a specific set of keys. [Const]
+
+    :param value:    The object to check.
+    :param info:     QAPI source file information.
+    :param source:   Human-readable str describing "what" this object is.
+    :param required: Keys that *must* be present.
+    :param optional: Keys that *may* be present.
+    """
 
     def pprint(elems: Iterable[str]) -> str:
         return ', '.join("'" + e + "'" for e in sorted(elems))
@@ -109,6 +165,12 @@ def pprint(elems: Iterable[str]) -> str:
 
 
 def check_flags(expr: Expression, info: QAPISourceInfo) -> None:
+    """
+    Ensures common fields in an Expression are correct. [Const]
+
+    :param expr: Expression to validate.
+    :param info: QAPI source file information.
+    """
     for key in ['gen', 'success-response']:
         if key in expr and expr[key] is not False:
             raise QAPISemError(
@@ -120,6 +182,18 @@ def check_flags(expr: Expression, info: QAPISourceInfo) -> None:
 
 
 def check_if(expr: _JSObject, info: QAPISourceInfo, source: str) -> None:
+    """
+    Syntactically validate and normalize the ``if`` field of an object. [RW]
+
+    The ``if`` field may be either a `str` or a `List[str]`.
+    A `str` element will be normalized to `List[str]`.
+
+    Sugared: `Union[str, List[str]]`
+    Ifcond: `List[str]`
+
+    :param expr: A `dict`; the ``if`` field, if present, will be validated.
+    :param info: QAPI source file information.
+    """
 
     def check_if_str(ifcond: object) -> None:
         if not isinstance(ifcond, str):
@@ -148,6 +222,16 @@ def check_if_str(ifcond: object) -> None:
 
 
 def normalize_members(members: object) -> None:
+    """
+    Normalize a "members" value. [RW]
+
+    If `members` is an object, for every value in that object, if that
+    value is not itself already an object, normalize it to
+    ``{'type': value}``.
+
+    Sugared: `Dict[str, Union[str, TypeRef]]`
+    Members: `Dict[str, TypeRef]`
+    """
     if isinstance(members, dict):
         for key, arg in members.items():
             if isinstance(arg, dict):
@@ -160,6 +244,18 @@ def check_type(value: Optional[object],
                source: str,
                allow_array: bool = False,
                allow_dict: Union[bool, str] = False) -> None:
+    """
+    Check the QAPI type of `value`. [RW]
+
+    Python types of `str` or `None` are always allowed.
+
+    :param value:       The value to check.
+    :param info:        QAPI Source file information.
+    :param source:      Human readable string describing "what" the value is.
+    :param allow_array: Allow a `List[str]` of length 1,
+                        which indicates an Array<T> type.
+    :param allow_dict:  Allow a dict, treated as an anonymous type.
+    """
     if value is None:
         return
 
@@ -205,6 +301,15 @@ def check_type(value: Optional[object],
 
 def check_features(features: Optional[object],
                    info: QAPISourceInfo) -> None:
+    """
+    Syntactically validate and normalize the "features" field. [RW]
+
+    `features` may be a List of either `str` or `dict`.
+    Any `str` element will be normalized to `{'name': element}`.
+
+    Sugared: `List[Union[str, Feature]]`
+    Features: `List[Feature]`
+    """
     if features is None:
         return
     if not isinstance(features, list):
@@ -222,6 +327,12 @@ def check_features(features: Optional[object],
 
 
 def check_enum(expr: Expression, info: QAPISourceInfo) -> None:
+    """
+    Validate this `Expression` as an ``enum`` expression. [RW]
+
+    :param expr: `Expression` to validate.
+    :param info: QAPI source file information.
+    """
     name = expr['enum']
     members = expr['data']
     prefix = expr.get('prefix')
@@ -246,6 +357,12 @@ def check_enum(expr: Expression, info: QAPISourceInfo) -> None:
 
 
 def check_struct(expr: Expression, info: QAPISourceInfo) -> None:
+    """
+    Validate this `Expression` as a ``struct`` expression. [RW]
+
+    :param expr: `Expression` to validate.
+    :param info: QAPI source file information.
+    """
     name = cast(str, expr['struct'])  # Asserted in check_exprs
     members = expr['data']
 
@@ -254,6 +371,12 @@ def check_struct(expr: Expression, info: QAPISourceInfo) -> None:
 
 
 def check_union(expr: Expression, info: QAPISourceInfo) -> None:
+    """
+    Validate this `Expression` as a ``union`` expression. [RW]
+
+    :param expr: `Expression` to validate.
+    :param info: QAPI source file information.
+    """
     name = cast(str, expr['union'])  # Asserted in check_exprs
     base = expr.get('base')
     discriminator = expr.get('discriminator')
@@ -280,6 +403,12 @@ def check_union(expr: Expression, info: QAPISourceInfo) -> None:
 
 
 def check_alternate(expr: Expression, info: QAPISourceInfo) -> None:
+    """
+    Validate this `Expression` as an ``alternate`` expression. [RW]
+
+    :param expr: Expression to validate.
+    :param info: QAPI source file information.
+    """
     members = expr['data']
 
     if not members:
@@ -297,6 +426,12 @@ def check_alternate(expr: Expression, info: QAPISourceInfo) -> None:
 
 
 def check_command(expr: Expression, info: QAPISourceInfo) -> None:
+    """
+    Validate this `Expression` as a ``command`` expression. [RW]
+
+    :param expr: `Expression` to validate.
+    :param info: QAPI source file information.
+    """
     args = expr.get('data')
     rets = expr.get('returns')
     boxed = expr.get('boxed', False)
@@ -308,6 +443,16 @@ def check_command(expr: Expression, info: QAPISourceInfo) -> None:
 
 
 def check_event(expr: Expression, info: QAPISourceInfo) -> None:
+    """
+    Normalize and syntactically validate the ``event`` expression. [RW]
+
+    Event:
+        event:    `str`
+        data:     `Optional[Dict[str, Member]]`
+        boxed:    `Optional[bool]`
+        if:       `Optional[Ifcond]`
+        features: `Optional[Features]`
+    """
     args = expr.get('data')
     boxed = expr.get('boxed', False)
 
@@ -317,6 +462,14 @@ def check_event(expr: Expression, info: QAPISourceInfo) -> None:
 
 
 def check_exprs(exprs: List[_JSObject]) -> List[_JSObject]:
+    """
+    Validate and normalize a list of parsed QAPI schema expressions. [RW]
+
+    This function accepts a list of expressions + metadta as returned by
+    the parser. It destructively normalizes the expressions in-place.
+
+    :param exprs: The list of expressions to normalize/validate.
+    """
     for expr_elem in exprs:
         # Expression
         assert isinstance(expr_elem['expr'], dict)
-- 
2.26.2


