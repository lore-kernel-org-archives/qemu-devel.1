Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46484C3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFC5246A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 07:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ye9gMgd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFC5246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7aNe-0005m0-1V
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 02:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j7aN0-0005DE-4M
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:47:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j7aMy-0000LL-Vp
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:47:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22782
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j7aMy-0000L1-Sb
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 02:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582876056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+D8DOie91iTmWTa82CCKy55oa4ppjpizVpeCrtHLaI=;
 b=Ye9gMgd5La25MEtlGkCnw1iIXfBJ0XedcCD9bUqs11oOsDEz1PhL+irxlqM/g2x0HEjF/y
 XEfSwdUV/navgPc8d3xVpOvKoN132aL9aScQq27JivDC6pKncUh1ys9IcFhqbKxE7BZtKi
 QOGJr4Np5ODRrui2b9arI/XkPivtcpE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267--HuvCzA2PEKbsW-hwEAi9w-1; Fri, 28 Feb 2020 02:47:34 -0500
X-MC-Unique: -HuvCzA2PEKbsW-hwEAi9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04D1213E4;
 Fri, 28 Feb 2020 07:47:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CCB360C18;
 Fri, 28 Feb 2020 07:47:31 +0000 (UTC)
Date: Fri, 28 Feb 2020 08:47:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
Message-ID: <20200228084729.3bb8bf11@redhat.com>
In-Reply-To: <CAPan3WrSRm986EfwJdXV2MduNLE5BS+QmCv0Bo5-BD+QfT-=dg@mail.gmail.com>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
 <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org>
 <87pne0w6rt.fsf@linaro.org>
 <56f5e355-9357-e212-e92b-9db1d8424dea@linaro.org>
 <CAPan3WrSRm986EfwJdXV2MduNLE5BS+QmCv0Bo5-BD+QfT-=dg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 20:07:24 +0100
Niek Linnenbank <nieklinnenbank@gmail.com> wrote:

> Hi Richard,
>=20
> On Thu, Feb 27, 2020 at 1:57 PM Richard Henderson <
> richard.henderson@linaro.org> wrote: =20
>=20
> > On 2/27/20 4:31 AM, Alex Benn=C3=A9e wrote: =20
> > >> It does not make sense for a linux-user chroot, running make -jN, on=
 =20
> > just about =20
> > >> any host.  For linux-user, I could be happy with a modest increase, =
but =20
> > not all =20
> > >> the way out to 2GiB.
> > >>
> > >> Discuss. =20
> > >
> > > Does it matter that much? Surely for small programs the kernel just
> > > never pages in the used portions of the mmap? =20
> >
> > That's why I used the example of a build under the chroot, because the
> > compiler
> > is not a small program.
> >
> > Consider when the memory *is* used, and N * 2GB implies lots of paging,
> > where
> > the previous N * 32MB did not.
> >
> > I agree that a lower default value probably is safer until we have more=
 =20
> proof that a larger value does not give any issues.
>=20
>=20
> > I'm saying that we should consider a setting more like 128MB or so, sin=
ce
> > the
> > value cannot be changed from the command-line, or through the environme=
nt.
> > =20
>=20
> Proposal: can we then introduce a new command line parameter for this?
> Maybe in a new patch?

linux-user currently uses 32Mb static buffer so it probably fine to
leave it as is or bump it to 128Mb regardless of the 32/64bit host.

for system emulation, we already have tb-size option to set user
specified buffer size.

Issue is with system emulation is that it sizes buffer to 1/4 of
ram_size and dependency on ram_size is what we are trying to get
rid of. If we consider unit/acceptance tests as main target/user,
then they mostly use default ram_size value which varies mostly
from 16Mb to 1Gb depending on the board. So used buffer size is
in 4-256Mb range.
Considering that current CI runs fine with max 256Mb buffer,
it might make sense to use it as new heuristic which would not
regress our test infrastructure and might improve performance
for boards where smaller default buffer was used.


> Since the size of the code generation buffer appears to have an impact on
> performance,
> in my opinion it would make sense to make it configurable by the user.
>=20
> Regards,
>=20
>=20
> >
> >
> > r~
> >
> > =20
>=20


