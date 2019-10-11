Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058CEC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9BC2190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE9BC2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpx7-0006ZJ-0b
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIpwG-00069s-Fm
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIpwE-00087g-Oi
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38710)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iIpwE-00086W-GM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE5968E582
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:06:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5161660BE1;
 Fri, 11 Oct 2019 08:06:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C670B1138619; Fri, 11 Oct 2019 10:06:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH v3 2/3] tests: qapi: Test 'features' of commands
References: <cover.1570705279.git.pkrempa@redhat.com>
 <7a97c6dbe0747f604a4da81ff055fbf3ac97afb3.1570705279.git.pkrempa@redhat.com>
 <87pnj4ogf9.fsf@dusky.pond.sub.org>
 <20191011074611.GA1979@andariel.pipo.sk>
Date: Fri, 11 Oct 2019 10:06:11 +0200
In-Reply-To: <20191011074611.GA1979@andariel.pipo.sk> (Peter Krempa's message
 of "Fri, 11 Oct 2019 09:46:11 +0200")
Message-ID: <87k19bhfkc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 11 Oct 2019 08:06:13 +0000 (UTC)
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> On Thu, Oct 10, 2019 at 15:53:30 +0200, Markus Armbruster wrote:
>> Peter Krempa <pkrempa@redhat.com> writes:
>> 
>> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>> > ---
>> >  tests/qapi-schema/qapi-schema-test.json | 26 ++++++++++++++++++++++
>> >  tests/qapi-schema/qapi-schema-test.out  | 29 +++++++++++++++++++++++++
>> >  tests/qapi-schema/test-qapi.py          |  4 ++++
>> >  tests/test-qmp-cmds.c                   | 28 ++++++++++++++++++++++++
>> >  4 files changed, 87 insertions(+)
>> 
>> More thorough than I asked for.  I'm not complaining :)
>> 
>> >
>> > diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
>> > index 75c42eb0e3..220859d4c9 100644
>> > --- a/tests/qapi-schema/qapi-schema-test.json
>> > +++ b/tests/qapi-schema/qapi-schema-test.json
>> > @@ -290,3 +290,29 @@
>> >              'cfs1': 'CondFeatureStruct1',
>> >              'cfs2': 'CondFeatureStruct2',
>> >              'cfs3': 'CondFeatureStruct3' } }
>> > +
>> > +# test 'features' for command
>> > +
>> > +{ 'command': 'test-command-features1',
>> > +  'features': [] }
>> > +
>> > +{ 'command': 'test-command-features2',
>> > +  'features': [ 'feature1' ] }
>> > +
>> > +{ 'command': 'test-command-features3',
>> > +  'features': [ 'feature1', 'feature2' ] }
>> > +
>> > +{ 'command': 'test-command-features4',
>> > +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'} ] }
>> > +
>> > +{ 'command': 'test-command-features5',
>> > +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
>> > +                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }
>> > +
>> > +{ 'command': 'test-command-features6',
>> > +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
>> > +                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }
>> 
>> Do you need both test-command-features5 and 6?  They look the same to me...
>
> No. It can be dropped. Looks like I mistakenly appropriated
> 'CondFeatureStruct2' test twice :/

Easy enough to fix :)

