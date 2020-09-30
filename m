Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19136C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B81120674
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1Zv5DQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B81120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNdpR-0005oL-M9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNdXA-0005F8-9C
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNdX8-0004fo-Hd
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 10:56:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601477801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQorTVOdK7NfOIx14n8dvynou1+JerkNLqwW3sxFwiQ=;
 b=X1Zv5DQRRCgs1bomYCnplcgT0qXJBkcLMsYEUc4ueYZIrBBw1P8ImWqrif0EOMtOUU73s4
 ABySWXgCkVUms0B21M1kzrofH6Pts6o4CsRKS0knsrLYJbsu27cIEuVXi057NWQG2T5x4X
 /iqqyC03ldqQBY1mxYEhmBNy/nGnE84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-8jE3uonQMPOtq_DoaR7VEQ-1; Wed, 30 Sep 2020 10:56:39 -0400
X-MC-Unique: 8jE3uonQMPOtq_DoaR7VEQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 629841868408;
 Wed, 30 Sep 2020 14:56:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-128.ams2.redhat.com [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4337A1002C03;
 Wed, 30 Sep 2020 14:56:37 +0000 (UTC)
Date: Wed, 30 Sep 2020 16:56:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] keyval: Parse help options
Message-ID: <20200930145635.GD9292@linux.fritz.box>
References: <20200929172649.158086-1-kwolf@redhat.com>
 <20200929172649.158086-2-kwolf@redhat.com>
 <b28cad72-d344-78fa-fc07-b4a6a63fbc50@redhat.com>
 <20200930130412.GB9292@linux.fritz.box>
 <feccfb3c-6d7d-e40f-e1b5-0fe1c3962f80@redhat.com>
MIME-Version: 1.0
In-Reply-To: <feccfb3c-6d7d-e40f-e1b5-0fe1c3962f80@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 30.09.2020 um 15:42 hat Eric Blake geschrieben:
> On 9/30/20 8:04 AM, Kevin Wolf wrote:
> > Am 29.09.2020 um 19:46 hat Eric Blake geschrieben:
> >> On 9/29/20 12:26 PM, Kevin Wolf wrote:
> >>> This adds a new parameter 'help' to keyval_parse() that enables parsi=
ng
> >>> of help options. If NULL is passed, the function behaves the same as
> >>> before. But if a bool pointer is given, it contains the information
> >>> whether an option "help" without value was given (which would otherwi=
se
> >>> either result in an error or be interpreted as the value for an impli=
ed
> >>> key).
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>
> >>> +++ b/util/keyval.c
> >>
> >> Might be nice to see this before the testsuite changes by tweaking the
> >> git orderfile.
> >=20
> > What does your git orderfile look like? I don't know how to exclude
> > tests/ from file type patterns like *.c.
>=20
> You can start with scripts/git.orderfile, and temporarily add:
>=20
>  # decoding tree specification
>  *.decode
>=20
> +# Key files that I want first for this patch
> +util/*.c
> +
>  # code
>  *.c
>=20
> or similar.  It's not a show-stopper if you don't, and I concede that
> remembering to do it (and then to revert back to the usual afterwords)
> is not trivial.

Ah, I see. I never did per-patch/series orderfiles, I just have my
generic one that does things like headers before implementation, and
documentation and QAPI schema changes before both.

Kevin

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl90nKMACgkQfwmycsiP
L9aAgg/+KfcIQCyv+R/gfwHsBTDktxvzBV8D/bPpFd4OYByvgS7oT4Xg+iaIbMmr
FZ0yuLUH3E/oD1XFXxV0gQTi98fpoaUvTVbxHnvgdipGRfev8XR96GnLX+fTZi4i
L5UW2Q3eCJf1yZoMJqHmAv7WZAhXdNhmeQHRQMfCDgjPG7tHKTV1L12dV6/NgOOD
AnJLKvN+to+eHF+a0tkdZzc4pO6/ZTkY4SG3nMniTAkh/xxlqU7oC1axX7QxbohA
THQXQ1wRkFhegalCbNRwqbxFbDf3JsyRIt4qwrHrAS6F5PpZA9CEp+Bap16PWZGM
ALmG6NxB7PtD3KL1wvJJqUGNUEa2Kee/tiVv145WJ/uGf8ICsgBrDI9qimzAJq65
1ODRtmh+tS3MBNCKhEwbsnJnqqeRIftiFnlvhITavktmkSoajmmxTPf2Yz4GTHH4
GkxIxuKe9u9SRZYPxMnAqVjUjwnsK8kfgCqgMEdwoPKh8fhooLqIM+qBoJ25vZcu
O+oFNkuR6loaK9ZzAS99kxH6V2ttpUtFrfV+rFfAJBKpB2nJ2uh0EtXPzqMlJ7dE
Vctk4vGwSM9tDVp8hkeO3ijwip0vCZ6LNp67sGq5Rc6B2btcfqm3E/Ol0/rMFt8D
TSr+DgyIzDSUZP3rhomZOlyfFsuLmkTtKzdDvfOdiU3uLmo5ZcU=
=lNqK
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--


