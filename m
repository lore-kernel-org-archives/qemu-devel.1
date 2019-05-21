Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C92C04E87
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C63217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 20:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C63217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58879 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTB72-0007US-OR
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 16:11:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTB5o-0006ji-8d
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hTB5m-0001ol-4F
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hTB5k-0001jX-43
	for qemu-devel@nongnu.org; Tue, 21 May 2019 16:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D923C2BDA;
	Tue, 21 May 2019 20:10:11 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 61070799E;
	Tue, 21 May 2019 20:10:04 +0000 (UTC)
Date: Tue, 21 May 2019 17:10:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190521201002.GL10764@habkost.net>
References: <20190520231910.12184-1-f4bug@amsat.org>
	<20190520231910.12184-5-f4bug@amsat.org>
	<CAL1e-=jfYuh4jLAacFeZcOes5A3PERNLqsE4_hiEci+x0XBTrw@mail.gmail.com>
	<CAL1e-=heGtJj-30YsAVyGKSMULZ5ggVd42+c9caGqN3PBRddag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAL1e-=heGtJj-30YsAVyGKSMULZ5ggVd42+c9caGqN3PBRddag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 21 May 2019 20:10:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] BootLinuxSshTest: Test some userspace
 commands on Malta
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Caio Carrara <ccarrara@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cleber Rosa <crosa@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 11:26:35AM +0200, Aleksandar Markovic wrote:
> On May 21, 2019 10:18 AM, "Aleksandar Markovic" <aleksandar.m.mail@gmai=
l.com>
> wrote:
> >
> >
> > On May 21, 2019 1:19 AM, "Philippe Mathieu-Daud=E9" <f4bug@amsat.org>=
 wrote:
> > >
> > > This tests boot a full VM and check the serial console until
> > > the SSH daemon is running, then start a SSH session and run
> > > some commands.
> > >
>=20
> If there is no objection from Cleber or others, I would like to apply t=
his
> patch to my next MIPS pull request. We in Wave just started regular
> regression tests of various nature for QEMU 4.1 for MIPS, and would rea=
lly
> like to have this test integrated as soon as possible, that is why I am
> rushing a bit. I am talking here about this patch only, since it is a s=
ort
> of an independant unit - I will not do anything with other remaining
> patches from this series.
>=20
> Please let me know if you have any concerns.

No problem to me.  I don't expect any merge conflicts caused by
the same patch being merged through both trees.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo

