Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F3C433F1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3295F21741
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTRfMudD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3295F21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYsms-0007iG-Ue
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYslx-0006LI-Mq
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:54:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYslw-0000Y0-S5
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589381651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=axpfmdDFPjG5EZz9BmNH/EB/sijSubCbry9C2F/GjuU=;
 b=cTRfMudDP8B8K9gcwZEWlu3pp4gZAREItJTUX6f6+VjnVx6EBWeVWkhKr81ZAjPHL02EXr
 89OXVuSr44RqWB//xqWHM33RtETY8HaNmTKkqavcwKNH2gWJziutDJ7E3qji6LcwM6H36F
 2UWekxRuyA6qRlUF3z6IE9RNLkYl7Vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-7mjdG-v2N22DrOjf1AowzQ-1; Wed, 13 May 2020 10:54:06 -0400
X-MC-Unique: 7mjdG-v2N22DrOjf1AowzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D7F1461;
 Wed, 13 May 2020 14:54:04 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-80.ams2.redhat.com [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BE8B6A977;
 Wed, 13 May 2020 14:54:03 +0000 (UTC)
Date: Wed, 13 May 2020 16:54:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Run pylint and mypy in a testcase
Message-ID: <20200513145401.GJ6202@linux.fritz.box>
References: <20200511163529.349329-1-kwolf@redhat.com>
 <20200511163529.349329-3-kwolf@redhat.com>
 <c2292ce0-6885-216e-b23f-26a341a5afd3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c2292ce0-6885-216e-b23f-26a341a5afd3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.05.2020 um 14:14 hat Max Reitz geschrieben:
> On 11.05.20 18:35, Kevin Wolf wrote:
> > We made sure that iotests.py passes pylint. It would be a shame if we
> > allowed new patches in that break this again, so let's just add a
> > meta-test case that runs pylint on it.
> >=20
> > While we don't pass mypy --strict yet, we can already run it with a few
> > options that would be part of --strict to make sure that we won't
> > regress on these aspects at least until we can enable the full thing.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/297     | 44 ++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/297.out |  3 +++
> >  tests/qemu-iotests/group   |  1 +
> >  3 files changed, 48 insertions(+)
> >  create mode 100755 tests/qemu-iotests/297
> >  create mode 100644 tests/qemu-iotests/297.out
>=20
> Bit of a shame that this takes 8 s (on my machine at least) and will run
> with every format/protocol combination unless I explictly exclude it
> with -x meta...

Yes, it's surprising how slow these tools are. At least mypy caches some
stuff, so the second run is considerably faster, but pylint doesn't do
that.

I wonder if there is some overlap between mypy and pylint that we could
configure away in pylint to speed it up.

> But I suppose the actual problem here is the fact that
> tests still can=E2=80=99t just define a =E2=80=9CThis is the format/proto=
col combination
> I require=E2=80=9D and then you can just let all tests run once with that
> default combination.  (And maybe afterwards run all tests again with
> some custom combinations, but only when that makes sense.)

It's probably not hard to find more "actual problems" in the test
harness...

Kevin

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl68CgkACgkQfwmycsiP
L9a74xAAoAOiOZmGBNww2APLdJwDsp3lWFpdqC3z2Kn26il3tyZhRwzHxXwtTUBL
5Qa9QhlGLwnakdLHJ7nANIVOabwzEWj9YFmfxbqAwZTJQtpBPQdkFLY027rBd5jL
i4Kc5Mdh8GuCPaZDp0bKIjmMHE3TE2Qg5tDjZQoBSlAmkPlD0beVxKRcECo5HWlQ
AhOqN6V4pbL3JSAOOeRfGfS6qP08vEPXOIQoVZoIXVAtbfn4eAjaS/ZuksHcscJD
6Iu7wScQRH/d1HECat2GG8JGfi2rcRaK9+kjdmxcaQW04E/AK64ixYcs4GGc/XHB
utdVKlFyXBSAJsYKUZhs+wdneIVPlwQ8xou1jZxjY9Y8LKVyDUVuiSnPIIMi/Yaa
7PmIL73DyKkmXuk395uveI/5E8o+zTRArZehxTaCdnNmEQA2a8vKLAnaY3RzlsUf
NjdoMI6zQzPubErm8or4AHePzt3k80SfAePgRutgFqV3ZVZsiyqO6RrQEN6Dtk5g
UUX9xfm+buAHqqpQB6of5MknesYvi3qcsPVD2wPdwlcs9bCBIHr+V4SpPTTTtsPX
7KBZ76ILlAVXVC8AvgNTAFo/+rp+ZGxXl+CNJ7LJFZ5m1lWdo2wQmN4mD+1+mYuT
0wxabB6SKSSaAcaZvMTGMFOlCwaVfTaR/GPxI8iJTwhN9DTq6KU=
=0xMi
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--


