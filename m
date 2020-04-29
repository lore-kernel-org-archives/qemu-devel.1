Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77066C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B751205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzh/7dzx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B751205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsIh-0001qq-7d
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jTsHC-0001D8-Ko
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jTsHA-0004ff-Ji
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:21:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22779
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jTsHA-0004f1-0G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588188102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wxYlt+8FlfHhwaHnUi1iFzZDp5puZx0HsaXfE7eMons=;
 b=Yzh/7dzxeROlYX4gvd6lQYhoHTShg4Ay5pgFhQfChN4fxRcvoKFOQlpdvhtTstvMYSUmjt
 IV+YwBg4YnAlbDTmuTm1Ennh2f+0TUAgxurTh2/wWaLte/z+mln1NBS80SMmiVWv+YQU++
 86xxpCYyvalK8/HeNLPyp/Detsf6ktU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-mC4E3-g-MOqzveUM5lscMw-1; Wed, 29 Apr 2020 15:21:36 -0400
X-MC-Unique: mC4E3-g-MOqzveUM5lscMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 752A845F;
 Wed, 29 Apr 2020 19:21:35 +0000 (UTC)
Received: from [10.10.117.103] (ovpn-117-103.rdu2.redhat.com [10.10.117.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D81E35D9C9;
 Wed, 29 Apr 2020 19:21:31 +0000 (UTC)
Subject: Re: [PATCH] tests: add a "check-flake8" test for validating python
 code style
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200429153621.1694266-1-berrange@redhat.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a0da53d6-59a0-1356-d90e-4c1de0a0a744@redhat.com>
Date: Wed, 29 Apr 2020 15:21:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429153621.1694266-1-berrange@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:59:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/29/20 11:36 AM, Daniel P. Berrang=C3=A9 wrote:
> The flake8 program is a standard tool used by Python projects for
> validating many commonly recommended style rules. It would be desirable
> for QEMU to come into alignment with normal Python coding style best
> practices.
>=20
> QEMU currently violates a huge number of the style rules, so we can't
> blindly turn it on. Instead this patch introduces use of flake8 with
> a huge ignore list to turn off everything that is currently violated.
>=20
> The following descriptions are mostly taken from:
>=20
>   https://www.flake8rules.com/
>=20
> Indentation:
>=20
>  E111 =09Indentation is not a multiple of four
>  E114 =09Indentation is not a multiple of four (comment)
>  E115   Expected an indented block (comment)
>  E116 =09Unexpected indentation (comment)
>  E117   Over-indented
>  E121   Continuation line under-indented for hanging indent
>  E122 =09Continuation line missing indentation or outdented
>  E123 =09Closing bracket does not match indentation of opening bracket's =
line
>  E124 =09Closing bracket does not match visual indentation
>  E125 =09Continuation line with same indent as next logical line
>  E126 =09Continuation line over-indented for hanging indent
>  E127 =09Continuation line over-indented for visual indent
>  E128 =09Continuation line under-indented for visual indent
>  E129 =09Visually indented line with same indent as next logical line
>  E131 =09Continuation line unaligned for hanging indent
>=20
> Whitespace:
>=20
>  E201 =09Whitespace after '('
>  E202 =09Whitespace before ')'
>  E203 =09Whitespace before ':'
>  E211 =09Whitespace before '('
>  E221 =09Multiple spaces before operator
>  E222 =09Multiple spaces after operator
>  E225 =09Missing whitespace around operator
>  E226 =09Missing whitespace around arithmetic operator
>  E228 =09Missing whitespace around modulo operator
>  E231 =09Missing whitespace after ',', ';', or ':'
>  E241 =09Multiple spaces after ','
>  E251 =09Unexpected spaces around keyword / parameter equals
>  E261 =09At least two spaces before inline comment
>  E265 =09Block comment should start with '# '
>  E266 =09Too many leading '#' for block comment
>=20
> Blank lines:
>=20
>  E301 =09Expected 1 blank line, found 0
>  E302 =09Expected 2 blank lines, found 0
>  E303 =09Too many blank lines (3)
>  E305 =09Expected 2 blank lines after end of function or class
>  E306 =09Expected 1 blank line before a nested definition
>=20
> Imports:
>=20
>  E401 =09Multiple imports on one line
>  E402 =09Module level import not at top of file
>=20
> Line length:
>=20
>  E501 =09Line too long (82 > 79 characters)
>  E502 =09The backslash is redundant between brackets
>=20
> Statements:
>=20
>  E701 =09Multiple statements on one line (colon)
>  E702 =09Multiple statements on one line (semicolon)
>  E703 =09Statement ends with a semicolon
>  E711 =09Comparison to none should be 'if cond is none:'
>  E712 =09Comparison to true should be 'if cond is true:' or 'if cond:'
>  E713 =09Test for membership should be 'not in'
>  E714 =09Test for object identity should be 'is not'
>  E722   Do not use bare 'except'
>  E731 =09Do not assign a lambda expression, use a def
>  E741 =09Do not use variables named 'I', 'O', or 'l'
>=20
> Errors:
>=20
>  F401 =09Module imported but unused
>  F403 =09'from module import *' used; unable to detect undefined names
>  F405 =09Name may be undefined, or defined from star imports: module
>  F811 =09Redefinition of unused name from line n
>  F821 =09Undefined name name
>  F841 =09Local variable name is assigned to but never used
>=20
> Warnings:
>=20
>  W391 =09Blank line at end of file
>  W503 =09Line break occurred before a binary operator
>  W504 =09Line break occurred after a binary operator
>  W605 =09Invalid escape sequence 'x'
>=20
> Over time code should be fixed and rules removed from the ignore list.
> A handful of style rules may not warrant fixing as the cure is arguably
> worse and very subjective. e.g.
>=20
>  E501: Force breaking lines at < 80 characters results in
>        some really unnatural code formatting which harms
>        readability.
>=20
>  W504: Knuth code style requires the operators "or" and "and" etc
>        to be at the start of line in a multi-line conditional.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> On its own this patch doesn't really do much of use except try to stop th=
e
> situation getting worse. To be valuable some motivated contributor(s)
> would need to go through fixing the code, and re-enabling each excluded
> warning category one at a time.
>=20
> I'm mostly proposing this patch as a starting point for discussion, to
> see if anyone is indeed motivated to take on the code cleanup challenge,
> and feed the fixes in through the various maintainers trees.
>=20
>  tests/Makefile.include | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 51de676298..f08e99b09c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -4,7 +4,7 @@
>  check-help:
>  =09@echo "Regression testing targets:"
>  =09@echo
> -=09@echo " $(MAKE) check                Run unit, qapi-schema, qtest and=
 decodetree"
> +=09@echo " $(MAKE) check                Run unit, qapi-schema, qtest and=
 decodetree flake8"
>  =09@echo
>  =09@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target=
"
>  =09@echo " $(MAKE) check-qtest          Run qtest tests"
> @@ -19,6 +19,7 @@ check-help:
>  =09@echo " $(MAKE) check-report.tap     Generates an aggregated TAP test=
 report"
>  =09@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>  =09@echo " $(MAKE) check-clean          Clean the tests and related data=
"
> +=09@echo " $(MAKE) check-flake8         Clean the tests and related data=
"
>  =09@echo
>  =09@echo " $(MAKE) get-vm-images        Downloads all images used by acc=
eptance tests, according to configured targets (~350 MB each, 1.5 GB max)"
>  =09@echo
> @@ -923,7 +924,40 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TAR=
GETS))
>  ifeq ($(CONFIG_TOOLS),y)
>  check-block: $(patsubst %,check-%, $(check-block-y))
>  endif
> -check: check-block check-qapi-schema check-unit check-softfloat check-qt=
est check-decodetree
> +
> +is_git :=3D $(shell test -d $(SRC_PATH)/.git && echo 1 || echo 0)
> +
> +ifeq (1, $(is_git))
> +PYTHON_FILES =3D $(shell git ls-tree -r HEAD: --name-only | grep '.py$$'=
)
> +PYTHON_FILES +=3D $(shell git ls-tree -r HEAD: --name-only tests/qemu-io=
tests/??? | xargs grep -l '/usr/bin/env python')
> +
> +# Validate many python style rules
> +FLAKE8_INDENTATION =3D E111,E114,E115,E116,E117,E121,E122,E123,E124,E125=
,E126,E127,E128,E129,E131
> +FLAKE8_WHITESPACE =3D E201,E202,E203,E211,E221,E222,E225,E226,E228,E231,=
E241,E251,E261,E265,E266
> +FLAKE8_BLANK_LINES =3D E301,E302,E303,E305,E306
> +FLAKE8_IMPORTS =3D E401,E402
> +FLAKE8_LINE_LENGTH =3D E501,E502
> +FLAKE8_STATEMENTS =3D E701,E702,E703,E711,E712,E713,E714,E722,E731,E741
> +FLAKE8_ERRORS =3D F401,F403,F405,F811,F821,F841
> +FLAKE8_WARNINGS =3D W391,W503,W504,W605
> +
> +FLAKE8_IGNORE =3D $(FLAKE8_INDENTATION),$\
> +               $(FLAKE8_WHITESPACE),$\
> +               $(FLAKE8_BLANK_LINES),$\
> +               $(FLAKE8_IMPORTS),$\
> +               $(FLAKE8_LINE_LENGTH),$\
> +               $(FLAKE8_STATEMENTS),$\
> +               $(FLAKE8_ERRORS),$\
> +               $(FLAKE8_WARNINGS) \
> +               $(NULL)
> +
> +check-flake8:
> +=09$(call quiet-command,flake8 --ignore=3D$(FLAKE8_IGNORE) $(PYTHON_FILE=
S))
> +else
> +check-flake8:
> +endif
> +
> +check: check-block check-qapi-schema check-unit check-softfloat check-qt=
est check-decodetree check-flake8
>  check-clean:
>  =09rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y=
)
>  =09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$=
(target)-y:%=3Dtests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtests/q=
test/%$(EXESUF)))
>=20

Worth pointing out that I have a patchset destined for iotests that
sneaks in a pylintrc file that establishes a much stricter subset for
code in that directory.

It didn't add a makefile entry for it, though.

I also have a lot of patches that work on cleaning up the rest of the
iotest .py files and bringing them up to speed on my pylint subset,
maybe I can take this patch as well and make sure that this minimum is
enforced.

Don't let that stop review on this patch, though. I think it's good to
start enforcing a subset, even if it's almost nothing at all. (And in
practice, I use *both* flake8 and pylint on personal projects, so don't
let that be a criticism against, either.)

--js


