Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4731CC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E05221537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E05221537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlZp6-0005dP-Ch
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hlZoS-00059h-FL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hlZoR-0007pi-FL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:12:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hlZoO-0007kD-Q9; Thu, 11 Jul 2019 10:12:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86C6581F07;
 Thu, 11 Jul 2019 14:12:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28FEF5D72E;
 Thu, 11 Jul 2019 14:12:35 +0000 (UTC)
Date: Thu, 11 Jul 2019 16:12:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190711141234.GA6594@linux.fritz.box>
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <3e82ff24-6f84-9de8-d3ab-c34966f875f0@redhat.com>
 <096a8bcf57997c594e1d5d7ea9606029909b81fc.camel@redhat.com>
 <1bdb9136-ae97-7bf3-762e-0774b0980160@redhat.com>
 <45b56973-cc6c-2968-e758-7e10734b75bf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <45b56973-cc6c-2968-e758-7e10734b75bf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 11 Jul 2019 14:12:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.07.2019 um 15:50 hat Eric Blake geschrieben:
> On 7/11/19 7:24 AM, Max Reitz wrote:
>=20
> >>> So it isn=E2=80=99t just me who expects these to pre-initialize the i=
mage to 0.
> >>>  Hm, although...  I suppose @falloc technically does not specify whet=
her
> >>> the data reads as zeroes.  I kind of find it to be implied, but, well=
=2E..
> >>
> >> I personally don't really think that zeros are important, but rather t=
he level of allocation.
> >> posix_fallocate probably won't write the data blocks but rather only t=
he inode metadata / used block bitmap/etc.
> >>
> >> On the other hand writing zeros (or anything else) will force the bloc=
k layer to actually write to the underlying
> >> storage which could trigger lower layer allocation if the underlying s=
torage is thin-provisioned.
> >>
> >> In fact IMHO, instead of writing zeros, it would be better to write ra=
ndom garbage instead (or have that as an even 'fuller'
> >> preallocation mode), since underlying storage might 'compress' the zer=
os.=20
> >=20
> > Which is actually an argument why you should just write zeroes on the
> > LUKS layer, because this will then turn into quasi-random data on the
> > protocol layer.
>=20
> We want preallocation to be fast (insofar as possible). Writing zeroes
> in LUKS is not fast, because it forces random data on the protocol
> layer; while writing zeroes on the protocol layer can be fast, even if
> it reads back as random on the LUKS layer. If you WANT to guarantee
> reading zeroes, that's image scrubbing, not preallocation.  I think this
> patch is taking the right approach, of letting the underlying layer
> allocate data efficiently (but the burden is then on the underlying
> layer to actually allocate data, and not optimize by compressing zeroes
> into non-allocated storage).

Isn't letting the host efficiently preallocate things what we have
preallocation=3Dfalloc for? We implement preallocation=3Dfull as explicit
writes to make sure that no shortcuts are taken and things are _really_
preallocated throughout all layers. Not being efficient, but thorough is
almost like the whole point of the option.

So I'm inclined to think that writing zeros on the LUKS layer would be
right for full preallocation.

Kevin

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdJ0PSAAoJEH8JsnLIjy/WU/AP/1azfL116D3YmbpQCNjEWpXI
NBCjGGDEpq8hJ7Nf+7AogSqqCDHWkHoSMfXmATx9saTrBasaIkyW4tQ+oAgo+a1x
m1/zp/q5gJRJ5lFjOKwyrU+b0h0rUIY+c0kACrRc+IaDL4KquMhwrGgZMpEfUzVy
NWSNOzJJfc5vJjY1SLkMnc2PpHQtR4bgyO/To4wdXnkIivrsYYfqdyxBK1lDToOE
FA1El8X4IW4KnNo/8fGSmMIHF/8aiapieO/hmsnNton9UH8OGhT/XeS3FhzRSYtl
yJPkYG2IAbGRkfKH7kW9zhnar6ZI4qIoEe5Pxzzz5cVftngIHGlPh1lhp05adfar
6cm5nSQI2HnT6RTzDFmE3k57oSpVfXKrtuFDkmtDgbqTLKRmN5qqADX2t0Bsl/oo
OOCEqi7jZC1oXqoHdZ8JvfCdoZ3vMCNdEl3DrJv8qHrrNuyI1JwWEk39a4vI95qy
Y+vEu51A/GFedHK1Xg5dARHCNliSYSzpdxzSYB1NkI1JfBN0bNFlxtoz48kSMCjU
erhBFUA4tqjN2qkL7NEypoaFkHSN763300Yn2S306Iuz/KloEUST47MTxjjhQa+m
C7MMGU/h2eyi6EfKvtvNkrZDdaFsdwILuAoPJNmhVkFJVzw9+XQc07/W0B3CPHAp
M4YOSXnOkfSEMqHXqTsl
=Lh+6
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

