Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163F2C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E8220797
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoKKZ0p4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E8220797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBv0-0000Jq-Oc
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEBuO-0008Cb-PQ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:37:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEBuM-0005DN-5X
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599226656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8ijyo9+wVenfwSwyNoFh/rmMtU7RcqAaFooiEOCDv4=;
 b=HoKKZ0p4j1kEg68rT7GbDxsRwfUFiXMtfwts2/yaaeBW92zLW25AtbF2GDTnTK4DUsNlXn
 fwsrsQnBs2MbQ1bN0O4qaNm3YrulYldF15sRn93bAkM5OYznS6/vAPZDZ5uTRC0QM2w2+e
 sP1jfGdJgE4DO4pxs5xBzKyJPq1t694=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-fc5DKkuNN0SvpLoNfbI9rA-1; Fri, 04 Sep 2020 09:37:33 -0400
X-MC-Unique: fc5DKkuNN0SvpLoNfbI9rA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 364068B1421;
 Fri,  4 Sep 2020 13:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D320760C0F;
 Fri,  4 Sep 2020 13:37:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 500E31132B59; Fri,  4 Sep 2020 15:37:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 14/20] scripts/qapi: Remove texinfo generation support
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-15-peter.maydell@linaro.org>
Date: Fri, 04 Sep 2020 15:37:30 +0200
In-Reply-To: <20200810195019.25427-15-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 10 Aug 2020 20:50:13 +0100")
Message-ID: <87y2lp64th.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> We no longer use the generated texinfo format documentation,
> so delete the code that generates it, and the test case for
> the generation.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile                        |   1 -
>  scripts/qapi-gen.py             |   2 -
>  scripts/qapi/doc.py             | 302 ------------------------------
>  scripts/qapi/gen.py             |   7 -
>  tests/Makefile.include          |  15 +-
>  tests/qapi-schema/doc-good.texi | 313 --------------------------------
>  6 files changed, 1 insertion(+), 639 deletions(-)
>  delete mode 100644 scripts/qapi/doc.py
>  delete mode 100644 tests/qapi-schema/doc-good.texi
>
> diff --git a/Makefile b/Makefile
> index 3df1cf68333..fc3ccc15030 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -626,7 +626,6 @@ qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
>  qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
>  $(SRC_PATH)/scripts/qapi/commands.py \
>  $(SRC_PATH)/scripts/qapi/common.py \
> -$(SRC_PATH)/scripts/qapi/doc.py \
>  $(SRC_PATH)/scripts/qapi/error.py \
>  $(SRC_PATH)/scripts/qapi/events.py \
>  $(SRC_PATH)/scripts/qapi/expr.py \
> diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> index 4b03f7d53be..541e8c1f55d 100755
> --- a/scripts/qapi-gen.py
> +++ b/scripts/qapi-gen.py
> @@ -10,7 +10,6 @@ import re
>  import sys
>  
>  from qapi.commands import gen_commands
> -from qapi.doc import gen_doc
>  from qapi.events import gen_events
>  from qapi.introspect import gen_introspect
>  from qapi.schema import QAPIError, QAPISchema
> @@ -51,7 +50,6 @@ def main(argv):
>      gen_commands(schema, args.output_dir, args.prefix)
>      gen_events(schema, args.output_dir, args.prefix)
>      gen_introspect(schema, args.output_dir, args.prefix, args.unmask)
> -    gen_doc(schema, args.output_dir, args.prefix)
>  
>  
>  if __name__ == '__main__':
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> deleted file mode 100644
> index 7764de1e4bc..00000000000
> --- a/scripts/qapi/doc.py
> +++ /dev/null
[...]
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index bf5552a4e7f..ca66c82b5b8 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -178,13 +178,6 @@ def ifcontext(ifcond, *args):
>          arg.end_if()
>  
>  
> -class QAPIGenDoc(QAPIGen):
> -
> -    def _top(self):
> -        return (super()._top()
> -                + '@c AUTOMATICALLY GENERATED, DO NOT MODIFY\n\n')
> -
> -
>  class QAPISchemaMonolithicCVisitor(QAPISchemaVisitor):
>  
>      def __init__(self, prefix, what, blurb, pydoc):
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index c7e4646ded7..ec83efeaa63 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -38,7 +38,6 @@ export SRC_PATH
>  qapi-py = $(SRC_PATH)/scripts/qapi/__init__.py \
>  $(SRC_PATH)/scripts/qapi/commands.py \
>  $(SRC_PATH)/scripts/qapi/common.py \
> -$(SRC_PATH)/scripts/qapi/doc.py \
>  $(SRC_PATH)/scripts/qapi/error.py \
>  $(SRC_PATH)/scripts/qapi/events.py \
>  $(SRC_PATH)/scripts/qapi/expr.py \
> @@ -501,16 +500,8 @@ tests/test-qapi-gen-timestamp: \
>  	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
>  		-o tests -p "test-" $<, \
>  		"GEN","$(@:%-timestamp=%)")
> -	@rm -f tests/test-qapi-doc.texi
>  	@>$@
>  
> -tests/qapi-schema/doc-good.test.texi: $(SRC_PATH)/tests/qapi-schema/doc-good.json $(qapi-py)
> -	$(call quiet-command,$(PYTHON) $(SRC_PATH)/scripts/qapi-gen.py \
> -		-o tests/qapi-schema -p "doc-good-" $<, \
> -		"GEN","$@")
> -	@mv tests/qapi-schema/doc-good-qapi-doc.texi $@
> -	@rm -f tests/qapi-schema/doc-good-qapi-*.[ch] tests/qapi-schema/doc-good-qmp-*.[ch]
> -
>  tests/qtest/dbus-vmstate1.h tests/qtest/dbus-vmstate1.c: tests/qtest/dbus-vmstate1-gen-timestamp ;
>  tests/qtest/dbus-vmstate1-gen-timestamp: $(SRC_PATH)/tests/qtest/dbus-vmstate1.xml
>  	$(call quiet-command,$(GDBUS_CODEGEN) $< \
> @@ -891,10 +882,6 @@ check-tests/qapi-schema/frontend: $(addprefix $(SRC_PATH)/, $(check-qapi-schema-
>  	  PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py $^, \
>  	  TEST, check-qapi-schema)
>  
> -.PHONY: check-tests/qapi-schema/doc-good.texi
> -check-tests/qapi-schema/doc-good.texi: tests/qapi-schema/doc-good.test.texi
> -	@diff -u $(SRC_PATH)/tests/qapi-schema/doc-good.texi $<
> -

We shouldn't just delete this test.

It is for checking the doc generator does what it should for "good"
input.  "Bad" input is coverd by the other doc-*.json.

With the old doc generation system, the testing "good" input is
straightforward: generate Texinfo, diff to expected Texinfo, which is
committed to git.

This test has been invaliable when maintaining and extending doc.py.

With the new system, there is no ouput suitable for diffing, as the
various outputs all depend on the version of Sphinx.

Or is there?  Is there a way to have Sphinx "unparse" its internal
representation of the input?

If not, we should still run doc-good.json through the doc generator to
at least catch errors.  We still lose the ability to catch silent bad
output.

>  .PHONY: check-decodetree
>  check-decodetree:
>  	$(call quiet-command, \
> @@ -956,7 +943,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>  # Consolidated targets
>  
>  .PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean get-vm-images
> -check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
> +check-qapi-schema: check-tests/qapi-schema/frontend
>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  ifeq ($(CONFIG_TOOLS),y)
>  check-block: $(patsubst %,check-%, $(check-block-y))
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
> deleted file mode 100644
> index 12808989ffb..00000000000
> --- a/tests/qapi-schema/doc-good.texi
> +++ /dev/null
[...]


