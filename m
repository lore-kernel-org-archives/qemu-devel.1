Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A713C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B1D2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B1D2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYtW-0005V5-Vw
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIYst-00053x-Ot
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIYss-0003Ap-Ba
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iIYss-0003AF-3b
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:53:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6489D10F2E81
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 13:53:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 089FF1001B11;
 Thu, 10 Oct 2019 13:53:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD8521138619; Thu, 10 Oct 2019 15:53:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v3 2/3] tests: qapi: Test 'features' of commands
References: <cover.1570705279.git.pkrempa@redhat.com>
 <7a97c6dbe0747f604a4da81ff055fbf3ac97afb3.1570705279.git.pkrempa@redhat.com>
Date: Thu, 10 Oct 2019 15:53:30 +0200
In-Reply-To: <7a97c6dbe0747f604a4da81ff055fbf3ac97afb3.1570705279.git.pkrempa@redhat.com>
 (Peter Krempa's message of "Thu, 10 Oct 2019 13:05:23 +0200")
Message-ID: <87pnj4ogf9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 10 Oct 2019 13:53:37 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---
>  tests/qapi-schema/qapi-schema-test.json | 26 ++++++++++++++++++++++
>  tests/qapi-schema/qapi-schema-test.out  | 29 +++++++++++++++++++++++++
>  tests/qapi-schema/test-qapi.py          |  4 ++++
>  tests/test-qmp-cmds.c                   | 28 ++++++++++++++++++++++++
>  4 files changed, 87 insertions(+)

More thorough than I asked for.  I'm not complaining :)

>
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
> index 75c42eb0e3..220859d4c9 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -290,3 +290,29 @@
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
> +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
> +                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }

Do you need both test-command-features5 and 6?  They look the same to me...

> +
> +{ 'command': 'test-command-features7',
> +  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
> +                                              'defined(TEST_IF_COND_2)'] } ] }
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
> index 98031da96f..a38e348d54 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -412,3 +412,32 @@ object q_obj_test-features-arg
>      member cfs3: CondFeatureStruct3 optional=False
>  command test-features q_obj_test-features-arg -> None
>     gen=True success_response=True boxed=False oob=False preconfig=False
> +command test-command-features1 None -> None
> +   gen=True success_response=True boxed=False oob=False preconfig=False
> +command test-command-features2 None -> None
> +   gen=True success_response=True boxed=False oob=False preconfig=False
> +   feature feature1
> +command test-command-features3 None -> None
> +   gen=True success_response=True boxed=False oob=False preconfig=False
> +   feature feature1
> +   feature feature2
> +command test-command-features4 None -> None
> +   gen=True success_response=True boxed=False oob=False preconfig=False
> +   feature feature1
> +        if ['defined(TEST_IF_FEATURE_1)']
> +command test-command-features5 None -> None
> +   gen=True success_response=True boxed=False oob=False preconfig=False
> +   feature feature1
> +        if ['defined(TEST_IF_FEATURE_1)']
> +   feature feature2
> +        if ['defined(TEST_IF_FEATURE_2)']
> +command test-command-features6 None -> None
> +   gen=True success_response=True boxed=False oob=False preconfig=False
> +   feature feature1
> +        if ['defined(TEST_IF_FEATURE_1)']
> +   feature feature2
> +        if ['defined(TEST_IF_FEATURE_2)']
> +command test-command-features7 None -> None
> +   gen=True success_response=True boxed=False oob=False preconfig=False
> +   feature feature1
> +        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
> index e13c2e8671..62e65b6a7d 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -80,6 +80,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>          print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s'
>                % (gen, success_response, boxed, allow_oob, allow_preconfig))
>          self._print_if(ifcond)
> +        if features:
> +            for f in features:
> +                print('   feature %s' % f.name)
> +                self._print_if(f.ifcond, 8)

Copied from visit_object_type().  Let's factor it into a @staticmethod
_print_features().

>
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
>          print('event %s %s' % (name, arg_type and arg_type.name))
> diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
> index 36fdf5b115..19f6e06ba7 100644
> --- a/tests/test-qmp-cmds.c
> +++ b/tests/test-qmp-cmds.c
> @@ -51,6 +51,34 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
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
> +void qmp_test_command_features7(Error **errp)
> +{
> +}
> +
>  UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
>                                bool has_udb1, UserDefOne *ud1b,
>                                Error **errp)

Any particular reason why we shouldn't squash this into PATCH 1?

