Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653BAC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:34:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A32921852
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A32921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9t1X-0007cu-6n
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i9sID-0002SG-Cs
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i9sIC-0000nY-At
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:47:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i9sI1-0000kl-S9; Mon, 16 Sep 2019 10:47:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57E701DA2;
 Mon, 16 Sep 2019 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1FFE5D6A3;
 Mon, 16 Sep 2019 14:47:36 +0000 (UTC)
Date: Mon, 16 Sep 2019 16:47:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190916144735.GB4573@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
 <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
 <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 16 Sep 2019 14:47:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 28/42] stream: Deal with filters
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.09.2019 um 11:52 hat Max Reitz geschrieben:
> On 13.09.19 16:16, Kevin Wolf wrote:
> > Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >> @@ -261,16 +272,19 @@ void stream_start(const char *job_id, BlockDrive=
rState *bs,
> >>       * disappear from the chain after this operation. The streaming j=
ob reads
> >>       * every block only once, assuming that it doesn't change, so for=
bid writes
> >>       * and resizes. Reassign the base node pointer because the backin=
g BS of the
> >> -     * bottom node might change after the call to bdrv_reopen_set_rea=
d_only()
> >> -     * due to parallel block jobs running.
> >> +     * above_base node might change after the call to
> >> +     * bdrv_reopen_set_read_only() due to parallel block jobs running.
> >>       */
> >> -    base =3D backing_bs(bottom);
> >> -    for (iter =3D backing_bs(bs); iter && iter !=3D base; iter =3D ba=
cking_bs(iter)) {
> >> +    base =3D bdrv_filtered_bs(above_base);
> >=20
> > We just calculated above_base such that it's the parent of base. Why
> > would base not already have the value we're assigning it again here?
>=20
> That=E2=80=99s no change to existing code, whose reasoning is explained i=
n the
> comment above: bdrv_reopen_set_read_only() can yield, which might lead
> to children of the bottom node changing.
>=20
> If you feel like either that=E2=80=99s superfluous, or that if something =
like
> that were to happen we=E2=80=99d have much bigger problems, be my guest t=
o drop
> both.
>=20
> But in this series I=E2=80=99d rather just not change it.

Ah, you mean comments are there to be read?

But actually, I think iterating down to base is too much anyway. The
reasoning in the comment for block_job_add_bdrv() is that the nodes will
be dropped at the end. But base with all of its filter will be kept
after this patch.

So I think the for loop should stop after bs->base_overlay. And then
concurrently changing links aren't even a problem any more because
that's exactly the place up to which we've frozen the chain.

Kevin

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdf6CHAAoJEH8JsnLIjy/WclgP/jHUVta61YzhZBH2/o5hlYkB
nXTEYYtddDgq3icR1Qc0BriQTn/0RJF1LMNOSY7DzEtLorbGAFXmTxHh2k2GuHu+
QyHl09WUpM+x9P/0HoIxvAnEULT2bl9ybiqB/Dc7wWpwhUT9xCLKrzvXCfjaD3Dn
XRveHXtvL8iaGnjmN6SrzC7GphN6u5goRY2XKNyGI/sM+xlTeo/13wxr0cN0ERCm
UotRznqvhCKH8fq1RBjlqFLWuPup8/fCfLDpD+pyaWPYqGme58lF/O9dlHz0x0dM
jT+F1fmpaKevip6VmCFh8juO45AOoEs7erWXDJiWfG8wJDNLP74oKLewjgVFsIuQ
UzP1uNeUYY5tKUxHOBRc6isFMrYMQltLJK6MZQsFq2HKdn2AkOsWquRAQL2g1/Ng
ObLxcH26McocW2Pgzg8gX//p2jQH8pEDPkG272MFKElgvVHHNPFECeGlekCk/fub
K86zFNTlow/f3ZxaF+k/M/RH535qs8Xm6m4RNoErw75UGtGw29OIDFvVbpNVozEF
wxyrkLEns2M1j/Ms46UxRTQrbQoRgGeJ8E/rWXLo6ogz7yanLpzr4NaMq81IhWXM
2FHw50xcsoUJQUSJ5S5Bbttyo/d7cv1Qu+2nCXuWzyTzt061P8NKjTqdqdYEG9cK
dxxFwZD2xK6aD8IabwG6
=lv0N
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--

