Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1330DC5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A992084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZF6Gu/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A992084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSeUd-0002wE-2W
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSeTG-0002Q2-Gn
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSeTD-0004iS-HY
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:52:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30897
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSeTD-0004e4-Dy
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573120370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=79ptaaPbW6Rdvj15WRlgi2jVNRp9DD+Z6xLM4tvWnt4=;
 b=VZF6Gu/3CAb/n33qLzhSsViNFshx0yLwXNTVtYIXYOudhoIiuVP1bOA/HCepMg3AnkVwXS
 msR00ziPv07ZEwf6P2QgM+b/5TdmBK6d6rZxrjFBiXjnq3Gl8y4XYVBLOxqgjBgnHpHfB1
 /917OT5qRyQZLz9/62XjoOGBIvdJD3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-TwQny7DvM5epjstTCBmTow-1; Thu, 07 Nov 2019 04:52:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94D64107ACC3;
 Thu,  7 Nov 2019 09:52:46 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57FA15D9CD;
 Thu,  7 Nov 2019 09:52:45 +0000 (UTC)
Message-ID: <42e5246d42f1c2b9c5ecf085387aaa24b44b4663.camel@redhat.com>
Subject: Re: [PATCH v2 10/21] iotests: Replace IMGOPTS= by -o
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 07 Nov 2019 11:52:44 +0200
In-Reply-To: <08e8683a-04b2-1604-3b9f-cb2fff8669f1@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-11-mreitz@redhat.com>
 <25befdcb33d3e77f7cab05c98609b88d6ff26766.camel@redhat.com>
 <08e8683a-04b2-1604-3b9f-cb2fff8669f1@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: TwQny7DvM5epjstTCBmTow-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-11-07 at 10:20 +0100, Max Reitz wrote:
> On 06.11.19 16:47, Maxim Levitsky wrote:
> > On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> > > Tests should not overwrite all user-supplied image options, but only =
add
> > > to it (which will effectively overwrite conflicting values).  Accompl=
ish
> > > this by passing options to _make_test_img via -o instead of $IMGOPTS.
> > >=20
> > > For some tests, there is no functional change because they already on=
ly
> > > appended options to IMGOPTS.  For these, this patch is just a
> > > simplification.
> > >=20
> > > For others, this is a change, so they now heed user-specified $IMGOPT=
S.
> > > Some of those tests do not work with all image options, though, so we
> > > need to disable them accordingly.
> > >=20
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/031 |  9 ++++---
> > >  tests/qemu-iotests/039 | 24 ++++++------------
> > >  tests/qemu-iotests/059 | 18 ++++++-------
> > >  tests/qemu-iotests/060 |  6 ++---
> > >  tests/qemu-iotests/061 | 57 ++++++++++++++++++++++------------------=
--
> > >  tests/qemu-iotests/079 |  3 +--
> > >  tests/qemu-iotests/106 |  2 +-
> > >  tests/qemu-iotests/108 |  2 +-
> > >  tests/qemu-iotests/112 | 32 ++++++++++++------------
> > >  tests/qemu-iotests/115 |  3 +--
> > >  tests/qemu-iotests/121 |  6 ++---
> > >  tests/qemu-iotests/125 |  2 +-
> > >  tests/qemu-iotests/137 |  2 +-
> > >  tests/qemu-iotests/138 |  3 +--
> > >  tests/qemu-iotests/175 |  2 +-
> > >  tests/qemu-iotests/190 |  2 +-
> > >  tests/qemu-iotests/191 |  3 +--
> > >  tests/qemu-iotests/220 |  4 ++-
> > >  tests/qemu-iotests/243 |  6 +++--
> > >  tests/qemu-iotests/244 | 10 +++++---
> > >  tests/qemu-iotests/250 |  3 +--
> > >  tests/qemu-iotests/265 |  2 +-
> > >  22 files changed, 100 insertions(+), 101 deletions(-)
>=20
> [...]
>=20
> > > @@ -161,7 +161,7 @@ _cleanup_test_img
> > > =20
> > >  echo
> > >  echo "=3D=3D=3D Testing 4TB monolithicFlat creation and IO =3D=3D=3D=
"
> > > -IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 4T
> > > +_make_test_img -o "subformat=3DmonolithicFlat" 4T
> > >  _img_info
> > >  $QEMU_IO -c "write -P 0xa 900G 512" "$TEST_IMG" | _filter_qemu_io
> > >  $QEMU_IO -c "read -v 900G 1024" "$TEST_IMG" | _filter_qemu_io
> > > @@ -170,7 +170,7 @@ _cleanup_test_img
> > >  echo
> > >  echo "=3D=3D=3D Testing qemu-img map on extents =3D=3D=3D"
> > >  for fmt in monolithicSparse twoGbMaxExtentSparse; do
> > > -    IMGOPTS=3D"subformat=3D$fmt" _make_test_img 31G
> > > +    _make_test_img -o "subformat=3D$fmt" 31G
> > >      $QEMU_IO -c "write 65024 1k" "$TEST_IMG" | _filter_qemu_io
> > >      $QEMU_IO -c "write 2147483136 1k" "$TEST_IMG" | _filter_qemu_io
> > >      $QEMU_IO -c "write 5G 1k" "$TEST_IMG" | _filter_qemu_io
> >=20
> > Looks good. Another test that pokes at guessed locations... :-)
>=20
> Actually, no.  These are writes on the format, not the file itself.  The
> monolithicSparse subformat will store everything in a single file,
> whereas twoGbMaxExtentSparse will create one file per 2 GB of guest
> disk.  So the locations are chosen accordingly to that 2 GB limit ((1)
> something somewhere in the first extent, (2) something that wraps around
> the first 2 GB limit, so hits extents #0 and #1, and (3) something in
> the middle of extent #2.)
>=20
> (The following qemu-img map call then verifies that it lands in the
> different files for twoGbMaxExtentSparse, and that monolithicSparse is
> at least indeed sparsely allocated.)
>=20
> Max
Good to know, I missed this one.


Best regards,
=09Maxim Levitsky




