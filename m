Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FDDC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC1742064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRWWrFBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC1742064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUmG-0005Nu-Ri
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1isUes-0001op-3Q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:39:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1isUeo-0004cx-Fb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:39:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1isUeo-0004c8-Cp
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579279177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWSPb2SK3PdbAdniD0q+Hyh4vmQVYHsdwyq/ijGZpr8=;
 b=BRWWrFByow8qKm2QrGy85nteFzez4MrbE6yM1OWPz8FjugxOYbuD/q+dPz7g6PvbTxGu2j
 xl4fhCF8h4aGdyahvlWbvIsX0jj0Z6xdoM//3osTwCgHJzH9eDni4v8rkd+uBEnZ81+DMF
 /JYUzjkd1T4qgRdGCIYPYWMPb9UXkyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-FzI8bvx9M0KJ8-vJLVsdGA-1; Fri, 17 Jan 2020 11:39:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48378100550E;
 Fri, 17 Jan 2020 16:39:32 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E03160BE1;
 Fri, 17 Jan 2020 16:39:27 +0000 (UTC)
Date: Fri, 17 Jan 2020 17:39:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 66/86] ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
Message-ID: <20200117173926.7d52023c@redhat.com>
In-Reply-To: <d3d50fff-3449-ba3e-12f2-5b74e20a1e4c@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-67-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001152149120.24151@zero.eik.bme.hu>
 <20200117114629.5b245c83@redhat.com>
 <d3d50fff-3449-ba3e-12f2-5b74e20a1e4c@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FzI8bvx9M0KJ8-vJLVsdGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 16:38:02 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/17/20 11:46 AM, Igor Mammedov wrote:
> > On Wed, 15 Jan 2020 22:33:46 +0100 (CET)
> > BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >  =20
> [...]
> > v2 basically works the same as original code, except of that
> > instead of fixing up ram_size, it ask user to fix CLI to
> > the same value.
> >  =20
> >> but I've not yet given up to keep current functionality
> >> (also for other boards where this series would drop it). If you don't =
like
> >> a generic callback then how about letting the board optionally specify=
 in
> >> the machine class next to default_ram_size some constraints such as
> >> min_ram_size, max_ram_size and an array of valid_ram_sizes (like
> >> ppc460ex_sdram_bank_sizes[]) that the generic code doing the allocatio=
n
> >> could check and clamp sizes to the nearest valid one emitting a warnin=
g
> >> and only bail out if constraints are not given. This would cover most
> >> cases expect the e500 where it has an alignment without max so
> >> representing it as a list of valid values is probably not practical (c=
ould
> >> also have ram_alignment but then a generic callback may be simpler). W=
ould
> >> that way work for you? =20
> >=20
> > I agree that we need to consolidate ram_size checks,
> > that would allow to clean up boards that practically do
> > the mostly the same. In the end it would allow to introspect
> > supported ram_sizes which would be good for upper layers.
> >=20
> > I even started something in that direction but dropped
> > all of that patches as not directly related to this
> > series purpose.
> > Phillipe is also trying to something like this for raspi
> > board.
> >=20
> > As for clamping, I still think that it's not good idea
> > to accept invalid value and fix it up.
> > Users should get what they asked for or get a clear error
> > (it's double true if user is management software as it
> > won't read any sort of warnings, well not all human users
> > would head warnings either as far as QEMU continues to run)
> >=20
> > Anyways, most maintainers agreed to dropping fixups
> > and generalizing checks or generalizing fix up for convenience
> > of users frameworks are out of scope of this series.
> >=20
> > Someone can work on these refactorings later on
> > (assuming someone is enough interested in it)
> >=20
> > PS:
> > If you insist on fixing ram_size up, it would still be possible
> > to do so locally within board. One can take all RAM that user
> > provided and then create clamped memory region alias.
> > It's rather ugly but will do the job without affecting generic
> > code. (though I wouldn't volunteer to write up such a hack) =20
>=20
> I think from the virtualization point of view, you don't want to=20
> allocate unused resources. Is that why you say it is "ugly"?
>=20
>  From the emulation point of view, it is easier to stay as close as=20
> possible to the hardware, where sometimes resources are wasted to=20
> simplify the design (or reduce production delays).
> If it matches hardware, clamping doesn't look "ugly" to me.
>=20

gist of discussion in this case is that:

bamboo HW supports 4 banks of RAM that could be populated by
256/128/64/32/16/8Mb DIMMs

so -m XXX must be multiple of that, otherwise we are not
able distribute all -m specified size between supported banks.

Current patch then would error out with
  "Max 4 banks of 256, 128, 64, 32, 16, 8 MB DIMM/bank supported"
  "Possible valid RAM size: XXX"
where XXX is clamped value original code uses to after fixup

Argument was that it's not convenient for users do what they
would do on real hw (i.e. calculate desired size manually
based on available banks/DIMMs).

I gave an attempt to dumping all possible sizes and it results
in not practically useful unique ~80 entries list, so that idea
also goes down the drain.

I agree that it's not convenient, but I think that human user
can easily adapt to error message and either fix CLI to use
suggested value (i.e. what they are getting now) or pick desired
DIMMs number/size and do the math.


