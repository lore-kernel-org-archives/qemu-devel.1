Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E1BC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ADF32087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADF32087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47510 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0s7-0002Yo-RC
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 10:15:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hO0r2-0001jS-V4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hO0r1-0002yB-81
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hO0r0-0002wy-F0
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F42A307ACF9;
	Tue,  7 May 2019 14:13:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 398E05D9CC;
	Tue,  7 May 2019 14:13:48 +0000 (UTC)
Date: Tue, 7 May 2019 15:13:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190507141345.GS27205@redhat.com>
References: <20190506213817.14344-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190506213817.14344-1-ehabkost@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 07 May 2019 14:13:57 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 06, 2019 at 06:38:17PM -0300, Eduardo Habkost wrote:
> test-qapi.py doesn't force a specific encoding for stderr or
> stdout, but the reference files used by check-qapi-schema are in
> UTF-8.  This breaks check-qapi-schema under certain circumstances
> (e.g. if using the C locale and Python < 3.7).
> 
> We need to make sure test-qapi.py always generate UTF-8 output
> somehow.  On Python 3.7+ we can do it using
> `sys.stdout.reconfigure(...)`, but we need a solution that works
> with older Python versions.
> 
> Instead of trying a hack like reopening sys.stdout and
> sys.stderr, we can just tell Python to use UTF-8 for I/O encoding
> when running test-qapi.py.  Do it by setting PYTHONIOENCODING.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 7c8b9c84b2..af88ab6f8b 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1103,7 +1103,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF)
>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
>  $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_PATH)/%.json
>  	$(call quiet-command, PYTHONPATH=$(SRC_PATH)/scripts \
> -		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
> +		PYTHONIOENCODING=utf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \

I see PYTHONIOENCODING exists since 2.6 which is nice.

How about we actually change $(PYTHON) so that it always includes
PYTHONIOENCODING=utf-8 ?

That way we avoid continuing to play whack-a-mole with more utf-8
bugs in future.

It would also let us revert this:

  commit de685ae5e9a4b523513033bd6cadc8187a227170
  Author: Markus Armbruster <armbru@redhat.com>
  Date:   Mon Jun 18 19:59:57 2018 +0200

    qapi: Open files with encoding='utf-8'

which had to provide separate logic for py2 vs py3 :-(

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

