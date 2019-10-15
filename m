Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39B0ECE587
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 06:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7703921835
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 06:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7703921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKGhq-0004Gk-MM
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 02:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iKGgd-0003om-Fu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iKGgb-0004Cg-5G
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:52:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iKGgZ-0004CM-71
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 02:52:00 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14B6C10C0928
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 06:51:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE89719C58;
 Tue, 15 Oct 2019 06:51:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16F111138619; Tue, 15 Oct 2019 08:51:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 3/4] tests: qapi: Test 'features' of commands
References: <20191011085027.28606-1-armbru@redhat.com>
 <20191011085027.28606-4-armbru@redhat.com>
Date: Tue, 15 Oct 2019 08:51:56 +0200
In-Reply-To: <20191011085027.28606-4-armbru@redhat.com> (Markus Armbruster's
 message of "Fri, 11 Oct 2019 10:50:26 +0200")
Message-ID: <8736fuzek3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 15 Oct 2019 06:51:58 +0000 (UTC)
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
Cc: kwolf@redhat.com, pkrempa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> From: Peter Krempa <pkrempa@redhat.com>
>
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qmp-cmds.c                   | 24 ++++++++++++++++++++++++
>  tests/qapi-schema/qapi-schema-test.json | 22 ++++++++++++++++++++++
>  tests/qapi-schema/qapi-schema-test.out  | 23 +++++++++++++++++++++++
>  tests/qapi-schema/test-qapi.py          | 12 ++++++++----
>  4 files changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index 36fdf5b115..ba623fda29 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -51,6 +51,30 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
>  {
>  }
>  
> +void qmp_test_command_features1(Error **errp)
> +{
> +}
> +
> +void qmp_test_command_features2(Error **errp)
> +{
> +}
> +
> +void qmp_test_command_features3(Error **errp)
> +{
> +}
> +
> +void qmp_test_command_features4(Error **errp)
> +{
> +}
> +
> +void qmp_test_command_features5(Error **errp)
> +{
> +}
> +
> +void qmp_test_command_features6(Error **errp)
> +{
> +}
> +
>  UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
>                                bool has_udb1, UserDefOne *ud1b,
>                                Error **errp)
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
> index 75c42eb0e3..80811dc8f0 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -290,3 +290,25 @@
>              'cfs1': 'CondFeatureStruct1',
>              'cfs2': 'CondFeatureStruct2',
>              'cfs3': 'CondFeatureStruct3' } }
> +
> +# test 'features' for command
> +
> +{ 'command': 'test-command-features1',
> +  'features': [] }
> +
> +{ 'command': 'test-command-features2',
> +  'features': [ 'feature1' ] }
> +
> +{ 'command': 'test-command-features3',
> +  'features': [ 'feature1', 'feature2' ] }
> +
> +{ 'command': 'test-command-features4',
> +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'} ] }
> +
> +{ 'command': 'test-command-features5',
> +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
> +                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }
> +
> +{ 'command': 'test-command-features6',
> +  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
> +                                              'defined(TEST_IF_COND_2)'] } ] }
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
> index aca43186a9..4061152cae 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -412,3 +412,26 @@ object q_obj_test-features-arg
>      member cfs3: CondFeatureStruct3 optional=False
>  command test-features q_obj_test-features-arg -> None
>      gen=True success_response=True boxed=False oob=False preconfig=False
> +command test-command-features1 None -> None
> +    gen=True success_response=True boxed=False oob=False preconfig=False
> +command test-command-features2 None -> None
> +    gen=True success_response=True boxed=False oob=False preconfig=False
> +    feature feature1
> +command test-command-features3 None -> None
> +    gen=True success_response=True boxed=False oob=False preconfig=False
> +    feature feature1
> +    feature feature2
> +command test-command-features4 None -> None
> +    gen=True success_response=True boxed=False oob=False preconfig=False
> +    feature feature1
> +        if ['defined(TEST_IF_FEATURE_1)']
> +command test-command-features5 None -> None
> +    gen=True success_response=True boxed=False oob=False preconfig=False
> +    feature feature1
> +        if ['defined(TEST_IF_FEATURE_1)']
> +    feature feature2
> +        if ['defined(TEST_IF_FEATURE_2)']
> +command test-command-features6 None -> None
> +    gen=True success_response=True boxed=False oob=False preconfig=False
> +    feature feature1
> +        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']

This might border on OCD...  Your new tests for commands are patterned
after the existing tests for structs.  You omit a few, and that's okay.
I'd like the names of corresponding tests to match; see appended
incremental patch.

[...]


diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index ba623fda29..27b0afe55a 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -51,27 +51,27 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
 {
 }
 
+void qmp_test_command_features0(Error **errp)
+{
+}
+
 void qmp_test_command_features1(Error **errp)
 {
 }
 
-void qmp_test_command_features2(Error **errp)
-{
-}
-
 void qmp_test_command_features3(Error **errp)
 {
 }
 
-void qmp_test_command_features4(Error **errp)
+void qmp_test_command_cond_features1(Error **errp)
 {
 }
 
-void qmp_test_command_features5(Error **errp)
+void qmp_test_command_cond_features2(Error **errp)
 {
 }
 
-void qmp_test_command_features6(Error **errp)
+void qmp_test_command_cond_features3(Error **errp)
 {
 }
 
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 80811dc8f0..9abf175fe0 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -293,22 +293,18 @@
 
 # test 'features' for command
 
+{ 'command': 'test-command-features0',
+  'features': [] }
 { 'command': 'test-command-features1',
-  'features': [] }
-
-{ 'command': 'test-command-features2',
   'features': [ 'feature1' ] }
-
 { 'command': 'test-command-features3',
   'features': [ 'feature1', 'feature2' ] }
 
-{ 'command': 'test-command-features4',
+{ 'command': 'test-command-cond-features1',
   'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'} ] }
-
-{ 'command': 'test-command-features5',
+{ 'command': 'test-command-cond-features2',
   'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
                 { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }
-
-{ 'command': 'test-command-features6',
+{ 'command': 'test-command-cond-features3',
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] } ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 4061152cae..3660e75a48 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -412,26 +412,26 @@ object q_obj_test-features-arg
     member cfs3: CondFeatureStruct3 optional=False
 command test-features q_obj_test-features-arg -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
+command test-command-features0 None -> None
+    gen=True success_response=True boxed=False oob=False preconfig=False
 command test-command-features1 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
-command test-command-features2 None -> None
-    gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
 command test-command-features3 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
     feature feature2
-command test-command-features4 None -> None
+command test-command-cond-features1 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
         if ['defined(TEST_IF_FEATURE_1)']
-command test-command-features5 None -> None
+command test-command-cond-features2 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
         if ['defined(TEST_IF_FEATURE_1)']
     feature feature2
         if ['defined(TEST_IF_FEATURE_2)']
-command test-command-features6 None -> None
+command test-command-cond-features3 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']

