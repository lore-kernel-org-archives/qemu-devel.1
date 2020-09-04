Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC84C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076142074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076142074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE4s-0005Lg-2S
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEE2l-00017g-Ln
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:54:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEE2j-0000gH-0L
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:54:26 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-3KdcvWwTMtSPiz-DIqEyfA-1; Fri, 04 Sep 2020 11:54:20 -0400
X-MC-Unique: 3KdcvWwTMtSPiz-DIqEyfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2A4D1017DC0;
 Fri,  4 Sep 2020 15:54:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A9C5D9CC;
 Fri,  4 Sep 2020 15:54:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3DB581132B59; Fri,  4 Sep 2020 17:54:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 00/20] Convert QAPI doc comments to generate rST
 instead of texinfo
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
 <87d0314nmp.fsf@dusky.pond.sub.org>
 <CAFEAcA9ABUwa_TnyczsO+TtSncX0hHwN7_zgyGGWP6nWtEkdDQ@mail.gmail.com>
Date: Fri, 04 Sep 2020 17:54:18 +0200
In-Reply-To: <CAFEAcA9ABUwa_TnyczsO+TtSncX0hHwN7_zgyGGWP6nWtEkdDQ@mail.gmail.com>
 (Peter Maydell's message of "Fri, 4 Sep 2020 15:48:35 +0100")
Message-ID: <87eenhzget.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:58:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 4 Sep 2020 at 15:34, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > I'm not sure whether the scripts/qapi code supports telling
>> > a consumer of the parsed info about this -- is it sufficient
>> > for QAPISchemaGenRSTVisitor to implement the 'visit_include'
>> > method, find the path to the included .qapi file from the
>> > arguments and call Sphinx's env.notedependency(), or do we
>> > need to do something more complicated to get the list of
>> > all the included .qapi files ?
>>
>> Visitors can implement visit_include() to see include directives.
>> QAPISchemaModularCVisitor does, to generate #include that mirror the
>> source schema.  This is not what your want.
>
> Why not? Surely "see include directives" is exactly what I want?
> Any time the QAPI parser opens a file that's different from the
> initial one we want to know about it.
>
>> You want visit_module().  The appended hack makes qapi-gen.py spit out
>> the modules when it generates types, e.g.:
>>
>>     $ python3 -B scripts/qapi-gen.py -o scratch tests/qapi-schema/qapi-schema-test.json
>>     ### None
>>     ### 'qapi-schema-test.json'
>>     ### 'include/sub-module.json'
>>     ### 'sub-sub-module.json'
>
> What's a "module" here ?

Initially, the include directive was just that: include another file's
contents right here.

Back in 2018, we switched from generating monolithic code to generating
modular code.  What does that mean?

Instead of generating the kitchen sink into a single qapi-types.c, we
split out the stuff generated for each FOO.json included by
qapi-schema.json into qapi-types-FOO.c.

Same for qapi-types.h, but with #include stitching that mirrors the
schema's include directives.  So, if FOO.json includes SUB.json, then
qapi-types-FOO.h will include qapi-types-SUB.h.

Same for qapi-{commands,events,visit}.{c,h}.

The qapi-schema.json (rather: the file you pass to qapi-gen.py) is the
main module.

The .json it includes are the sub-modules.

visit_module() lets you see the modules.

visit_include() lets you see the includes.  The same module can be
included multiple times.  Having to filter that out would be annoying.

>                          Does this still produce output if the
> top level .json file includes a sub-json file that doesn't actually
> have any contents ? (We still want to generate the dependency
> then, so we update the docs if the included file is edited to
> add content.)

If it doesn't, I'd be willing to call it a bug.  I dimly remember fixing
this (or a similar bug) before.


