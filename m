Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BF6C17449
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 21:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC7A21783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 21:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKvc+7pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC7A21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUHW9-0001vj-SV
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 16:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iUHUz-0001Ng-DH
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 16:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iUHUw-0003Sy-VV
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 16:45:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iUHUw-0003RK-R8
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 16:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573508722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jff1M1k0SGYv3M3nrQjhW5BraO1lOdhfmjo0tKGtdWA=;
 b=NKvc+7pD5o7pqqJ1wRmEWdxqBRWk0dqel9mQMeRqkNTrMl0/wOLpT18KhALO0NvMzIwY9m
 LGt8defDX2JBAffgi+Y3Xf9ou6cRcvbqnNy6fHNagpluXyCuIowOdaAINFsXsMdyH0uKun
 4BT/iXRO7hNP1WLIW9WPdmMhHeyHS8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-tOOQ8w-vMeW-KgAshzdvmg-1; Mon, 11 Nov 2019 16:44:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D5B78064DC;
 Mon, 11 Nov 2019 21:44:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 56A6C5DD79;
 Mon, 11 Nov 2019 21:44:04 +0000 (UTC)
Date: Mon, 11 Nov 2019 16:44:02 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 2/8] Acceptance tests: introduce utility method for
 tags unique vals
Message-ID: <20191111214402.GB19559@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-3-crosa@redhat.com>
 <619a8f8e-ab0c-f837-853e-34e61e85a583@redhat.com>
MIME-Version: 1.0
In-Reply-To: <619a8f8e-ab0c-f837-853e-34e61e85a583@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: tOOQ8w-vMeW-KgAshzdvmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 02:14:58PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/4/19 4:13 PM, Cleber Rosa wrote:
> > Currently a test can describe the target architecture binary that it
> > should primarily be run with, be setting a single tag value.
> >=20
> > The same approach is expected to be done with other QEMU aspects to be
> > tested, for instance, the machine type and accelerator, so let's
> > generalize the logic into a utility method.
> >=20
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >   tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++------
> >   1 file changed, 13 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> > index 9a57c020d8..e676d9c4e7 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -100,14 +100,21 @@ def exec_command_and_wait_for_pattern(test, comma=
nd,
> >   class Test(avocado.Test):
> > +    def _get_unique_tag_val(self, tag_name):
> > +        """
> > +        Gets a tag value, if unique for a key
>=20
> 'Get'?
>=20

Not sure what's better, I was thinking along the lines that *this
method* gets (one) a tag value...  But you may be right.

- Cleber.


