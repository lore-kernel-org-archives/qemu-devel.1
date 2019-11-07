Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D56DC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170162085B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQjPlR+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170162085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSeZJ-0004y5-6F
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:59:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSeWq-0003vs-KV
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSeWh-0007FO-E5
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:56:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24990
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSeWh-0007Bg-AJ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:56:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573120586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ocey3eMAz9lCZNK6E0SFKnvPltfdbe/nSim1/cKA7Ws=;
 b=TQjPlR+TE01rGjQfunKGsVp9PqvLTtFUvx38yPA8UQhJe4JWDgJMCcs/5itoUB8+LuE/Nz
 KYxigKVwNjtKWIcpYWwZ3FlydFO9wJe4Ub9jQvY+3AJa7tlfhDXElDb/EwTXZTWzLY2Htx
 U3/vUXcrA7Pt9KKnRsV6o34BwToLSF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-GicM4F7KNdWSFfOsm5HYrQ-1; Thu, 07 Nov 2019 04:56:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49723477;
 Thu,  7 Nov 2019 09:56:24 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4BFA600CE;
 Thu,  7 Nov 2019 09:56:22 +0000 (UTC)
Message-ID: <4c88e7d195d1534dc107ffb4f9ffd94f337fbbb0.camel@redhat.com>
Subject: Re: [PATCH v2 05/21] iotests: Replace IMGOPTS by _unsupported_imgopts
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 07 Nov 2019 11:56:21 +0200
In-Reply-To: <7e3bbbb8-416b-eae9-7e51-a816045b83dd@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-6-mreitz@redhat.com>
 <4d3ed1468e966b14aa5b6453327be0710bc26ed7.camel@redhat.com>
 <7e3bbbb8-416b-eae9-7e51-a816045b83dd@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GicM4F7KNdWSFfOsm5HYrQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-11-07 at 10:08 +0100, Max Reitz wrote:
> On 06.11.19 16:45, Maxim Levitsky wrote:
> > On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> > > Some tests require compat=3D1.1 and thus set IMGOPTS=3D'compat=3D1.1'
> > > globally.  That is not how it should be done; instead, they should
> > > simply set _unsupported_imgopts to compat=3D0.10 (compat=3D1.1 is the
> > > default anyway).
> > >=20
> > > This makes the tests heed user-specified $IMGOPTS.  Some do not work
> > > with all image options, though, so we need to disable them accordingl=
y.
> > >=20
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/036 | 3 +--
> > >  tests/qemu-iotests/060 | 4 ++--
> > >  tests/qemu-iotests/062 | 3 ++-
> > >  tests/qemu-iotests/066 | 3 ++-
> > >  tests/qemu-iotests/068 | 3 ++-
> > >  tests/qemu-iotests/098 | 4 ++--
> > >  6 files changed, 11 insertions(+), 9 deletions(-)
> > >=20
> > > diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
> > > index 5f929ad3be..bbaf0ef45b 100755
> > > --- a/tests/qemu-iotests/036
> > > +++ b/tests/qemu-iotests/036
> > > @@ -43,9 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > >  # This tests qcow2-specific low-level functionality
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > > -
> > >  # Only qcow2v3 and later supports feature bits
> > > -IMGOPTS=3D"compat=3D1.1"
> > > +_unsupported_imgopts 'compat=3D0.10'
> > > =20
> > >  echo
> > >  echo =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
> > > diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> > > index b91d8321bb..9c2ef42522 100755
> > > --- a/tests/qemu-iotests/060
> > > +++ b/tests/qemu-iotests/060
> > > @@ -48,6 +48,8 @@ _filter_io_error()
> > >  _supported_fmt qcow2
> > >  _supported_proto file
> > >  _supported_os Linux
> > > +# These tests only work for compat=3D1.1 images with refcount_bits=
=3D16
> > > +_unsupported_imgopts 'compat=3D0.10' 'refcount_bits=3D\([^1]\|.\([^6=
]\|$\)\)'
> >=20
> > Looks like the reason for that is that the test hardcodes (or guesses t=
hat is) various qcow2 structures
> > thing I have seen few times already in the iotests.
> > Not now but sometime in the future it would be nice to extend qcow2.py =
(or something
> > like that) to dump location of all qcow2 structures so that the guesswo=
rk could be eliminated.
>=20
> With the peek_file* functions we have now it=E2=80=99s actually simple to=
 dump
> that location ($(peek_file_be "$TEST_IMG" 48 8) for the refcount table
> offset, for example).
>=20
> But it wouldn=E2=80=99t help, because compat=3D0.10 or refcount_bits !=3D=
 16 won=E2=80=99t
> change those locations.  So the locations aren=E2=80=99t the reason why w=
e need
> to forbid those options here.
>=20
> The reason we need refcount_bits=3D16 is that we=E2=80=99re going to dire=
ctly
> manipulate a refcount block.  To do so, we need to know the refcount
> width, and I don=E2=80=99t think it=E2=80=99s worth trying to implement s=
omething generic.
>=20
> We need compat=3D1.1 because compat=3D0.10 doesn=E2=80=99t have feature b=
its, so
> there=E2=80=99s no =E2=80=9Ccorrupt=E2=80=9D bit there.
>=20
> Max
>=20
This makes sense! Sorry for the noise!

Best regards,
=09Maxim Levitsky




