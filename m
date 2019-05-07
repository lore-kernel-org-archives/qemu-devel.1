Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EC2C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8F3B20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 14:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F3B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1MK-0000ZP-VT
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 10:46:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hO1LC-0007x7-9E
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hO1LB-0000k5-75
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:45:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hO1LA-0000jg-VW
	for qemu-devel@nongnu.org; Tue, 07 May 2019 10:45:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E92F307D935;
	Tue,  7 May 2019 14:45:08 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 372792CFC6;
	Tue,  7 May 2019 14:45:02 +0000 (UTC)
Date: Tue, 7 May 2019 11:45:00 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190507144500.GK28722@habkost.net>
References: <20190506213817.14344-1-ehabkost@redhat.com>
	<20190507141345.GS27205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190507141345.GS27205@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 07 May 2019 14:45:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 03:13:45PM +0100, Daniel P. Berrang=E9 wrote:
> On Mon, May 06, 2019 at 06:38:17PM -0300, Eduardo Habkost wrote:
> > test-qapi.py doesn't force a specific encoding for stderr or
> > stdout, but the reference files used by check-qapi-schema are in
> > UTF-8.  This breaks check-qapi-schema under certain circumstances
> > (e.g. if using the C locale and Python < 3.7).
> >=20
> > We need to make sure test-qapi.py always generate UTF-8 output
> > somehow.  On Python 3.7+ we can do it using
> > `sys.stdout.reconfigure(...)`, but we need a solution that works
> > with older Python versions.
> >=20
> > Instead of trying a hack like reopening sys.stdout and
> > sys.stderr, we can just tell Python to use UTF-8 for I/O encoding
> > when running test-qapi.py.  Do it by setting PYTHONIOENCODING.
> >=20
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Tested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  tests/Makefile.include | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 7c8b9c84b2..af88ab6f8b 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -1103,7 +1103,7 @@ check-tests/qemu-iotests-quick.sh: tests/qemu-i=
otests-quick.sh qemu-img$(EXESUF)
> >  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
> >  $(patsubst %, check-%, $(check-qapi-schema-y)): check-%.json: $(SRC_=
PATH)/%.json
> >  	$(call quiet-command, PYTHONPATH=3D$(SRC_PATH)/scripts \
> > -		$(PYTHON) $(SRC_PATH)/tests/qapi-schema/test-qapi.py \
> > +		PYTHONIOENCODING=3Dutf-8 $(PYTHON) $(SRC_PATH)/tests/qapi-schema/t=
est-qapi.py \
>=20
> I see PYTHONIOENCODING exists since 2.6 which is nice.
>=20
> How about we actually change $(PYTHON) so that it always includes
> PYTHONIOENCODING=3Dutf-8 ?
>=20
> That way we avoid continuing to play whack-a-mole with more utf-8
> bugs in future.
>=20
> It would also let us revert this:
>=20
>   commit de685ae5e9a4b523513033bd6cadc8187a227170
>   Author: Markus Armbruster <armbru@redhat.com>
>   Date:   Mon Jun 18 19:59:57 2018 +0200
>=20
>     qapi: Open files with encoding=3D'utf-8'
>=20
> which had to provide separate logic for py2 vs py3 :-(

Not every Python script in the QEMU tree is run by our makefiles
and scripts using $(PYTHON).  We need to ensure our scripts and
modules won't break when run directly from the command line, too.
Setting PYTHONIOENCODING everywhere would just hide these bugs
from us.

--=20
Eduardo

