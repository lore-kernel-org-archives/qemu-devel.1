Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B93C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44B2206D6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 23:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+0sZz3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44B2206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVlII-00032e-Q0
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 18:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iVlHU-0002NH-97
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iVlHR-0007AV-HT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:45:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37142
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iVlHR-0007AG-DD
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 18:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573861532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOLo+lAb3vrdzQHlo0ifbBRIf+NP/VkMSg2pC2xpcyo=;
 b=i+0sZz3I7ZlnVzW9jf8Qv61S2nog3RJjxrffDFcuS95Pxyw6/y97gTGsGnfANUWgwaPO/5
 p+mvkKT8iSHkXR6Cusp5o3vkkrX3ZzGU2fP3P28ly5SdjqPz7nt0+gXzCxfIZ6IIP+41Kk
 /sulDm8PST7OHmayZM6gKPyVJ7enuM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-32qqobpWN2CprJ_qpL_uqA-1; Fri, 15 Nov 2019 18:45:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FC8F107ACC4;
 Fri, 15 Nov 2019 23:45:29 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-0.rdu2.redhat.com [10.10.125.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D38E1036C80;
 Fri, 15 Nov 2019 23:45:22 +0000 (UTC)
Date: Fri, 15 Nov 2019 18:45:20 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v7 7/8] Acceptance tests: depend on qemu-img
Message-ID: <20191115234520.GJ19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-8-crosa@redhat.com>
 <3b075001-d6c5-3391-8fe8-515bbfb3d979@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3b075001-d6c5-3391-8fe8-515bbfb3d979@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 32qqobpWN2CprJ_qpL_uqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 06:31:03PM -0200, Wainer dos Santos Moschetta wrote=
:
>=20
> On 11/4/19 1:13 PM, Cleber Rosa wrote:
> > Tests using the avocado.utils.vmimage library make use of qemu-img,
> > and because it makes sense to use the version matching the rest of the
> > source code, let's make sure it gets built.
> >=20
> > Its selection, instead of a possible qemu-img binary installed system
> > wide, is already dealt with by the change that adds the build dir to
> > the PATH during the test execution.
> >=20
> > This is based on the same work for qemu-iotests, and suggested by its
> > author:
> >=20
> >    - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00951.htm=
l
> >=20
> > CC: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> >   tests/Makefile.include | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 65e85f5275..559c3e6375 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -1174,7 +1174,7 @@ $(TESTS_RESULTS_DIR):
> >   check-venv: $(TESTS_VENV_DIR)
> > -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> > +check-acceptance: check-venv $(TESTS_RESULTS_DIR) qemu-img$(EXESUF)
>=20
> To be honest, I don't fell comfortable by the fact that the whole accepta=
nce
> suite will depend on qemu-img which, in reality, is needed by only a sub-=
set
> of tests. Besides it, there might be some reason for someone to build QEM=
U
> with --disable-tools and this change will end up forcing the qemu-img bui=
lt
> (of course if check-acceptance is issued).
>

Fair enough.

> What if we instead:
>=20
> 1. Warn the users in case qemu tools weren't built. Alerting that qemu-im=
g
> and friends will be picked up from system-wide (if any).
>

I'll propose on v8 that we try the locally built qemu-img, or fallback to t=
he
system-wide install if available...

> 2. The tests that rely on avocado.utils.vmimage check for the presence of
> dependent tools, possible canceling itself on their lack. This may be don=
e
> at test code level or perhaps using Avocado's tag mechanism + tweaking
> avocado_qemu.
>

... if not available, the test will automatically cancel because the
image creation (which depends on qemu-img) behaves like that.

Thanks!
- Cleber.

> Thanks,
>=20
> Wainer
>=20
> >   =09$(call quiet-command, \
> >               $(TESTS_VENV_DIR)/bin/python -m avocado \
> >               --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_=
RESULTS_DIR) \


