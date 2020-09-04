Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A8DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C66F206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnFJRhIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C66F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECnr-0000Kb-OD
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kECnE-0007oe-JC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kECnA-0004Ls-I9
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 10:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599230053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7tpVB8gm9XidZP5cJOudnVX+PtoHPhL+/W3W2Lr1YKo=;
 b=UnFJRhIWmSmyVQiqOBPPE8JWntHfKPKpNfkbQFBCVzlXyU9qUZ62PUngIGQSA0WqacUpjV
 g0JTzza3WF2n0LVF4IHOZXlD8nBtX2zWrBaxcAUzDD5ezQcSsUlmSzlchNETdrHZw9mxal
 lN/8T0FAyRAQciQ/85HjY8/MfcDtdpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-OyoxJQ7PP3qrhR8XPzu7sA-1; Fri, 04 Sep 2020 10:34:09 -0400
X-MC-Unique: OyoxJQ7PP3qrhR8XPzu7sA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2FF618BA285;
 Fri,  4 Sep 2020 14:34:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5666074E33;
 Fri,  4 Sep 2020 14:34:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BC1311132B59; Fri,  4 Sep 2020 16:34:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 00/20] Convert QAPI doc comments to generate rST
 instead of texinfo
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
Date: Fri, 04 Sep 2020 16:34:06 +0200
In-Reply-To: <CAFEAcA9cyKVwONYuzG3oPcQQ9sibpdtetCjcBe3133gd09Aa9w@mail.gmail.com>
 (Peter Maydell's message of "Thu, 27 Aug 2020 12:25:53 +0100")
Message-ID: <87d0314nmp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Mon, 10 Aug 2020 at 20:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>> This series switches all our QAPI doc comments over from
>> texinfo format to rST. It then removes all the texinfo
>> machinery, because this was the last user of texinfo.
>>
>> This is largely just a rebase of patchset v4 to current master.

It needs another rebase now, for the Meson build system.

>> There are a few things I have left out of this initial series:
>
> I realized there is something I forgot to add to this "left out" list:
>
> Sphinx needs to know what all the input files which go into
> a document are, as it builds up dependencies to tell it whether
> to rebuild the output or not. The docs/sphinx/qapidoc.py
> plugin adds such a dependency on the file that the .rst
> docs reference (eg qapi/qapi-schema.json)

In QAPIDocDirective.run():

        # Tell sphinx of the dependency
        env.note_dependency(os.path.abspath(qapifile))


>                                           but it does not
> have a mechanism for adding dependencies when that .json
> file uses an 'include' to pull in other .json files.
>
> I'm not sure whether the scripts/qapi code supports telling
> a consumer of the parsed info about this -- is it sufficient
> for QAPISchemaGenRSTVisitor to implement the 'visit_include'
> method, find the path to the included .qapi file from the
> arguments and call Sphinx's env.notedependency(), or do we
> need to do something more complicated to get the list of
> all the included .qapi files ?

Visitors can implement visit_include() to see include directives.
QAPISchemaModularCVisitor does, to generate #include that mirror the
source schema.  This is not what your want.

You want visit_module().  The appended hack makes qapi-gen.py spit out
the modules when it generates types, e.g.:

    $ python3 -B scripts/qapi-gen.py -o scratch tests/qapi-schema/qapi-schema-test.json 
    ### None
    ### 'qapi-schema-test.json'
    ### 'include/sub-module.json'
    ### 'sub-sub-module.json'

As you can see, the module names are file names relative to the main
module's directory.

Module None is for built-ins.

Unfortunately, your qapidoc.py bypasses the regular schema.visit() just
like old doc.py does, and for the same reason: it wants to iterate over
doc comments, not definitions.  Doc comments were bolted on later, and
it still shows.

I figure the clean solution is making schema.visit() pass doc comments
just like it passes entities.  Gets rid of the need to bypass
schema.visit().  Requires surgery to QAPISchema and QAPISchemaParser.

A quick hack: use a trivial QAPISchemaVisitor just to collect the
modules.

Questions?



diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 3ad33af4ee..cec89e199c 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -274,6 +274,10 @@ class QAPISchemaGenTypeVisitor(QAPISchemaModularCVisitor):
         # gen_object() is recursive, ensure it doesn't visit the empty type
         objects_seen.add(schema.the_empty_object_type.name)
 
+    def visit_module(self, name):
+        print('### %r' % name)
+        super().visit_module(name)
+
     def _gen_type_cleanup(self, name):
         self._genh.add(gen_type_cleanup_decl(name))
         self._genc.add(gen_type_cleanup(name))