>> > +{ 'command': 'test-command-features7',
>> > +  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
>> > +                                              'defined(TEST_IF_COND_2)'] } ] }
>> > diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
>> > index 98031da96f..a38e348d54 100644
>> > --- a/tests/qapi-schema/qapi-schema-test.out
>> > +++ b/tests/qapi-schema/qapi-schema-test.out
>> > @@ -412,3 +412,32 @@ object q_obj_test-features-arg
>> >      member cfs3: CondFeatureStruct3 optional=False
>> >  command test-features q_obj_test-features-arg -> None
>> >     gen=True success_response=True boxed=False oob=False preconfig=False
>> > +command test-command-features1 None -> None
>> > +   gen=True success_response=True boxed=False oob=False preconfig=False
>> > +command test-command-features2 None -> None
>> > +   gen=True success_response=True boxed=False oob=False preconfig=False
>> > +   feature feature1
>> > +command test-command-features3 None -> None
>> > +   gen=True success_response=True boxed=False oob=False preconfig=False
>> > +   feature feature1
>> > +   feature feature2
>> > +command test-command-features4 None -> None
>> > +   gen=True success_response=True boxed=False oob=False preconfig=False
>> > +   feature feature1
>> > +        if ['defined(TEST_IF_FEATURE_1)']
>> > +command test-command-features5 None -> None
>> > +   gen=True success_response=True boxed=False oob=False preconfig=False
>> > +   feature feature1
>> > +        if ['defined(TEST_IF_FEATURE_1)']
>> > +   feature feature2
>> > +        if ['defined(TEST_IF_FEATURE_2)']
>> > +command test-command-features6 None -> None
>> > +   gen=True success_response=True boxed=False oob=False preconfig=False
>> > +   feature feature1
>> > +        if ['defined(TEST_IF_FEATURE_1)']
>> > +   feature feature2
>> > +        if ['defined(TEST_IF_FEATURE_2)']
>> > +command test-command-features7 None -> None
>> > +   gen=True success_response=True boxed=False oob=False preconfig=False
>> > +   feature feature1
>> > +        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
>> > diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
>> > index e13c2e8671..62e65b6a7d 100755
>> > --- a/tests/qapi-schema/test-qapi.py
>> > +++ b/tests/qapi-schema/test-qapi.py
>> > @@ -80,6 +80,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>> >          print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s'
>> >                % (gen, success_response, boxed, allow_oob, allow_preconfig))
>> >          self._print_if(ifcond)
>> > +        if features:
>> > +            for f in features:
>> > +                print('   feature %s' % f.name)
>> > +                self._print_if(f.ifcond, 8)
>> 
>> Copied from visit_object_type().  Let's factor it into a @staticmethod
>> _print_features().
>
> I'm not sure if that's intentional but the 'struct' and 'command'
> feature printers differ in indentation level by one space. I went for
> aligning it with the 'gen' line above. I thought it's for visual
> separation with other possible lines.

You're right.  I think I simply messed up the spacing in commit
156402e5042.  I'd like to clean it up.

I think it's easiest if I do the touch-ups here and in PATCH 1 (they're
all straightforward).  I'll post them as v4 so you can give them a quick
eye-over.

>> >      def visit_event(self, name, info, ifcond, arg_type, boxed):
>> >          print('event %s %s' % (name, arg_type and arg_type.name))
>> > diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
>> > index 36fdf5b115..19f6e06ba7 100644
>> > --- a/tests/test-qmp-cmds.c
>> > +++ b/tests/test-qmp-cmds.c
>> > @@ -51,6 +51,34 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
>> >  {
>> >  }
>> >
>> > +void qmp_test_command_features1(Error **errp)
>> > +{
>> > +}
>> > +
>> > +void qmp_test_command_features2(Error **errp)
>> > +{
>> > +}
>> > +
>> > +void qmp_test_command_features3(Error **errp)
>> > +{
>> > +}
>> > +
>> > +void qmp_test_command_features4(Error **errp)
>> > +{
>> > +}
>> > +
>> > +void qmp_test_command_features5(Error **errp)
>> > +{
>> > +}
>> > +
>> > +void qmp_test_command_features6(Error **errp)
>> > +{
>> > +}
>> > +
>> > +void qmp_test_command_features7(Error **errp)
>> > +{
>> > +}
>> > +
>> >  UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
>> >                                bool has_udb1, UserDefOne *ud1b,
>> >                                Error **errp)
>> 
>> Any particular reason why we shouldn't squash this into PATCH 1?
>
> Not really. I tend to prefer tests added separately and it was also done
> so in case of features for 'structs' so I went with that approach. Said
> that I'm perfectly fine with squashing them.

Okay.

