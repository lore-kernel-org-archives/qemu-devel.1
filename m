Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6429C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 02:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B145206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 02:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONpmkY4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B145206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iULVV-0007I0-MS
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 21:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iULTX-0006Wy-75
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 21:00:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iULTT-0000so-Sk
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 21:00:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iULTT-0000sY-75
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 21:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573524006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMTolXthhefi2J/qZ93MwOATDzh7qC9JYwBwZD+yCTo=;
 b=ONpmkY4e9QrKatu1eS78GcG87R0O2khcbsc1haOlpeijgkhA564Fv/W+hNCeWjTZ1JV1RQ
 8PXdALGmWuigubJgpLes1iJXUUBbyjCHCXmDL34QP4HBTWU4gTTKaruVTPJpIU8sAH8b8f
 daNRGMM4kp8jDpJFspOplUJhz4Ena+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-MQDcBNFqPriEuZS0cy44ew-1; Mon, 11 Nov 2019 21:00:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 355DA1005502;
 Tue, 12 Nov 2019 01:59:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 833B95DD79;
 Tue, 12 Nov 2019 01:59:50 +0000 (UTC)
Date: Mon, 11 Nov 2019 20:59:48 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 3/8] Acceptance tests: use avocado tags for machine type
Message-ID: <20191112015948.GA23968@localhost.localdomain>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-4-crosa@redhat.com>
 <b1730ec3-51ce-719b-81ca-e24194283ec7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b1730ec3-51ce-719b-81ca-e24194283ec7@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: MQDcBNFqPriEuZS0cy44ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>,
 qemu-devel@nongnu.org, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 08, 2019 at 02:20:45PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 11/4/19 4:13 PM, Cleber Rosa wrote:
> >           """
> > -        self.vm.set_machine('none')
> >           self.vm.add_args('-S')
> >           self.vm.launch()
> > diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_=
initrd.py
> > index c61d9826a4..3a0ff7b098 100644
> > --- a/tests/acceptance/linux_initrd.py
> > +++ b/tests/acceptance/linux_initrd.py
> > @@ -20,6 +20,7 @@ class LinuxInitrd(Test):
> >       Checks QEMU evaluates correctly the initrd file passed as -initrd=
 option.
> >       :avocado: tags=3Darch:x86_64
> > +    :avocado: tags=3Dmachine:pc
>=20
> For some tests we can run on multiple machines (here q35), I was tempted =
to
> use multiple tags. How could I do that now?
>

I missed this comment: you can add many tag values here to *classify*
the test as being "q35 machine type capable".

But, Avocado will only run a test multiple times with a varianter
plugin active.  In that case, a "machine" *parameter* with different
values will be passed to the tests.  This tag value is being used
as a default value for the parameter, so it has a lower precedence.

We have a pending task[1] to create an initial CIT file for arch and
machine types.

CC'ing Jan Richter, who is supposed to start working on it soon.

- Cleber.

[1] - https://trello.com/c/1wvzcxHY/105-create-cit-parameter-for-acceptance=
-tests


