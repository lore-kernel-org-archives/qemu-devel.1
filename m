Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E8AC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D226217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D226217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54760 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUANS-00051U-DJ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:36:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUAK9-0001gR-Bp
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hUAG5-0005uB-HM
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hUAG3-0005rp-HI; Fri, 24 May 2019 09:29:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B83C7C0AD283;
	Fri, 24 May 2019 13:29:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 82DF66870F;
	Fri, 24 May 2019 13:29:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1749F1138648; Fri, 24 May 2019 15:29:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190517144232.18965-1-kwolf@redhat.com>
	<20190517144232.18965-3-kwolf@redhat.com>
Date: Fri, 24 May 2019 15:29:07 +0200
In-Reply-To: <20190517144232.18965-3-kwolf@redhat.com> (Kevin Wolf's message
	of "Fri, 17 May 2019 16:42:28 +0200")
Message-ID: <87y32w6kws.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 24 May 2019 13:29:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/6] tests/qapi-schema: Test for good
 feature lists in structs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qapi-schema/qapi-schema-test.json | 30 +++++++++++++++++++++++
>  tests/qapi-schema/qapi-schema-test.out  | 32 +++++++++++++++++++++++++
>  tests/qapi-schema/test-qapi.py          |  4 ++++
>  3 files changed, 66 insertions(+)
>
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
> index 0952c68734..35a50fbe54 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -242,3 +242,33 @@
>    { 'foo': 'TestIfStruct',
>      'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } },
>    'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
> +
> +# test 'features' for structs
> +
> +{ 'struct': 'FeatureStruct0',
> +  'data': { 'foo': 'int' },
> +  'features': [] }
> +{ 'struct': 'FeatureStruct1',
> +  'data': { 'foo': 'int' },
> +  'features': [ 'feature1' ] }
> +{ 'struct': 'FeatureStruct2',
> +  'data': { 'foo': 'int' },
> +  'features': [ { 'name': 'feature1' } ] }
> +{ 'struct': 'FeatureStruct3',
> +  'data': { 'foo': 'int' },
> +  'features': [ 'feature1', 'feature2' ] }
> +{ 'struct': 'FeatureStruct4',
> +  'data': { 'namespace-test': 'int' },
> +  'features': [ 'namespace-test', 'int', 'name', 'if' ] }
> +
> +{ 'struct': 'CondFeatureStruct1',
> +  'data': { 'foo': 'int' },
> +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'} ] }
> +{ 'struct': 'CondFeatureStruct2',
> +  'data': { 'foo': 'int' },
> +  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'},
> +                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'} ] }
> +{ 'struct': 'CondFeatureStruct3',
> +  'data': { 'foo': 'int' },
> +  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
> +                                              'defined(TEST_IF_COND_2)'] } ] }

Let's add

   { 'command': 'test-features',
     'data': { 'fs0': 'FeatureStruct0',
               'fs1': 'FeatureStruct1',
               'fs2': 'FeatureStruct2',
               'fs3': 'FeatureStruct3',
               'cfs1': 'CondFeatureStruct1',
               'cfs2': 'CondFeatureStruct2',
               'cfs3': 'CondFeatureStruct3' } }

because without it, the feature test cases won't generate introspection
code.

[...]

