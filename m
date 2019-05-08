Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F231C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E1D20850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E1D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMIX-0005oH-PO
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:07:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOMFf-0003WA-Le
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOMFe-0000rv-GG
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:04:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hOMFe-0000qs-8i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:04:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FBD181E1E;
	Wed,  8 May 2019 13:04:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E57D600D4;
	Wed,  8 May 2019 13:04:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id E12C51132B35; Wed,  8 May 2019 15:04:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190506213817.14344-1-ehabkost@redhat.com>
	<20190507141345.GS27205@redhat.com>
	<20190507144500.GK28722@habkost.net>
Date: Wed, 08 May 2019 15:04:43 +0200
In-Reply-To: <20190507144500.GK28722@habkost.net> (Eduardo Habkost's message
	of "Tue, 7 May 2019 11:45:00 -0300")
Message-ID: <87pnot2j2s.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Wed, 08 May 2019 13:04:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] tests: Force Python I/O encoding for
 check-qapi-schema
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, May 07, 2019 at 03:13:45PM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, May 06, 2019 at 06:38:17PM -0300, Eduardo Habkost wrote:
>> > test-qapi.py doesn't force a specific encoding for stderr or
>> > stdout, but the reference files used by check-qapi-schema are in
>> > UTF-8.  This breaks check-qapi-schema under certain circumstances
>> > (e.g. if using the C locale and Python < 3.7).
>> >=20
>> > We need to make sure test-qapi.py always generate UTF-8 output
>> > somehow.  On Python 3.7+ we can do it using
>> > `sys.stdout.reconfigure(...)`, but we need a solution that works
>> > with older Python versions.
>> >=20
>> > Instead of trying a hack like reopening sys.stdout and
>> > sys.stderr, we can just tell Python to use UTF-8 for I/O encoding
>> > when running test-qapi.py.  Do it by setting PYTHONIOENCODING.
>> >=20
>> > Reported-by: Thomas Huth <thuth@redhat.com>
>> > Tested-by: Thomas Huth <thuth@redhat.com>
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> >  tests/Makefile.include | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > diff --git a/tests/Makefile.include b/tests/Makefile.include
>> > index 7c8b9c84b2..af88ab6f8b 100644
>> > --- a/tests/Makefile.include
>> > +++ b/tests/Makefile.include
>> > @@ -1103,7 +1103,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-io=
tests-quick.sh qemu-img$(EXESUF)
>> >  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
>> >  $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_P=
ATH)/%.json
>> >  	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
>> > -		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
>> > +		PYTHONIOENCODING=3Dutf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/te=
st-qapi.py \
>>=20
>> I see PYTHONIOENCODING exists since 2.6 which is nice.
>>=20
>> How about we actually change $(PYTHON) so that it always includes
>> PYTHONIOENCODING=3Dutf-8 ?
>>=20
>> That way we avoid continuing to play whack-a-mole with more utf-8
>> bugs in future.
>>=20
>> It would also let us revert this:
>>=20
>>   commit de685ae5e9a4b523513033bd6cadc8187a227170
>>   Author: Markus Armbruster <armbru@redhat.com>
>>   Date:   Mon Jun 18 19:59:57 2018 +0200
>>=20
>>     qapi: Open files with encoding=3D'utf-8'
>>=20
>> which had to provide separate logic for py2 vs py3 :-(

The separate logic will soon be history.  I'd welcome getting rid of the
remainder anyway.

> Not every Python script in the QEMU tree is run by our makefiles
> and scripts using $(PYTHON).  We need to ensure our scripts and
> modules won't break when run directly from the command line, too.
> Setting PYTHONIOENCODING everywhere would just hide these bugs
> from us.

I agree for Python scripts that are meant to be run that way (assuming
such scripts exist).  For all the others (including all the QAPI-related
scripts), I'd be quite fine with

1. Our build system runs all Python scripts with the
PYTHONIOENCODING=3Dutf-8

2. If you run a Python script yourself, you get to specify the
PYTHONIOENCODING=3Dutf-8, or use a suitable locale.  Enabling UTF-8 mode
with PYTHONUTF8=3D1 or -X utf8 could also work.

