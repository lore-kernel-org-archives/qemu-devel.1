Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A6EC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBFC2077C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQrAX0A5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBFC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58819 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLTh-0006ZV-Va
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iSLSp-0005Vt-Jv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iSLSk-0007m4-Mp
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:35:11 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iSLSk-0007lN-JB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573047305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s+lN5Y1N27oJvllwM8VJJoOu1WcjpJtS/y8WMFymCkY=;
 b=EQrAX0A5sMEbVqTtNefgFoOAem1iUqze9jupeRgpjSPLrIFeIfDI4Mr4kgXTGncI4z+r+e
 o+wBTEDqU265UiTaz/j+hqrX/Zl3kMBUxNoELg8GdvIB5MnaRBuBTFr9sGf4gPPbzjmezE
 KGiU57VHMs9vX6Tax8Zpj/PGPEmnv+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-AxWyntuBOleWLSrqW1Z13g-1; Wed, 06 Nov 2019 08:35:02 -0500
X-MC-Unique: AxWyntuBOleWLSrqW1Z13g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BD061005500;
 Wed,  6 Nov 2019 13:35:01 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BAC319756;
 Wed,  6 Nov 2019 13:35:00 +0000 (UTC)
Date: Wed, 6 Nov 2019 14:34:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 08/18] qemu-storage-daemon: Add --export option
Message-ID: <20191106133458.GB7548@dhcp-200-226.str.redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-9-kwolf@redhat.com>
 <5d920618-219a-6dd2-5823-3fc3f09e6a61@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5d920618-219a-6dd2-5823-3fc3f09e6a61@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.11.2019 um 14:11 hat Max Reitz geschrieben:
> On 17.10.19 15:01, Kevin Wolf wrote:
> > Add a --export option to qemu-storage-daemon to export a block node. Fo=
r
> > now, only NBD exports are implemented. Apart from the 'type' option
> > (which is the implied key), it maps the arguments for nbd-server-add to
> > the command line. Example:
> >=20
> >     --export nbd,device=3Ddisk,name=3Dtest-export,writable=3Don
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block.json       | 27 +++++++++++++++++++++++++++
> >  qemu-storage-daemon.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 58 insertions(+)
>=20
> Would it be better to collect the BlockExports in a list and work on it
> after all arguments have been parsed?  As it is, it=E2=80=99s important t=
hat
> users define block devices and things like NBD servers before --export.
>  Yes, I know, that=E2=80=99s exactly how it works with qemu, but is that =
really
> the best way?

It's actually not how QEMU works generally. QEMU collects things in
QemuOptsLists and then tries to interpret them in the right order. Of
course, we never get the order actually right, which results in constant
reshuffling of the order of initialisations in vl.c.

It also means that vl.c (!) has a list of -object types that need to be
created early so that other backends can make use of them, and of those
types that actually depend on a backend already being present (see
object_create_initial() for details).

I think it's much cleaner to simply use the order in the command line
instead of adding magic that tries to resolve (and fails at actually
resolving) all the dependencies. I seem to remember that this was in
fact one of the things Markus keeps mentioning he would change if he
were to rewrite the QEMU command line parser from scratch without
compatibility requirements.

Kevin

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdwswCAAoJEH8JsnLIjy/WetcQAIJGxwlPYRSBvD+DiYJLizMj
v52UH/05GvQRr0M6pW8Jwmo+xAVHUPBceCZ8Iy6/qJuGv6jczPnIYQsXx6P214LI
T8YV1mB10m7/PZI6MKWZIy2AI6E4n/g4neEsP5Fi2HFqQaEMUkrAuBg4pYk7v3n+
TsumYGET49MaWhONW8fsstsPXi7g+ADIFYoR+c1kLbQn9QK11ik+KRr65CGzsVTy
TklyTCIHV5310lbauztHivDTWLMHxzn/mBe6lOnbA7phbVFGnFCn6+SuQB++s4xl
121tDMvt6MvZYCC0qi380sEMSvL+PnFHHHEtOE5q3/2By9+I1+Gon18r4UxbQW/H
HN8ID4yrad78LDiSC3vCvbAPDxp1ERV4ylmN/tMV8aPnVvOQpo58ALdoxi7UFlkl
vYIO4miFhBK22AVOxVOw9X/KqLHDrYsuSPqbvyTmW5FDbsosGM99Z2z8L2R+1a+5
EE/X71Sol88jIuiHozML/hHyOxVLQzSs7KuBWA7QM0RF7qwlpuR8+BLIfTa6GS5G
/GFCN6dbgd4uVDtRJc0VJcd2T44NWHW+jD2LDTh+PwkhJGqSTg8AcWLHGEim2inD
9dTlIPUag0DeXfO7wKvLJ/ZEn6cJnVhl0u3pF/q64UYu7cnvYsfvXLKRNtn3iMxa
s9TeiGjf/C0JRwkn63TS
=uCEm
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--


